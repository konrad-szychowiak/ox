#!/usr/bin/env bash

B="\e[1m"
RED="\e[31m"
BLUE="\e[34m"
NULL="\e[0m"
LOG="" # "\e[35m"

# preset
XOBOARD=(0 1 2 3 4 5 6 7 8)
symbolX=$RED"X"$NULL
symbolO=$BLUE"O"$NULL

[[ ! $ox_locale ]] && ox_locale=${LANG%%.*}
until [[ -f ./locales/$ox_locale.locale ]]; do
  printf $B"choose language [en_GB/pl_PL/... ? list all possible choices]: "$NULL
  read ox_locale

  if [[ $ox_locale == ? ]]; then
    echo installed locales:
    for lang in $(ls ./locales)
    do
      echo -e "  + "${lang%%.locale*}
    done
  fi
done

. locales/$ox_locale.locale


function check_if_solved {
  local crowded=0

  for i in ${!XOBOARD[*]}; do [[ $i = ${XOBOARD[$i]} ]] && crowded=$(( crowded + 1 )); done

  if [ ${XOBOARD[0]} = ${XOBOARD[1]} -a ${XOBOARD[1]} = ${XOBOARD[2]} ]
  then
    winner ${XOBOARD[0]}
    return 0
  fi

  if [ ${XOBOARD[3]} = ${XOBOARD[4]} -a ${XOBOARD[4]} = ${XOBOARD[5]} ]
  then
    winner ${XOBOARD[3]}
    return 0
  fi

  if [ ${XOBOARD[6]} = ${XOBOARD[7]} -a ${XOBOARD[7]} = ${XOBOARD[8]} ]
  then
    winner ${XOBOARD[6]}
    return 0
  fi

  if [ ${XOBOARD[0]} = ${XOBOARD[4]} -a ${XOBOARD[4]} = ${XOBOARD[8]} ]
  then
    winner ${XOBOARD[0]}
    return 0
  fi

  if [ ${XOBOARD[2]} = ${XOBOARD[4]} -a ${XOBOARD[4]} = ${XOBOARD[6]} ]
  then
    winner ${XOBOARD[2]}
    return 0
  fi

  if [ ${XOBOARD[0]} = ${XOBOARD[3]} -a ${XOBOARD[3]} = ${XOBOARD[6]} ]
  then
    winner ${XOBOARD[0]}
    return 0
  fi

  if [ ${XOBOARD[1]} = ${XOBOARD[4]} -a ${XOBOARD[4]} = ${XOBOARD[7]} ]
  then
    winner ${XOBOARD[1]}
    return 0
  fi

  if [ ${XOBOARD[2]} = ${XOBOARD[5]} -a ${XOBOARD[5]} = ${XOBOARD[8]} ]
  then
    winner ${XOBOARD[2]}
    return 0
  fi

  if [[ $crowded == 0 ]]
  then
    [[ $quite != true ]] && locale_tie
    return 0
  fi

  return 1
}

function put_user_symbol {
  local where=-1
  until [[ 0 -le $where ]] 2>/dev/null && [[ 9 -ge $where ]] 2>/dev/null && [[ ${XOBOARD[$where]} == $where ]] 2>/dev/null; do
    [[ $quite != true ]] && locale_prompt $symbolX && read where
  done

  [[ $quite != true ]] && locale_endturn_player
  XOBOARD[$where]=$symbolX
}

function put_enemy_symbol {
  local where
  until [[ ${XOBOARD[$where]} == $where ]]; do
    where=$(( $RANDOM % 9 ))
  done
  [[ $quite != true ]] && locale_endturn_cpu
  XOBOARD[$where]=$symbolO

  check_if_solved
}

function get_symbol {
  case $1 in
    X )
      get=$symbolX
      ;;
    O )
      get=$symbolO
      ;;
    * )
      get=$1
      ;;
  esac

  printf "│ $get "
}

function print_board {
  printf "╭───┬───┬───╮\n"
  get_symbol ${XOBOARD[0]}
  get_symbol ${XOBOARD[1]}
  get_symbol ${XOBOARD[2]}
  printf "│\n├───┼───┼───┤\n"
  get_symbol ${XOBOARD[3]}
  get_symbol ${XOBOARD[4]}
  get_symbol ${XOBOARD[5]}
  printf "│\n├───┼───┼───┤\n"
  get_symbol ${XOBOARD[6]}
  get_symbol ${XOBOARD[7]}
  get_symbol ${XOBOARD[8]}
  printf "│\n╰───┴───┴───╯\n"

  # return 8
}



# CONFIG
for arg in "$@"; do
  shift
  case "$arg" in
    "--help")
      set -- "$@" "-h" ;;
    "--quiet")
      set -- "$@" "-q" ;;
    *)
      set -- "$@" "$arg"
  esac
done

while getopts ":hucxoq :X: :O:" opt; do
  case ${opt} in
    h )
      print_help
      exit 0
      ;;
    q )
      quiet=true
      ;;
    u )
      firstPlayer=user
      ;;
    c )
      firstPlayer=cpu
      ;;
    X )
      symbolX=$RED$B$OPTARG$NULL
      # echo -e $BLUE"Symbol for [X] has been overwritten by the user. Now using [$symbolX]."$NULL
      ;;
    O )
      symbolO=$BLUE$B$OPTARG$NULL
      # echo -e $BLUE"Symbol for [O] has been overwritten by the user. Now using [$symbolX]."$NULL
      ;;
    x )
      symbolX=$RED"X"$NULL
      symbolO=$BLUE"O"$NULL
      # echo -e $BLUE"User have chosen to play [$symbolX]"$NULL
      ;;
    o )
      symbolX=$RED"O"$NULL
      symbolO=$BLUE"X"$NULL
      # echo -e $BLUE"Symbol for [O] has been overwritten by the user. Now using [$symbolO]."$NULL
      ;;
    \? )
      printf "$RED[%6s]${NULL}Invalid Option: -$OPTARG" error 1>&2
      exit 1
      ;;
    : )
      printf "$RED[%6s]${NULL}Invalid Option: -$OPTARG requires an argument" error 1>&2
      exit 1
      ;;
  esac
done



# MAIN
# set_player_symbol
if [[ $firstPlayer = cpu ]]; then
  put_enemy_symbol
fi

print_board
until [[ $solved = true ]]; do

  put_user_symbol $place
  print_board
  check_if_solved && break

  put_enemy_symbol
  print_board
  check_if_solved && break
done
