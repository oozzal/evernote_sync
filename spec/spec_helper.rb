# Generate code coverage whenever required with:
# COVERAGE=true bundle exec rspec
if ENV['COVERAGE']

  require 'simplecov'

  SimpleCov.start do
    add_filter '/spec/'
    add_filter '/config/'
    add_filter '/tmp/'
    add_filter '/log/'
  end
end

require 'rubygems'
require 'bundler'
Bundler.require(:default, :test)

require File.expand_path("../../lib/evernote_sync.rb", __FILE__)

RSpec.configure do |config|
  # rspec configs
end

