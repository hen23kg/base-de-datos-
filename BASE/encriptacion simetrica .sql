create database Simetrica 
go 
use Simetrica 
go 

create table seguridad(
id int identity (1,1) primary key,
nombre varchar (20) not null,
contraseña varbinary (max) not null
)
go 
----------------simetrica(symmetric key)---------------
CREATE SYMMETRIC KEY llavesimetrica 
WITH ALGORITHM = AES_128
ENCRYPTION BY PASSWORD = '## clave ##'

---------------encriptacion----------------
DECLARE @LLAVEID UNIQUEIDENTIFIER
SET @LLAVEID = ('llavesimetrica')

OPEN SYMMETRIC KEY llavesimetrica
DECRYPTION BY PASSWORD = '## clave ##'

INSERT INTO seguridad VALUES ('JOSE' , ENCRYPTBYKEY (@LLAVEID , '919'))

CLOSE SYMMETRIC KEY llavesimetrica 

SELECT * FROM seguridad 

--------------desencriptar-------------
OPEN SYMMETRIC KEY llavesimetrica
DECRYPTION BY PASSWORD = '## clave ##'

select USER as 'USUARIO',
cast (decryptbykey(contraseña) as varchar(200)) AS 'CONTRASEÑA'
from seguridad 

CLOSE SYMMETRIC KEY llavesimetrica














