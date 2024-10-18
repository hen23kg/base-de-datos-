create database Asim�trica1
go
use Asim�trica1
go
-------------------------------Asim�tricas (Asymmetric Key)-------------------

create table seguridad(                 
id int identity (1,1) primary key,
nombre varchar (20)not null,
contrase�a varbinary(max)not null
)
go

CREATE ASYMMETRIC KEY LlaveMajito ----crea la llave y asocia el algortimo y la esta incriptacion---
WITH ALGORITHM = RSA_2048
ENCRYPTION BY PASSWORD ='$$clave$$'
GO

--ENCRIPTACION
DECLARE @LLAVEID INT 
SET @LLAVEID = AsymKey_ID('LlaveMajito')
INSERT INTO seguridad VALUES ('MARIA',EncryptByAsymKey(@LLAVEID,'345')), ('TERESA',EncryptByAsymKey(@LLAVEID,'555')),('JOSE',EncryptByAsymKey(@LLAVEID,'095')),('FER',EncryptByAsymKey(@LLAVEID,'111')),('CLAUDIA',EncryptByAsymKey(@LLAVEID,'987')) 

select * from seguridad

--DESENCRIPTACION
DECLARE @LLAVEID INT 
SET @LLAVEID = AsymKey_ID('LlaveMajito')
SELECT nombre AS 'USUARIO', CAST(DecryptByAsymKey(@LLAVEID,contrase�a,N'$$clave$$') AS VARCHAR(100)) AS 'CONTRASE�A'
FROM seguridad

