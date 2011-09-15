require 'sinatra'
require 'erector'
require 'sass'
require 'twitter'
require 'time'

ROOT = File.expand_path(File.dirname(__FILE__))
$:.unshift ROOT
Dir.chdir(ROOT)

["lib", "views"].each do |dir|
  Dir["#{dir}/**/*.rb"].each do |file|
    require file
  end
end

@@cache = {}

def important_stuff
  @important_stuff ||= {
    :tweets => get_tweets,
    :recent => get_recent,
    :tags => finder.all_tags
  }
end

def render_class(clazz, locals)
  clazz.new(locals.merge(important_stuff)).to_html
end

def get_tweets
  cache_stuff(:tweets, 10) do
    begin
      Twitter.user_timeline("icambron", :count => 10)
    rescue
      puts "Error getting tweets: #{$!}"
      []
    end
  end
end

def get_recent
  finder.find_posts.take(10)
end

def finder
  @finder ||= PostFinder.new
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
  stuff = finder.find_posts().take(5)
  render_class Index, :posts => stuff
end

get '/archive' do
  stuff = finder.find_posts(:tag => params[:tag])
  title = params[:tag] ? "Posts tagged as \"#{params[:tag]}\"" : "All posts. Ever."
  render_class Archive, :posts => stuff, :title => title
end

get '/feed.xml' do
  content_type :xml, :charset => 'utf-8'
  finder.atom_feed(10, 'Isaac', 'drunkencoder.net', '/feed.xml')
end

#stylesheeting
get '/css/:sheet.css' do
  content_type 'text/css', :charset => 'utf-8'
  scss params[:sheet].to_sym
end

#articles
get '*' do
  parts = params[:splat].map { |p| p.sub(/\/$/, '') }
  post = finder.find_by_path(File.join(parts))
  render_class PostPage, :post => post
end
