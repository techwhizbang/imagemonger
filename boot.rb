require 'rubygems'
require 'java'
require 'bundler'
Bundler.setup
require 'sinatra'
require 'sequel'
require 'jdbc/postgres'

require File.expand_path(File.dirname(__FILE__) + "/lib/commons-codec-1.5.jar")
require File.expand_path(File.dirname(__FILE__) + "/lib/commons-io-2.0.1.jar")
Dir.glob(File.expand_path(File.dirname(__FILE__) + "/lib/*.rb")).each { |f| require f }
Dir.glob(File.expand_path(File.dirname(__FILE__) + "/lib/database/*.rb")).each { |f| require f }

DatabaseConnection.connect(ENV['RACK_ENV'])

Dir.glob(File.expand_path(File.dirname(__FILE__) + "/lib/models/*.rb")).each { |f| require f }
Dir.glob(File.expand_path(File.dirname(__FILE__) + "/lib/servers/*.rb")).each { |f| require f }
