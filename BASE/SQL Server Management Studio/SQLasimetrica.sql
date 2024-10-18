create database asimetrica 
go 
use asimetrica
--hendy latife kalaf gomez 
create table seguridad(                 
id int identity (1,1) primary key,
nombre varchar (10)not null,
contraseña varbinary(max)not null
)
go
CREATE ASYMMETRIC KEY Llavelati
WITH ALGORITHM = RSA_2048
ENCRYPTION BY PASSWORD ='$$clave$$'
GO
DECLARE @llave  INT 
SET @llave = AsymKey_ID('Llavelati')
INSERT INTO seguridad VALUES ('TANIA ',EncryptByAsymKey(@llave,'245')), ('TERESA',EncryptByAsymKey(@llave,'555')),('luis',EncryptByAsymKey(@llave,'095')),('FER',EncryptByAsymKey(@llave,'111')),('CLAUDIA',EncryptByAsymKey(@llave,'987'));
select * from seguridad