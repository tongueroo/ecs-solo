module EcsSolo
  class Docker
    def initialize(options={})
      @options = options
      @task_definition = options[:task_definition] # describe_task_definition resp.task_definition
      @command = options[:command] # will be array
    end

    def execute
      unless in_use?
        run
        return
      end

      if @options[:force_new]
        puts "INFO: Forcing new container"
        stop
        rm
        run
      elsif !running?
        rm
        run
      else
        puts "WARN: container name is already in use".color(:yellow)
        puts "If you want to force a new container, use the --force-new option."
      end
    end

    def running?
      out = sh "docker inspect -f '{{.State.Running}}' #{name}"
      out.strip == "true"
    end

    def run
      docker_options = ENV['ECS_SOLO_DOCKER_RUN_OPTIONS']
      sh "docker run --name #{name} -d #{docker_options}#{image} #{@command}"
    end

    def in_use?
      sh "docker ps -a -f name=#{name} --format '{{.Names}}' | grep #{name}"
    end

    def stop
      sh "docker stop #{name}"
    end

    def rm
      sh "docker rm #{name}"
    end

    def pull
      sh "docker pull #{image}"
    end

    # Almost resembles the name ecs-agent generates.
    # Unsure how about the random looking id at the end though. Example:
    #
    #     ecs-demo-web-217-web-86a0bcbac2b7d1b92d00
    #
    # So not including that.
    #
    # Also not including revision to make this script simpler. So final result:
    #
    #    ecs-demo-web-web
    #
    def name
      "ecs-#{@task_definition.family}-#{container_definition.name}"
    end

    def image
      container_definition.image
    end

    def container_definition
      @task_definition.container_definitions.first
    end

    def sh(command)
      puts "=> #{command}"
      out = `#{command}`
      puts out
      out
    end
  end
end
