#!/bin/bash

#version 1.0

confFile='mb.conf'

doUpdate() {
    instancePort=$theBaseport

    for (( c=1; c<=$theInstances; c++ ))
    do
        if [[ ! -z "$theGuirpc" ]]; then
            boinccmdCmdParamers="--host $theHost:$instancePort --passwd $theGuirpc --project $theProjecturl update"
        else
            boinccmdCmdParamers="--host $theHost:$instancePort --project $theProjecturl update"
        fi
	    echo updating  $theProjecturl "on" $theHost:$instancePort
        echo "boinccmd $boinccmdCmdParamers"
        instancePort=$((instancePort+1))
    done
}

performRun() {
    if [[ -z "$theMode" ]]; then
        theMode="update"
    fi
    case "$theMode" in
        update)
            if [[ -z "$theHost" ]]; then
                echo "missing target host, add host XXXXXXX to $confFile, use localhost or 127.0.0.1 for the current computer"
            elif [[ -z "$theBaseport" ]]; then
                echo "missing base port, add baseport XXXXX to $confFile, 31420 is a good number"
            elif [[ -z "$theInstances" ]]; then
                echo "missing number of instances, add instances XX to $confFile, 1 is a good number"
            elif [[ -z "$theProjecturl" ]]; then
                echo "missing project url, add projecturl XXXXXXX to $confFile"
            else
                doUpdate
            fi
        ;;
        *)
            echo "unknown mode $theMode"
        ;;
    esac
}

interpretLine() {
    case $1 in
        mode)
            theMode=$2;;
        host)
            theHost=$2;;
        baseport)
            theBaseport=$2;;
        instances)
            theInstances=$2;;
        projecturl)
            theProjecturl=$2;;
        guirpc)
            theGuirpc=$2;;
        run)
            performRun;;
    esac
}

while read line; do
    if [[ ! ${line::1} == "#" ]]
    then
        interpretLine $line
    fi
done < $confFile
