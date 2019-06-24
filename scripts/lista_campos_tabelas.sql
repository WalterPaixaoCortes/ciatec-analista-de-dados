select table_name as 'Nome Tabela', 
       ordinal_position as '#', 
       column_name as 'Nome Coluna', 
       column_type as 'Tipo de Dados', 
       column_key as 'Tipo Chave', 
       is_nullable as 'Aceita Nulo?', 
       '' as 'Descrição' 
from information_schema.columns
where table_schema = 'got_db'
order by table_name, ordinal_position