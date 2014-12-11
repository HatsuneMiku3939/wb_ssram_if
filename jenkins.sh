#!/bin/sh

cd sim/icarus
make > sim.log 2>&1
cat sim.log
PASSED=`cat sim.log | grep "#ALL PASS" | wc -l`

if [ "1" = $PASSED ]; then
  exit 0
else
  exit 1
fi

