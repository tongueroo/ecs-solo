## Examples

    ecs_solo completion

Prints words for TAB auto-completion.

    ecs_solo completion
    ecs_solo completion hello
    ecs_solo completion hello name

To enable, TAB auto-completion add the following to your profile:

    eval $(ecs_solo completion_script)

Auto-completion example usage:

    ecs_solo [TAB]
    ecs_solo hello [TAB]
    ecs_solo hello name [TAB]
    ecs_solo hello name --[TAB]
