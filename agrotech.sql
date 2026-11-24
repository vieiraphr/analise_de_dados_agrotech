-- AgroTech Solutions - Auditoria de Dados e Indicadores Gerenciais

-- =====================================================
-- PREPARAÇÃO DA BASE
-- =====================================================
CREATE DATABASE agropecuaria_db;
USE agropecuaria_db;

CREATE TABLE tb_vendas_agro (
    id INT PRIMARY KEY,
    produto VARCHAR(100),
    categoria VARCHAR(50),
    fornecedor VARCHAR(100),
    estado VARCHAR(50),
    quantidade INT,
    valor_unitario DECIMAL(10,2),
    data_venda DATE,
    estoque BOOLEAN
);

INSERT INTO tb_vendas_agro
(id, produto, categoria, fornecedor, estado, quantidade, valor_unitario, data_venda, estoque)
VALUES
(1, 'Milho Safrinha', 'Grãos', 'AgroSul', 'PR', 120, 89.90, '2025-01-10', true),
(2, 'Soja Premium', 'Grãos', 'Campo Verde', 'MT', 200, 145.50, '2025-01-15', true),
(3, 'Ração Bovina 25kg', 'Rações', 'NutriCampo', 'SC', 80, 110.00, '2025-01-18', true),
(4, 'Fertilizante NPK', 'Fertilizantes', 'AgroMax', 'GO', 50, 320.75, '2025-01-22', false),
(5, 'Herbicida ForteMax', 'Defensivos', 'BioPlant', 'MS', 30, 450.00, '2025-01-25', true),
(6, 'Calcário Agrícola', 'Minerais', 'Solo Forte', 'PR', 300, 45.90, '2025-01-27', true),
(7, 'Semente de Trigo', 'Sementes', 'AgroSul', 'RS', 90, 99.99, '2025-02-01', false),
(8, 'Inseticida Power', 'Defensivos', 'Campo Verde', 'MT', 25, 599.00, '2025-02-03', true),
(9, 'Farelo de Soja', 'Rações', 'NutriCampo', 'SC', 110, 76.50, '2025-02-05', true),
(10, 'Adubo Orgânico', 'Fertilizantes', 'BioPlant', 'SP', 60, 180.00, '2025-02-08', true),
(11, 'Milheto', 'Sementes', 'AgroSul', 'GO', 70, 88.80, '2025-02-10', false),
(12, 'Sal Mineral Bovino', 'Minerais', 'NutriCampo', 'MG', 95, 67.40, '2025-02-12', true),
(13, 'Soja Convencional', 'Grãos', 'Campo Verde', 'MT', 180, 139.00, '2025-02-15', true),
(14, 'Ração Suína 20kg', 'Rações', 'NutriCampo', 'SC', 55, 98.00, '2025-02-17', false),
(15, 'Fungicida Max', 'Defensivos', 'AgroMax', 'PR', 22, 799.90, '2025-02-20', true),
(16, 'Semente de Aveia', 'Sementes', 'AgroSul', 'RS', 65, 72.30, '2025-02-22', true),
(17, 'Ureia Agrícola', 'Fertilizantes', 'Solo Forte', 'GO', 140, 210.00, '2025-02-25', true),
(18, 'Milho Híbrido', 'Grãos', 'Campo Verde', 'MS', 210, 155.90, '2025-03-01', false),
(19, 'Ração Equina', 'Rações', 'NutriCampo', 'SP', 40, 132.75, '2025-03-04', true),
(20, 'Herbicida Select', 'Defensivos', 'BioPlant', 'MT', 28, 499.90, '2025-03-06', true),
(21, 'Calcário Premium', 'Minerais', 'Solo Forte', 'PR', 310, 55.50, '2025-03-08', true),
(22, 'Semente de Pastagem', 'Sementes', 'AgroSul', 'GO', 85, 120.00, '2025-03-10', false),
(23, 'Soja Exportação', 'Grãos', 'Campo Verde', 'MT', 260, 160.00, '2025-03-12', true),
(24, 'Fertilizante Potássico', 'Fertilizantes', 'AgroMax', 'MS', 48, 420.00, '2025-03-14', true),
(25, 'Inseticida Ultra', 'Defensivos', 'BioPlant', 'SP', 18, 890.00, '2025-03-16', false),
(26, 'Ração Avícola', 'Rações', 'NutriCampo', 'SC', 130, 89.50, '2025-03-18', true),
(27, 'Milho Orgânico', 'Grãos', 'AgroSul', 'PR', 95, 110.00, '2025-03-20', true),
(28, 'Adubo Nitrogenado', 'Fertilizantes', 'Solo Forte', 'GO', 75, 275.00, '2025-03-22', true),
(29, 'Semente de Arroz', 'Sementes', 'Campo Verde', 'RS', 60, 140.00, '2025-03-24', false),
(30, 'Fungicida Premium', 'Defensivos', 'AgroMax', 'MT', 15, 950.00, '2025-03-26', true),
(31, 'Farelo Bovino', 'Rações', 'NutriCampo', 'MG', 120, 82.30, '2025-03-28', true),
(32, 'Soja Safra 2025', 'Grãos', 'Campo Verde', 'MS', 230, 150.00, '2025-03-30', false),
(33, 'Calcário Fino', 'Minerais', 'Solo Forte', 'PR', 340, 42.00, '2025-04-01', true),
(34, 'Herbicida AgroPlus', 'Defensivos', 'BioPlant', 'GO', 26, 620.00, '2025-04-03', true),
(35, 'Ração Premium Bovina', 'Rações', 'NutriCampo', 'SC', 88, 145.00, '2025-04-05', false),
(36, 'Semente de Feijão', 'Sementes', 'AgroSul', 'PR', 77, 115.90, '2025-04-07', true),
(37, 'Milho Tradicional', 'Grãos', 'Campo Verde', 'MT', 170, 100.00, '2025-04-10', true),
(38, 'Fertilizante Especial', 'Fertilizantes', 'AgroMax', 'SP', 54, 380.00, '2025-04-12', true),
(39, 'Inseticida Verde', 'Defensivos', 'BioPlant', 'MS', 19, 720.00, '2025-04-15', false),
(40, 'Sal Mineral Premium', 'Minerais', 'Solo Forte', 'MG', 105, 92.00, '2025-04-18', true),
(41, 'Ração Ovina', 'Rações', 'NutriCampo', 'RS', 66, 118.00, '2025-04-20', true),
(42, 'Soja Natural', 'Grãos', 'Campo Verde', 'GO', 190, 148.00, '2025-04-22', false),
(43, 'Semente Especial', 'Sementes', 'AgroSul', 'PR', 59, 132.50, '2025-04-24', true),
(44, 'Fungicida Rural', 'Defensivos', 'AgroMax', 'MT', 24, 845.00, '2025-04-26', true),
(45, 'Adubo Premium', 'Fertilizantes', 'Solo Forte', 'SC', 81, 299.90, '2025-04-28', false),
(46, 'Milho Exportação', 'Grãos', 'Campo Verde', 'MS', 250, 170.00, '2025-05-01', true),
(47, 'Ração Campo Forte', 'Rações', 'NutriCampo', 'GO', 74, 136.40, '2025-05-03', true),
(48, 'Calcário Rural', 'Minerais', 'Solo Forte', 'PR', 330, 48.90, '2025-05-05', false),
(49, 'Herbicida Platinum', 'Defensivos', 'BioPlant', 'SP', 17, 980.00, '2025-05-07', true),
(50, 'Semente Premium', 'Sementes', 'AgroSul', 'RS', 68, 155.00, '2025-05-10', true),

-- REGISTROS COM PROBLEMAS PARA LIMPEZA E TRATAMENTO DE DADOS

-- PRODUTOS DUPLICADOS
(51, 'Milho Safrinha', 'Grãos', 'AgroSul', 'PR', 120, 89.90, '2025-05-12', true),
(52, 'Soja Premium', 'Grãos', 'Campo Verde', 'MT', 200, 145.50, '2025-05-12', true),
(53, 'Ração Bovina 25kg', 'Rações', 'NutriCampo', 'SC', 80, 110.00, '2025-05-12', true),

-- NOMES INCORRETOS DE PRODUTOS
(54, 'Milhho Safrinha', 'Grãos', 'AgroSul', 'PR', 95, 88.00, '2025-05-13', true),
(55, 'Sojjja Premium', 'Grãos', 'Campo Verde', 'MT', 180, 140.00, '2025-05-13', true),
(56, 'Racão Bovina 25kg', 'Rações', 'NutriCampo', 'SC', 70, 105.00, '2025-05-13', true),
(57, 'Fertilizanti NPK', 'Fertilizantes', 'AgroMax', 'GO', 45, 310.00, '2025-05-13', false),
(58, 'Insetcida Power', 'Defensivos', 'Campo Verde', 'MT', 20, 580.00, '2025-05-13', true),

-- FORNECEDORES ESCRITOS ERRADOS
(59, 'Milho Híbrido', 'Grãos', 'Campo Vrede', 'MS', 190, 150.00, '2025-05-14', true),
(60, 'Ração Equina', 'Rações', 'NutriCamp', 'SP', 38, 130.00, '2025-05-14', true),
(61, 'Herbicida Select', 'Defensivos', 'Bio Planti', 'MT', 27, 495.00, '2025-05-14', true),

-- PREÇOS INCORRETOS / SUSPEITOS
(62, 'Soja Exportação', 'Grãos', 'Campo Verde', 'MT', 250, 1.99, '2025-05-15', true),
(63, 'Fungicida Premium', 'Defensivos', 'AgroMax', 'MT', 12, 99999.99, '2025-05-15', true),
(64, 'Calcário Premium', 'Minerais', 'Solo Forte', 'PR', 300, -45.00, '2025-05-15', true),
(65, 'Adubo Nitrogenado', 'Fertilizantes', 'Solo Forte', 'GO', 70, 0.00, '2025-05-15', true),

-- QUANTIDADES INCORRETAS
(66, 'Milho Tradicional', 'Grãos', 'Campo Verde', 'MT', -10, 100.00, '2025-05-16', true),
(67, 'Ração Ovina', 'Rações', 'NutriCampo', 'RS', 0, 118.00, '2025-05-16', true),

-- ESTADOS INCORRETOS
(68, 'Semente Especial', 'Sementes', 'AgroSul', 'PARANA', 59, 132.50, '2025-05-16', true),
(69, 'Herbicida Platinum', 'Defensivos', 'BioPlant', 'SÃO PAULO', 17, 980.00, '2025-05-16', true),

-- CATEGORIAS INCORRETAS
(70, 'Milho Exportação', 'Graos', 'Campo Verde', 'MS', 250, 170.00, '2025-05-17', true),
(71, 'Ração Campo Forte', 'Racao', 'NutriCampo', 'GO', 74, 136.40, '2025-05-17', true),

-- DATAS INCONSISTENTES
(72, 'Calcário Rural', 'Minerais', 'Solo Forte', 'PR', 330, 48.90, '2035-01-01', false),
(73, 'Semente Premium', 'Sementes', 'AgroSul', 'RS', 68, 155.00, '2028-12-30', true),

-- REGISTROS COMPLETAMENTE INCONSISTENTES
(74, 'XXXXX', 'ERRO', 'DESCONHECIDO', 'XX', -999, -500.00, '2040-01-01', false),
(75, 'TESTE PRODUTO', 'TESTE', 'TESTE', 'TT', 99999, 999999.99, '2099-01-01', true);

SELECT COUNT(*) FROM tb_vendas_agro; -- deve retornar 75

-- =====================================================
-- PARTE 1 - LIMPEZA E TRATAMENTO DE DADOS
-- =====================================================

-- 01. Remoção de registros duplicados
-- Os originais são os ids 1, 2 e 3; as duplicatas têm id maior que 3
SELECT * FROM tb_vendas_agro
WHERE produto IN ('Milho Safrinha', 'Soja Premium', 'Ração Bovina 25kg')
AND id > 3;

DELETE FROM tb_vendas_agro
WHERE produto IN ('Milho Safrinha', 'Soja Premium', 'Ração Bovina 25kg')
AND id > 3;

-- 02. Padronização dos nomes dos produtos
SELECT * FROM tb_vendas_agro
WHERE produto IN ('Milhho Safrinha', 'Sojjja Premium', 'Racão Bovina 25kg', 'Fertilizanti NPK', 'Insetcida Power');

UPDATE tb_vendas_agro SET produto = 'Milho Safrinha' WHERE produto = 'Milhho Safrinha';
UPDATE tb_vendas_agro SET produto = 'Soja Premium' WHERE produto = 'Sojjja Premium';
UPDATE tb_vendas_agro SET produto = 'Ração Bovina 25kg' WHERE produto = 'Racão Bovina 25kg';
UPDATE tb_vendas_agro SET produto = 'Fertilizante NPK' WHERE produto = 'Fertilizanti NPK';
UPDATE tb_vendas_agro SET produto = 'Inseticida Power' WHERE produto = 'Insetcida Power';

-- 03. Padronização dos fornecedores
SELECT * FROM tb_vendas_agro
WHERE fornecedor IN ('Campo Vrede', 'NutriCamp', 'Bio Planti');

UPDATE tb_vendas_agro SET fornecedor = 'Campo Verde' WHERE fornecedor = 'Campo Vrede';
UPDATE tb_vendas_agro SET fornecedor = 'NutriCampo' WHERE fornecedor = 'NutriCamp';
UPDATE tb_vendas_agro SET fornecedor = 'BioPlant' WHERE fornecedor = 'Bio Planti';

-- 04. Correção dos valores unitários
SELECT * FROM tb_vendas_agro
WHERE (produto = 'Soja Exportação' AND valor_unitario < 10)
OR (produto = 'Fungicida Premium' AND valor_unitario > 10000)
OR (produto = 'Calcário Premium' AND valor_unitario < 0)
OR (produto = 'Adubo Nitrogenado' AND valor_unitario = 0);

UPDATE tb_vendas_agro SET valor_unitario = 160.00
WHERE produto = 'Soja Exportação' AND valor_unitario < 10;

UPDATE tb_vendas_agro SET valor_unitario = 950.00
WHERE produto = 'Fungicida Premium' AND valor_unitario > 10000;

UPDATE tb_vendas_agro SET valor_unitario = 55.50
WHERE produto = 'Calcário Premium' AND valor_unitario < 0;

UPDATE tb_vendas_agro SET valor_unitario = 275.00
WHERE produto = 'Adubo Nitrogenado' AND valor_unitario = 0;

-- 05. Correção das quantidades
SELECT * FROM tb_vendas_agro
WHERE (produto = 'Milho Tradicional' AND quantidade = -10)
OR (produto = 'Ração Ovina' AND quantidade = 0);

UPDATE tb_vendas_agro SET quantidade = 170
WHERE produto = 'Milho Tradicional' AND quantidade = -10;

UPDATE tb_vendas_agro SET quantidade = 66
WHERE produto = 'Ração Ovina' AND quantidade = 0;

-- 06. Padronização dos estados
SELECT * FROM tb_vendas_agro WHERE estado IN ('PARANA', 'SÃO PAULO');

UPDATE tb_vendas_agro SET estado = 'PR' WHERE estado = 'PARANA';
UPDATE tb_vendas_agro SET estado = 'SP' WHERE estado = 'SÃO PAULO';

-- 07. Padronização das categorias
SELECT * FROM tb_vendas_agro WHERE categoria IN ('Graos', 'Racao');

UPDATE tb_vendas_agro SET categoria = 'Grãos' WHERE categoria = 'Graos';
UPDATE tb_vendas_agro SET categoria = 'Rações' WHERE categoria = 'Racao';

-- 08. Exclusão de datas incompatíveis (após 31/12/2025)
SELECT * FROM tb_vendas_agro WHERE data_venda > '2025-12-31';

DELETE FROM tb_vendas_agro WHERE data_venda > '2025-12-31';

-- 09. Exclusão de registros de teste
-- (já foram removidos na questão 08, então não deve encontrar nada)
SELECT * FROM tb_vendas_agro
WHERE produto IN ('XXXXX', 'TESTE PRODUTO')
OR categoria IN ('ERRO', 'TESTE')
OR fornecedor IN ('DESCONHECIDO', 'TESTE');

DELETE FROM tb_vendas_agro
WHERE produto IN ('XXXXX', 'TESTE PRODUTO')
OR categoria IN ('ERRO', 'TESTE')
OR fornecedor IN ('DESCONHECIDO', 'TESTE');

-- 10. Bloqueio comercial de defensivos acima de R$ 800,00
SELECT * FROM tb_vendas_agro
WHERE categoria = 'Defensivos' AND valor_unitario > 800;

UPDATE tb_vendas_agro SET estoque = false
WHERE categoria = 'Defensivos' AND valor_unitario > 800;

SELECT COUNT(*) FROM tb_vendas_agro; -- deve retornar 68

-- =====================================================
-- PARTE 2 - RELATÓRIO GERENCIAL
-- =====================================================

-- 01. Produtos disponíveis
SELECT COUNT(*) AS registros_disponiveis
FROM tb_vendas_agro
WHERE estoque = true;

-- 02. Participação dos fornecedores
SELECT fornecedor, COUNT(*) AS qtd_registros
FROM tb_vendas_agro
GROUP BY fornecedor
ORDER BY qtd_registros DESC;

-- 03. Produtos de maior valor unitário
SELECT produto, categoria, valor_unitario, estado
FROM tb_vendas_agro
ORDER BY valor_unitario DESC
LIMIT 10;

-- 04. Valor médio por categoria
SELECT categoria, ROUND(AVG(valor_unitario), 2) AS valor_medio
FROM tb_vendas_agro
GROUP BY categoria;

-- 05. Distribuição por estado
SELECT estado, COUNT(*) AS qtd_registros
FROM tb_vendas_agro
GROUP BY estado
ORDER BY qtd_registros DESC;

-- 06. Sementes e grãos disponíveis
SELECT produto, categoria, quantidade, valor_unitario, estado
FROM tb_vendas_agro
WHERE categoria IN ('Sementes', 'Grãos') AND estoque = true;

-- 07. Produtos com grande quantidade armazenada
SELECT produto, quantidade, estado
FROM tb_vendas_agro
WHERE quantidade > 200
ORDER BY quantidade DESC;

-- 08. Valor potencial do estoque disponível
SELECT ROUND(SUM(quantidade * valor_unitario), 2) AS valor_potencial
FROM tb_vendas_agro
WHERE estoque = true;

-- 09. Produtos indisponíveis por categoria
SELECT categoria, COUNT(*) AS qtd_indisponiveis
FROM tb_vendas_agro
WHERE estoque = false
GROUP BY categoria
HAVING COUNT(*) >= 1;

-- 10. Vendas entre março e maio de 2025
SELECT produto, categoria, data_venda, valor_unitario, estado
FROM tb_vendas_agro
WHERE data_venda BETWEEN '2025-03-01' AND '2025-05-31'
ORDER BY data_venda;

-- =====================================================
-- PARTE 3 - KPIs
-- Valor potencial = quantidade x valor_unitario (não é faturamento nem lucro)
-- NULLIF evita divisão por zero
-- =====================================================

-- KPI 1 - Taxa de disponibilidade de registros
-- Objetivo: medir quanto do catálogo está apto à comercialização
-- Regra: registros com estoque = true / total de registros x 100 (todos os registros)
SELECT
    SUM(CASE WHEN estoque = true THEN 1 ELSE 0 END) AS registros_disponiveis,
    COUNT(*) AS total_registros,
    ROUND(SUM(CASE WHEN estoque = true THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(*), 0), 2) AS pct_disponibilidade
FROM tb_vendas_agro;

-- KPI 2 - Unidades em registros indisponíveis
-- Objetivo: mostrar quanto do volume físico está parado em itens bloqueados
-- Regra: soma de quantidade com estoque = false / soma total de quantidade x 100 (todos os registros)
SELECT
    SUM(CASE WHEN estoque = false THEN quantidade ELSE 0 END) AS unidades_indisponiveis,
    SUM(quantidade) AS unidades_totais,
    ROUND(SUM(CASE WHEN estoque = false THEN quantidade ELSE 0 END) * 100.0 / NULLIF(SUM(quantidade), 0), 2) AS pct_unidades_indisponiveis
FROM tb_vendas_agro;

-- KPI 3 - Valor potencial do estoque disponível (R$)
-- Objetivo: dimensionar o valor potencial dos itens aptos à comercialização
-- Regra: soma de quantidade x valor_unitario com estoque = true (apenas disponíveis);
--        o total de todos os registros (subquery) é só referência
SELECT
    ROUND(SUM(quantidade * valor_unitario), 2) AS valor_potencial_disponivel,
    (SELECT ROUND(SUM(quantidade * valor_unitario), 2) FROM tb_vendas_agro) AS valor_potencial_total,
    ROUND(SUM(quantidade * valor_unitario) * 100.0 / NULLIF((SELECT SUM(quantidade * valor_unitario) FROM tb_vendas_agro), 0), 2) AS pct_do_total
FROM tb_vendas_agro
WHERE estoque = true;

-- KPI 4 - Valor médio ponderado por unidade (R$)
-- Objetivo: saber quanto vale, em média, cada unidade armazenada
-- Regra: soma de (quantidade x valor_unitario) / soma de quantidade (todos os registros)
SELECT
    ROUND(SUM(quantidade * valor_unitario), 2) AS valor_potencial_total,
    SUM(quantidade) AS unidades_totais,
    ROUND(SUM(quantidade * valor_unitario) / NULLIF(SUM(quantidade), 0), 2) AS valor_medio_por_unidade
FROM tb_vendas_agro;

-- KPI 5 - Concentração por fornecedor (o primeiro da lista é o líder)
-- Objetivo: medir a dependência da empresa em relação a um único fornecedor
-- Regra: registros do fornecedor / total de registros x 100 (todos os registros);
--        o total vem de uma subquery
SELECT
    fornecedor,
    COUNT(*) AS qtd_registros,
    ROUND(COUNT(*) * 100.0 / NULLIF((SELECT COUNT(*) FROM tb_vendas_agro), 0), 2) AS pct_registros
FROM tb_vendas_agro
GROUP BY fornecedor
ORDER BY qtd_registros DESC;

-- KPI 6 - Valor potencial por categoria
-- Objetivo: ver onde se concentra o valor potencial disponível
-- Regra: valor potencial da categoria / valor potencial total disponível x 100
--        (apenas disponíveis; o total vem de uma subquery)
SELECT
    categoria,
    ROUND(SUM(quantidade * valor_unitario), 2) AS valor_potencial,
    ROUND(SUM(quantidade * valor_unitario) * 100.0 /
        NULLIF((SELECT SUM(quantidade * valor_unitario) FROM tb_vendas_agro WHERE estoque = true), 0), 2) AS pct_do_valor_disponivel
FROM tb_vendas_agro
WHERE estoque = true
GROUP BY categoria
ORDER BY pct_do_valor_disponivel DESC;

-- KPI 7 - Distribuição de unidades por estado
-- Objetivo: comparar os estados pelo volume físico armazenado (logística)
-- Regra: soma de quantidade do estado / soma total de quantidade x 100
--        (todos os registros; o total vem de uma subquery)
SELECT
    estado,
    SUM(quantidade) AS unidades,
    ROUND(SUM(quantidade) * 100.0 / NULLIF((SELECT SUM(quantidade) FROM tb_vendas_agro), 0), 2) AS pct_unidades
FROM tb_vendas_agro
GROUP BY estado
ORDER BY unidades DESC;

-- KPI 8 - Taxa de indisponibilidade por categoria
-- Objetivo: apontar as categorias com maior proporção de itens bloqueados
-- Regra: registros com estoque = false na categoria / registros da categoria x 100 (todos os registros)
SELECT
    categoria,
    SUM(CASE WHEN estoque = false THEN 1 ELSE 0 END) AS registros_indisponiveis,
    COUNT(*) AS registros_categoria,
    ROUND(SUM(CASE WHEN estoque = false THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(*), 0), 2) AS pct_indisponibilidade
FROM tb_vendas_agro
GROUP BY categoria
ORDER BY pct_indisponibilidade DESC;

-- KPI 9 - Volume em grandes registros (quantidade > 200, limite sugerido pelo grupo)
-- Objetivo: medir se o volume está concentrado em poucos registros grandes
-- Regra: registros com quantidade > 200 / total de registros x 100;
--        unidades desses registros / total de unidades x 100 (todos os registros)
SELECT
    SUM(CASE WHEN quantidade > 200 THEN 1 ELSE 0 END) AS registros_grandes,
    COUNT(*) AS total_registros,
    ROUND(SUM(CASE WHEN quantidade > 200 THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(*), 0), 2) AS pct_registros,
    SUM(CASE WHEN quantidade > 200 THEN quantidade ELSE 0 END) AS unidades_grandes,
    SUM(quantidade) AS unidades_totais,
    ROUND(SUM(CASE WHEN quantidade > 200 THEN quantidade ELSE 0 END) * 100.0 / NULLIF(SUM(quantidade), 0), 2) AS pct_unidades
FROM tb_vendas_agro;

-- KPI 10 - Indisponibilidade por fornecedor (o primeiro da lista é o mais bloqueado)
-- Objetivo: identificar os fornecedores com mais produtos bloqueados
-- Regra: registros do fornecedor com estoque = false / registros do fornecedor x 100 (todos os registros)
SELECT
    fornecedor,
    SUM(CASE WHEN estoque = false THEN 1 ELSE 0 END) AS registros_indisponiveis,
    COUNT(*) AS registros_fornecedor,
    ROUND(SUM(CASE WHEN estoque = false THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(*), 0), 2) AS pct_indisponibilidade
FROM tb_vendas_agro
GROUP BY fornecedor
ORDER BY pct_indisponibilidade DESC;
