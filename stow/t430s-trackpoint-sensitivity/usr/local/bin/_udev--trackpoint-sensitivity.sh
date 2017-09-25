#!/bin/bash

shopt -s globstar

system=/sys/devices/platform/i8042/serio1/serio2
dateit() { while IFS= read -r x; do echo "$(date) $x"; done; }
logit() { cat >>/home/lampam/.serio.log; }

{
	sleep 1
	echo -n 250 >$system/sensitivity
	echo -n 250 >$system/speed

	# # workaround for a kernel bug that keeps reassigning new names to the trackpoint,
	# # until this patch goes through:
	# #     https://patchwork.kernel.org/patch/9874667/
	# echo -n 250 | tee /sys/devices/platform/i8042/serio1/serio*/**/{speed,sensitivity}
} 2>&1 | dateit | logit &

# cargo-cultism alert:
#   Some forum post claimed this was important, to avoid joining the forked thread.
#   It seems to work just fine to me without it, but w/e.
exit
