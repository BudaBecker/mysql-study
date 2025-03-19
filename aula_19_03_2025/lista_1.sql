USE clinicas;

SELECT * FROM medicos WHERE idade >= 20 AND idade <= 40;
SELECT * FROM medicos WHERE idade BETWEEN 20 AND 40;

SELECT * FROM medicos WHERE cidade = 'Florianopolis' OR cidade = 'Joinville';
SELECT * FROM medicos WHERE cidade IN ('Florianopolis', 'Joinville');
SELECT * FROM medicos WHERE cidade NOT IN ('Florianopolis', 'Joinville');

-- Exemplo de junção
SELECT * FROM medicos AS m, consultas AS c WHERE m.codm = c.codm;
SELECT * FROM medicos AS m JOIN consultas AS c ON m.codm = c.codm WHERE especialidade IN ('ortopedia', 'pediatria');

-- Exemplo de união
SELECT nome, cpf FROM medicos UNION SELECT nome, cpf FROM funcionarios;

-- Exercicios:
-- 1) Buscar o nome e o CPF dos médicos com menos de 40 anos ou com especialidade diferente de traumatologia 
SELECT nome, cpf FROM medicos WHERE idade < 40 AND especialidade != 'traumatologia';

-- 2) Buscar todos os dados das consultas marcadas no período da tarde após o dia 19/06/2006
SELECT * FROM consultas WHERE (hora BETWEEN '12:00' and '18:00') AND (data > '2006-06-19');
 
-- 3) Buscar o nome e a idade dos pacientes que não residem em Florianópolis
SELECT nome, idade FROM pacientes WHERE cidade != 'Florianopolis';

-- 4) Buscar a hora das consultas marcadas antes do dia 14/06/2024 e depois do dia 20/12/2024
SELECT hora FROM consultas WHERE data < '2024-06-14' and data > '2024-12-20';

-- 5) Buscar o nome e a idade (em meses) dos pacientes
SELECT nome, idade*12 as idade_em_meses FROM pacientes;

-- 6) Em quais cidades residem os funcionários?
SELECT cidade FROM funcionarios;

-- 7) Qual o menor e o maior salário dos funcionários da Florianópolis?
SELECT MIN(salario) as menor_salario, MAX(salario) as maior_salario FROM funcionarios WHERE cidade = 'Florianopolis';

-- 10) Qual o horário da última consulta marcada para o dia 13/06/2024?
SELECT MAX(hora) FROM consultas WHERE data = '2024-06-13';

-- 11) Qual a média de idade dos médicos e o total de ambulatórios atendidos por eles?
SELECT AVG(idade) as avg_idade, COUNT(*) as total_ambulatorios FROM medicos;

-- 12) Buscar o código, o nome e o salário líquido dos funcionários. O salário líquido é obtido pela diferença entre o salário cadastrado menos 20% deste mesmo salário
SELECT nome, codf, (salario*0.8) as salario_liquido FROM funcionarios;

-- 13) Buscar o nome dos funcionários que terminam com a letra “a”
SELECT nome FROM funcionarios WHERE nome LIKE '%a'; -- Nome e sobrenome
SELECT nome FROM funcionarios WHERE SUBSTRING_INDEX(nome, ' ', 1) LIKE '%a'; -- Apenas primeiro nome termina em 'A'

-- 14) Buscar o nome e CPF dos funcionários que não possuam a seqüência “00000” em seus CPFs
SELECT nome, cpf FROM funcionarios WHERE NOT cpf LIKE '%00000%';

-- 15) Buscar o nome e a especialidade dos médicos cuja segunda e a última letra de seus nomes seja a letra “o”
SELECT nome, especialidade FROM medicos WHERE (nome LIKE '%o') AND (nome LIKE '_o%');

-- 16) Buscar os códigos e nomes dos pacientes com mais de 25 anos que estão com tendinite, fratura, gripe e sarampo
SELECT nome, codp FROM pacientes WHERE idade > 25 AND doenca IN ('tendinite', 'fratura', 'gripe', 'sarampo');
