
require File.expand_path(File.dirname(__FILE__) + "/boot")

use Rack::Lint

map "/views" do
  run ViewImageController
end

map "/uploads" do
  run UploadImageController
end
