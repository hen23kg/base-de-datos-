use UAB

insert into Estudiantes values (1, 'Dennilson','Durán', 23)
insert into Estudiantes values (2, 'Carolina','Cruz', 22)
insert into Estudiantes values (3, 'Milton','Pariqui', 24)
insert into Estudiantes values (4, 'Angel','Luna', 26)
insert into Estudiantes values (5, 'Denni','Justiniano', 25)

select * from Estudiantes

select D.id, D.Nombre, D.Apellido, D.edad, M.materia, M.semestre, M.ru

From [UAB].[dbo].[Estudiantes] as D [192.168.1.6] [UAB].[dbo].[Estudiantes] as M

Where D.id = M.id