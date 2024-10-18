create database encriptacion
 create table USUARIOS (
 usuario varchar(30)primary key,
 password_sin_encriptar varchar (15),
 password_encriptado varbinary (255)
 )

 insert into USUARIOS values ('Mikel','bd_2022',ENCRYPTBYPASSPHRASE('password','bd_2022'))


 insert into USUARIOS values ('Angel','semestre5', ENCRYPTBYPASSPHRASE('password','semestre5'))

 insert into USUARIOS values ('Andy','real13',ENCRYPTBYPASSPHRASE('password','real13'))

 select * from USUARIOS

 select usuario, password_sin_encriptar,
		convert(varchar(50),DECRYPTBYPASSPHRASE('password',password_encriptado))
from USUARIOS