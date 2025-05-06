DROP DATABASE ig_clone;
CREATE DATABASE IF NOT EXISTS ig_clone;
USE ig_clone;

CREATE TABLE users (
	id SERIAL PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photos (
	id SERIAL PRIMARY KEY,
    image_url VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    user_id BIGINT UNSIGNED,
    CONSTRAINT fk_user_photo FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE comments (
	id SERIAL PRIMARY KEY,
    comment_text VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    user_id BIGINT UNSIGNED,
	photo_id BIGINT UNSIGNED,
    CONSTRAINT fk_user_comment FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_commented_photo FOREIGN KEY (photo_id) REFERENCES photos(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE likes (
	created_at TIMESTAMP DEFAULT NOW(),
    user_id BIGINT UNSIGNED,
    photo_id BIGINT UNSIGNED,
    CONSTRAINT fk_user_like FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_photo_like FOREIGN KEY (photo_id) REFERENCES photos(id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT user_already_liked PRIMARY KEY (user_id, photo_id)
);

CREATE TABLE follows (
	created_at TIMESTAMP DEFAULT NOW(),
    follower_id BIGINT UNSIGNED,
    followee_id BIGINT UNSIGNED,
    CONSTRAINT fk_follower_follows FOREIGN KEY (follower_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_followee_follows FOREIGN KEY (followee_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT already_follows PRIMARY KEY (follower_id, followee_id)
);

CREATE TABLE unfollows (
	created_at TIMESTAMP DEFAULT NOW(),
    follower_id BIGINT UNSIGNED,
    followee_id BIGINT UNSIGNED,
    CONSTRAINT fk_follower_unfollows FOREIGN KEY (follower_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_followee_unfollows FOREIGN KEY (followee_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT already_unfollows PRIMARY KEY (follower_id, followee_id)
);

CREATE TABLE tags (
	id SERIAL PRIMARY KEY,
    tag_name VARCHAR(255) UNIQUE NOT NULL,
	created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photo_tags (
	photo_id BIGINT UNSIGNED,
    tag_id BIGINT UNSIGNED,
    FOREIGN KEY (photo_id) REFERENCES photos(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES tags(id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT already_tagged PRIMARY KEY (photo_id, tag_id)
);