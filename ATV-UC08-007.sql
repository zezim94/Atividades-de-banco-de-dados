/*Criar um aluguel de equipamento para o mês de novembro (qualquer data e hora), qualquer equipamento, qualquer funcionário e qualquer cliente, mas cujo pagamento não tenha sido feito (ficou em aberto).*/
insert into
    aluguel (
        `idCliente`,
        `idFuncionario`,
        `dataHoraRetirada`
    )
values (7, 1, '2026-05-01');

insert into
    aluguelequipamento (
        `idEquipamento`,
        `idAluguel`,
        `valorItem`,
        `valorUnitario`,
        qtd
    )
values (5, 13, 6.00, 1.50, 4);

update equipamento set qtd = qtd - 1 where `idEquipamento` = 5

/*Listar nome de todos os funcionários, cpf e os aluguéis feitos por ele (apenas a data e que equipamento alugou).*/
SELECT f.`nomeFuncionario` as 'Funcionário', f.cpf, e.`nomeEquipamento` as 'Equipamento', DATE_FORMAT(
        a.`dataHoraRetirada`, '%d/%m/%Y'
    ) as 'Retirada'
from
    aluguel a
    JOIN funcionario f ON a.`idFuncionario` = f.`idFuncionario`
    JOIN aluguelequipamento ae ON a.`idAluguel` = ae.`idAluguel`
    JOIN equipamento e ON ae.`idEquipamento` = e.`idEquipamento`;

/*/Listar nome do cliente, cpf, datas que ele esteve na praia, quem atendeu este cliente, tudo isto, ordenado por data, da mais nova para a mais antiga, apenas no mês de DEZ24.*/
SELECT c.`nomeCliente` as 'Cliente', c.cpf, DATE_FORMAT(
        a.`dataHoraRetirada`, '%d/%m/%Y'
    ) as 'Retirada', f.`nomeFuncionario` as 'Funcionário'
from
    aluguel a
    JOIN cliente c ON a.`idCliente` = c.`idCliente`
    JOIN funcionario f ON a.`idFuncionario` = f.`idFuncionario`
    JOIN aluguelequipamento ae ON a.`idAluguel` = ae.`idAluguel`
ORDER BY a.`dataHoraRetirada`;

/*Lista do nome dos equipamentos que foram mais alugados em ordem decrescente, do equipamento mais alugado para o menos alugado. Equipamentos não alugados devem sair no relatório.*/
select DISTINCT
    e.`nomeEquipamento` as 'Equipamento',
    SUM(ae.`idEquipamento`) as 'Total'
from
    aluguelequipamento ae
    JOIN equipamento e ON ae.`idEquipamento` = e.`idEquipamento`
GROUP BY
    `nomeEquipamento`
ORDER BY SUM(ae.`idEquipamento`) desc;

/*Listar a arrecadação bruta da barraca de praia entre Natal e Ano Novo.*/
select SUM(a.`valorAPagar`) as 'Total'
from aluguel a
WHERE
    a.`dataHoraRetirada` BETWEEN '2024-12-25' AND '2024-12-31';

/*Reajustar preço por hora de todos os equipamentos em 10%.*/
update equipamento set `valorHora` = (`valorHora` * 1.1);

/*Listar a quantidade de clientes que pagaram utilizando determinada forma de pagamento, em ordem crescente, do método mais usado para o menos usado. Também é necessário que pagamentos não realizados sejam apontados.*/
select COUNT(c.`nomeCliente`) as 'Qtd', a.`formaPagamento` as 'Forma Pgt.'
from aluguel a
    JOIN cliente c on a.`idCliente` = c.`idCliente`
GROUP BY
    a.`formaPagamento`
ORDER BY COUNT(c.`nomeCliente`) DESC

/*Listar quanto a barraca faturou por dia, em cada um dos dias do mês de dezembro apenas.*/
select DATE_FORMAT(
        a.`dataHoraRetirada`, '%d/%m/%Y'
    ) as 'Data', sum(a.`valorAPagar`) as 'Faturamento do dia'
from aluguel a
GROUP BY
    a.`dataHoraRetirada`;

/*Excluir o pagamento e todas as referências a ele criadas no item 1. Se tentar excluir direto da tabela aluguel teremos um problema? Por que isto ocorre? Como resolver (escrever o código usado)?*/

/* primeiro o pai depois o filho, se não da erro de chave estrangeira */
DELETE FROM aluguelequipamento WHERE `idAluguelEquipamento` = 20;
delete from aluguel where `idAluguel` = 13;


/*Listar todos os equipamentos que tiveram a quantidade de aluguéis inferiores a 5 unidades, durante o mês de DEZ24.*/
select e.`nomeEquipamento` as 'Equipamento', DATE_FORMAT(a.`dataHoraRetirada`, '%m/%Y') as 'Data', SUM(ae.`idEquipamento`) as 'Total'
from
    aluguel a
    JOIN aluguelequipamento ae ON a.`idAluguel` = ae.`idAluguelEquipamento`
    JOIN equipamento e ON ae.`idEquipamento` = e.`idEquipamento`
where
    'Total' < 5
    and DATE_FORMAT(a.`dataHoraRetirada`, '%m/%Y') = '12/2024'
GROUP BY
    e.`nomeEquipamento`