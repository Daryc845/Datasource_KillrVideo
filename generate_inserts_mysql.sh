#!/bin/bash

OUTFILE="inserts_100k_mysql.sql"
DB="killrvideo"
TABLE="user_videos"
N=100000

USER_IDS=(
  "d0f60aa8-54a9-4840-b70c-fe562b68842b"
  "522b1fe2-2e36-4cef-a667-cd4237d08b89"
  "9761d3d7-7fbd-4269-9988-6cfd4e188678"
)

VIDEO_IDS=(
  "99051fe9-6a9c-46c2-b949-38ef78858dd0"
  "b3a76c6b-7c7f-4af6-964f-803a9283c401"
  "0c3f7e87-f6b6-41d2-9668-2b64d117102c"
  "416a5ddc-00a5-49ed-adde-d99da9a27c0c"
  "06049cbb-dfed-421f-b889-5f649a0de1ed"
  "873ff430-9c23-4e60-be5f-278ea2bb21bd"
  "49f64d40-7d89-4890-b910-dbf923563a33"
)

echo "Generando archivo con $N inserciones para la tabla $TABLE..."
echo "USE $DB;" > $OUTFILE

for ((i=1; i<=N; i++)); do
  USER_ID=${USER_IDS[$((RANDOM % ${#USER_IDS[@]}))]}
  VIDEO_ID=${VIDEO_IDS[$((RANDOM % ${#VIDEO_IDS[@]}))]}
  ADDED_DATE=$(date -u -d "$BASE_DATE + $i seconds" +"%Y-%m-%d %H:%M:%S")

  echo "INSERT INTO $TABLE (userid, added_date, videoid, name, preview_image_location)
  VALUES ('$USER_ID', '$ADDED_DATE', '$VIDEO_ID', 'Video_$i', 'https://cdn.killrvideo.com/thumbs/video_$i.jpg');" >> $OUTFILE
done

echo "Archivo $OUTFILE generado para la tabla $TABLE"
