CREATE DATABASE series_db;
USE series_db;

CREATE TABLE reviewers (
    id SERIAL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    PRIMARY KEY(id)
);
 
CREATE TABLE series (
    id SERIAL,
    title VARCHAR(100),
    released_year YEAR,
    genre VARCHAR(100),
    PRIMARY KEY(id)
);
 
CREATE TABLE reviews (
    id SERIAL,
    rating DECIMAL(2, 1),
    series_id BIGINT UNSIGNED,
    reviewer_id BIGINT UNSIGNED,
    PRIMARY KEY(id),
    FOREIGN KEY (series_id) REFERENCES series (id),
    FOREIGN KEY (reviewer_id) REFERENCES reviewers (id)
);