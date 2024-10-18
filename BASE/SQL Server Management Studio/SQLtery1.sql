create database tarjeta 
create table fk(
ID int primary key identity not null,
nombre varchar(6),
cod_materia decimal (7,5)
)
create table alimento(
ID int primary key identity not null,
nombre varchar (90),
cod_materia int 
)
