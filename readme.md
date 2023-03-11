- Primeiro rodas as Queries de CREATE para criar as tabelas com suas relações;
- Segundo rodas as Queries de INSERT para popular as tabelas com dados;
- Terceiro rodar as Queries de SELECT para buscar os dados nas tabelas;

# Queries de SELECT

## 1. Buscar os nomes de todos os alunos que frequentam alguma turma do professor 'JOAO PEDRO'.
### Resultado esperado:
| nome   |
| :---------- |
| FELIPE SILVA |
| EDUARDO CAMPOS |
| CLAUDIO SILVA |

## 2. Buscar os dias da semana que tenham aulas da disciplina 'MATEMATICA'.
### Resultado esperado:
| dia_da_semana   |
| :---------- |
| 1 |
| 2 |

## 3. Buscar todos os alunos que frequentem aulas de 'MATEMATICA' e também 'FISICA'.
### Resultado esperado:
| id   | nome       |
| :---------- | :--------- |
| 1   | FELIPE SILVA  |

## 4. Buscar as disciplinas que não tenham nenhuma turma.
### Resultado esperado:
| id   | nome       |
| :---------- | :--------- |
| 4   | PORTUGUES  |
| 5   | RELIGIAO   |

## 5. Buscar os alunos que frequentem aulas de 'MATEMATICA' exceto os que frequentem 'QUIMICA'.
### Resultado esperado:
| id   | nome       |
| :---------- | :--------- |
| 1   | FELIPE SILVA   |
| 2   | EDUARDO CAMPOS |
