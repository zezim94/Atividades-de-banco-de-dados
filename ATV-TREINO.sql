/*
T1 - Listar o nomes de todos os médicos que começam com G
e suas especialidades.
*/
SELECT nome, `nomeEspecialidade` from medico
JOIN especialidade ON medico.`idEspecialidade` = especialidade.`idEspecialidade`
WHERE nome LIKE '____G%';

/*
T2 - Listar o nome de todos os médidos, sua especialidade e 
seus meios contatos.
*/
SELECT nome, `nomeEspecialidade`, contatomedico.contato from medico
JOIN especialidade ON medico.`idEspecialidade` = especialidade.`idEspecialidade`
JOIN contatomedico ON medico.`idMedico` = contatomedico.`idMedico`;

/*
T3 - Listar a data da consulta, o paciente que será atendido,
e qual a especialidade do médico que irá atendê-lo, da consulta
mais longe para a mais próxima.
*/
SELECT DATE_FORMAT(c.dataHoraConsulta, '%d/%m/%Y') as 'Data Consulta', p.nome as 'Paciente', e.nomeEspecialidade as 'Especialidade' from consulta as c
JOIN medico as m ON c.idmedico = m.idMedico
JOIN especialidade as e ON m.idEspecialidade = e.idEspecialidade
JOIN paciente as p ON c.idpaciente = p.idPaciente
ORDER BY dataHoraConsulta DESC;

/*
T4 - Inserir um Dr a mais na tabela medicos, 
como clínico geral, o Dr. Otávio Meirelles. 
Listar o nome de todos os médicos e a data de suas consultas, 
mesmo médicos sem consultas (Dr Otávio tem que aparecer).
*/
INSERT INTO medico VALUES(null, '123654', 2, 'Dr. Otávio', );
SELECT medico.nome consulta.`dataHoraConsulta` FROM consulta
FULL JOIN medico ON consulta.idMedico = medico.`idMedico`;

/*
T5 - Listar o nome de todos os medicos, sua especialidade e 
todos os seus contatos apenas quando forem telefone.
*/

SELECT medico.nome, especialidade.`nomeEspecialidade`, contatomedico.contato from medico
JOIN especialidade ON medico.`idEspecialidade` = especialidade.`idEspecialidade`
JOIN contatomedico ON medico.`idMedico` = contatomedico.`idMedico`
WHERE contatomedico.`tipoContato` = 'telefone';