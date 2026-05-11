select max(valor) as 'Consulta mais cara' from consulta;

select min(valor) as 'Consulta mais cara' from consulta;

select sum(valor) as 'Totsl arrecadado nas consultas'
from consulta
where
    `tipoConsulta` = 'Cardiologia';

select avg(valor) as 'Média de valor arrecadado em consultas'
from consulta
where
    YEAR(`dataHoraConsulta`) = 2026;

select avg(valor) as 'Média de valor arrecadado em consultas'
from consulta
where
    MONTH(`dataHoraConsulta`) = 5;

select count(*) as 'Total' from paciente;

select count(*) as 'Total' from paciente where cidade = 'Santos';

SELECT ROUND(13.497429524);

select e.`nomeEspecialidade`, count(*) as Total
from medico m
    join especialidade e on m.`idEspecialidade` = e.`idEspecialidade`
GROUP BY
    e.`nomeEspecialidade`;

select `tipoConsulta`, sum(valor) as Total
from consulta
GROUP BY
    `tipoConsulta`
ORDER BY total;

select MONTH(`dataHoraConsulta`) as Mês, count(*)
from consulta
WHERE
    YEAR(`dataHoraConsulta`) = 2026
GROUP BY
    MONTH(`dataHoraConsulta`);

select e.`nomeEspecialidade`, count(*) as Total
from medico m
    join especialidade e on m.`idEspecialidade` = e.`idEspecialidade`
GROUP BY
    e.`nomeEspecialidade`
HAVING
    Total >= 1;

/* exercÍcios */
/* 1 */
SELECT
    case
        WHEN c.`temPlano` = 0 THEN 'Sem plano'
        WHEN c.`temPlano` = 1 THEN 'Com plano'
    END as Status,
    COUNT(*) as Total
from consulta c
GROUP BY
    c.`temPlano`;

SELECT c.`temPlano` as 'Com Plano', COUNT(*) as Total
from consulta c
GROUP BY
    c.`temPlano`;

/* 2 */
select e.`nomeEspecialidade` as Especialidade, COUNT(*) as Total
from
    consulta c
    JOIN medico m on c.idmedico = m.`idMedico`
    join especialidade e on m.`idEspecialidade` = e.`idEspecialidade`
GROUP BY
    e.`nomeEspecialidade`;

/* 3 */
select p.nome as Paciente, COUNT(*) as Total
from consulta c
    join paciente p on c.idpaciente = p.`idPaciente`
GROUP BY
    p.nome
HAVING
    Total >= 2;