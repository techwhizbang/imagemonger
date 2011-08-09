require 'rubygems'
require 'java'
require 'bundler'
Bundler.setup
require 'sinatra'
require 'sequel'
require 'jdbc/postgres'

Dir.glob(File.expand_path(File.dirname(__FILE__) + "/lib/database/*.rb")).each { |f| require f }
Dir.glob(File.expand_path(File.dirname(__FILE__) + "/lib/models/*.rb")).each { |f| require f }
Dir.glob(File.expand_path(File.dirname(__FILE__) + "/lib/servers/*.rb")).each { |f| require f }
