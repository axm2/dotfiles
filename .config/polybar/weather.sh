#!/usr/bin/env bash

# vars
key="64c13e7679dd5ffef7ecaf33f2850717"
loc="40.7221,-73.7613"
units="us"
temp="$(curl -s "https://api.darksky.net/forecast/$key/$loc?units=$units" | grep -oP "(?<=temperature\"\:).*?(?=,\"apparentTemperature)" | sed "s/\..*\$/°F/" | head -n1)"
cond="$(curl -s "https://api.darksky.net/forecast/$key/$loc?units=$units" | grep -oP "(?<=summary\"\:\").*?(?=\",\"icon)" | head -n1 | tr "[:upper:]" "[:lower:]")"

#print
echo $temp $cond
