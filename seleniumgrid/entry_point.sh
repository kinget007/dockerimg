#!/bin/bash

CMD="xvfb-run java -jar /root/selenium-server-standalone-3.7.1.jar -port 4444 -role hub"
pkill -x xvfb-run
$CMD
