#!/bin/bash

# modified slack_send.sh script
# differences:
# instead of the message param it takes a svn repo path and revision number
# the actual message is constructed from svn log output for the give repo and rev
# username and channel are fixed

#these have to be setup via slack
api_token="your slack webapi token"
url="https://your webhook url"

username="svnbot"
channel="#korona-resource"

#commandline parameter
repo=$1
revision=$2

#build message
message=`svn log --revision $revision $repo`
message=`echo $message | iconv -f iso8859-1 -t ascii//translit`
message=`echo $message | sed "s/'/\\\\\'/g"`
message=${message//--/}
message=${message//|/\\n}

#build json
jsonstring="{\"token\":\"$api_token\",\"channel\":\"$channel\",\"username\":\"$username\",\"text\":\"$message\",\"icon_emoji\":\":ghost:\"}"

#call curl
curl -i -X POST -H 'Accept: application/json' -H "Content-Type: application/json; charset=ascii"  --data @/tmp/slack_git_msg $url
