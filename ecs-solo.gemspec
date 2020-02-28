# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ecs_solo/version"

Gem::Specification.new do |spec|
  spec.name          = "ecs-solo"
  spec.version       = EcsSolo::VERSION
  spec.authors       = ["Tung Nguyen"]
  spec.email         = ["tongueroo@gmail.com"]
  spec.summary       = "Deploy Docker image from ECS service to current instance"
  spec.homepage      = "https://github.com/tongueroo/ecs-solo"
  spec.license       = "MIT"

  spec.files         = Dir.glob("**/*")
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"
  spec.add_dependency "aws-sdk-cloudformation"
  spec.add_dependency "aws-sdk-ecs"
  spec.add_dependency "memoist"
  spec.add_dependency "rainbow"
  spec.add_dependency "thor"
  spec.add_dependency "zeitwerk"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "cli_markdown"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    # spec.metadata["allowed_push_host"] = ""
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/tongueroo/ecs-deploy"
    spec.metadata["changelog_uri"] = "https://github.com/tongueroo/ecs-deploy/blob/master/CHANGELOG.md"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end
end
