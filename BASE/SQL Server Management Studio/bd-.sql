create database bd_carolina11
go

use bd_carolina11
go


create table Producto
(
idproducto int not null primary key,
Nom_Producto varchar (30) null,
Precio_Unitario numeric(5,2)null,
marca varchar (20)null,
color varchar (20) null
)
go
select * from Producto

----- CASCADA DE SELECCIONES--
select * from producto
where Nom_Producto='Clavos' and Precio_Unitario>10 and color='aluminio'
and marca='pregos'

--ES EQUIVALENTE A:  --

select * from (select * from (select * from(select * from Producto
where marca='pregos') as Z where color='plateado') as Y where
Precio_Unitario>10) as X where Nom_Producto='clavos'
go

--CONMUTATIVIDAD DE LA SELECCION--
select * from(select * from Producto where Precio_Unitario>10) as X
where Nom_Producto='clavos'

--ES EQUIVALENTE A: --
select * from(select * from Producto where Nom_Producto='clavos') as X
where Precio_Unitario>10
go

--CASCADA DE PROYECCIONES --
SELECT IDPRODUCTO FROM (SELECT IDPRODUCTO,Nom_Producto FROM (SELECT 
IDPRODUCTO,Nom_Producto,Precio_Unitario FROM PRODUCTO) AS X1) AS X2

SELECT IDPRODUCTO FROM PRODUCTO

--DISTRIBUTIVIDAD DE LA PROYECCION Y LA SELECCION--
select * from(select * from Producto where Nom_Producto='clavos') as X 

-- ES ESQUIVALENTE A: --
select * from (select * from Producto) as X where Nom_Producto='clavos'
go

create database bd_carolina12
go

use bd_carolina12
go


create table Producto
(
idproducto int not null primary key,
Nom_Producto varchar (30) null,
Precio_Unitario numeric(5,2)null,
marca varchar (20)null,
)
go

create table factura
(
idfactura int not null primary key,
idproducto int not null,
nom_cliente varchar (30)null,
totalfactura numeric (5,2)null,

constraint fk_factura foreign key(idproducto)references Producto(idproducto)
)
go

create table recibo
(
idrecibo int not null primary key,
idproducto int not null,
nom_cliente varchar (30)null,
totalrecibo numeric (5,2)null,

constraint fk_recibo foreign key(idproducto)references Producto(idproducto)
)
go

select * from Producto
select * from factura
select * from recibo
go

-- CONMUTATIVA JOIN Y PRODUCTO CARTESIANO--
select * from factura,producto order by idfactura
go

select * from producto,factura order by idfactura
go


select * from factura join producto on 
factura.idProducto=producto.idProducto
go

select * from producto join factura on 
factura.idProducto=factura.idProducto
go

--DISTRIVUYIDAD DE LA SELECCION CON EL RESPECTO AL JOIN Y AL PRODUCTO CARTESIANO--
select * from factura,producto where totalfactura<100 and 
marca = 'nacional'
go

select * from (select * from factura where totalfactura>100) as x,
(select * from producto where marca = 'nacional') as y
go

select * from factura join producto on
factura.idProducto=producto.idproducto and totalfactura>100 and
marca='nacional'
go

select * from(select * from factura where totalfactura<100)as x join
(select *from producto where marca = 'nacional') as  y on 
x.idProducto=y.idproducto
go


--CONMUTATIVIDAD DE UNION Y INSERCCION--
select * from factura union select * from recibo
go

select * from recibo union select * from factura
go

create database bd_carolina13
go

use bd_carolina13
go

create table Producto
(
idproducto int not null primary key,
nombreProducto varchar (30) null,
preciounitario numeric(5,2)null,
marca varchar (20)null,

)
go
create table factura
(
idfactura int not null primary key,
idproducto int not null,
nombrecliente varchar (30)null,
totalfactura numeric (5,2)null,

constraint fk_factura foreign key(idproducto)references Producto(idproducto)
)
go

create table recibo
(
idrecibo int not null primary key,
idproducto int not null,
nombrecliente varchar (30)null,
totalrecibo numeric (5,2)null,

constraint fk_recibo foreign key(idproducto)references Producto(idproducto)
)
go
create table nodeclarado
(
idnodeclarado int not null primary key,
idproducto int not null,
nombrecliente varchar (30)null,
totalrecibo numeric (5,2)null,

constraint fk_nodeclarado foreign key(idproducto)references Producto(idproducto)
)
go

select * from Producto
select * from factura
select * from recibo
select * from nodeclarado
go

insert into Producto values (01,'taladro',250.50,'tajibal'),(02,'martillo',120.00,'tajibal'),(03,'pack de herramientas',260.00,'tajibal'),
(04,'juego de baño',760.00,'tajibal'),(05,'vidrio blindex',560.00,'tajibal'),(06,'taladro',110.50,'nacional')

insert into factura values (01,01,'pedro',250.50),(02,02,'ana',120.00),(03,03,'julio',260.00),(04,04,'javier',250.50),(05,05,'juan',560.00),
(06,01,'carmen',250.50),(07,02,'jenny',120.00),(08,03,'america',260.00),(09,04,'fernando',760.00),(10,05,'carlos',560.00),(11,06,'alberto',110.50)

insert into recibo values (01,01,'pedro',250.50),(02,02,'ana',120.00),(03,03,'julio',260.00),(04,04,'javier',250.50),(05,05,'juan',560.00),
(06,01,'carmen',250.50),(07,02,'jenny',120.00),(08,03,'america',260.00),(09,04,'fernando',760.00),(10,05,'carlos',560.00),(11,06,'alberto',110.50)

insert into nodeclarado values (01,01,'pedro',250.50),(02,02,'ana',120.00),(03,03,'julio',260.00),(04,04,'javier',250.50),(05,05,'juan',560.00),
(06,01,'carmen',250.50),(07,02,'jenny',120.00),(08,03,'america',260.00),(09,04,'fernando',760.00),(10,05,'carlos',560.00),(11,06,'alberto',110.50)
go


---9)ASOCIATIVIDAD DE LA UNION, INTERSECCION Y EL PRODUCTO CARTECIANO
-----UNION
(select * from factura union select * from recibo) union select * from nodeclarado
select * from factura union (select * from recibo union select * from nodeclarado)
go
-----INTERSECCION
(select * from factura intersect select * from recibo) intersect select * from nodeclarado
select * from factura intersect (select * from recibo intersect select * from nodeclarado)
go

---10)DISTRIVUTIVIDAD DE LA SELECCION CON RESPECTO A LA UNION Y LA INTERSECCION

select idproducto from ( select * from factura where idfactura = '01') as x  union
select idproducto from recibo where idrecibo = '01'

select idproducto from ( select * from factura where idfactura = '01') as x  intersect
select idproducto from recibo where idrecibo = '01'
go
---11)DISTRIVUTIVIDAD DE LA PROYECCION CON RESPECTO A LA UNION Y LA INTERSECCION

select idproducto from ( select * from factura where idfactura = '01') as x  union
select idproducto from recibo where idrecibo = '01'

select idproducto from ( select * from factura where idfactura = '01') as x  intersect
select idproducto from recibo where idrecibo = '01'
go
---12)CONVERSION DEL PRODUCTO CARTESIANO EN JOIN
select * from factura f,recibo r
select * from factura f join recibo r on f.idproducto=r.idproducto