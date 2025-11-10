#!/bin/bash

OUTFILE="inserts_100k_no_batch.cql"
KEYSPACE="killrvideo"
TABLE="user_videos"
N=100000

USER_IDS=(
  "11111111-1111-1111-1111-111111111111"
  "22222222-2222-2222-2222-222222222222"
  "33333333-3333-3333-3333-333333333333"
  "44444444-4444-4444-4444-444444444444"
)

echo "Generando archivo con $N inserciones para la tabla $KEYSPACE.$TABLE..."
echo "USE $KEYSPACE;" > $OUTFILE

for ((i=1; i<=$N; i++)); do
  USER_ID=${USER_IDS[$((RANDOM % ${#USER_IDS[@]}))]}
  echo "INSERT INTO $TABLE (userid, added_date, videoid, name, preview_image_location)
  VALUES ($USER_ID, toTimestamp(now()), uuid(), 'Video_$i', 'https://cdn.killrvideo.com/thumbs/video_$i.jpg');" >> $OUTFILE
done

echo "Archivo $OUTFILE generado para la tabla $TABLE"
