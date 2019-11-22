#!/bin/bash

# Watch a bashfile and run it if changed
function bash_monitor () {

  local file="dvr_main"
  local tmp1="$HOME/.tmp_bash_monitor_1"
  local tmp2="$HOME/.tmp_bash_monitor_2"

  # create temporary files to compare status
  touch "$tmp1" "$tmp2" 

  while true; do
    ls -l "$file" > "$tmp1"

    diff "$tmp1" "$tmp2" > /dev/null \
      || {
        echo 
        echo '[BASH MONITOR] File changed.' 
        echo '----------------------------'
        # run bash with parameters from second if changed

        #source "$file" "${@:2}g
	killall daemon ${file} & watchdog_switch -d
	sleep 5
	./${file} &
      }

    cp "$tmp1" "$tmp2"

    sleep 1

  done

}

bash_monitor "$@"
