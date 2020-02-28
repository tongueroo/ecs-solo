# ecs-solo

Deploy Docker image from ECS service to the current instance.  This is useful if you want to deploy the current running ECS docker image onto an EC2 instance outside of ECS purview. It can also be useful to run the Docker container locally and exam it.

## Usage

You may have to login to pull from the Docker regsitry first. Here's an example ECR login command:

    eval $(aws ecr get-login --no-include-email --region us-west-2)

There are 2 forms that the `ecs-solo deploy` understands:

    ecs-solo deploy STACK_NAME # CloudFormation template AWS::ECS::Service resource
    ecs-solo deploy ECS_SERVICE --cluster development

* When passed the CloudFormation stack name, the ECS Cluster and Cluster is automatically infer. The cluster option is not needed and not used at all.
* When passed the ECS Service, the --cluster optional will probably be needed since the ECS service may not be running in the default development cluster.

## Override command

You can override the default command in the Dockerfile with the `-c` option.

    ecs-solo deploy demo-web-development -c bin/loop.sh

## Example

Here's an example with output:

    $ ecs-solo deploy demo-web-development
    Finding Docker image associated with service
    Found task definition with Docker image
    => docker ps -a -f name=ecs-demo-web-web --format '{{.Names}}' | grep ecs-demo-web-web
    => docker run --name ecs-demo-web-web -d 112233445566.dkr.ecr.us-west-2.amazonaws.com/demo/sinatra:ufo-2020-02-28T20-11-55-f6ef0e0
    d39bc08598bb133c36690b1bfe2c321c1fc219d3e8526174cb9b8e281f161f24
    $ docker ps
    CONTAINER ID        IMAGE                                                                                       COMMAND             CREATED             STATUS              PORTS               NAMES
    d39bc08598bb        112233445566.dkr.ecr.us-west-2.amazonaws.com/demo/sinatra:ufo-2020-02-28T20-11-55-f6ef0e0   "bin/web"           3 seconds ago       Up 2 seconds        8080/tcp            ecs-demo-web-web
    $

## Installation

    gem install ecs-solo
