require 'rubygems'
require 'rspec'
require 'rspec/autorun'
require 'rack/test'
require File.expand_path(File.dirname(__FILE__) + "/../boot.rb")

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

