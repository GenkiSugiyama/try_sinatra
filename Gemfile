# frozen_string_literal: true

source "https://rubygems.org"

gem 'sinatra', :github => 'sinatra/sinatra'

gem 'rake'
gem 'sinatra-contrib'
gem 'activerecord'
gem 'sinatra-activerecord'
gem 'sqlite3'
gem 'rubocop', require: false

group :test do
  # このプロジェクトのGemfileに記述してbundle installしたrspecはbundle execで動かす。
  gem 'rspec'
  gem 'rack-test'
  gem 'factory_bot'
  gem 'database_cleaner'
end
