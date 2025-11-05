#!/bin/bash

OUTFILE="inserts_100k.cql"
KEYSPACE="killrvideo"
TABLE="videos"
N=100000

echo "Generando archivo con $N inserciones para la tabla $KEYSPACE.$TABLE..."
echo "USE $KEYSPACE;" > $OUTFILE
echo "BEGIN BATCH" >> $OUTFILE

for ((i=1; i<=$N; i++)); do
  echo "INSERT INTO $TABLE (videoid, userid, name, description, added_date)
  VALUES (uuid(), uuid(), 'Video_$i', 'Descripción generada $i', toTimestamp(now()));" >> $OUTFILE
  if (( i % 1000 == 0 )); then
    echo "APPLY BATCH;" >> $OUTFILE
    echo "BEGIN BATCH" >> $OUTFILE
  fi
done

echo "APPLY BATCH;" >> $OUTFILE
echo "Archivo $OUTFILE generado con éxito"
