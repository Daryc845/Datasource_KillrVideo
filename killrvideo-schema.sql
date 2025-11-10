
DROP DATABASE IF EXISTS killrvideo;
CREATE DATABASE killrvideo;
USE killrvideo;

CREATE TABLE user_credentials (
    email VARCHAR(255) PRIMARY KEY,
    password VARCHAR(255),
    userid CHAR(36)
);

CREATE TABLE users (
    userid CHAR(36) PRIMARY KEY,
    firstname VARCHAR(100),
    lastname VARCHAR(100),
    email VARCHAR(255),
    created_date DATETIME
);

CREATE INDEX idx_firstname ON users (firstname);
CREATE INDEX idx_lastname ON users (lastname);
CREATE INDEX idx_email ON users (email);
CREATE INDEX idx_created_date ON users (created_date);

CREATE TABLE video_metadata (
    id INT AUTO_INCREMENT PRIMARY KEY,
    videoid CHAR(36),
    height INT,
    width INT,
    encoding VARCHAR(50)
);

CREATE TABLE videos (
    videoid CHAR(36) PRIMARY KEY,
    userid CHAR(36),
    name VARCHAR(255),
    description TEXT,
    location TEXT,
    location_type INT,
    added_date DATETIME,
    FOREIGN KEY (userid) REFERENCES users(userid)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE preview_thumbnails (
    videoid CHAR(36),
    position_key VARCHAR(50),
    url TEXT,
    PRIMARY KEY (videoid, position_key),
    FOREIGN KEY (videoid) REFERENCES videos(videoid)
        ON DELETE CASCADE
);

CREATE TABLE video_tags (
    videoid CHAR(36),
    tag VARCHAR(100),
    PRIMARY KEY (videoid, tag),
    FOREIGN KEY (videoid) REFERENCES videos(videoid)
        ON DELETE CASCADE
);

CREATE TABLE videos_by_location (
    location TEXT,
    videoid CHAR(36),
    userid CHAR(36),
    added_date DATETIME,
    PRIMARY KEY (location(100), videoid)
);

CREATE TABLE user_videos (
    userid CHAR(36),
    added_date DATETIME,
    videoid CHAR(36),
    name VARCHAR(255),
    preview_image_location TEXT,
    PRIMARY KEY (userid, added_date, videoid)
);

CREATE TABLE latest_videos (
    yyyymmdd CHAR(10),
    added_date DATETIME,
    videoid CHAR(36),
    name VARCHAR(255),
    preview_image_location TEXT,
    PRIMARY KEY (yyyymmdd, added_date, videoid)
);

CREATE TABLE video_rating (
    videoid CHAR(36) PRIMARY KEY,
    rating_counter BIGINT,
    rating_total BIGINT
);

CREATE TABLE video_ratings_by_user (
    videoid CHAR(36),
    userid CHAR(36),
    rating INT,
    PRIMARY KEY (videoid, userid)
);

CREATE TABLE videos_by_tag (
    tag VARCHAR(100),
    videoid CHAR(36),
    added_date DATETIME,
    name VARCHAR(255),
    preview_image_location TEXT,
    tagged_date DATETIME,
    PRIMARY KEY (tag, videoid)
);

CREATE TABLE tags_by_letter (
    first_letter CHAR(1),
    tag VARCHAR(100),
    PRIMARY KEY (first_letter, tag)
);

CREATE TABLE comments_by_video (
    videoid CHAR(36),
    commentid CHAR(36),
    userid CHAR(36),
    comment TEXT,
    PRIMARY KEY (videoid, commentid)
);

CREATE TABLE comments_by_user (
    userid CHAR(36),
    commentid CHAR(36),
    videoid CHAR(36),
    comment TEXT,
    PRIMARY KEY (userid, commentid)
);

CREATE TABLE video_event (
    videoid CHAR(36),
    userid CHAR(36),
    preview_image_location TEXT,
    event VARCHAR(50),
    event_timestamp CHAR(36),
    video_timestamp BIGINT,
    PRIMARY KEY (videoid, userid, event_timestamp, event)
);

CREATE TABLE uploaded_videos (
    videoid CHAR(36) PRIMARY KEY,
    userid CHAR(36),
    name VARCHAR(255),
    description TEXT,
    added_date DATETIME,
    jobid VARCHAR(100)
);

CREATE TABLE uploaded_videos_by_jobid (
    jobid VARCHAR(100) PRIMARY KEY,
    videoid CHAR(36),
    userid CHAR(36),
    name VARCHAR(255),
    description TEXT,
    added_date DATETIME
);

CREATE TABLE encoding_job_notifications (
    jobid VARCHAR(100),
    status_date DATETIME,
    etag VARCHAR(255),
    newstate VARCHAR(50),
    oldstate VARCHAR(50),
    PRIMARY KEY (jobid, status_date, etag)
);
