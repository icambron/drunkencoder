require 'bundler'
Bundler.require

ROOT = File.expand_path(File.dirname(__FILE__))
$:.unshift ROOT
Dir.chdir(ROOT)

#for dealing with heroku
(ENV["RACK_ENV"] == 'development')? RubyPython.start(:python_exe => "python2.7") : RubyPython.start(:python_exe => "python2.6") 

["lib", "views"].each do |dir|
  Dir["#{dir}/**/*.rb"].each do |file|
    require file
  end
end

map '/assets' do
  environment = Sprockets::Environment.new
  environment.append_path 'assets/stylesheets'
  environment.append_path 'assets/javascripts'

  environment.append_path 'vendor/assets/javascripts'

  environment.append_path 'vendor/bootstrap-sass/vendor/assets/javascripts'
  environment.append_path 'vendor/bootstrap-sass/vendor/assets/images'
  environment.append_path 'vendor/bootstrap-sass/vendor/assets/stylesheets'

  environment.append_path 'vendor/font-awesome-sass-rails/vendor/assets/fonts'
  environment.append_path 'vendor/font-awesome-sass-rails/vendor/assets/stylesheets'

  environment.js_compressor = Uglifier.new
  run environment
end

require './blog.rb'
map "/" do
  run Blog
end