create database TransaccionBanco
go

use TransaccionBanco
drop database TransaccionBanco
 go

----------CREACION DE LA TABLA CON EL ATRIBUTO ENCRITADO -----
create table Cuentas(
idCuenta decimal (10),
saldo decimal(18,2),
numCuenta nvarchar(20),
titular varchar (25),
clave varbinary(max),
llave varchar(max)
constraint pk_ces primary key(idCuenta) 
)

drop table Cuentas
-----------------------PROCEDIMIENTO ALMACENADO PRA ISERTAR USUARIOS-----------------------------------------------

alter proc sp_insert_usuarios
@idCuenta decimal(10),
@saldo decimal(18,2),
@numCuenta nvarchar(20),
@titular varchar(25),
@pss varchar (max),
@key varchar(max)
as
declare 
@pssb varbinary(max)
begin 
set @pssb = (ENCRYPTBYPASSPHRASE(@key,@pss));

insert into Cuentas values (@idCuenta,@saldo,@numCuenta,@titular, @pssb,@key)
end 

--------- EJECUCION DEL PROCEDIMEINTO ALMACENADO Y ASIGNACION DE DATOS ----

exec sp_insert_usuarios 01,'100', '130465822','fernando muiba', 'fer8833', 'encriptacion'
---------------------------------------------------------------------
select * from Cuentas

-------------PROCEDIMIENTO ALMACENADO PARA PODER VER LA CONTRASEÑA ENCRIPTADA---------

create proc sp_mirar_pss
@idCuenta decimal(10)
as
begin 
select *,libre = CONVERT (varchar(max),DECRYPTBYPASSPHRASE(llave,clave)) from Cuentas
end 
----------------------------------------------------------------------------------------------------

exec sp_mirar_pss '130465822'
select * from Cuentas  


insert into Cuentas values(01, 20 , 130465822 ,'Luis Fernando Muiba Muiba')
insert into Cuentas values(02, 13455.50 , 130465823 ,'Darwin Muiba Muiba')

select * from Cuentas


create table Movimientos(
idCuenta decimal(10),
saldoAnterior decimal(18),
saldoPosterior decimal (18),
importe decimal,
fecha DateTime,

constraint fk_ic Foreign key (idCuenta) references Cuentas(idCuenta)

)



drop table Movimiento

select * from Cuentas
select * from Movimientos


-- declaramos-------------------------------------

declare @importe decimal(18,2),
@cuentaOrigen Varchar(15),
@cuentaDestino varchar(15)



-- asignamos el importe de la tranferencia y las cuentas de origen y destino--

set @importe = 50
set @cuentaOrigen = '130465822'
set @cuentaDestino = '130465823'

Begin Transaction 

Begin Try 

-- incrementamos el importe a la cuenta destino -- 
update cuentas 
set saldo = saldo + @importe
where numCuenta = @cuentaDestino

-- registramos el movimiento -- 
 insert into Movimientos
 (idCuenta, saldoAnterior, saldoPosterior, importe, fecha)
 select
 idCuenta, saldo - @importe, saldo,@importe, GetDate()
 from Cuentas 
 where numCuenta = @cuentaDestino 

 -- confirmamos la transaccion -- 

 Commit Transaction 
 end try 

 begin catch 

 Rollback Transaction 
 
 print 'se ah producido un error' 

 end catch 

 select *  from Cuentas 
 select * from Movimientos

 /*

insert into Movimiento (idCuenta, saldoAnterior,saldoPosterior,importe,fecha)
select idCuenta , saldo + @importe, saldo, @importe, getdate()),
from Cuentas
where numCuneta = @cuentaOrigen


update cuentas 
set saldo = saldo + @importe
where numCuenta = @cuentaDestino

insert into Movimiento(idCuenta, saldoAnterior,saldoPosterior,importe,fecha)
select idCuenta, saldo - @importe, saldo, @importe, get date())
from cuentas
where numCuenta = @cuentaDestino

end try 
Commit Transaction 

Begin Catch 
rollback transaction 
print 'error en la consulta'

end catch
*/