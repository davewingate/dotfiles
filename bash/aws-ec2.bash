ec2user() { 
    ssh ec2-user@$1 
}

ec2ip() {
  usage="usage: ec2ip profile_name region filter [-q]"

  if [[ "$1" == "" ]]; then
   >&2  echo "$usage"
    return 1
  fi
  profile="$1"

  if [[ "$2" == "" ]]; then
    >&2 echo "$usage"
    return 1
  fi
  region="$2"

  if [[ "$3" == "" ]]; then
    >&2 echo "$usage"
    return 1
  fi
  filter="$3"

  if [[ "$4" != "-q" ]]; then
      echo "Searching for $filter in $region with $profile"
  fi

  aws ec2 describe-instances --filters Name=tag-value,Values="$filter" --profile "$profile" --region "$region" --output text |grep PRIVATEIPADDRESSES | awk '{print $3}'
  return 0
}

# checks health according to dropwizard conventions
ec2health() {
    ips=$(ec2ip "$1" "$2" "$3" -q)
    if [[ $? == 0 ]]; then
      while read -r ip; do
        echo -e "======= $ip ======="
        version=$(curl -s "$ip:8080/version" | cut -d : -f 5 | tr -d '"}')
        health=$(curl -s "$ip:8081/healthcheck")
        echo "Version: $version"
        echo "$health"
        if [[ $health == *"{\"healthy\":false}"* ]]; then
          _error "\xE2\x9C\x97"
        elif [[ $health != *"{\"healthy\":true}"* ]]; then
          _error "\xE2\x9C\x97"
        else
          _success "\xE2\x9C\x93"
        fi
      done <<< "$ips"
    fi
}
