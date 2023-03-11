-- Queries para criação das tabelas
CREATE TABLE IF NOT EXISTS aluno
  (
     id     SERIAL PRIMARY KEY,
     "nome" VARCHAR(45) UNIQUE
  );

CREATE TABLE IF NOT EXISTS disciplina
  (
     id     SERIAL PRIMARY KEY,
     "nome" VARCHAR(45) UNIQUE
  );

CREATE TABLE IF NOT EXISTS professor
  (
     id     SERIAL PRIMARY KEY,
     "nome" VARCHAR(45) UNIQUE
  );

CREATE TABLE IF NOT EXISTS turma
  (
     id            SERIAL PRIMARY KEY,
     dia_da_semana INTEGER,
     horario       VARCHAR(45),
     disciplina_id INTEGER NOT NULL,
          CONSTRAINT fk_disciplina_id FOREIGN KEY (disciplina_id) REFERENCES
          disciplina(id),
          professor_id  INTEGER NOT NULL,
     CONSTRAINT fk_professor_id FOREIGN KEY (professor_id) REFERENCES professor(
          id)
  );

CREATE TABLE IF NOT EXISTS aluno_turma
  (
     aluno_id INTEGER NOT NULL,
     turma_id INTEGER NOT NULL,
     FOREIGN KEY (aluno_id) REFERENCES aluno(id),
     FOREIGN KEY (turma_id) REFERENCES turma(id)
  );

-- Queries para popular as tabelas
INSERT INTO professor
            (nome)
VALUES      ('JOAO PEDRO');

INSERT INTO professor
            (nome)
VALUES      ('PAULO RICARDO');

INSERT INTO professor
            (nome)
VALUES      ('FABIO JUNIOR');

INSERT INTO disciplina
            (nome)
VALUES      ('MATEMATICA');

INSERT INTO disciplina
            (nome)
VALUES      ('FISICA');

INSERT INTO disciplina
            (nome)
VALUES      ('QUIMICA');

INSERT INTO disciplina
            (nome)
VALUES      ('PORTUGUES');

INSERT INTO disciplina
            (nome)
VALUES      ('RELIGIAO');

INSERT INTO aluno
            (nome)
VALUES      ('FELIPE SILVA');

INSERT INTO aluno
            (nome)
VALUES      ('EDUARDO CAMPOS');

INSERT INTO aluno
            (nome)
VALUES      ('ROBERTO GOMES');

INSERT INTO aluno
            (nome)
VALUES      ('CLAUDIO SILVA');

INSERT INTO turma
            (dia_da_semana,
             horario,
             disciplina_id,
             professor_id)
VALUES      (1,
             'MANHA',
             1,
             1);

INSERT INTO turma
            (dia_da_semana,
             horario,
             disciplina_id,
             professor_id)
VALUES      (2,
             'TARDE',
             1,
             2);

INSERT INTO turma
            (dia_da_semana,
             horario,
             disciplina_id,
             professor_id)
VALUES      (2,
             'NOITE',
             2,
             2);

INSERT INTO turma
            (dia_da_semana,
             horario,
             disciplina_id,
             professor_id)
VALUES      (5,
             'MANHA',
             3,
             1);

INSERT INTO aluno_turma
            (aluno_id,
             turma_id)
VALUES      (1,
             1);

INSERT INTO aluno_turma
            (aluno_id,
             turma_id)
VALUES      (2,
             1);

INSERT INTO aluno_turma
            (aluno_id,
             turma_id)
VALUES      (1,
             3);

INSERT INTO aluno_turma
            (aluno_id,
             turma_id)
VALUES      (4,
             2);

INSERT INTO aluno_turma
            (aluno_id,
             turma_id)
VALUES      (4,
             4);


-- Queries para consultar as tabelas

-- 1. Buscar os nomes de todos os alunos que frequentam alguma turma do professor 'JOAO PEDRO':
SELECT a.nome
FROM   aluno a
       JOIN aluno_turma at2
         ON a.id = at2.aluno_id
       JOIN turma t
         ON at2.turma_id = t.id
       JOIN professor p
         ON p.id = t.professor_id
WHERE  p.nome = 'JOAO PEDRO';

-- 2. Buscar os dias da semana que tenham aulas da disciplina 'MATEMATICA':
SELECT t.dia_da_semana
FROM   turma t
       LEFT JOIN disciplina d
              ON d.id = t.disciplina_id
WHERE  d.nome = 'MATEMATICA';

-- 3. Buscar todos os alunos que frequentem aulas de 'MATEMATICA' e também 'FISICA':
-- Versão 1:
SELECT a.*
FROM   aluno a
       JOIN aluno_turma at1
         ON at1.aluno_id = a.id
       JOIN turma t
         ON t.id = at1.turma_id
       JOIN disciplina d
         ON d.id = t.disciplina_id
WHERE  d.nome = 'MATEMATICA'
       AND a.id IN (SELECT a2.id
                    FROM   aluno a2
                           JOIN aluno_turma at2
                             ON at2.aluno_id = a2.id
                           JOIN turma t2
                             ON t2.id = at2.turma_id
                           JOIN disciplina d2
                             ON d2.id = t2.disciplina_id
                    WHERE  d2.nome = 'FISICA');
-- Versão 2:
SELECT DISTINCT a.*
FROM   aluno a
       JOIN aluno_turma at2
         ON a.id = at2.aluno_id
       JOIN turma t
         ON at2.turma_id = t.id
       JOIN disciplina d
         ON d.id = t.disciplina_id
WHERE  d.nome IN ( 'MATEMATICA', 'FISICA' )
GROUP  BY a.nome,
          a.id
HAVING Count(DISTINCT d.nome) = 2;

-- 4. Buscar as disciplinas que não tenham nenhuma turma:
SELECT d.*
FROM   disciplina d
WHERE  NOT EXISTS (SELECT *
                   FROM   turma t
                   WHERE  d.id = t.disciplina_id);

-- 5. Buscar os alunos que frequentem aulas de 'MATEMATICA' exceto os que frequentem 'QUIMICA':
SELECT a.*
FROM   aluno a
       JOIN aluno_turma at1
         ON at1.aluno_id = a.id
       JOIN turma t
         ON t.id = at1.turma_id
       JOIN disciplina d
         ON d.id = t.disciplina_id
WHERE  d.nome = 'MATEMATICA'
       AND a.id NOT IN (SELECT a2.id
                        FROM   aluno a2
                               JOIN aluno_turma at2
                                 ON at2.aluno_id = a2.id
                               JOIN turma t2
                                 ON t2.id = at2.turma_id
                               JOIN disciplina d2
                                 ON d2.id = t2.disciplina_id
                        WHERE  d2.nome = 'QUIMICA');