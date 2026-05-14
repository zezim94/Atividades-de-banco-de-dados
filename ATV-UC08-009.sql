/* 01) Criar uma view que traga a data do aluguel, o nome do funcionário que alugou e o cliente*/
create view vw_relatorio_aluguel as
select f.`nomeFuncionario` as Funcionário, DATE_FORMAT(
        a.`dataHoraRetirada`, '%d/%m/%Y'
    ) as 'Data do Aluguel', c.`nomeCliente` as Cliente
from
    aluguel a
    join funcionario f on a.`idFuncionario` = f.`idFuncionario`
    join cliente c on a.`idCliente` = c.`idCliente`;

select * from vw_relatorio_aluguel;

/* 02) Criar uma procedure que traga todos os aluguéis de determinado dia. 
Deve aparecer no aluguel a data do aluguel, o nome do cliente, o funcionário, e o equipamento alugado 
de acordo com uma data passada como parâmetro */

create PROCEDURE ps_todos_alugueis
(
    in data_escolhida date
)
select f.`nomeFuncionario` as Funcionário, c.`nomeCliente` as Cliente, DATE_FORMAT(a.`dataHoraRetirada`, '%d/%m/%Y') as 'Data do Aluguel', e.`nomeEquipamento` as Equipamento from aluguel a
join aluguelequipamento ae on a.`idAluguel` = ae.`idAluguel`
join equipamento e on ae.`idEquipamento` = e.`idEquipamento`
join funcionario f on a.`idFuncionario` = f.`idFuncionario`
join cliente c on a.`idCliente` = c.`idCliente`
where date(a.`dataHoraRetirada`) = data_escolhida;

call ps_todos_alugueis ('2025-12-29');

/* 03) Criar uma procedure ou view para trazer a quantidade de aluguéis 
realizadas separadas por forma de pagamento. É melhor usar procedure ou view? Justifique.
Ex.:
PIX       67
CRÉDITO  177
*/
create view vw_forma_pagamento as
select a.`formaPagamento` as 'Forma pagamento', COUNT(*) as 'Total'
from aluguel a
GROUP BY
    a.`formaPagamento`

SELECT * from vw_forma_pagamento;

/* View é melhor pois vai trazer todos e na view é possível fazer filtros caso queira refinar a busca */

/* 04) Criar uma procedure que permita reajustar em X percentual
toda a tabela de equipamentos. */

create PROCEDURE pu_equipamento
(
    in reajuste DECIMAL(10.2)
)
update equipamento set `valorHora` = `valorHora` * reajuste;

call pu_equipamento (1.20);

/* 05) Criar uma procedure ou view para trazer a quantidade de aluguéis 
realizadas de acordo com a forma de pagamento informada. 
É melhor usar procedure ou view? Justifique.
*/

create PROCEDURE ps_forma_pagamento
(
    in forma_pagamento_busca VARCHAR(50)
)
select e.`nomeEquipamento` as Equipamento, sum(ae.`valorItem`) as 'Total Arrecadado' from aluguel a
join aluguelequipamento ae on a.`idAluguel` = ae.`idAluguel`
JOIN equipamento e ON ae.`idEquipamento` = e.`idEquipamento`
WHERE `formaPagamento` = forma_pagamento_busca
GROUP BY e.`nomeEquipamento`;

call ps_forma_pagamento ('Pix');

/* nesse caso procedure, pois a busca vai ser dinamica, passando o paramnetro a busca já vai ser feita */

/*DESAFIO - Automatizar o processo de locação de um equipamento 
atualizando o estoque e tudo que for necessário através de uma procedure
de criar aluguel*/

create Procedure pi_insert_aluguel
(
    in cliente int,
    in funcionario int,
    in data_hora DATETIME,

    in equipamento int,
    in aluguel int,
    in valor_unitario DECIMAL(10,2),
    in valor_total DECIMAL(10,2),
    in quantidade int,

    in baixa_qtd int,
    in equipamento_baixa int

)
BEGIN
  DECLARE aluguel_id INT;
insert into aluguel(idCliente, idFuncionario, dataHoraretirada) values(cliente, funcionario, data_hora);
 SET aluguel_id = LAST_INSERT_ID();
insert into aluguelequipamento(idEquipamento, idAluguel, valorItem, valorUnitario, qtd) values(equipamento, aluguel_id, valor_total, valor_unitario, quantidade);

update equipamento set qtd = baixa_qtd WHERE `idEquipamento` = equipamento_baixa;
END

call pi_insert_aluguel (
    1,
    1,
    '2026-05-14',
    3,
    16,
    2.20,
    2.20,
    1,
    1,
    3
);