require "aws-sdk-cloudformation"
require "aws-sdk-ecs"

module EcsSolo
  module AwsServices
    extend Memoist

    def cloudformation
      Aws::CloudFormation::Client.new
    end
    memoize :cloudformation

    def ecs
      Aws::ECS::Client.new
    end
    memoize :ecs
  end
end
