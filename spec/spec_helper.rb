require 'rubygems'
require 'rspec'
require 'rspec/autorun'
require 'rack/test'
require 'net/http/post/multipart'

ENV['RACK_ENV'] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../boot.rb")

# TODO: Waiting for the Sequel support to become available
# require 'database_cleaner'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  
  # conf.before(:suite) do
  #   DatabaseConnection.connect("test")
  #   DatabaseCleaner.strategy = :transaction
  #   DatabaseCleaner.clean_with(:truncation)
  # end
  # 
  conf.before(:each) do  
    #DatabaseCleaner.start
    ImageBinary.dataset.destroy
  end
   
  conf.after(:each) do
    #DatabaseCleaner.clean
  end
  
end

