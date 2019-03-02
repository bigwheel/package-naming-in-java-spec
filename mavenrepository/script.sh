#!/usr/bin/env bash

set -eu

tmpfile=$(mktemp)

tldpath=tmp/tlds-alpha-by-domain.txt
if ! [[ -e $tldpath ]]; then
  wget 'http://data.iana.org/TLD/tlds-alpha-by-domain.txt' -P tmp
fi

scrapy crawl repository -t csv -o $tmpfile > /dev/null 2>&1
cat $tmpfile | tail -n +2 | tr -d '\r' | {
  while read -r url; do
    filename=${url##*/}
    filepath="tmp/$filename"
    if ! [[ -e $filepath ]]; then
      wget "$url" -P tmp
      sleep 3
    fi
    set +e
    tlps=$(jar tf $filepath |
      grep --color=never -E '^.*\.(class|clj)$' |
      sed -e 's|/.*$||g' |
      sort |
      uniq |
      grep -vE '(META-INF|module-info.class)'
    )
    set -e
    echo "$tlps" | {
      no_tlps=true
      exist_tld=false
      while read -r tlp; do
        if grep -iE "^$tlp$" $tldpath > /dev/null || [ "$tlp" = "java" ] || [ "$tlp" = "javax" ]; then
          exist_tld=true
        fi
        if [ "$tlp" != "" ]; then
          no_tlps=false
        fi
      done
      if [ $exist_tld = "true" ] || [ $no_tlps = "true" ]; then
        exist_tld_or_no_tlps=true
      else
        exist_tld_or_no_tlps=false
      fi
      tlps_csv=$(echo "$tlps" | tr '\n' ',')
      echo -e "$exist_tld_or_no_tlps\t${tlps_csv::-1}\t$filepath"
    }
  done
}

rm $tmpfile
