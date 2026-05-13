create view vw_consulta as
select p.nome as Paciente, p.celular, p.email, c.`dataHoraConsulta`, m.nome as Medico, e.`nomeEspecialidade` from consulta c
join paciente p on c.idpaciente = p.`idPaciente`
join medico m on c.idmedico = m.`idMedico`
join especialidade e on m.`idEspecialidade` = e.`idEspecialidade`;

SELECT * from vw_consulta where MONTH(`dataHoraConsulta`) = 5;

SELECT `Paciente`, celular, `Medico`, `nomeEspecialidade` from vw_consulta where `Medico` like 'C%';

/* Procedure */
create Procedure ps_relatorio 
(
    in nome_medico varchar(100)
)

SELECT * from vw_consulta
where `Medico` = nome_medico;

CALL  ps_relatorio('Juliana Souza');

CREATE Procedure pi_especialidade
(
    in nome_especialidade VARCHAR(50)
)
insert into  especialidade(nomeEspecialidade) values(nome_especialidade);

CALL pi_especialidade('Traumatologia');

create Procedure pi_Medico
(
    in idEspecialidade int,
    in nomeMedico varchar(100),
    in novoCrm varchar(6)
)
insert into medico(idEspecialidade, nome, crm) values(idEspecialidade, nomeMedico, novoCrm);

call pi_Medico(6, 'Andelson', 654231);
