#! bash
# bash completion for the `jruby` command.
#
# Copyright (c) 2009-2013 Daniel Luz <dev at mernen dot com>.
# Distributed under the MIT license.
# http://mernen.com/projects/completion-ruby
#
# To use, source this file on bash:
#   . completion-jruby
#
# This script works best when completion-ruby is also loaded.

__jruby() {
  local cmd=$1
  local cur=$2
  local prev=$3
  COMPREPLY=()

  local options="
    -b -J --debug --jdb --properties --sample --client --server --manager
    --headless --1.8 --1.9 --bytecode -X-O -X+O -X-C -X+C --fast
    --ng --ng-server"

  local i
  local script_given
  local script_in_path
  local switches_accepted=1
  for ((i=1; i < $COMP_CWORD; ++i)); do
    local arg=${COMP_WORDS[$i]}

    case $arg in
    -S)
      script_in_path=1;;
    -S*)
      # syntax supported by jruby, but not by ruby, oddly
      script_given=1;;
    --)
      # end of switches
      switches_accepted=
      [[ $COMP_CWORD != $((i + 1)) ]] && script_given=1
      break;;
    -*)
      ;;
    *)
      # non-switch arg, must be the script name
      script_given=1
      switches_accepted=;;
    esac
  done

  if [[ $switches_accepted && $cur = -* ]]; then
    COMPREPLY=($(compgen -W "$options" -- "$cur"))
  elif [[ $script_in_path && ! $script_given ]]; then
    local jruby_dir=$(dirname "$(which "$cmd")" 2>/dev/null)
    if [[ -d $jruby_dir ]]; then
      local jruby_cmds=($(find "$jruby_dir" -maxdepth 1 -type f -perm +111 2>/dev/null))
      jruby_cmds=("${jruby_cmds[@]##*/}")
      COMPREPLY=($(compgen -W "${jruby_cmds[*]}" -- "$cur"))
    fi
  fi

  # include `ruby` completion results, if available
  if [[ $(type -t __ruby) = function ]]; then
    local cr=("${COMPREPLY[@]}")
    __ruby "$@"
    COMPREPLY+=("${cr[@]}")
  fi
}

complete -F __jruby -o filenames -o bashdefault -o default jruby
# vim: ai ft=sh sw=2 sts=2 et
