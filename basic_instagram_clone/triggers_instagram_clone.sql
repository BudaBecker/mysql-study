DELIMITER $$

CREATE TRIGGER prevent_self_follows
	BEFORE INSERT ON follows FOR EACH ROW
	BEGIN
		IF NEW.follower_id = NEW.followee_id
        THEN
			SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'You cannot follow yourself!';
		END IF;
    END;

CREATE TRIGGER capture_unfollow
	AFTER DELETE ON follows FOR EACH ROW
	BEGIN
		INSERT INTO unfollows (follower_id, followee_id) 
        VALUES (OLD.follower_id, OLD.followee_id);
	END;

CREATE TRIGGER clear_unfollow_after_follow
	AFTER INSERT ON follows FOR EACH ROW
	BEGIN
		DELETE FROM unfollows
		WHERE  follower_id = NEW.follower_id AND  followee_id = NEW.followee_id;
	END;

$$
DELIMITER ;