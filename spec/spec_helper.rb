require 'rubygems'
require 'rspec'
require 'rspec/autorun'
require 'rack/test'
require File.expand_path(File.dirname(__FILE__) + "/../boot.rb")
# require 'database_cleaner'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  
  # conf.before(:suite) do
  #   DatabaseConnection.connect("test")
  #   DatabaseCleaner.strategy = :transaction
  #   DatabaseCleaner.clean_with(:truncation)
  # end
  # 
  # conf.before(:each) do  
  #   DatabaseCleaner.start
  # end
  #   
  # conf.after(:each) do
  #   DatabaseCleaner.clean
  # end

end

