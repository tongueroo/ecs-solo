module EcsSolo
  class AbstractBase
    include AwsServices
    extend Memoist

    def initialize(options={})
      @options = options
    end
  end
end
