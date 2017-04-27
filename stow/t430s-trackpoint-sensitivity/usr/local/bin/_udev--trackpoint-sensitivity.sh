#!/bin/bash

dateit() { while IFS= read -r x; do echo "$(date) $x"; done; }
logit() { cat >>/home/lampam/.serio.log; }

{
	sleep 1
	echo -n 250 >/sys/devices/platform/i8042/serio1/serio2/sensitivity
	echo -n 250 >/sys/devices/platform/i8042/serio1/serio2/speed
} 2>&1 | dateit | logit &

# cargo-cultism alert:
#   Some forum post claimed this was important, to avoid joining the forked thread.
#   It seems to work just fine to me without it, but w/e.
exit
