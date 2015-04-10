#!/bin/bash

sharingdpid=$(/bin/ps ax | /usr/bin/awk '/sharingd/ {print $1; exit;}')

# 'cd' used to suppress error:
# shell-init: error retrieving current directory: getcwd: cannot access parent directories: Permission denied
cd /

timer=0
restart=1

# the script will attempt to set AirDrop's discoverable mode for 15 minutes (before the next checkin)
while [ $timer -lt 15 ]; do
    timer=$((timer +1))
    
    # check the CPU usage of the 'sharingd' process
    # if greater than 5% the script will sleep for 60 seconds
    cpuUsage=$(/bin/ps aux | /usr/bin/awk  -v pid=$sharingdpid '$2==pid {print $3}')
    if [ $(/usr/bin/printf "%.0f" $cpuUsage) -gt 1 ]; then
        echo "Process 'sharingd' is currently in use; will try again in 1 minute. Attempts: $timer"
        sleep 60
        continue
    else
        # this loop reads through /Users/ and for each valid user account sets DiscoverableMode to 'Off'
        for dir in /Users/*; do
            echo "Checking $dir"
            username=$(echo $dir | /usr/bin/awk -F'/' '{print $NF}')
            # isUser variable reads output from 'dscl' - which is blank if the user doesn't exist
            isUser=$(/usr/bin/dscl . -read /Users/$username 2>/dev/null)
            if [[ ! -z $isUser ]]; then
                # verify DiscoverableMode is not already set to 'Off' before making changes
                discmode=$(/usr/bin/defaults read ${dir}/Library/Preferences/com.apple.sharingd.plist DiscoverableMode)
                echo "    com.apple.sharingd.plist DiscoverableMode is set to: $discmode"
                if [[ $discmode != "Off" ]]; then
                    # set 'restart' var to '0' so 'sharingd' is restarted at end of script
                    restart=0
                    echo "    Setting AirDrop to 'No One' for user $username"
                    /usr/bin/su $username -c "/usr/bin/defaults write ${dir}/Library/Preferences/com.apple.sharingd.plist DiscoverableMode -string Off"
                    # read the modified plist to load it into cache as the user
                    /usr/bin/su $username -c "/usr/bin/defaults read ${dir}/Library/Preferences/com.apple.sharingd.plist" 2&> /dev/null
                    newdiscmode=$(/usr/bin/defaults read ${dir}/Library/Preferences/com.apple.sharingd.plist DiscoverableMode)
                    echo "    com.apple.sharingd.plist DiscoverableMode now set to: $newdiscmode"
                fi
            fi
        done
        # stop the 'while' loop, ending the timer
        break
    fi
done

# killing 'sharingd' is required for these changes to actively take effect
# only executed if 'restart' is set to 0
if [[ restart -eq 0 ]]; then
    echo "Restarting 'sharingd' for changes take effect"
    /bin/kill $sharingdpid
fi

exit 0