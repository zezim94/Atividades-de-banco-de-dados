/*6)Listar todos os dados dos clientes que tenha id entre 5 e 10. Os clientes de id 5 e 10 devem aparecer na listagem.*/

select * from cliente where idCliente >= 5 and idCliente <= 10;

/*7)Listar o nome do equipamento e a quantidade que possuem em estoque do que tem mais para o que tem menos. */

select  nomeEquipamento, qtd from equipamento ORDER BY qtd DESC;

/*8)Listar todos os dados de todos os aluguéis do aluguel mais novo para o mais antigo*/

select * from aluguel ORDER BY dataHoraRetirada;

/*9)Aplicar uma promoção de dez por cento em todas as cadeiras (valor da hora)*/

update equipamento set valorHora = valorHora * 0.9 where nomeEquipamento like 'Cadeiras';

/*10)Listar todas as cidades onde a barraca possui cliente.*/

/* todos que tem aluguel */
select DISTINCT c.cidade from aluguelequipamento ae
LEFT JOIN aluguel a on ae.idAluguel = a.idAluguel
left join cliente c on a.idCliente = c.idCliente;


/* todos os cadastrados */
select DISTINCT cidade from cliente;