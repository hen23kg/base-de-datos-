create database hendy
go
use hendy 
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


--CONSULTA 2
create table EST(
ci int not null primary key,
)

create table CURS(
ci int not null,
constraint fk_EST foreign key(ci)references EST(ci),
 nota int not null,
 cod_mat int not null primary key,
 sem_curso varchar(50)
 )

 create table MATERIA(
 COD_MAT INT not null,
 constraint fk_CURS foreign key(COD_MAT)references CURS(cod_mat),
 nombre varchar(50)
 )

 insert into EST values
 (1)

 insert into CURS values 
 (1,61,6311,'2-2020')

 insert into MATERIA values
 (6311,'BDD')

 select * from EST
 select * from CURS
 select * from MATERIA

 select nombre from EST e, CURS c, MATERIA m
 where e.ci = c.ci and nota > 60 and m.COD_MAT = c.cod_mat and nombre = 'BDD' and sem_curso = '2-2020'

 select nombre from (EST e join (select * from CURS c where nota)