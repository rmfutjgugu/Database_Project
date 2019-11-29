-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Domain`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Domain` (
  `Domain_Name` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`Domain_Name`),
  UNIQUE INDEX `Domain_Name_UNIQUE` (`Domain_Name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Agenda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Agenda` (
  `Agenda_ID` INT NOT NULL AUTO_INCREMENT,
  `Agneda_Body` VARCHAR(255) NULL DEFAULT NULL,
  `Agenda_Title` VARCHAR(45) NULL DEFAULT NULL,
  `Agenda_Date` VARCHAR(45) NULL DEFAULT NULL,
  `Agenda_Domain` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`Agenda_ID`),
  UNIQUE INDEX `Agenda_ID_UNIQUE` (`Agenda_ID` ASC) VISIBLE,
  INDEX `Agenda_Domain_idx` (`Agenda_Domain` ASC) VISIBLE,
  CONSTRAINT `Agenda_Domain`
    FOREIGN KEY (`Agenda_Domain`)
    REFERENCES `mydb`.`Domain` (`Domain_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Article`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Article` (
  `Article_ID` INT NOT NULL AUTO_INCREMENT,
  `Article_title` VARCHAR(255) NULL,
  `Article_Body` VARCHAR(255) NULL,
  `Article_Date` DATE NULL,
  `Article_Link` VARCHAR(255) NULL,
  `Domain_Name` VARCHAR(45) NULL,
  `Article_Agenda` INT NULL,
  PRIMARY KEY (`Article_ID`),
  UNIQUE INDEX `idArticle_UNIQUE` (`Article_ID` ASC) VISIBLE,
  INDEX `Domain_Name_idx` (`Domain_Name` ASC) VISIBLE,
  INDEX `Article_Agenda_idx` (`Article_Agenda` ASC) VISIBLE,
  CONSTRAINT `Domain_Name`
    FOREIGN KEY (`Domain_Name`)
    REFERENCES `mydb`.`Domain` (`Domain_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Article_Agenda`
    FOREIGN KEY (`Article_Agenda`)
    REFERENCES `mydb`.`Agenda` (`Agenda_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Party`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Party` (
  `Party_Name` VARCHAR(45) NOT NULL,
  `Floor leader` INT NULL,
  PRIMARY KEY (`Party_Name`),
  UNIQUE INDEX `Party_Name_UNIQUE` (`Party_Name` ASC) VISIBLE,
  UNIQUE INDEX `Floor leader_UNIQUE` (`Floor leader` ASC) VISIBLE,
  CONSTRAINT `Floor leader`
    FOREIGN KEY (`Floor leader`)
    REFERENCES `mydb`.`Member_of_Congress` (`Member_of_Congress_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Member_of_Congress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Member_of_Congress` (
  `Member_of_Congress_ID` INT NOT NULL AUTO_INCREMENT,
  `Member_of_Congress_Name` VARCHAR(45) NULL,
  `Member_of_Congress_Party` VARCHAR(45) NULL,
  PRIMARY KEY (`Member_of_Congress_ID`),
  UNIQUE INDEX `Member_of_Congress_ID_UNIQUE` (`Member_of_Congress_ID` ASC) VISIBLE,
  INDEX `Member_of_Congress_Party_idx` (`Member_of_Congress_Party` ASC) VISIBLE,
  CONSTRAINT `Member_of_Congress_Party`
    FOREIGN KEY (`Member_of_Congress_Party`)
    REFERENCES `mydb`.`Party` (`Party_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Petition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Petition` (
  `Petition_ID` INT NOT NULL AUTO_INCREMENT,
  `Petition_Name` VARCHAR(255) NULL,
  `Petition_Agenda` INT NULL,
  `Petition_Agree_Number` INT NOT NULL,
  PRIMARY KEY (`Petition_ID`),
  UNIQUE INDEX `Petition_Number_UNIQUE` (`Petition_ID` ASC) VISIBLE,
  UNIQUE INDEX `Petition_Agenda_UNIQUE` (`Petition_Agenda` ASC) VISIBLE,
  CONSTRAINT `Petition_Agenda`
    FOREIGN KEY (`Petition_Agenda`)
    REFERENCES `mydb`.`Agenda` (`Agenda_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`User` (
  `User_ID` INT NOT NULL,
  `User_Password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`User_ID`),
  UNIQUE INDEX `User_Id_UNIQUE` (`User_ID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MVA(Domain_Petition)`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MVA(Domain_Petition)` (
  `Petition_Name` VARCHAR(45) NOT NULL,
  `Agenda_Number` INT NOT NULL,
  PRIMARY KEY (`Petition_Name`, `Agenda_Number`),
  INDEX `Agenda_Number_idx` (`Agenda_Number` ASC) VISIBLE,
  CONSTRAINT `MDP_Petition_Name`
    FOREIGN KEY (`Petition_Name`)
    REFERENCES `mydb`.`Domain` (`Domain_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `MDP_Agenda_Number`
    FOREIGN KEY (`Agenda_Number`)
    REFERENCES `mydb`.`Agenda` (`Agenda_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MVA(Domain_Article)`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MVA(Domain_Article)` (
  `Domain_Name` VARCHAR(45) NOT NULL,
  `Article_Number` INT NOT NULL,
  PRIMARY KEY (`Domain_Name`, `Article_Number`),
  INDEX `Article_Number_idx` (`Article_Number` ASC) VISIBLE,
  CONSTRAINT `MDA_Domain_Names`
    FOREIGN KEY (`Domain_Name`)
    REFERENCES `mydb`.`Domain` (`Domain_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `MDA_Article_Number`
    FOREIGN KEY (`Article_Number`)
    REFERENCES `mydb`.`Article` (`Article_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Save(User_Member)`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Save(User_Member)` (
  `Member_ID` INT NOT NULL,
  `User_ID` INT NOT NULL,
  PRIMARY KEY (`Member_ID`, `User_ID`),
  INDEX `User_ID_idx` (`User_ID` ASC) VISIBLE,
  CONSTRAINT `SaveUM_Member_IDs`
    FOREIGN KEY (`Member_ID`)
    REFERENCES `mydb`.`Member_of_Congress` (`Member_of_Congress_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `SaveUM_User_ID`
    FOREIGN KEY (`User_ID`)
    REFERENCES `mydb`.`User` (`User_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Search(User_Member)`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Search(User_Member)` (
  `Member_ID` INT NOT NULL,
  `User_ID` INT NOT NULL,
  PRIMARY KEY (`Member_ID`, `User_ID`),
  INDEX `User_ID_idx` (`User_ID` ASC) VISIBLE,
  CONSTRAINT `SUM_Member_ID`
    FOREIGN KEY (`Member_ID`)
    REFERENCES `mydb`.`Member_of_Congress` (`Member_of_Congress_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `SUM_User_ID`
    FOREIGN KEY (`User_ID`)
    REFERENCES `mydb`.`User` (`User_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Save(User_Agenda)`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Save(User_Agenda)` (
  `Agenda_ID` INT NOT NULL,
  `User_ID` INT NOT NULL,
  PRIMARY KEY (`Agenda_ID`, `User_ID`),
  INDEX `User_ID_idx` (`User_ID` ASC) VISIBLE,
  CONSTRAINT `SUA_User_ID`
    FOREIGN KEY (`User_ID`)
    REFERENCES `mydb`.`User` (`User_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `SUA_Agenda_ID`
    FOREIGN KEY (`Agenda_ID`)
    REFERENCES `mydb`.`Agenda` (`Agenda_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Search(User_Agenda)`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Search(User_Agenda)` (
  `Agenda_ID` INT NOT NULL,
  `User_ID` INT NOT NULL,
  PRIMARY KEY (`Agenda_ID`, `User_ID`),
  INDEX `User_ID_idx` (`User_ID` ASC) VISIBLE,
  CONSTRAINT `SearchUA_Agenda_ID`
    FOREIGN KEY (`Agenda_ID`)
    REFERENCES `mydb`.`Agenda` (`Agenda_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `SearchUA_User_ID`
    FOREIGN KEY (`User_ID`)
    REFERENCES `mydb`.`User` (`User_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Save(User_Ariticle)`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Save(User_Ariticle)` (
  `Article_ID` INT NOT NULL,
  `User_ID` INT NOT NULL,
  PRIMARY KEY (`Article_ID`, `User_ID`),
  INDEX `User_ID_idx` (`User_ID` ASC) VISIBLE,
  CONSTRAINT `SUAr_User_ID`
    FOREIGN KEY (`User_ID`)
    REFERENCES `mydb`.`User` (`User_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `SUAr_Article_ID`
    FOREIGN KEY (`Article_ID`)
    REFERENCES `mydb`.`Article` (`Article_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Search(User_Article)`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Search(User_Article)` (
  `Article_ID` INT NOT NULL,
  `User_ID` INT NOT NULL,
  PRIMARY KEY (`Article_ID`, `User_ID`),
  INDEX `User_ID_idx` (`User_ID` ASC) VISIBLE,
  CONSTRAINT `SUArti_Ariticle_ID`
    FOREIGN KEY (`Article_ID`)
    REFERENCES `mydb`.`Article` (`Article_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `SUArti_User_ID`
    FOREIGN KEY (`User_ID`)
    REFERENCES `mydb`.`User` (`User_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MVA(Agenda_Article)`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MVA(Agenda_Article)` (
  `Agenda_ID` INT NOT NULL,
  `Article_ID` INT NOT NULL,
  PRIMARY KEY (`Agenda_ID`, `Article_ID`),
  INDEX `Article_ID_idx` (`Article_ID` ASC) VISIBLE,
  CONSTRAINT `MAA_Article_ID`
    FOREIGN KEY (`Article_ID`)
    REFERENCES `mydb`.`Article` (`Article_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `MAA_Agenda_ID`
    FOREIGN KEY (`Agenda_ID`)
    REFERENCES `mydb`.`Agenda` (`Agenda_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MVA(Agenda_Member)`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MVA(Agenda_Member)` (
  `Agenda_ID` INT NOT NULL,
  `Member_ID` INT NOT NULL,
  PRIMARY KEY (`Agenda_ID`, `Member_ID`),
  INDEX `Member_ID_idx` (`Member_ID` ASC) VISIBLE,
  CONSTRAINT `MAM_Agenda_ID`
    FOREIGN KEY (`Agenda_ID`)
    REFERENCES `mydb`.`Agenda` (`Agenda_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `MAM_Member_ID`
    FOREIGN KEY (`Member_ID`)
    REFERENCES `mydb`.`Member_of_Congress` (`Member_of_Congress_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MVA(Agenda_Petition)`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MVA(Agenda_Petition)` (
  `Agenda_ID` INT NOT NULL,
  `Petition_ID` INT NOT NULL,
  PRIMARY KEY (`Agenda_ID`, `Petition_ID`),
  INDEX `Petition_ID_idx` (`Petition_ID` ASC) VISIBLE,
  CONSTRAINT `MAP_Agenda_ID`
    FOREIGN KEY (`Agenda_ID`)
    REFERENCES `mydb`.`Agenda` (`Agenda_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `MAP_Petition_ID`
    FOREIGN KEY (`Petition_ID`)
    REFERENCES `mydb`.`Petition` (`Petition_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MVA(Member_Article)`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MVA(Member_Article)` (
  `Member_ID` INT NOT NULL,
  `Article_ID` INT NOT NULL,
  PRIMARY KEY (`Member_ID`, `Article_ID`),
  INDEX `Article_ID_idx` (`Article_ID` ASC) VISIBLE,
  CONSTRAINT `MMA_Member_ID`
    FOREIGN KEY (`Member_ID`)
    REFERENCES `mydb`.`Member_of_Congress` (`Member_of_Congress_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `MMA_Article_ID`
    FOREIGN KEY (`Article_ID`)
    REFERENCES `mydb`.`Article` (`Article_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Include(Member_Agenda)`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Include(Member_Agenda)` (
  `Member_ID` INT NOT NULL,
  `Agenda_ID` INT NOT NULL,
  PRIMARY KEY (`Member_ID`, `Agenda_ID`),
  INDEX `Agenda_ID_idx` (`Agenda_ID` ASC) VISIBLE,
  CONSTRAINT `IMA_Member_ID`
    FOREIGN KEY (`Member_ID`)
    REFERENCES `mydb`.`Member_of_Congress` (`Member_of_Congress_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IMA_Agenda_ID`
    FOREIGN KEY (`Agenda_ID`)
    REFERENCES `mydb`.`Agenda` (`Agenda_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Exist(Member_Article)`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Exist(Member_Article)` (
  `Member_ID` INT NOT NULL,
  `Article_ID` INT NOT NULL,
  PRIMARY KEY (`Member_ID`, `Article_ID`),
  INDEX `Article_ID_idx` (`Article_ID` ASC) VISIBLE,
  CONSTRAINT `EMA_Member_ID`
    FOREIGN KEY (`Member_ID`)
    REFERENCES `mydb`.`Member_of_Congress` (`Member_of_Congress_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `EMA_Article_ID`
    FOREIGN KEY (`Article_ID`)
    REFERENCES `mydb`.`Article` (`Article_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MVA(Member_Agenda)`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MVA(Member_Agenda)` (
  `Member_ID` INT NOT NULL,
  `Agenda_ID` INT NOT NULL,
  PRIMARY KEY (`Member_ID`, `Agenda_ID`),
  INDEX `MMA_Agenda_idx` (`Agenda_ID` ASC) VISIBLE,
  CONSTRAINT `MMAgen_Member`
    FOREIGN KEY (`Member_ID`)
    REFERENCES `mydb`.`Member_of_Congress` (`Member_of_Congress_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `MMAgen_Agenda`
    FOREIGN KEY (`Agenda_ID`)
    REFERENCES `mydb`.`Agenda` (`Agenda_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MVA(Party_Member)`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MVA(Party_Member)` (
  `Party_Name` VARCHAR(45) NOT NULL,
  `Member_ID` INT NOT NULL,
  PRIMARY KEY (`Party_Name`, `Member_ID`),
  INDEX `Member_ID_idx` (`Member_ID` ASC) VISIBLE,
  CONSTRAINT `MPM_Party_Name`
    FOREIGN KEY (`Party_Name`)
    REFERENCES `mydb`.`Party` (`Party_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `MPM_Member_ID`
    FOREIGN KEY (`Member_ID`)
    REFERENCES `mydb`.`Member_of_Congress` (`Member_of_Congress_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
