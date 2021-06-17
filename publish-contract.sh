#!/bin/bash

source scriptutils/print.sh
source scriptutils/prompts.sh

usage() {
    echo "publish-contract [options]"
}

elementNotIn () {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 1; done
  return 0
}

tags=()
file=
consumer=
version=1.0.0
provider=
username=
password=
protocol=http
host=localhost
port=80

while [ "$1" != "" ]; do
    case $1 in
        -f | --file )         shift
                              file=$1
                              ;;
        -c | --consumer )     shift
                              consumer=$1
                              ;;
        -v | --version )     shift
                              version=$1
                              ;;
        -p | --provider )     shift
                              provider=$1
                              ;;
        -u | --user )         shift
                              username=$1
                              ;;
        -pwd | --password )   shift
                              password=$1
                              ;;
        -t | --tag )          shift
                              tags[${#tags[@]}]=$1
                              ;;
        --help )              usage
                              exit
                              ;;
        * )                   usage
                              exit 1
    esac
    shift
done


# if [ "$file" == "" ]; then
#     file=$(promptWithDefault "Path to contract file" "$(pwd)/consumer-provider.json")
# fi
# if [$consumer == ""]; then
  # consumer=$(promptWithDefault "Name of consumer" "Consumer")
# fi
# if [$provider == ""]; then
  # provider=$(promptWithDefault "Name of provider" "Provider")
# fi

# echo $file
# echo $consumer
# echo $provider
# echo $username
# echo $password
# echo $protocol
# echo $host
# echo $port
# echo $hash
# echo "${tags[@]}"


echo $(curl --request PUT --header "Content-Type: application/json" --user ${username}:${password} --data @${file} ${protocol}://${host}:${port}/pacts/provider/${provider}/consumer/${consumer}/version/${version})

for tag in "${tags[@]}"; do
  echo $(curl --request PUT --header "Content-Type: application/json" --user ${username}:${password} ${protocol}://${host}:${port}/pacticipants/${consumer}/versions/${version}/tags/${tag})
done
