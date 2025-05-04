-- AVG rating per genre
SELECT genre, AVG(rating) as review_avg
FROM series
JOIN reviews ON reviews.series_id = series.id
GROUP BY genre
ORDER BY review_avg;

-- Reviews by reviwer full name
SELECT 
	CONCAT_WS(' ', reviewers.first_name, reviewers.last_name) AS reviewer_name,
    series.title AS reviewed_series,
    reviews.rating AS rating
FROM reviewers
JOIN reviews ON reviews.reviewer_id = reviewers.id
JOIN series ON series.id = reviews.series_id;

-- AVG rating per reviwer
SELECT 
	CONCAT_WS(' ', reviewers.first_name, reviewers.last_name) AS reviewer_name,
    AVG(reviews.rating) AS rating_avg
FROM reviewers
JOIN reviews ON reviews.reviewer_id = reviewers.id
GROUP BY reviewer_name
ORDER BY rating_avg DESC;

-- no reviwed series
SELECT series.title AS non_reviwed
FROM series
LEFT JOIN reviews ON reviews.series_id = series.id
WHERE rating IS NULL;

-- Reviwer status
SELECT 
	CONCAT_WS(' ', reviewers.first_name, reviewers.last_name) AS reviewer_name,
    COUNT(reviews.rating) AS COUNT,
    IFNULL(MIN(reviews.rating), 0) AS MIN,
    IFNULL(MAX(reviews.rating), 0) AS MAX,
    ROUND(IFNULL(AVG(reviews.rating), 0), 2) AS AVG,
    IF(COUNT(reviews.rating) > 0, 'ACTIVE', 'INACTIVE') AS status -- use IF for only true or false, use CASE for multiple cases (if, elif, else)
FROM reviewers
LEFT JOIN reviews ON reviews.reviewer_id = reviewers.id
LEFT JOIN series ON series.id = reviews.series_id
GROUP BY reviewer_name;