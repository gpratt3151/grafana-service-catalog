#!/bin/sh
#set -x
BINDIR="${HOME}/bin"

DELIMITER=';'

# Data format
# Semicolon separated values
# YYYY-MM-DD;measurement;tag,tag;value

# See if the database exists
curl --silent -i -XPOST http://localhost:8086/query --data-urlencode "q=SHOW DATABASES"| grep -q service_catalog ; RC=$?
if [ $RC -ne 0 ]
then
# Create the database
  echo "Database not found!"
  echo "Creating Datbase: service_catalog"
  curl --silent -i -XPOST http://localhost:8086/query --data-urlencode "q=CREATE DATABASE service_catalog" >/dev/null
fi

echo "Loading data..."
#for i in $(cat /tmp/data.csv) $(cat /tmp/junk)
for i in $(cat ntburndown.csv) $(cat overall.csv) $(cat esburndown.csv) $(cat iamburndown.csv) $(cat eusburndown.csv)
do
  xTIMESTAMP=$(echo "${i}" | cut -f1 -d"${DELIMITER}")
  TIMESTAMP=$(date -d${xTIMESTAMP} +%s)
  MEASUREMENT=$(echo "${i}" | cut -f2 -d"${DELIMITER}")
  TAG_AND_VALUE=$(echo "${i}" | cut -f3 -d"${DELIMITER}")
  if [ "x${TAG_AND_VALUE}" != "x" ]
  then
    TAG_AND_VALUE=",${TAG_AND_VALUE}" 
  fi
  FIELD_AND_VALUE=$(echo "${i}" | cut -f4- -d"${DELIMITER}")

  echo "${xTIMESTAMP}: ${MEASUREMENT}${TAG_AND_VALUE} ${FIELD_AND_VALUE} ${TIMESTAMP}"
  

  # InfluxDB
  # curl -i -XPOST 'http://localhost:8086/write?db=mydb' --data-binary \ 
  #   'cpu_load_short,host=server01,region=us-west value=0.64 1434055562000000000'
  curl --silent -i -XPOST 'http://localhost:8086/write?db=service_catalog&precision=s' --data-binary \
    "${MEASUREMENT}${TAG_AND_VALUE} ${FIELD_AND_VALUE} ${TIMESTAMP}" > /dev/null

  unset xTIMESTAMP
  unset TIMESTAMP
  unset MEASUREMENT
  unset TAG_AND_VALUE
  unset FIELD_AND_VALUE
done
