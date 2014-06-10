SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema borrowerdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `borrowerdb` DEFAULT CHARACTER SET utf8 ;
USE `borrowerdb` ;

-- -----------------------------------------------------
-- Table `borrowerdb`.`UserConnection`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borrowerdb`.`UserConnection` ;

CREATE TABLE IF NOT EXISTS `borrowerdb`.`UserConnection` (
  `userId` VARCHAR(255) NOT NULL,
  `providerId` VARCHAR(255) NOT NULL,
  `providerUserId` VARCHAR(255) NOT NULL DEFAULT '',
  `rank` INT(11) NOT NULL,
  `displayName` VARCHAR(255) NULL DEFAULT NULL,
  `profileUrl` VARCHAR(512) NULL DEFAULT NULL,
  `imageUrl` VARCHAR(512) NULL DEFAULT NULL,
  `accessToken` VARCHAR(255) NOT NULL,
  `secret` VARCHAR(255) NULL DEFAULT NULL,
  `refreshToken` VARCHAR(255) NULL DEFAULT NULL,
  `expireTime` BIGINT(20) NULL DEFAULT NULL,
  PRIMARY KEY (`userId`, `providerId`, `providerUserId`),
  UNIQUE INDEX `UserConnectionRank` (`userId` ASC, `providerId` ASC, `rank` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `borrowerdb`.`items`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borrowerdb`.`items` ;

CREATE TABLE IF NOT EXISTS `borrowerdb`.`items` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `item` VARCHAR(255) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 29
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `borrowerdb`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borrowerdb`.`users` ;

CREATE TABLE IF NOT EXISTS `borrowerdb`.`users` (
  `username` VARCHAR(60) NOT NULL,
  `name` VARCHAR(60) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `authority` VARCHAR(40) NOT NULL,
  `enabled` TINYINT(1) NULL DEFAULT '1',
  PRIMARY KEY (`username`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `borrowerdb`.`deals`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borrowerdb`.`deals` ;

CREATE TABLE IF NOT EXISTS `borrowerdb`.`deals` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `items_id` BIGINT(20) NOT NULL,
  `borrower` VARCHAR(60) NOT NULL,
  `lender` VARCHAR(60) NOT NULL,
  `created_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `borrow_time` TIMESTAMP NULL DEFAULT NULL,
  `return_time` TIMESTAMP NULL DEFAULT NULL,
  `borrowed` TINYINT(1) NULL DEFAULT NULL,
  `returned` TINYINT(1) NULL DEFAULT NULL,
  `accept` TINYINT(1) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_items_has_users_users1_idx` (`borrower` ASC),
  INDEX `fk_items_has_users_items_idx` (`items_id` ASC),
  INDEX `fk_items_has_users_users2_idx` (`lender` ASC),
  CONSTRAINT `fk_items_has_users_items`
    FOREIGN KEY (`items_id`)
    REFERENCES `borrowerdb`.`items` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_items_has_users_users1`
    FOREIGN KEY (`borrower`)
    REFERENCES `borrowerdb`.`users` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_items_has_users_users2`
    FOREIGN KEY (`lender`)
    REFERENCES `borrowerdb`.`users` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 24
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
