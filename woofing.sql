-- MySQL Script generated by MySQL Workbench
-- Mon Mar 15 16:59:56 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema woofing
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `woofing` ;

-- -----------------------------------------------------
-- Schema woofing
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `woofing` DEFAULT CHARACTER SET utf8 ;
USE `woofing` ;

-- -----------------------------------------------------
-- Table `woofing`.`activities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `woofing`.`activities` ;

CREATE TABLE IF NOT EXISTS `woofing`.`activities` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `woofing`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `woofing`.`user` ;

CREATE TABLE IF NOT EXISTS `woofing`.`user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `mail` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `woofing`.`host`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `woofing`.`host` ;

CREATE TABLE IF NOT EXISTS `woofing`.`host` (
  `user_id` INT(11) NOT NULL,
  `adress` VARCHAR(45) NOT NULL,
  `place_type` VARCHAR(45) NOT NULL,
  `profession_type` VARCHAR(45) NOT NULL,
  `capacity` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  INDEX `fk_host_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_host_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `woofing`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `woofing`.`project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `woofing`.`project` ;

CREATE TABLE IF NOT EXISTS `woofing`.`project` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `host_user_id` INT(11) NOT NULL,
  `beginning` DATE NOT NULL,
  `ending` DATE NOT NULL,
  `max_workers` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `host_user_id`),
  INDEX `fk_project_host1_idx` (`host_user_id` ASC),
  CONSTRAINT `fk_project_host1`
    FOREIGN KEY (`host_user_id`)
    REFERENCES `woofing`.`host` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `woofing`.`project_has_activities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `woofing`.`project_has_activities` ;

CREATE TABLE IF NOT EXISTS `woofing`.`project_has_activities` (
  `project_id` INT(11) NOT NULL,
  `Activities_id` INT(11) NOT NULL,
  PRIMARY KEY (`project_id`, `Activities_id`),
  INDEX `fk_project_has_Activities_Activities1_idx` (`Activities_id` ASC),
  INDEX `fk_project_has_Activities_project1_idx` (`project_id` ASC),
  CONSTRAINT `fk_project_has_Activities_Activities1`
    FOREIGN KEY (`Activities_id`)
    REFERENCES `woofing`.`activities` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_project_has_Activities_project1`
    FOREIGN KEY (`project_id`)
    REFERENCES `woofing`.`project` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `woofing`.`user_has_activities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `woofing`.`user_has_activities` ;

CREATE TABLE IF NOT EXISTS `woofing`.`user_has_activities` (
  `user_id` INT(11) NOT NULL,
  `Activities_id` INT(11) NOT NULL,
  `level` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`, `Activities_id`),
  INDEX `fk_user_has_Activities_Activities1_idx` (`Activities_id` ASC),
  INDEX `fk_user_has_Activities_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_Activities_Activities1`
    FOREIGN KEY (`Activities_id`)
    REFERENCES `woofing`.`activities` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_Activities_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `woofing`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `woofing`.`user_has_project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `woofing`.`user_has_project` ;

CREATE TABLE IF NOT EXISTS `woofing`.`user_has_project` (
  `user_id` INT(11) NOT NULL,
  `abscent` TINYINT(4) NULL DEFAULT NULL,
  `arrival` DATE NOT NULL,
  `departure` DATE NOT NULL,
  `project_id` INT(11) NOT NULL,
  INDEX `fk_user_has_project_user1_idx` (`user_id` ASC),
  INDEX `fk_user_has_project_project1_idx` (`project_id` ASC),
  CONSTRAINT `fk_user_has_project_project1`
    FOREIGN KEY (`project_id`)
    REFERENCES `woofing`.`project` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_project_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `woofing`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `woofing`.`woofing`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `woofing`.`woofing` ;

CREATE TABLE IF NOT EXISTS `woofing`.`woofing` (
  `user_id` INT(11) NOT NULL,
  `host_user_id` INT(11) NOT NULL,
  `arrival` DATE NOT NULL,
  `departure` DATE NOT NULL,
  `validated` TINYINT(4) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`, `host_user_id`),
  INDEX `fk_user_has_host_host1_idx` (`host_user_id` ASC),
  INDEX `fk_user_has_host_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_host_host1`
    FOREIGN KEY (`host_user_id`)
    REFERENCES `woofing`.`host` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_host_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `woofing`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

SELECT 'Loading Activities' AS 'INFO';
source C:/Users/El Figuer/Desktop/project_sql/load_activities.dump ;

SELECT 'Loading Users' AS 'INFO';
source C:/Users/El Figuer/Desktop/project_sql/load_users.dump ;

SELECT 'Loading Hosts' AS 'INFO';
source C:/Users/El Figuer/Desktop/project_sql/load_hosts.dump ;

SELECT 'Loading Projects' AS 'INFO';
source C:/Users/El Figuer/Desktop/project_sql/load_projects.dump ;

SELECT 'Loading User has Activities' AS 'INFO';
source C:/Users/El Figuer/Desktop/project_sql/load_user_has_activities.dump ;

SELECT 'Loading Projects has activites' AS 'INFO';
source C:/Users/El Figuer/Desktop/project_sql/load_project_has_activities.dump ;

SELECT 'Loading User has Project' AS 'INFO';
source C:/Users/El Figuer/Desktop/project_sql/load_user_has_project.dump ;

SELECT 'Loading Woofing' AS 'INFO';
source C:/Users/El Figuer/Desktop/project_sql/load_woofing.dump ;