#!/bin/sh

currSessId=`cat ~/terminalRecord/sessionId`
currSessId=$((currSessId+1))

echo $currSessId > ~/terminalRecord/sessionId

script -a ~/terminalRecord/$currSessId.out
echo

echo "             THIS SESSION IS UNDER SURVAILANCE"

echo
