
require File.expand_path(File.dirname(__FILE__) + "/boot")

use Rack::Lint
run ThumbnailServer
