#!/bin/bash
#list="list.txt"
if [ ! -z $1 ]
then
list=$1
fi
for domain in $(cat list.txt)
do
  domain2=$domain
  if command -v idn > /dev/null; then domain2=$(echo $domain | idn); fi
  exp=$(whois ${domain2} | grep -i expi | head -n 1 | egrep -o '[0-9]{1,2}\.[0-9]{1,2}\.[0-9]{4}|[0-9]{4}\-[0-9]{2}\-[0-9]{2}')
  expf=$(date -j -f '%d.%m.%Y' "${exp}" '+%d.%m.%Y' 2> /dev/null)
  if [ -z "$expf" ]
  then
    expf=$(date -j -f '%Y-%m-%d' "${exp}" '+%d.%m.%Y' 2> /dev/null)
  fi
  echo -e $domain "\t" $expf
done

