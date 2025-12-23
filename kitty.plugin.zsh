#####################################################
# Kitty plugin for oh-my-zsh                        #
#####################################################

if [[ "$TERM" == 'xterm-kitty' ]]; then
  ## kssh
  # Use this when your terminfo isn't recognized on remote hosts.
  # See: https://sw.kovidgoyal.net/kitty/faq/#i-get-errors-about-the-terminal-being-unknown-or-opening-the-terminal-failing-when-sshing-into-a-different-computer
  alias kssh="kitty +kitten ssh"
  compdef kssh='ssh'
  # Use this if kssh fails
  alias kssh-slow="infocmp -a xterm-kitty | ssh myserver tic -x -o \~/.terminfo /dev/stdin"

  # Change the colour theme
  alias kitty-theme="kitty +kitten themes"
fi

#####################################################
# Kitty 独自plugin for oh-my-zsh                        #
#####################################################


klaunch() {
  emulate -L zsh
  if (( $# == 0 )); then
    print -u2 "usage: klaunch [launch-opts...] <command> [args...]"
    return 2
  fi

  local -a argv; argv=("$@")
  local has_type=0 has_cwd=0

  local i=1
  while (( i <= $#argv )); do
    case ${argv[i]} in
      --type=*) has_type=1 ;;
      --type)   has_type=1; (( i++ )) ;;  # 値を1つ消費
      --cwd=*)  has_cwd=1 ;;
      --cwd)    has_cwd=1; (( i++ )) ;;
    esac
    (( i++ ))
  done

  local -a base
  (( !has_type )) && base+=(--type=os-window)
  (( !has_cwd  )) && base+=(--cwd=current)

  command kitten @ launch "${base[@]}" "${argv[@]}"
}

