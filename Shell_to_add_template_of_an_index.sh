#!/bin/bash

if [ -z $1 ] ; then
    echo "Please enter index name"
    exit
fi

INDEXNAME=$1

if [ -z $2 ] ; then
    echo "Please enter temp name"
    exit
fi

TEMPLATE=$2

echo "Index Name :" $INDEXNAME
echo "Template Name :" $TEMPLATE
curl -s localhost:9200/$INDEXNAME/_settings | jq .[] |jq 'del(.settings.index.version)|del(.settings.index.creation_date)|del(.settings.index.uuid)|del(.settings.index.provided_name)'|sed '$d'|sed -e "\$a," > template.json
curl -s localhost:9200/$INDEXNAME/_mapping | jq .[] | sed -e '1d' >> template.json

SHARDS=$(jq .settings.index.number_of_shards template.json)
REPLICA=`jq .settings.index.number_of_replicas template.json`


sed -i 's/"number_of_shards": '$SHARDS'/"number_of_shards": "1"/g' template.json
sed -i 's/"number_of_replicas": '$REPLICA'/"number_of_replicas": "1"/g' template.json
sed -i '2i "template": "'$TEMPLATE'",' template.json


curl -XPUT "localhost:9200/_template/$TEMPLATE" -d @template.json
