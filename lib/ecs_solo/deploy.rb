module EcsSolo
  class Deploy < AbstractBase
    def initialize(options={})
      super
      @identifier = options[:identifier] # ECS Service or CloudFormation Stack
      @cluster = options[:cluster]
      @command = options[:command]
    end

    def run
      task_definition = find_task_definition
      unless task_definition
        puts "Unable to task definition associated with service #{@service.color(:green)} in the cluster #{@cluster.color(:green)}"
        exit 1
      end

      @docker = Docker.new(@options.merge(task_definition: task_definition))
      @docker.execute
    end

    def find_task_definition
      puts "Finding Docker image associated with service #{@service}"
      service = find_service
      return unless service

      task_definition = service.task_definition
      resp = ecs.describe_task_definition(task_definition: task_definition)
      puts "Found task definition with Docker image"
      resp.task_definition
    end

    def find_service
      ecs_service_arn = cloudformation_ecs_service_arn(@identifier)
      if ecs_service_arn
        # IE: arn:aws:ecs:us-west-2:112233445566:service/development/demo-web-development-Ecs-179L598PRC44
        @cluster = ecs_service_arn.split('/')[1] # override @cluster
        ecs_service(ecs_service_arn)
      else
        ecs_service(@identifier)
      end
    end

    def cloudformation_ecs_service_arn(stack_name)
      resp = cloudformation.describe_stack_resources(stack_name: stack_name)
      resource = resp.stack_resources.find { |r| r.resource_type == "AWS::ECS::Service" }
      resource.physical_resource_id # IE: arn:aws:ecs:us-west-2:112233445566:service/development/demo-web-development-Ecs-179L598PRC44
    rescue Aws::CloudFormation::Errors::ValidationError => e
      if e.message.include?("does not exist")
        return
      else
        raise(e)
      end
    end

    def ecs_service(service)
      begin
        resp = ecs.describe_services(services: [service], cluster: @cluster)
      rescue Aws::ECS::Errors::ClusterNotFoundException => e
        puts "#{e.class}: #{e.message}"
        puts "WARN: #{@cluster.color(:green)} not found."
        return
      end

      resp.services.first
    end

  private
    def docker
      Docker.new
    end
    memoize :docker
  end
end
