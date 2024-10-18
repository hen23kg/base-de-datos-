create database PASSPHRASE01
go
use PASSPHRASE01
go

-------------------Passphrase-----------------

create table seguridad(
id int identity (1,1) primary key,
nombre varchar (20)not null,
contraseña varbinary(max)not null
)
go
--------
----ENCRIPTAR---------
INSERT INTO seguridad VALUES ('JOSE',ENCRYPTBYPASSPHRASE('$$clave$$','SHUEK'))
GO

SELECT * FROM seguridad
GO 
-----DESENCRIPTAR-----

SELECT 'JOSE' AS 'USUARIO', CONVERT(VARCHAR(300), DECRYPTBYPASSPHRASE('$$clave$$',contraseña)) AS 'CONTRASEÑA'
FROM seguridad