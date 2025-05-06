USE ig_clone;

-- 1) Find the 5 oldest users.
SELECT username, created_at
FROM users
ORDER BY created_at
LIMIT 5;

-- 2) What day of the week do most users register on?
SELECT 
	DAYNAME(created_at) AS week_day,
    COUNT(DAYNAME(created_at)) AS register_count
FROM users
GROUP BY week_day
ORDER BY register_count DESC;

-- 3) Find the users who have never posted a photo.
SELECT users.username
FROM users
LEFT JOIN photos ON photos.user_id = users.id
WHERE photos.id IS NULL;

-- 4) Find the user who has the most liked photo.
SELECT 
	users.username,
    COUNT(likes.photo_id) AS likes_count,
    photos.image_url
FROM photos
JOIN likes ON likes.photo_id = photos.id
JOIN users ON users.id = photos.user_id
GROUP BY likes.photo_id
ORDER BY likes_count DESC
LIMIT 1;

-- 5) How many times does the average user posts?
SELECT (SELECT Count(*) FROM photos) / (SELECT Count(*) FROM users) AS avg_posts; 

-- 6) What are the top 5 most commonly used hashtags?
SELECT
	tags.tag_name AS tag,
	COUNT(photo_tags.tag_id) AS times_used
FROM photo_tags
JOIN tags ON tags.id = photo_tags.tag_id
GROUP BY tag
ORDER BY times_used DESC
LIMIT 5;

-- 7) Find users who have liked every single photo on the site.
SELECT
	users.username AS bot_users,
    COUNT(likes.user_id) AS total_likes
FROM users
JOIN likes ON likes.user_id = users.id
GROUP BY bot_users
HAVING total_likes = (SELECT Count(*) FROM photos);