module EcsSolo
  class CLI < Command
    class_option :verbose, type: :boolean
    class_option :noop, type: :boolean

    desc "deploy IDENTIFIER", "Deploys Docker image associated with ECS service"
    long_desc Help.text(:deploy)
    option :cluster, default: "development", desc: "ECS Cluster"
    option :force_new, type: :boolean, desc: "Force new container if container name is already in use"
    option :command, aliases: :c, desc: "Command to use as part of docker run. Overrides default in the Dockerfile"
    def deploy(identifier)
      Deploy.new(options.merge(identifier: identifier)).run
    end

    desc "completion *PARAMS", "Prints words for auto-completion."
    long_desc Help.text(:completion)
    def completion(*params)
      Completer.new(CLI, *params).run
    end

    desc "completion_script", "Generates a script that can be eval to setup auto-completion."
    long_desc Help.text(:completion_script)
    def completion_script
      Completer::Script.generate
    end

    desc "version", "prints version"
    def version
      puts VERSION
    end
  end
end
