require 'sinatra'
require 'erector'
require 'sass'
require 'twitter'
require 'time'
require 'spandex'

ROOT = File.expand_path(File.dirname(__FILE__))
$:.unshift ROOT
Dir.chdir(ROOT)

["lib", "views"].each do |dir|
  Dir["#{dir}/**/*.rb"].each do |file|
    require file
  end
end

@@cache = {}

content_dir = File.expand_path('content', File.dirname(__FILE__))
@@spandex = Spandex.new(content_dir, :fenced_code_blocks => true)

Twitter.configure do |config|
  config.consumer_key = ENV["TWITTER_KEY"]
  config.consumer_secret = ENV["TWITTER_SECRET"]
end

def important_stuff
  @important_stuff ||= {
    :tweets => get_tweets,
    :recent =>  @@spandex.all_articles.take(10),
    :tags => @@spandex.tags
  }
end

def render_class(clazz, locals)
  clazz.new(locals.merge(important_stuff)).to_html
end

def get_tweets
  cache_stuff(:tweets, 10) do
    begin
      Twitter.user_timeline("icambron", :count => 5)
    rescue
      puts "Error getting tweets: #{$!}"
      []
    end
  end
end

#this is dumb - use something smarter here
def cache_stuff(key, max_age_minutes, &blk)
  cached = @@cache[key]
  unless cached && cached[:stamp] >= Time.now - max_age_minutes * 60
    val = blk.call()
    @@cache[key] = {:stamp => Time.now, :val => val}
    return val
  end
  return cached[:val]
end

#index page, shows all the posts
get '/' do
  stuff = @@spandex.all_articles.take(5)
  render_class Index, :posts => stuff
end

get '/archive' do
  stuff = @@spandex.find_articles(:tag => params[:tag])
  title = params[:tag] ? "Posts tagged as \"#{params[:tag]}\"" : "All posts. Ever."
  render_class Archive, :posts => stuff, :title => title
end

get '/feed.xml' do
  content_type :xml, :charset => 'utf-8'
  @@spandex.atom_feed(10, "Drunken Coder", 'Isaac', 'drunkencoder.net', '/feed.xml')
end

#stylesheeting
get '/css/:sheet.css' do
  content_type 'text/css', :charset => 'utf-8'
  scss params[:sheet].to_sym
end

#articles
get '*' do
  post = @@spandex.get(params[:splat][0])
  if post
    render_class PostPage, :post => post
  else 
    404
  end
end
