_ecs_solo() {
  COMPREPLY=()
  local word="${COMP_WORDS[COMP_CWORD]}"
  local words=("${COMP_WORDS[@]}")
  unset words[0]
  local completion=$(ecs_solo completion ${words[@]})
  COMPREPLY=( $(compgen -W "$completion" -- "$word") )
}

complete -F _ecs_solo ecs_solo
