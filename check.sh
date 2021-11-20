#!/bin/bash
ping -c 3 -w 5 youtube.com
if [[ $?!=0]];then
git config --global url."https://hub.fastgit.org/".insteadOf "https://github.com/"
git config protocol.https.allow always
else
return 0;
