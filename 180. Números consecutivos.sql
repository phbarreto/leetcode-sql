/* 
180. Números consecutivos
    +-------------+---------+
    | Column Name | Type    |
    +-------------+---------+
    | id          | int     |
    | num         | varchar |
    +-------------+---------+

    Em SQL, id é a chave primária para esta tabela.
    id é uma coluna de autoincremento começando em 1.
    

    Encontre todos os números que aparecem pelo menos três vezes consecutivas.
    Retorna a tabela de resultados em qualquer ordem .
    O formato do resultado está no exemplo a seguir.

*/

/* 
Resolução:
    1º. usando LEAD, criar colunas trazer os 2 próximos num daquele registro.
    2º. retornar só o 'num' em que 2 dois próximo forem iguais a ele.
*/

with cte as (
    select *
        ,lead(num,1) over (order by id) as 1_next
        ,lead(num,2) over (order by id) as 2_next
    from logs
    order by id
)
select 
    distinct num as ConsecutiveNums
from cte
    where 
        num = 1_next
        and num = 2_next