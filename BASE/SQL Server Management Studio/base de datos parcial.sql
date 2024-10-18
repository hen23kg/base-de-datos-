create database bd_cca
go
use bd_cca
go

create table estudiante(
ci int not null primary key,
nombre varchar(50)not null

)
go

create table inscripcion(
id int not null,
codMateria int not null,
semestre varchar(40) not null

constraint fk_inscripcion foreign key (id) references estudiante(ci)
)
go
insert into estudiante values (2,'lucas')
insert into estudiante values (3,'jose')
insert into estudiante values (4,'carlos')
insert into estudiante values (5,'josue')
select * from estudiante
select * from inscripcion
go

--CONULTA OPTIMIZADO--
select ci,nombre,codMateria from  estudiante e join (select * from inscripcion i where i.codMateria='6311' 
and semestre = '2-2011') as x on (e.ci=x.id)
go

-- NO OPTIMIZADO--
select ci,nombre,codMateria from estudiante e, inscripcion i
where i.codMateria='6311'and semestre = '2-2011' and e.ci=i.id
go