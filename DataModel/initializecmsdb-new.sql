-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema cms
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema cms
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cms` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
-- -----------------------------------------------------
-- Schema cmsusers
-- -----------------------------------------------------
USE `cms` ;

-- -----------------------------------------------------
-- Table `cms`.`Attachments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cms`.`Attachments` (
  `AttachmentID` INT NOT NULL AUTO_INCREMENT,
  `Login` VARCHAR(64) NOT NULL,
  `Name` VARCHAR(64) NOT NULL,
  `Description` VARCHAR(128) NOT NULL,
  `Data` LONGBLOB NOT NULL,
  PRIMARY KEY (`AttachmentID`),
  INDEX `IX_Attachments_Login` (`Login` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cms`.`CASDataItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cms`.`CASDataItems` (
  `CASDataID` INT NOT NULL AUTO_INCREMENT,
  `CASNumber` VARCHAR(32) NOT NULL,
  `ChemicalName` VARCHAR(1024) NULL DEFAULT NULL,
  `CWCFlag` VARCHAR(1) NOT NULL,
  `TheftFlag` VARCHAR(1) NOT NULL,
  `CarcinogenFlag` VARCHAR(1) NOT NULL,
  `Pictograms` VARCHAR(256) NULL DEFAULT NULL,
  PRIMARY KEY (`CASDataID`),
  INDEX `IX_CASDataItems_CASNumber` (`CASNumber` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 3902
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cms`.`CASDisposalProcedures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cms`.`CASDisposalProcedures` (
  `CASDisposalProcedureID` INT NOT NULL AUTO_INCREMENT,
  `CASNumber` VARCHAR(32) NOT NULL,
  `DisposalProcedureID` INT NOT NULL,
  PRIMARY KEY (`CASDisposalProcedureID`),
  INDEX `IX_CASDisposalProcedures_CASNumber` (`CASNumber` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cms`.`ChemicalsOfConcern`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cms`.`ChemicalsOfConcern` (
  `COCID` INT NOT NULL AUTO_INCREMENT,
  `ChemicalName` VARCHAR(256) NOT NULL,
  `CASNumber` VARCHAR(32) NOT NULL,
  `CWC` BIT(1) NOT NULL,
  `CFATS` BIT(1) NOT NULL,
  `EU` BIT(1) NOT NULL,
  `AG` BIT(1) NOT NULL,
  `WMD` BIT(1) NOT NULL,
  `OTHER` BIT(1) NOT NULL,
  PRIMARY KEY (`COCID`),
  INDEX `IX_ChemicalsOfConcern_CASNumber` (`CASNumber` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 603
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cms`.`DatabaseQueries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cms`.`DatabaseQueries` (
  `DatabaseQueryID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(64) NOT NULL,
  `QueryText` LONGTEXT NOT NULL,
  PRIMARY KEY (`DatabaseQueryID`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cms`.`DisposalProcedures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cms`.`DisposalProcedures` (
  `DisposalProcedureID` INT NOT NULL AUTO_INCREMENT,
  `Schedule` VARCHAR(8) NULL DEFAULT NULL,
  `Category` VARCHAR(32) NULL DEFAULT NULL,
  `ChemicalName` LONGTEXT NULL DEFAULT NULL,
  `Treatment` VARCHAR(64) NULL DEFAULT NULL,
  `Techniques` LONGTEXT NOT NULL,
  `Products` LONGTEXT NULL DEFAULT NULL,
  `WasteDisposal` LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`DisposalProcedureID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cms`.`GHSClassifications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cms`.`GHSClassifications` (
  `LCSSInformationID` INT NOT NULL AUTO_INCREMENT,
  `CASNumber` VARCHAR(32) NOT NULL,
  `SourceID` INT NOT NULL,
  `ChemicalName` LONGTEXT NOT NULL,
  `CID` INT NOT NULL,
  `IsHealthHazard` BIT(1) NOT NULL,
  `IsIrritant` BIT(1) NOT NULL,
  `IsAccuteToxicity` BIT(1) NOT NULL,
  `IsCorrosive` BIT(1) NOT NULL,
  `IsEnvironmental` BIT(1) NOT NULL,
  `IsExplosive` BIT(1) NOT NULL,
  `IsFlamable` BIT(1) NOT NULL,
  `IsOxidizer` BIT(1) NOT NULL,
  `IsCompressedGas` BIT(1) NOT NULL,
  `Pictograms` VARCHAR(1024) NOT NULL,
  `Signal` VARCHAR(32) NOT NULL,
  `HazardStatements` LONGTEXT NULL DEFAULT NULL,
  `PrecautionaryCodes` LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`LCSSInformationID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cms`.`HazardCodes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cms`.`HazardCodes` (
  `HazardCodeID` INT NOT NULL AUTO_INCREMENT,
  `GHSCode` VARCHAR(16) NOT NULL,
  `CASNumber` VARCHAR(32) NOT NULL,
  `HazardClass` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`HazardCodeID`),
  INDEX `IX_HazardCodes_CASNumber` (`CASNumber` ASC) VISIBLE,
  INDEX `IX_HazardCodes_GHSCode` (`GHSCode` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 12722
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cms`.`InventoryStatusNames`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cms`.`InventoryStatusNames` (
  `InventoryStatusID` INT NOT NULL,
  `Name` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`InventoryStatusID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cms`.`Owners`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cms`.`Owners` (
  `OwnerID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`OwnerID`))
ENGINE = InnoDB
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cms`.`StorageGroups`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cms`.`StorageGroups` (
  `GroupID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`GroupID`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cms`.`LocationTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cms`.`LocationTypes` (
  `LocationTypeID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(255) NOT NULL,
  `ValidChildren` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`LocationTypeID`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cms`.`LocationLevelNames`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cms`.`LocationLevelNames` (
  `LocationLevel` INT NOT NULL,
  `Name` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`LocationLevel`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cms`.`StorageLocations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cms`.`StorageLocations` (
  `LocationID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(64) NOT NULL,
  `ParentID` INT NOT NULL,
  `LocationTypeID` INT NOT NULL,
  `IsLeaf` BIT(1) NOT NULL,
  `LocationLevel` INT NOT NULL,
  `Path` LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`LocationID`),
  INDEX `IX_StorageLocations_LocationTypeID` (`LocationTypeID` ASC) VISIBLE,
  INDEX `IX_StorageLocations_ParentID` (`ParentID` ASC) VISIBLE,
  INDEX `fk_StorageLocations_LocationLevelNames1_idx` (`LocationLevel` ASC) VISIBLE,
  CONSTRAINT `FK_StorageLocations_LocationTypes_LocationTypeID`
    FOREIGN KEY (`LocationTypeID`)
    REFERENCES `cms`.`LocationTypes` (`LocationTypeID`)
    ON DELETE CASCADE,
  CONSTRAINT `FK_StorageLocations_LocationLevelNames1`
    FOREIGN KEY (`LocationLevel`)
    REFERENCES `cms`.`LocationLevelNames` (`LocationLevel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2093
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cms`.`ContainerUnits`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cms`.`ContainerUnits` (
  `ContainerUnitID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(64) NULL,
  `UnitAbbreviation` VARCHAR(45) NULL,
  PRIMARY KEY (`ContainerUnitID`),
  UNIQUE INDEX `ContainerUnitID_UNIQUE` (`ContainerUnitID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cms`.`InventoryItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cms`.`InventoryItems` (
  `InventoryID` INT NOT NULL AUTO_INCREMENT,
  `Barcode` VARCHAR(64) NOT NULL,
  `CASNumber` VARCHAR(32) NULL DEFAULT NULL,
  `ChemicalName` VARCHAR(256) NULL DEFAULT NULL,
  `LocationID` INT NOT NULL,
  `ContainerName` VARCHAR(64) NULL,
  `GroupID` INT NULL DEFAULT NULL,
  `OwnerID` INT NULL DEFAULT NULL,
  `DateIn` DATETIME(6) NULL DEFAULT NULL,
  `ExpirationDate` DATETIME(6) NULL DEFAULT NULL,
  `Quantity` INT NULL DEFAULT NULL,
  `ContainerSize` DOUBLE NULL DEFAULT NULL,
  `RemainingQuantity` DOUBLE NULL DEFAULT NULL,
  `Units` VARCHAR(64) NULL DEFAULT NULL,
  `State` VARCHAR(64) NULL DEFAULT NULL,
  `Flags` VARCHAR(16) NULL DEFAULT NULL,
  `IsOtherCOC` BIT(1) NOT NULL DEFAULT b'0',
  `InventoryStatusID` INT NULL DEFAULT NULL,
  `LastInventoryDate` DATETIME(6) NULL DEFAULT NULL,
  `SDS` VARCHAR(32) NULL DEFAULT NULL,
  `Notes` LONGTEXT NULL DEFAULT NULL,
  `StockCheckPreviousLocation` INT NULL DEFAULT NULL,
  `StockCheckTime` DATETIME(6) NULL DEFAULT NULL,
  `StockCheckUser` VARCHAR(64) NULL DEFAULT NULL,
  `MaterialType` INT NOT NULL DEFAULT '0',
  `DisposeFlag` BIT(1) NOT NULL,
  `Custom1` VARCHAR(256) NULL DEFAULT NULL,
  `Custom2` VARCHAR(256) NULL DEFAULT NULL,
  `Custom3` VARCHAR(256) NULL DEFAULT NULL,
  `ContainerUnitID` INT NULL,
  `Refillable` TINYINT NULL,
  PRIMARY KEY (`InventoryID`),
  INDEX `IX_InventoryItems_GroupID` (`GroupID` ASC) VISIBLE,
  INDEX `IX_InventoryItems_InventoryStatusID` (`InventoryStatusID` ASC) VISIBLE,
  INDEX `IX_InventoryItems_LocationID` (`LocationID` ASC) VISIBLE,
  INDEX `IX_InventoryItems_OwnerID` (`OwnerID` ASC) VISIBLE,
  INDEX `FK_InventoryItems_ContainerUnits1_idx` (`ContainerUnitID` ASC) VISIBLE,
  CONSTRAINT `FK_InventoryItems_InventoryStatusNames_InventoryStatusID`
    FOREIGN KEY (`InventoryStatusID`)
    REFERENCES `cms`.`InventoryStatusNames` (`InventoryStatusID`),
  CONSTRAINT `FK_InventoryItems_Owners_OwnerID`
    FOREIGN KEY (`OwnerID`)
    REFERENCES `cms`.`Owners` (`OwnerID`),
  CONSTRAINT `FK_InventoryItems_StorageGroups_GroupID`
    FOREIGN KEY (`GroupID`)
    REFERENCES `cms`.`StorageGroups` (`GroupID`),
  CONSTRAINT `FK_InventoryItems_StorageLocations_LocationID`
    FOREIGN KEY (`LocationID`)
    REFERENCES `cms`.`StorageLocations` (`LocationID`)
    ON DELETE CASCADE,
  CONSTRAINT `FK_InventoryItems_ContainerUnits1`
    FOREIGN KEY (`ContainerUnitID`)
    REFERENCES `cms`.`ContainerUnits` (`ContainerUnitID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1001
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cms`.`InventoryAudits`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cms`.`InventoryAudits` (
  `InventoryAuditID` INT NOT NULL AUTO_INCREMENT,
  `AuditTime` DATETIME(6) NOT NULL,
  `Barcode` VARCHAR(64) NOT NULL,
  `InventoryID` INT NOT NULL,
  `LocationID` INT NULL DEFAULT NULL,
  `PreviousLocationID` INT NULL DEFAULT NULL,
  `User` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`InventoryAuditID`),
  INDEX `IX_InventoryAudits_InventoryID` (`InventoryID` ASC) VISIBLE,
  CONSTRAINT `FK_InventoryAudits_InventoryItems_InventoryID`
    FOREIGN KEY (`InventoryID`)
    REFERENCES `cms`.`InventoryItems` (`InventoryID`)
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cms`.`LogEntries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cms`.`LogEntries` (
  `LogEntryID` INT NOT NULL AUTO_INCREMENT,
  `EntryDateTime` DATETIME(6) NOT NULL,
  `MessageLevel` INT NOT NULL,
  `Login` VARCHAR(256) NOT NULL,
  `Category` VARCHAR(32) NOT NULL,
  `Text` VARCHAR(1024) NOT NULL,
  PRIMARY KEY (`LogEntryID`))
ENGINE = InnoDB
AUTO_INCREMENT = 27
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cms`.`RemovedItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cms`.`RemovedItems` (
  `RemovedItemID` INT NOT NULL AUTO_INCREMENT,
  `InventoryID` INT NOT NULL,
  `Barcode` VARCHAR(64) NOT NULL,
  `ChemicalName` VARCHAR(256) NULL DEFAULT NULL,
  `CASNumber` VARCHAR(32) NULL DEFAULT NULL,
  `LocationID` INT NOT NULL,
  `GroupID` INT NULL DEFAULT NULL,
  `OwnerID` INT NULL DEFAULT NULL,
  `DateIn` DATETIME(6) NULL DEFAULT NULL,
  `ExpirationDate` DATETIME(6) NULL DEFAULT NULL,
  `ContainerSize` DOUBLE NULL DEFAULT NULL,
  `RemainingQuantity` DOUBLE NULL DEFAULT NULL,
  `Units` VARCHAR(64) NULL DEFAULT NULL,
  `State` VARCHAR(64) NULL DEFAULT NULL,
  `Flags` VARCHAR(16) NULL DEFAULT NULL,
  `RemovalReason` INT NOT NULL,
  `DateRemoved` DATETIME(6) NOT NULL,
  PRIMARY KEY (`RemovedItemID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cms`.`ReportDefinitions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cms`.`ReportDefinitions` (
  `ReportID` INT NOT NULL AUTO_INCREMENT,
  `ReportName` VARCHAR(256) NOT NULL,
  `Description` VARCHAR(1024) NOT NULL,
  `DatabaseQueryID` INT NOT NULL,
  `WhereClause` LONGTEXT NULL DEFAULT NULL,
  `Roles` VARCHAR(64) NOT NULL,
  `Widgets` VARCHAR(64) NOT NULL,
  `ColumnDefinitions` LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`ReportID`),
  INDEX `IX_ReportDefinitions_DatabaseQueryID` (`DatabaseQueryID` ASC) VISIBLE,
  CONSTRAINT `FK_ReportDefinitions_DatabaseQueries_DatabaseQueryID`
    FOREIGN KEY (`DatabaseQueryID`)
    REFERENCES `cms`.`DatabaseQueries` (`DatabaseQueryID`)
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cms`.`Settings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cms`.`Settings` (
  `SettingID` INT NOT NULL AUTO_INCREMENT,
  `SettingKey` VARCHAR(64) NOT NULL,
  `SettingValue` LONGTEXT NOT NULL,
  PRIMARY KEY (`SettingID`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cms`.`Refills`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cms`.`Refills` (
  `RefillID` INT NOT NULL AUTO_INCREMENT,
  `Manufacturer` VARCHAR(45) NULL,
  `LotNumber` VARCHAR(45) NULL,
  `DateManufactured` DATETIME(6) NULL,
  `DateReceived` DATETIME(6) NULL,
  `DateExpires` DATETIME(6) NULL,
  `UnitsReceived` DOUBLE NULL,
  `InventoryID` INT NOT NULL,
  `PurchaseOrderNumber` VARCHAR(45) NULL,
  PRIMARY KEY (`RefillID`),
  UNIQUE INDEX `DeliveryID_UNIQUE` (`RefillID` ASC) VISIBLE,
  INDEX `fk_Refills_InventoryItems1_idx` (`InventoryID` ASC) VISIBLE,
  CONSTRAINT `fk_Refills_InventoryItems1`
    FOREIGN KEY (`InventoryID`)
    REFERENCES `cms`.`InventoryItems` (`InventoryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
