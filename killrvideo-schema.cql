DROP KEYSPACE IF EXISTS killrvideo;
CREATE KEYSPACE killrvideo 
WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 3 };

USE killrvideo;

-- Tabla de credenciales de usuario
CREATE TABLE user_credentials (
   email text,
   password text,
   userid uuid,
   PRIMARY KEY (email)
);

-- Tabla principal de usuarios
CREATE TABLE users (
   userid uuid,
   firstname varchar,
   lastname varchar,
   email text,
   created_date timestamp,
   PRIMARY KEY (userid)
);

-- Tipo definido por el usuario
CREATE TYPE video_metadata (
   height int,
   width int,
   video_bit_rate set<text>,
   encoding text
);

-- Tabla de videos
CREATE TABLE videos (
   videoid uuid,
   userid uuid,
   name varchar,
   description varchar,
   location text,
   location_type int,
   preview_thumbnails map<text,text>,
   tags set<varchar>,
   metadata set<frozen<video_metadata>>,
   added_date timestamp,
   PRIMARY KEY (videoid)
);

-- Tabla relacional usuario → videos
CREATE TABLE user_videos (
   userid uuid,
   added_date timestamp,
   videoid uuid,
   name text,
   preview_image_location text,
   PRIMARY KEY ((userid), added_date, videoid)
) WITH CLUSTERING ORDER BY (added_date DESC, videoid ASC);

-- Últimos videos (agrupados por día)
CREATE TABLE latest_videos (
   yyyymmdd text,
   added_date timestamp,
   videoid uuid,
   name text,
   preview_image_location text,
   PRIMARY KEY (yyyymmdd, added_date, videoid)
) WITH CLUSTERING ORDER BY (added_date DESC, videoid ASC);

-- Contador de calificaciones
CREATE TABLE video_rating (
   videoid uuid,
   rating_counter counter,
   rating_total counter,
   PRIMARY KEY (videoid)
);

-- Calificaciones de videos por usuario
CREATE TABLE video_ratings_by_user (
   videoid uuid,
   userid uuid,
   rating int,
   PRIMARY KEY (videoid, userid)
);

-- Videos agrupados por etiqueta
CREATE TABLE videos_by_tag (
   tag text,
   videoid uuid,
   added_date timestamp,
   name text,
   preview_image_location text,
   tagged_date timestamp,
   PRIMARY KEY (tag, videoid)
);

-- Etiquetas agrupadas por primera letra
CREATE TABLE tags_by_letter (
   first_letter text,
   tag text,
   PRIMARY KEY (first_letter, tag)
);

-- Comentarios por video
CREATE TABLE comments_by_video (
   videoid uuid,
   commentid timeuuid,
   userid uuid,
   comment text,
   PRIMARY KEY (videoid, commentid)
) WITH CLUSTERING ORDER BY (commentid DESC);

-- Comentarios por usuario
CREATE TABLE comments_by_user (
   userid uuid,
   commentid timeuuid,
   videoid uuid,
   comment text,
   PRIMARY KEY (userid, commentid)
) WITH CLUSTERING ORDER BY (commentid DESC);

-- Eventos de video (ej: reproducción, pausa, etc.)
CREATE TABLE video_event (
   videoid uuid,
   userid uuid,
   preview_image_location text static,
   event varchar,
   event_timestamp timeuuid,
   video_timestamp bigint,
   PRIMARY KEY ((videoid, userid), event_timestamp, event)
) WITH CLUSTERING ORDER BY (event_timestamp DESC, event ASC);

-- Videos subidos
CREATE TABLE uploaded_videos (
    videoid uuid,
    userid uuid,
    name text,
    description text,
    tags set<text>,
    added_date timestamp,
    jobid text,
    PRIMARY KEY (videoid)
);

-- Videos subidos por job ID
CREATE TABLE uploaded_videos_by_jobid (
    jobid text,
    videoid uuid,
    userid uuid,
    name text,
    description text,
    tags set<text>,
    added_date timestamp,
    PRIMARY KEY (jobid)
);

-- Log de notificaciones de trabajos de codificación
CREATE TABLE encoding_job_notifications (
    jobid text,
    status_date timestamp,
    etag text,
    newstate text,
    oldstate text,
    PRIMARY KEY (jobid, status_date, etag)
) WITH CLUSTERING ORDER BY (status_date DESC, etag ASC);
