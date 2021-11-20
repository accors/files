#!/bin/bash
while true
do
ping -c 3 -W 5 youtube.com &> /dev/null
if [ "$?" != "0" ]; then
echo "不可访问外网，设置GitHub镜像"
git config --global url."https://github.com.cnpmjs.org/".insteadOf "https://github.com/"
git config protocol.https.allow always
break
else
echo "可访问外网"
break
fi
done
