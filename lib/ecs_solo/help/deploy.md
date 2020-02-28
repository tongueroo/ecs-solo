## Examples

    ecs-solo deploy IDENTIFIER
    ecs-solo deploy IDENTIFIER --cluster development

The `IDENTIFIER` can be either a:

1. CloudFormation stack name that has an `AWS::ECS::Service` resource. The ECS Service and its Cluster is inferred from the stack.
2. ECS Service, the `--cluster` optional will probably be needed since the ECS service may not be running in the default development cluster.

    ecs-solo deploy CFN_STACK
    ecs-solo deploy ECS_SERVICE --cluster development
