# require gems and classes
require 'bundler'
Bundler.require
$: << File.expand_path('../', __FILE__)

# configure sinatra
set :root, File.dirname(__FILE__) + '/../..'