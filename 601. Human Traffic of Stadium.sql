/* 
# 601. Human Traffic of Stadium

    +---------------+---------+
    | Column Name   | Type    |
    +---------------+---------+
    | id            | int     |
    | visit_date    | date    |
    | people        | int     |
    +---------------+---------+

    visit_date is the column with unique values for this table.
    Each row of this table contains the visit date and visit id to the stadium with the number of people during the visit.
    As the id increases, the date increases as well.
    

    Write a solution to display the records with three or more rows with consecutive id's, and the number of people is greater than or equal to 100 for each.
    Return the result table ordered by visit_date in ascending order.



*/

/*
    Lógica:
    1. Identificar grupos consecutivos:
    - Window function para criar um grupo (grp) que identifica sequências de linhas onde people >= 100.

    2. Verificar o tamanho do grupo:
    - Para cada grupo, verificar se ele tem 3 ou mais linhas consecutivas.

    3. Retornar todas as linhas do grupo:
    - filtrar apenas as linhas que pertencem a grupos com 3 ou mais linhas consecutivas.

*/

WITH cte AS (
    SELECT 
        *,
        SUM(CASE WHEN people < 100 THEN 1 ELSE 0 END) OVER (ORDER BY visit_date) AS grupo
    FROM stadium
)

,final AS (
    SELECT 
        *,
        COUNT(*) OVER (PARTITION BY grupo) AS count_grupo
    FROM cte
    WHERE people >= 100
)
SELECT 
    id,
    visit_date,
    people
FROM final
WHERE count_grupo >= 3
ORDER BY visit_date;
