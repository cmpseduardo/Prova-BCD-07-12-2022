DROP DATABASE IF EXISTS escoladanca2;
CREATE DATABASE escoladanca2 CHARSET=UTF8 COLLATE UTF8_GENERAL_CI;

USE escoladanca2;

CREATE TABLE professores(
    id_prof INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome_prof VARCHAR(50) NOT NULL,
    formacao VARCHAR(35) NOT NULL
);

CREATE TABLE telefonesProfs(
    id INTEGER NOT NULL,
    telefone VARCHAR(14) NOT NULL,
    FOREIGN KEY (id) REFERENCES professores(id_prof)
);


CREATE TABLE turmas(
    cod_turma INTEGER PRIMARY KEY AUTO_INCREMENT,
    id_prof INTEGER NOT NULL,
    horario VARCHAR(30) NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    FOREIGN KEY (id_prof) REFERENCES professores(id_prof)
);


CREATE TABLE alunos(
    ra VARCHAR(15) NOT NULL,
    nome VARCHAR(50) NOT NULL,
    sexo VARCHAR(15) NOT NULL,
    data_nascimento DATE NOT NULL,
    cod_turma INTEGER NOT NULL,
    FOREIGN KEY (cod_turma) REFERENCES turmas(cod_turma)
);

CREATE TABLE horarios(
    id_horario INTEGER PRIMARY KEY AUTO_INCREMENT,
    inicio TIME NOT NULL,
    fim TIME NOT NULL
);

CREATE TABLE disciplinas(
    id_disciplina INTEGER PRIMARY KEY AUTO_INCREMENT,
    id_horario INTEGER NOT NULL,
    nome_disciplina VARCHAR(40) NOT NULL,
    id_prof INTEGER NOT NULL,
    FOREIGN KEY (id_prof) REFERENCES professores(id_prof),
    FOREIGN KEY (id_horario) REFERENCES horarios(id_horario)
);

INSERT INTO professores VALUES (DEFAULT, 'Guinever', 'Dança');
INSERT INTO professores VALUES (DEFAULT, 'Gustavo', 'Dança');

INSERT INTO telefonesProfs VALUES (1, '199989890');
INSERT INTO telefonesProfs VALUES (1, '199089980');
INSERT INTO telefonesProfs VALUES (2, '199984253');
INSERT INTO telefonesProfs VALUES (2, '199984826');

INSERT INTO turmas VALUES (DEFAULT, 1, 'Manhã', 'Adulto');
INSERT INTO turmas VALUES (DEFAULT, 1, 'Tarde', 'Idoso');
INSERT INTO turmas VALUES (DEFAULT, 2, 'Noite', 'Adulto');

INSERT INTO alunos VALUES ('0004594999', 'José', 'homem', '2003-08-20', 1);
INSERT INTO alunos VALUES ('0004594980', 'João', 'homem', '2005-09-29', 2);
INSERT INTO alunos VALUES ('0004782152', 'Robinson', 'homem', '2001-07-21', 1);
INSERT INTO alunos VALUES ('0004501312', 'Gustavo', 'homem', '1999-02-23', 2);
INSERT INTO alunos VALUES ('0004721405', 'Geraldo', 'homem', '2000-09-21', 2);
INSERT INTO alunos VALUES ('0004782489', 'Francisco', 'homem', '1987-01-28', 1);
INSERT INTO alunos VALUES ('0004325061', 'Ana', 'mulher', '2005-04-17', 1);
INSERT INTO alunos VALUES ('0004513654', 'Denilson', 'homem', '2005-09-26', 2);
INSERT INTO alunos VALUES ('0004512345', 'Cristian', 'homem', '2005-03-11', 1);

INSERT INTO horarios VALUES (DEFAULT, '07:30:00', '11:20:00');
INSERT INTO horarios VALUES (DEFAULT, '06:40:00', '09:30:00');
INSERT INTO horarios VALUES (DEFAULT, '09:30:00', '11:30:00');
INSERT INTO horarios VALUES (DEFAULT, '13:00:00', '16:00:00');
INSERT INTO horarios VALUES (DEFAULT, '07:30:00', '11:20:00');
INSERT INTO horarios VALUES (DEFAULT, '06:40:00', '09:30:00');
INSERT INTO horarios VALUES (DEFAULT, '09:30:00', '11:30:00');

INSERT INTO disciplinas VALUES (DEFAULT, 1, 'Valsa', 1);
INSERT INTO disciplinas VALUES (DEFAULT, 1, 'Salsa', 1);
INSERT INTO disciplinas VALUES (DEFAULT, 2, 'Samba', 1);
INSERT INTO disciplinas VALUES (DEFAULT, 2, 'Funk', 2);
INSERT INTO disciplinas VALUES (DEFAULT, 3, 'Balé', 2);
INSERT INTO disciplinas VALUES (DEFAULT, 3, 'Zumba', 2);

DESCRIBE professores;
DESCRIBE telefonesProfs;
DESCRIBE turmas;
DESCRIBE disciplinas;
DESCRIBE alunos;
DESCRIBE horarios;
SHOW TABLES;


CREATE VIEW vw_professores AS 
SELECT p.id_prof AS id_prof, p.nome_prof, p.formacao, t.id AS id, t.telefone
FROM telefonesProfs t
INNER JOIN professores p ON p.id_prof = t.id;

CREATE VIEW vw_prof_turma AS 
SELECT p.id_prof AS id_prof, p.nome_prof, t.cod_turma AS cod_turma, t.tipo
FROM turmas t
INNER JOIN professores p ON p.id_prof = t.cod_turma;

CREATE VIEW vw_turmas_disc AS 
SELECT t.cod_turma AS cod_turma, t.tipo, d.id_disciplina AS id_disciplina, d.nome_disciplina
FROM turmas t
INNER JOIN disciplinas d ON t.cod_turma = d.id_disciplina;

CREATE VIEW vw_turmas_alunos AS 
SELECT t.cod_turma AS cod_turma, t.tipo, a.ra AS ra, a.nome, a.sexo, a.data_nascimento
FROM alunos a
INNER JOIN turmas t ON t.cod_turma = a.ra;

CREATE VIEW vw_disc_horario AS
SELECT d.id_disciplina AS id_disciplina, d.nome_disciplina, h.id_horario AS id_horario, h.inicio, h.fim
FROM disciplinas d
INNER JOIN horarios h ON d.id_disciplina = h.id_horario;