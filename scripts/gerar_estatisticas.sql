-- Listando o Total de Registros das tabelas

SELECT 
    CONCAT('select \'',
            table_name,
            '\' as \'Tabela\', count(1) as cnt from ',
            table_name,
            ' union all ') AS SQLStatement
FROM
    information_schema.tables t
WHERE
    table_schema = 'simpsons_db'
        AND table_type <> 'VIEW' 
UNION ALL SELECT 'SELECT \'Total de Registros Por Tabela\' as \'Tabela\', 0 as cnt  FROM dual;' FROM DUAL;

-- Estatísticas de Campos
-- Count Distinto de Valores
SELECT 
    CONCAT('select \'',
            c.table_name,
            '\' as \'Table Name\', \'',
            c.column_name,
            '\' as \'Column Name\', count(distinct ',
            c.column_name,
            ') as \'Distinct Values\' From ',
            c.table_name,
            ' union all') AS SQLStatement
FROM
    information_schema.columns c
        INNER JOIN
    information_schema.tables t ON t.table_catalog = c.table_catalog
        AND t.table_schema = c.table_schema
        AND t.table_name = c.table_name
WHERE
    t.table_schema = 'simpsons_db'
        AND t.table_type <> 'VIEW';

-- Media, Desvio Padrao e Variancia de Valores
SELECT 
    CONCAT('select \'',
            c.table_name,
            '\' as \'Table Name\', \'',
            c.column_name,
            '\' as \'Column Name\', avg(',
            c.column_name,
            ') as \'Average Values\', std(',
            c.column_name,
            ') as \'Std. Deviation Values\', variance(',
            c.column_name,
            ') as \'Variance Values\' From ',
            c.table_name,
            ' union all') AS SQLStatement
FROM
    information_schema.columns c
        INNER JOIN
    information_schema.tables t ON t.table_catalog = c.table_catalog
        AND t.table_schema = c.table_schema
        AND t.table_name = c.table_name
WHERE
    t.table_schema = 'simpsons_db'
        AND t.table_type <> 'VIEW'
        AND c.data_type IN ('int');

-- Categorias para Campos com até 10 valores distintos
SELECT 
    CONCAT('select \'',
            c.table_name,
            '\' as \'Table Name\', \'',
            c.column_name,
            '\' as \'Column Name\', group_concat(distinct(',
            c.column_name,
            ')) as \'Sample Values\' From ',
            c.table_name,
            ' having count(distinct(',
            c.column_name,
            ')) < 10 union all') AS SQLStatement
FROM
    information_schema.columns c
        INNER JOIN
    information_schema.tables t ON t.table_catalog = c.table_catalog
        AND t.table_schema = c.table_schema
        AND t.table_name = c.table_name
WHERE
    t.table_schema = 'simpsons_db'
        AND t.table_type <> 'VIEW'
        AND c.data_type IN ('text' , 'varchar');
