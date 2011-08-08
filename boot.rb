require 'rubygems'
require 'java'
require 'bundler'
Bundler.setup
require 'sinatra'

require File.expand_path(File.dirname(__FILE__) + "/lib/thumbnail_server.rb")
