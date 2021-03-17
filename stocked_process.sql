USE woofing;
DROP PROCEDURE IF EXISTS get_user_projects;
DROP PROCEDURE IF EXISTS add_user_to_project;
DROP PROCEDURE IF EXISTS set_worker_as_abscent;

DELIMITER $$

CREATE PROCEDURE get_user_projects(id_user INT)
BEGIN
	SELECT u.name, p.* FROM user u
    JOIN user_has_project uhp ON u.id = uhp.user_id 
    JOIN project p 
    ON p.id = project_id 
    WHERE u.id = id_user;
END $$

CREATE PROCEDURE add_user_to_project(id_user INT, id_project INT, arrive DATE, go DATE)
BEGIN
	INSERT INTO user_has_project VALUES (id_user, 0, arrive, go, id_project);
END$$

CREATE PROCEDURE set_worker_as_abscent(id_user INT, id_project INT)
BEGIN
	UPDATE user_has_project
    SET abscent = 1
    WHERE user_id = id_user AND project_id = id_project;
END$$
CALL get_user_projects(1);