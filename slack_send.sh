#!/bin/bash
#these have to be setup via slack
api_token="xoxp-4780797817-4994509351-5144550728-5c1548"
url="https://hooks.slack.com/services/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"

#commandline parameter
message=$1
channel=$2
username=$3

#assemble json payload
jsonstring="'payload={\"token\":\"$api_token\",\"channel\":\"$channel\",\"username\":\"$username\",\"text\":\"$message\",\"icon_emoji\":\":ghost:\"}'"

#call curl
curl -X POST --data-urlencode $jsonstring $url
