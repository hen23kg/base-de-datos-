create database bd_segunda_instancia
go 
use bd_segunda_instancia
go
--hendy latife kalaf gomez

create table cliente 
(
ci int primary key identity not null,
nombre varchar (60),
estado_civil varchar,
edad nvarchar,
)
go 
create table Producto
(
idfecha int not null primary key,
Nom_Producto varchar (30) null,
Precio_monto numeric(5,2)null,
ci_cliente varchar (20)null, 
)
go
--select 
select * from cliente
select * from Producto

----- CASCADA DE seleccion--
select * from cliente
where  ci='1234' and nombre >10 and estado_civil='soltera 'and  edad='13'

--cascada de seleccion 
select * from producto
where fecha='13\2'and Nom_Producto='clavos' and Precio_monto='38' and ci_cliente='jasivi'
--ES EQUIVALENTE A:  --

select * from (select * from (select * from(select * from producto
where idfecha='13\2') as Z where ci_cliente='111- jasivi') as Y where
Precio_monto='13') as X where Nom_Producto='clavos'
go
