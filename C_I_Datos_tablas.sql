DROP DATABASE IF EXISTS Ecommerce;
CREATE DATABASE Ecommerce;

USE Ecommerce;
  
DROP TABLE IF EXISTS Venta_aux;
CREATE TABLE `Ecommerce`.`Venta_aux` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Id_Venta` INT NOT NULL,
  `Id_Item` INT NOT NULL,
  `Estado_Compra` VARCHAR(45) NOT NULL,
  `Fecha` DATE NOT NULL,
  `Categoria` VARCHAR(50) NOT NULL,
  `Id_Cliente` INT NOT NULL,
  `Precio` DECIMAL(10,3) NOT NULL,
  `Cantidad` INT NOT NULL,
  `Descuento` DECIMAL(10,4) NOT NULL,
  `Metodo_Pago` VARCHAR(45) NOT NULL,
  `Fecha_Trabajo` DATE NOT NULL,
  `Total` DECIMAL(15,5) NOT NULL,
  PRIMARY KEY (`Id`));
  
  
  DROP TABLE IF EXISTS Metodo_Pago;
  CREATE TABLE `Ecommerce`.`Metodo_Pago` (
  `Id_Metodo_Pago` INT NOT NULL AUTO_INCREMENT,
  `Metodo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id_Metodo_Pago`));
  
  DROP TABLE IF EXISTS Estado_Compra;
  CREATE TABLE `Ecommerce`.`Estado_Compra` (
  `Id_Estado_Compra` INT NOT NULL AUTO_INCREMENT,
  `Estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id_Estado_Compra`));
  
  DROP TABLE IF EXISTS Categoria;
  CREATE TABLE `Ecommerce`.`Categoria` (
  `Id_Categoria` INT NOT NULL AUTO_INCREMENT,
  `Categoria` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Categoria`));

LOAD DATA INFILE '/var/lib/mysql-files/Venta.csv'
INTO TABLE Venta_aux
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '/var/lib/mysql-files/Metodo_Pago.csv'
INTO TABLE Metodo_Pago
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '/var/lib/mysql-files/Categoria.csv'
INTO TABLE Categoria
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '/var/lib/mysql-files/Estado_Compra.csv'
INTO TABLE Estado_Compra
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DROP TABLE IF EXISTS Venta;
CREATE TABLE `Ecommerce`.`Venta` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Id_Venta` INT NOT NULL,
  `Id_Item` INT NOT NULL,
  `Fecha` DATE NOT NULL,
  `Id_Cliente` INT NOT NULL,
  `Precio` DECIMAL(10,3) NOT NULL,
  `Cantidad` INT NOT NULL,
  `Descuento` DECIMAL(10,4) NOT NULL,
  `Fecha_Trabajo` DATE NOT NULL,
  `Total` DECIMAL(15,5) NOT NULL,
  `Id_Metodo_Pago` INT NOT NULL,
  `Id_Categoria` INT NOT NULL,
  `Id_Estado_Compra` INT NOT NULL,
  PRIMARY KEY (`Id`));
  
INSERT INTO Venta
SELECT v.Id, v.Id_Venta, v.Id_Item, v.Fecha, v.Id_Cliente, v.Precio, v.Cantidad, v.Descuento, v.Fecha_Trabajo, v.Total, m.Id_Metodo_Pago, c.Id_Categoria, e.Id_Estado_Compra FROM Venta_aux v
join Metodo_Pago m on(m.Metodo=v.Metodo_Pago)
join Categoria c on (c.Categoria=v.Categoria)
Join Estado_Compra e on (e.Estado=v.Estado_Compra);

DROP TABLE IF EXISTS Venta_aux;


ALTER TABLE `Ecommerce`.`Venta` 
ADD INDEX `Venta_Categoria_idx` (`Id_Categoria` ASC) VISIBLE,
ADD INDEX `Venta_Estado_idx` (`Id_Estado_Compra` ASC) VISIBLE,
ADD INDEX `Venta_Metodo_idx` (`Id_Metodo_Pago` ASC) VISIBLE;
ALTER TABLE `Ecommerce`.`Venta` 
ADD CONSTRAINT `Venta_Categoria`
  FOREIGN KEY (`Id_Categoria`)
  REFERENCES `Ecommerce`.`Categoria` (`Id_Categoria`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `Venta_Estado`
  FOREIGN KEY (`Id_Estado_Compra`)
  REFERENCES `Ecommerce`.`Estado_Compra` (`Id_Estado_Compra`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `Venta_Metodo`
  FOREIGN KEY (`Id_Metodo_Pago`)
  REFERENCES `Ecommerce`.`Metodo_Pago` (`Id_Metodo_Pago`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;



