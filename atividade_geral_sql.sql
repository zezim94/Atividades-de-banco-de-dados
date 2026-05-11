/*1. Listar todos os clientes cadastrados.*/
select c.`nomeCliente` Cleintes from cliente c; 

/*2. Exibir nome dos clientes e data de retirada dos aluguéis.*/
select c.`nomeCliente` as Cliente, DATE_FORMAT(a.`dataHoraRetirada`, '%d/%m/%Y') as 'Data Aluguel' from aluguel a
join cliente c on a.`idCliente` = c.`idCliente`;

/*3. Mostrar o nome dos equipamentos alugados e a quantidade alugada em cada aluguel.*/
select e.`nomeEquipamento` as Equipamento, COUNT(*) as Total
 from aluguel a
JOIN aluguelequipamento ae ON  a.`idAluguel` = ae.`idAluguel`
join equipamento e on ae.`idEquipamento` = e.`idEquipamento`
GROUP BY ae.`idAluguel`
ORDER BY e.`nomeEquipamento`;

/*4. Listar o nome dos funcionários e a data em que realizaram os aluguéis.*/
select f.`nomeFuncionario` as Funcionário, DATE_FORMAT(a.`dataHoraRetirada`, '%d/%m/%Y') as 'Data do Aluguel' from aluguel a
join funcionario f on a.`idFuncionario` = f.`idFuncionario`;

/*5. Listar a quantidade de clientes que existem no sistema.*/
select COUNT(*) as 'Total de clientes' from cliente; 

/*6. Contar quantos aluguéis cada cliente realizou.*/
select c.`nomeCliente` as Cliente, COUNT(*) as 'Total alugado' from aluguel a
join cliente c on a.`idCliente` = c.`idCliente`
GROUP BY c.`nomeCliente`;

/*7. Mostrar o maior valor de aluguel registrado.*/
select max(a.`valorAPagar`) as 'Maior valor pago' from aluguel a;

/*8. Mostrar o menor valor de aluguel registrado.*/
select min(a.`valorAPagar`) as 'Menor valor pago' from aluguel a; 

/*9. Calcular o valor médio dos aluguéis realizados.*/
select avg(a.`valorAPagar`) as 'Média de valor pago' from aluguel a; 

/*10. Calcular o total arrecadado com aluguéis até o dia de hoje.*/
select sum(a.`valorPago`) as 'Total arrecadado' from aluguel a;

/*11. Listar o nome dos equipamentos com quantidade em estoque maior que 40*/
select e.`nomeEquipamento` as Equipamento, e.qtd as Quantidade from equipamento e
WHERE e.qtd > 40;

/*12. Mostrar a data do aluguel, o valor gasto, apenas dos aluguéis pagos via cartão.*/
select DATE_FORMAT(a.`dataHoraRetirada`, '%d/%m/%Y') as 'Data Aluguel', (a.`valorPago`) from aluguel a
WHERE a.`formaPagamento` in ('debito', 'credito');

/*13. Exibir o nome dos clientes e quantos aluguéis realizaram mas apenas dos que realizaram mais de 2 aluguéis*/
select c.`nomeCliente` as Cliente, COUNT(*) as Total from aluguel a 
join cliente c on a.`idCliente` = c.`idCliente`
GROUP BY c.`nomeCliente`
HAVING Total > 2;

/*14. Listar a quantidade total do valor arrecadado nos aluguéis por tipo de equipamento.*/
select e.`nomeEquipamento` as Equipamento, sum(a.`valorPago`) as Total from aluguel a
join aluguelequipamento ae on a.`idAluguel` = ae.`idAluguel`
JOIN equipamento e ON ae.`idEquipamento` = e.`idEquipamento`
GROUP BY e.`nomeEquipamento`;

/*15. Mostrar o valor total movimentado por cliente*/
select c.`nomeCliente` as Cliente, sum(`valorPago`) as 'Valor Pago' from aluguel a
join cliente c on a.`idCliente` = c.`idCliente`
GROUP BY c.`nomeCliente`;

/*16. Exibir os equipamentos com valor/hora acima da média*/ 
select e.`nomeEquipamento` as Equipamento, e.`valorHora` as Valor from equipamento e
WHERE e.`valorHora` > (SELECT avg(`valorHora`) from equipamento);

/*17. Mostrar o funcionário que realizou mais aluguéis.*/
select f.`nomeFuncionario` as Funcionário from aluguel a
join funcionario f on a.`idFuncionario` = f.`idFuncionario`
GROUP BY f.`nomeFuncionario`
ORDER BY COUNT(*) DESC LIMIT 1;

/*18. Exibir a data dos aluguéis cujo valor total seja maior que R$ 100,00.*/
select DATE_FORMAT(a.`dataHoraRetirada`, '%d/%m/%Y') as 'Data Aluguel', sum(a.`valorPago`) as Total from aluguelequipamento ae
join aluguel a on ae.`idAluguel` = a.`idAluguel`
GROUP BY ae.`idAluguel`
HAVING Total > 100;

/*19. Mostrar o total de valor pago por forma de pagamento.*/
select a.`formaPagamento` as 'Forma de Pagamento', sum(a.`valorPago`) from aluguel a
WHERE a.`formaPagamento` is NOT null
GROUP BY a.`formaPagamento`;

/*20. Exibir o nome dos equipamentos alugados mais de 3 vezes.*/
select e.`nomeEquipamento` Equipamento, COUNT(*) as Total from aluguelequipamento ae
join equipamento e on ae.`idEquipamento` = e.`idEquipamento`
GROUP BY ae.`idAluguel`
HAVING Total > 3;