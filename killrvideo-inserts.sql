-- ======================================================
-- KillrVideo Sample Data (MySQL Equivalent)
-- ======================================================
USE killrvideo;

-- =====================================
-- USER CREDENTIALS
-- =====================================
INSERT INTO user_credentials (userid, email, password) VALUES
('d0f60aa8-54a9-4840-b70c-fe562b68842b','tcodd@relational.com','5f4dcc3b5aa765d61d8327deb882cf99'),
('522b1fe2-2e36-4cef-a667-cd4237d08b89','cdate@relational.com','6cb75f652a9b52798eb6cf2201057c73'),
('9761d3d7-7fbd-4269-9988-6cfd4e188678','patrick@datastax.com','ba27e03fd95e507daf2937c937d499ab'),
('99999999-9999-9999-9999-999999999999','jenifer@datastax.com','hj32hj4h2jhjhjhj23h3jhj23hjkh233');

-- =====================================
-- USERS
-- =====================================
INSERT INTO users (userid, firstname, lastname, email, created_date) VALUES
('d0f60aa8-54a9-4840-b70c-fe562b68842b','Ted','Codd','tcodd@relational.com','2011-06-01 08:00:00'),
('522b1fe2-2e36-4cef-a667-cd4237d08b89','Chris','Date','cdate@relational.com','2011-06-20 13:50:00'),
('9761d3d7-7fbd-4269-9988-6cfd4e188678','Patrick','McFadin','patrick@datastax.com','2011-06-20 13:50:00'),
('99999999-9999-9999-9999-999999999999','Jenifer','Pacheco','jenifer@datastax.com','2012-07-20 14:55:00');

-- =====================================
-- VIDEOS
-- =====================================
INSERT INTO videos (videoid, userid, name, description, location, location_type, added_date) VALUES
('99051fe9-6a9c-46c2-b949-38ef78858dd0','d0f60aa8-54a9-4840-b70c-fe562b68842b','My funny cat','My cat likes to play the piano! So funny.','/us/vid/b3/b3a76c6b-7c7f-4af6-964f-803a9283c401',1,'2012-06-01 08:00:00'),
('b3a76c6b-7c7f-4af6-964f-803a9283c401','d0f60aa8-54a9-4840-b70c-fe562b68842b','Now my dog plays piano!','My dog learned to play the piano because of the cat.','/us/vid/b3/b3a76c6b-7c7f-4af6-964f-803a9283c401',1,'2012-08-30 16:50:00'),
('0c3f7e87-f6b6-41d2-9668-2b64d117102c','522b1fe2-2e36-4cef-a667-cd4237d08b89','An Introduction to Database Systems','An overview of my book','/us/vid/0c/0c3f7e87-f6b6-41d2-9668-2b64d117102c',1,'2012-09-03 10:30:00'),
('416a5ddc-00a5-49ed-adde-d99da9a27c0c','522b1fe2-2e36-4cef-a667-cd4237d08b89','Intro to CAP theorem','I think there might be something to this.','/us/vid/41/416a5ddc-00a5-49ed-adde-d99da9a27c0c',1,'2012-12-01 11:29:00'),
('06049cbb-dfed-421f-b889-5f649a0de1ed','9761d3d7-7fbd-4269-9988-6cfd4e188678','The data model is dead. Long live the data model.','First in a three part series for Cassandra Data Modeling','http://www.youtube.com/watch?v=px6U2n74q3g',1,'2013-05-02 12:30:29'),
('873ff430-9c23-4e60-be5f-278ea2bb21bd','9761d3d7-7fbd-4269-9988-6cfd4e188678','Become a Super Modeler','Second in a three part series for Cassandra Data Modeling','http://www.youtube.com/watch?v=qphhxujn5Es',1,'2013-05-16 16:50:00'),
('49f64d40-7d89-4890-b910-dbf923563a33','9761d3d7-7fbd-4269-9988-6cfd4e188678','The World''s Next Top Data Model','Third in a three part series for Cassandra Data Modeling','http://www.youtube.com/watch?v=HdJlsOZVGwM',1,'2013-06-11 11:00:00');

-- =====================================
-- USER_VIDEOS
-- =====================================
INSERT INTO user_videos (userid, videoid, added_date, name, preview_image_location) VALUES
('d0f60aa8-54a9-4840-b70c-fe562b68842b','99051fe9-6a9c-46c2-b949-38ef78858dd0','2012-06-01 08:00:00','My funny cat','/us/vid/b3/b3a76c6b-7c7f-4af6-964f-803a9283c401'),
('d0f60aa8-54a9-4840-b70c-fe562b68842b','b3a76c6b-7c7f-4af6-964f-803a9283c401','2012-08-30 16:50:00','Now my dog plays piano!','/us/vid/b3/b3a76c6b-7c7f-4af6-964f-803a9283c401'),
('522b1fe2-2e36-4cef-a667-cd4237d08b89','0c3f7e87-f6b6-41d2-9668-2b64d117102c','2013-05-02 12:30:29','An Introduction to Database Systems','/us/vid/0c/0c3f7e87-f6b6-41d2-9668-2b64d117102c'),
('522b1fe2-2e36-4cef-a667-cd4237d08b89','416a5ddc-00a5-49ed-adde-d99da9a27c0c','2012-12-01 11:29:00','Intro to CAP theorem','/us/vid/41/416a5ddc-00a5-49ed-adde-d99da9a27c0c'),
('9761d3d7-7fbd-4269-9988-6cfd4e188678','06049cbb-dfed-421f-b889-5f649a0de1ed','2013-05-02 12:30:29','The data model is dead. Long live the data model.','http://www.youtube.com/watch?v=px6U2n74q3g'),
('9761d3d7-7fbd-4269-9988-6cfd4e188678','873ff430-9c23-4e60-be5f-278ea2bb21bd','2013-05-16 16:50:00','Become a Super Modeler','http://www.youtube.com/watch?v=qphhxujn5Es'),
('9761d3d7-7fbd-4269-9988-6cfd4e188678','49f64d40-7d89-4890-b910-dbf923563a33','2013-06-11 11:00:00','The World''s Next Top Data Model','http://www.youtube.com/watch?v=HdJlsOZVGwM');

-- =====================================
-- LATEST_VIDEOS
-- =====================================
INSERT INTO latest_videos (yyyymmdd, videoid, added_date, name, preview_image_location) VALUES
('2012-06-01','99051fe9-6a9c-46c2-b949-38ef78858dd0','2012-06-01 08:00:00','My funny cat','/us/vid/b3/b3a76c6b-7c7f-4af6-964f-803a9283c401'),
('2012-08-30','b3a76c6b-7c7f-4af6-964f-803a9283c401','2012-08-30 16:50:00','Now my dog plays piano!','/us/vid/b3/b3a76c6b-7c7f-4af6-964f-803a9283c401'),
('2013-05-02','0c3f7e87-f6b6-41d2-9668-2b64d117102c','2013-05-02 12:30:29','An Introduction to Database Systems','/us/vid/0c/0c3f7e87-f6b6-41d2-9668-2b64d117102c'),
('2012-12-01','416a5ddc-00a5-49ed-adde-d99da9a27c0c','2012-12-01 11:29:00','Intro to CAP theorem','/us/vid/41/416a5ddc-00a5-49ed-adde-d99da9a27c0c'),
('2013-05-02','06049cbb-dfed-421f-b889-5f649a0de1ed','2013-05-02 12:30:29','The data model is dead. Long live the data model.','http://www.youtube.com/watch?v=px6U2n74q3g'),
('2013-05-16','873ff430-9c23-4e60-be5f-278ea2bb21bd','2013-05-16 16:50:00','Become a Super Modeler','http://www.youtube.com/watch?v=qphhxujn5Es'),
('2013-06-11','49f64d40-7d89-4890-b910-dbf923563a33','2013-06-11 11:00:00','The World''s Next Top Data Model','http://www.youtube.com/watch?v=HdJlsOZVGwM');

-- =====================================
-- VIDEO RATINGS (counter simulation)
-- =====================================
INSERT INTO video_rating (videoid, rating_counter, rating_total) VALUES
('99051fe9-6a9c-46c2-b949-38ef78858dd0',3,12);

-- =====================================
-- VIDEO_RATINGS_BY_USER
-- =====================================
INSERT INTO video_ratings_by_user (videoid, userid, rating) VALUES
('99051fe9-6a9c-46c2-b949-38ef78858dd0','9761d3d7-7fbd-4269-9988-6cfd4e188678',3),
('99051fe9-6a9c-46c2-b949-38ef78858dd0','99999999-9999-9999-9999-999999999999',5),
('99051fe9-6a9c-46c2-b949-38ef78858dd0','522b1fe2-2e36-4cef-a667-cd4237d08b89',4);

-- =====================================
-- VIDEOS_BY_TAG
-- =====================================
INSERT INTO videos_by_tag (tag, videoid, tagged_date, added_date, name, preview_image_location) VALUES
('cats','99051fe9-6a9c-46c2-b949-38ef78858dd0','2012-05-25 08:30:29','2012-06-01 08:00:00','My funny cat','/us/vid/b3/b3a76c6b-7c7f-4af6-964f-803a9283c401'),
('piano','99051fe9-6a9c-46c2-b949-38ef78858dd0','2012-05-25 08:30:29','2012-06-01 08:00:00','My funny cat','/us/vid/b3/b3a76c6b-7c7f-4af6-964f-803a9283c401'),
('lol','99051fe9-6a9c-46c2-b949-38ef78858dd0','2012-05-25 08:30:29','2012-06-01 08:00:00','My funny cat','/us/vid/b3/b3a76c6b-7c7f-4af6-964f-803a9283c401'),
('dogs','b3a76c6b-7c7f-4af6-964f-803a9283c401','2012-08-30 16:50:00','2012-08-30 16:50:00','Now my dog plays piano!','/us/vid/b3/b3a76c6b-7c7f-4af6-964f-803a9283c401'),
('piano','b3a76c6b-7c7f-4af6-964f-803a9283c401','2012-08-30 16:50:00','2012-08-30 16:50:00','Now my dog plays piano!','/us/vid/b3/b3a76c6b-7c7f-4af6-964f-803a9283c401'),
('lol','b3a76c6b-7c7f-4af6-964f-803a9283c401','2012-08-30 16:50:00','2012-08-30 16:50:00','Now my dog plays piano!','/us/vid/b3/b3a76c6b-7c7f-4af6-964f-803a9283c401');

-- =====================================
-- COMMENTS_BY_VIDEO (BATCH)
-- =====================================
INSERT INTO comments_by_video (videoid, userid, commentid, comment) VALUES
('99051fe9-6a9c-46c2-b949-38ef78858dd0','d0f60aa8-54a9-4840-b70c-fe562b68842b',UUID(),'Worst. Video. Ever.'),
('99051fe9-6a9c-46c2-b949-38ef78858dd0','522b1fe2-2e36-4cef-a667-cd4237d08b89',UUID(),'It is amazing');

-- =====================================
-- VIDEO_EVENT
-- =====================================
INSERT INTO video_event (videoid, userid, event, event_timestamp, video_timestamp) VALUES
('99051fe9-6a9c-46c2-b949-38ef78858dd0','d0f60aa8-54a9-4840-b70c-fe562b68842b','start',NOW(),0),
('99051fe9-6a9c-46c2-b949-38ef78858dd0','d0f60aa8-54a9-4840-b70c-fe562b68842b','stop',NOW(),30000),
('99051fe9-6a9c-46c2-b949-38ef78858dd0','99999999-9999-9999-9999-999999999999','start',NOW(),3000),
('99051fe9-6a9c-46c2-b949-38ef78858dd0','99999999-9999-9999-9999-999999999999','stop',NOW(),230000);
