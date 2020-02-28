$:.unshift(File.expand_path("../", __FILE__))
require "ecs_solo/version"
require "memoist"
require "rainbow/ext/string"

require "ecs_solo/autoloader"
EcsSolo::Autoloader.setup

module EcsSolo
  class Error < StandardError; end
end
