-- Your task at hand is to create a MySQL database for LinkedIn from scratch. 
-- The implementation details are up to you, though you should minimally ensure that your database meets 
-- the platform’s specification and that it can represent the given sample data. 
-- You’re welcome to use, or improve upon, your design of a SQLite database—just keep in mind that 
-- you’ll now have a new set of types at your disposal!

-- To use mysql, you first need to start a MySQL server, as with:
    -- docker container run --name mysql -p 3306:3306 -v /workspaces/$RepositoryName:/mnt -e MYSQL_ROOT_PASSWORD=crimson -d mysql
-- You can then connect to the server with:
    -- mysql -h 127.0.0.1 -P 3306 -u root -p
-- Type crimson as your password.

-- CREATE DATABASE `linkedin`;
-- Users table
CREATE TABLE IF NOT EXISTS `users` (
    `id` INT AUTO_INCREMENT,
    `first_name` VARCHAR(45) NOT NULL,
    `last_name` VARCHAR(45) NOT NULL,
    `username` VARCHAR(32) NOT NULL UNIQUE,
    `password` VARCHAR(36) NOT NULL,
    PRIMARY KEY (`id`)
);
-- Schools table
CREATE TABLE IF NOT EXISTS `universities` (
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL UNIQUE,
    `type` ENUM('Elementary School', 'Middle School', 'High School', 'Lower School', 'Upper School', 'College', 'University', 'Other') NOT NULL,
    `address` VARCHAR(54) NOT NULL,
    `foundation_date` DATE NOT NULL,
    PRIMARY KEY (`id`)
);
-- Companies table
CREATE TABLE IF NOT EXISTS `companies` (
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL UNIQUE,
    `industry` ENUM('Education', 'Technology', 'Finance') NOT NULL,
    `address` VARCHAR(54) NOT NULL,
    PRIMARY KEY (`id`)
);
-- People connections table
CREATE TABLE IF NOT EXISTS `people_connections` (
    `id` INT AUTO_INCREMENT,
    `id_user_fk` INT NOT NULL,
    `id_following_fk` INT NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`id_user_fk`) REFERENCES `users` (`id`),
    FOREIGN KEY (`id_following_fk`) REFERENCES `users` (`id`)
);
-- Schools connection
CREATE TABLE IF NOT EXISTS `schools_connections` (
    `id` INT AUTO_INCREMENT,
    `id_user_fk` INT NOT NULL,
    `id_school_fk` INT NOT NULL,
    `start_date` TIMESTAMP NOT NULL,
    `end_date` TIMESTAMP NOT NULL,
    `degree` VARCHAR(30) NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`id_user_fk`) REFERENCES `users` (`id`),
    FOREIGN KEY (`id_school_fk`) REFERENCES `universities` (`id`)
);
-- Companies connection
CREATE TABLE IF NOT EXISTS `companies_connections` (
    `id` INT AUTO_INCREMENT,
    `id_user_fk` INT NOT NULL,
    `id_companie_fk` INT NOT NULL,
    `start_date` TIMESTAMP NOT NULL,
    `end_date` TIMESTAMP NOT NULL,
    `title` VARCHAR(36) NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`id_user_fk`) REFERENCES `users` (`id`),
    FOREIGN KEY (`id_companie_fk`) REFERENCES `universities` (`id`)
);