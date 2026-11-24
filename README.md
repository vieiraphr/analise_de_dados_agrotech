# analise_de_dados_agrotech

Auditoria de dados e indicadores gerenciais da **AgroTech Solutions**: tratamento da base consolidada de vendas, relatório gerencial e 10 KPIs, tudo em um único script SQL para MySQL.

## Sumário

1. [Visão geral](#1-visão-geral)
2. [Como executar](#2-como-executar)
3. [Dicionário de dados](#3-dicionário-de-dados)
4. [Resultados do tratamento e do relatório gerencial](#4-resultados-do-tratamento-e-do-relatório-gerencial)
5. [Catálogo e resultados dos 10 KPIs](#5-catálogo-e-resultados-dos-10-kpis)
6. [Conclusão gerencial](#6-conclusão-gerencial)

---

## 1. Visão geral

### Objetivo

A AgroTech Solutions comercializa produtos agrícolas e está consolidando os dados de suas filiais em uma única base. Na integração surgiram registros duplicados, erros de digitação, valores incorretos, datas incompatíveis e dados de teste, o que compromete a confiabilidade dos relatórios. Este projeto trata esses problemas, produz consultas gerenciais e cria indicadores (KPIs) para apoiar as decisões da diretoria. O material será repassado a outra equipe, por isso o repositório documenta a base, a execução e os resultados.

### Integrantes

Pedro Henrique Ribeiro Vieira

**Disciplina:** _Linguagem e Projeto de Banco de Dados_
 
### O que foi feito em cada parte

| Parte | O que foi feito |
|-------|-----------------|
| Preparação da base | Criação do banco `agropecuaria_db`, da tabela `tb_vendas_agro` e carga de 75 registros (50 válidos e 25 com problemas propositais). |
| Parte 1 — Limpeza e tratamento | 10 questões: remoção de duplicados, padronização de nomes, fornecedores, estados e categorias, correção de valores e quantidades, exclusão de datas fora do período e de registros de teste, e bloqueio de defensivos acima de R$ 800,00. Cada alteração é precedida por um `SELECT` de conferência com o mesmo filtro. |
| Parte 2 — Relatório gerencial | 10 consultas sobre disponibilidade, fornecedores, valores, estados, quantidades e período. |
| Parte 3 — KPIs | 10 indicadores (`KPI 01` a `KPI 10`) de disponibilidade, estoque e logística, valor financeiro, fornecedores, categorias e estados. |
| Parte 4 — Documentação | Este README e a publicação do projeto no GitHub. |

### Estrutura do repositório

```
analise_de_dados_agrotech/
├── AgroTech_Integrantes.sql         # Banco, carga, Partes 1, 2 e 3
├── AgroTech_KPIs_Integrantes.pptx   # Slides com os 10 KPIs
└── README.md
```

> Ajuste os nomes dos arquivos se os entregues forem diferentes.

---

## 2. Como executar

### Requisitos

- **MySQL** 8.0 ou superior (o script usa `USE`, `LIMIT` e `BOOLEAN`).
- Um cliente SQL (MySQL Workbench, DBeaver ou a linha de comando `mysql`).
- Um usuário com permissão para `CREATE DATABASE`.

### Arquivo a executar

**`AgroTech_Integrantes.sql`** é o único arquivo necessário. Ele cria o banco, carrega a base, aplica o tratamento e executa todas as consultas. Deve ser rodado **na ordem apresentada**, partindo de um ambiente em que `agropecuaria_db` ainda não exista.

```bash
mysql -u <usuario> -p < AgroTech_Integrantes.sql
```

Ou abra o arquivo no cliente SQL e execute o script completo.

### Ordem do script

1. Preparação da base (`CREATE DATABASE`, `CREATE TABLE`, `INSERT`)
2. Parte 1 — Limpeza e tratamento (questões 01 a 10)
3. Parte 2 — Relatório gerencial (questões 01 a 10)
4. Parte 3 — KPIs (`KPI 01` a `KPI 10`)

### Como conferir

O script traz dois `SELECT COUNT(*)` de controle:

| Momento | Resultado esperado |
|---------|--------------------|
| Após o `INSERT` | 75 |
| Ao final da Parte 1 | 68 |

---

## 3. Dicionário de dados

### Tabela `tb_vendas_agro`

Consolida os registros de produtos das filiais da AgroTech. **Cada linha representa um registro de produto**: um item, de um fornecedor, em um estado, em uma data, com a quantidade de unidades armazenadas e o valor unitário. Um mesmo nome de produto pode aparecer em mais de uma linha (por exemplo, `Herbicida Platinum` e `Fungicida Premium` têm dois registros cada). Por isso, **contar registros é diferente de somar unidades**.

| Coluna | Tipo | Descrição | Restrições e regras | Exemplo (base tratada) |
|--------|------|-----------|---------------------|------------------------|
| `id` | `INT` | Identificador do registro. | Chave primária (única e não nula). | `1` |
| `produto` | `VARCHAR(100)` | Nome do produto. | Sem restrição no DDL. Regra de negócio: grafia oficial (ex.: `Milho Safrinha`, `Ração Bovina 25kg`). | `Milho Safrinha` |
| `categoria` | `VARCHAR(50)` | Categoria do produto. | Sem restrição no DDL. Valores válidos: `Grãos`, `Rações`, `Fertilizantes`, `Defensivos`, `Minerais`, `Sementes`. | `Grãos` |
| `fornecedor` | `VARCHAR(100)` | Fornecedor do produto. | Sem restrição no DDL. Valores válidos: `AgroSul`, `Campo Verde`, `NutriCampo`, `AgroMax`, `BioPlant`, `Solo Forte`. | `AgroSul` |
| `estado` | `VARCHAR(50)` | UF da filial. | Sem restrição no DDL. Regra de negócio: sigla de duas letras. Valores na base tratada: `MT`, `PR`, `GO`, `MS`, `SP`, `SC`, `RS`, `MG`. | `PR` |
| `quantidade` | `INT` | Unidades armazenadas no registro. | Sem restrição no DDL. Regra de negócio: valor positivo. | `120` |
| `valor_unitario` | `DECIMAL(10,2)` | Valor de cada unidade, em R$. | Sem restrição no DDL. Regra de negócio: valor maior que zero. | `89.90` |
| `data_venda` | `DATE` | Data do registro. | Sem restrição no DDL. Regra de negócio: não posterior a 31/12/2025. | `2025-01-10` |
| `estoque` | `BOOLEAN` | Indica se o registro está disponível para comercialização. | `true` = disponível; `false` = indisponível ou bloqueado. | `true` |

> O DDL define apenas a chave primária. As demais regras (valores positivos, siglas, período válido) foram aplicadas pelo tratamento da Parte 1, não por `CHECK` ou `NOT NULL`.

### Como interpretar `quantidade`, `estoque` e `data_venda`

- **`quantidade`** é o número de **unidades** do registro, não a contagem de registros. `COUNT(*)` conta registros; `SUM(quantidade)` soma unidades. Na base tratada há **68 registros** e **7.387 unidades**.
- **`estoque`** é o indicador de disponibilidade. `true` significa apto à comercialização. `false` significa indisponível, seja por já constar assim na origem, seja por bloqueio da diretoria (defensivos com valor unitário acima de R$ 800,00).
- **`data_venda`** é a data do registro. A empresa considera como período operacional válido o que vai **até 31/12/2025**. Na base tratada as datas vão de `2025-01-10` a `2025-05-17`.

---

## 4. Resultados do tratamento e do relatório gerencial

> Os números abaixo foram obtidos reproduzindo as consultas do script sobre a base tratada. Antes da entrega, execute o script no MySQL e confira se os retornos coincidem com esta documentação.

### 4.1 Parte 1 — Principais correções

**Volume de registros: 75 antes da limpeza, 68 depois (7 removidos).**

| Etapa | Ação | Registros afetados |
|-------|------|--------------------|
| 01 | Remoção de duplicados posteriores (ids 51, 52 e 53), preservando os ids 1, 2 e 3 | 3 excluídos (75 → 72) |
| 02 | Correção de 5 nomes de produtos (ids 54 a 58) | 5 atualizados |
| 03 | Correção de 3 fornecedores (ids 59 a 61) | 3 atualizados |
| 04 | Correção de valores unitários (ids 62 a 65): Soja Exportação (R$ 1,99 → R$ 160,00), Fungicida Premium (R$ 99.999,99 → R$ 950,00), Calcário Premium (−R$ 45,00 → R$ 55,50) e Adubo Nitrogenado (R$ 0,00 → R$ 275,00) | 4 atualizados |
| 05 | Correção de quantidades (ids 66 e 67): Milho Tradicional (−10 → 170) e Ração Ovina (0 → 66) | 2 atualizados |
| 06 | Estados por extenso para sigla (`PARANA` → `PR`, `SÃO PAULO` → `SP`) | 2 atualizados |
| 07 | Categorias sem acento ou fora do padrão (`Graos` → `Grãos`, `Racao` → `Rações`) | 2 atualizados |
| 08 | Exclusão de datas posteriores a 31/12/2025 (ids 72 a 75) | 4 excluídos (72 → 68) |
| 09 | Exclusão de registros de teste | 0 excluídos (já removidos na etapa 08) |
| 10 | Bloqueio de defensivos acima de R$ 800,00 (`estoque = false`) | 6 localizados, 5 alterados (o id 25 já estava indisponível) |

Os 7 registros removidos correspondem a 3 duplicados e 4 fora do período (entre eles os 2 de teste). Os registros com nomes incorretos (ids 54 a 58) **não** foram excluídos: foram corrigidos e permaneceram na base, conforme a regra da atividade.

### 4.2 Parte 2 — Principais resultados

**Disponibilidade.** Dos 68 registros, **48 estão disponíveis** (`estoque = true`) e 20 estão indisponíveis.

**Participação dos fornecedores (registros).**

| Fornecedor | Registros | % dos registros |
|------------|-----------|-----------------|
| Campo Verde | 16 | 23,53% |
| NutriCampo | 14 | 20,59% |
| AgroSul | 11 | 16,18% |
| Solo Forte | 10 | 14,71% |
| BioPlant | 9 | 13,24% |
| AgroMax | 8 | 11,76% |

Os dois maiores fornecedores (Campo Verde e NutriCampo) somam 30 dos 68 registros (44,12%).

**Distribuição por estado (registros).**

| Estado | Registros |
|--------|-----------|
| MT | 14 |
| PR | 12 |
| GO | 11 |
| MS | 8 |
| SP | 7 |
| SC | 7 |
| RS | 6 |
| MG | 3 |

MT, PR e GO concentram 37 dos 68 registros (54,41%).

**Maiores valores unitários.** Os 10 maiores valores são todos da categoria Defensivos, de R$ 599,00 a R$ 980,00. O topo é `Herbicida Platinum` (R$ 980,00, SP, dois registros) e `Fungicida Premium` (R$ 950,00, MT, dois registros). A consulta lista **registros**, por isso o mesmo produto pode aparecer duas vezes.

**Valor unitário médio por categoria.**

| Categoria | Valor médio (R$) |
|-----------|------------------|
| Defensivos | 739,91 |
| Fertilizantes | 296,74 |
| Grãos | 136,02 |
| Sementes | 117,44 |
| Rações | 113,68 |
| Minerais | 58,17 |

**Demais consultas.**

- **Sementes e Grãos disponíveis:** 18 registros.
- **Registros com quantidade acima de 200:** 11, dos quais 5 são Calcário (todos no PR, de 300 a 340 unidades).
- **Valor potencial do estoque disponível:** R$ 769.784,00.
- **Registros indisponíveis por categoria:** Defensivos 7, Sementes 4, Fertilizantes 3, Grãos 3, Rações 2, Minerais 1.
- **Registros entre 01/03/2025 e 31/05/2025:** 51.

---

## 5. Catálogo e resultados dos 10 KPIs

Todos os KPIs usam a tabela `tb_vendas_agro` após a Parte 1. A identificação (`KPI 01` a `KPI 10`) é a mesma dos comentários do arquivo SQL.

**Convenções.**

- **Valor potencial do estoque** = `quantidade × valor_unitario`. Não é faturamento nem lucro, pois a base não informa custos nem a quantidade efetivamente vendida.
- **Divisão por zero:** todos os percentuais e a média usam `NULLIF(denominador, 0)`, que retorna `NULL` em vez de erro quando o denominador é zero.
- Valores monetários e percentuais são exibidos com duas casas decimais (`ROUND(..., 2)`).
- Quando uma consulta traz o total por meio de **subquery**, isso está indicado no KPI.

### Visão resumida

| KPI | Nome | Unidade | Base considerada |
|-----|------|---------|------------------|
| KPI 01 | Taxa de disponibilidade de registros | % | Todos os registros |
| KPI 02 | Unidades em registros indisponíveis | % | Todos os registros |
| KPI 03 | Valor potencial do estoque disponível | R$ e % | Apenas disponíveis |
| KPI 04 | Valor médio ponderado por unidade | R$ por unidade | Todos os registros |
| KPI 05 | Concentração por fornecedor | % | Todos os registros |
| KPI 06 | Valor potencial por categoria | R$ e % | Apenas disponíveis |
| KPI 07 | Distribuição de unidades por estado | unidades e % | Todos os registros |
| KPI 08 | Taxa de indisponibilidade por categoria | % | Todos os registros |
| KPI 09 | Volume em grandes registros | registros, unidades e % | Todos os registros |
| KPI 10 | Indisponibilidade por fornecedor | % | Todos os registros |

### KPI 01 — Taxa de disponibilidade de registros

- **Objetivo:** medir quanto do catálogo está apto à comercialização.
- **Tabela e colunas:** `tb_vendas_agro` — `estoque`.
- **Regra de cálculo:** registros com `estoque = true` ÷ total de registros × 100.
- **Numerador:** 48 registros disponíveis. **Denominador:** 68 registros.
- **Filtros:** nenhum (todos os registros).
- **Unidade:** percentual (%).
- **Resultado:** 48 de 68 registros, **70,59%**.
- **Interpretação:** cerca de 7 em cada 10 registros estão aptos à venda. Os 29,41% restantes não podem ser comercializados agora. A diretoria pode acompanhar o indicador para avaliar o efeito do bloqueio de defensivos e priorizar a regularização dos itens indisponíveis.

### KPI 02 — Unidades em registros indisponíveis

- **Objetivo:** mostrar quanto do volume físico está parado em itens indisponíveis.
- **Tabela e colunas:** `tb_vendas_agro` — `quantidade`, `estoque`.
- **Regra de cálculo:** soma de `quantidade` com `estoque = false` ÷ soma total de `quantidade` × 100.
- **Numerador:** 1.706 unidades. **Denominador:** 7.387 unidades.
- **Filtros:** nenhum (todos os registros).
- **Unidade:** percentual (%), calculado sobre unidades.
- **Resultado:** **23,09%** do volume (1.706 de 7.387 unidades).
- **Interpretação:** os itens indisponíveis são 29,41% dos registros (KPI 01), mas apenas 23,09% das unidades. Ou seja, os registros bloqueados tendem a ter menos unidades que os disponíveis. Cabe à logística avaliar o que fazer com essas 1.706 unidades enquanto estão bloqueadas.

### KPI 03 — Valor potencial do estoque disponível

- **Objetivo:** dimensionar o valor potencial dos itens aptos à comercialização.
- **Tabela e colunas:** `tb_vendas_agro` — `quantidade`, `valor_unitario`, `estoque`.
- **Regra de cálculo:** soma de `quantidade × valor_unitario` com `estoque = true`. Como referência, a consulta usa uma **subquery** para o valor potencial de todos os registros e calcula o percentual: disponível ÷ total × 100.
- **Numerador:** R$ 769.784,00. **Denominador:** R$ 1.096.474,50.
- **Filtros:** `estoque = true` (apenas disponíveis); a subquery considera todos os registros.
- **Unidade:** reais (R$) e percentual (%).
- **Resultado:** valor potencial disponível de **R$ 769.784,00**, equivalente a **70,21%** do total de R$ 1.096.474,50.
- **Interpretação:** R$ 326.690,50 (29,79%) do valor potencial está indisponível. É um valor potencial, não receita. A diretoria pode usá-lo para medir o custo de oportunidade do bloqueio de defensivos e das demais indisponibilidades.

### KPI 04 — Valor médio ponderado por unidade

- **Objetivo:** saber quanto vale, em média, cada unidade armazenada.
- **Tabela e colunas:** `tb_vendas_agro` — `quantidade`, `valor_unitario`.
- **Regra de cálculo:** soma de `quantidade × valor_unitario` ÷ soma de `quantidade`.
- **Numerador:** R$ 1.096.474,50. **Denominador:** 7.387 unidades.
- **Filtros:** nenhum (todos os registros).
- **Unidade:** reais por unidade (R$/unidade).
- **Resultado:** **R$ 148,43** por unidade.
- **Interpretação:** é a média ponderada pelo volume, e não a média simples dos valores unitários. Serve de referência para comparar categorias: Minerais (média de R$ 58,17) fica bem abaixo, enquanto Defensivos (R$ 739,91) fica muito acima. Pode orientar a priorização de espaço e atenção logística pelo valor por unidade.

### KPI 05 — Concentração por fornecedor

- **Objetivo:** medir a dependência da empresa em relação a um único fornecedor.
- **Tabela e colunas:** `tb_vendas_agro` — `fornecedor`.
- **Regra de cálculo:** registros do fornecedor ÷ total de registros × 100. O total vem de uma **subquery**.
- **Numerador:** registros do fornecedor. **Denominador:** 68 registros.
- **Filtros:** nenhum (todos os registros).
- **Unidade:** percentual (%).
- **Resultado:**

| Fornecedor | Registros | % |
|------------|-----------|---|
| Campo Verde | 16 | 23,53% |
| NutriCampo | 14 | 20,59% |
| AgroSul | 11 | 16,18% |
| Solo Forte | 10 | 14,71% |
| BioPlant | 9 | 13,24% |
| AgroMax | 8 | 11,76% |

- **Interpretação:** a base é relativamente distribuída. O líder, Campo Verde, tem 23,53% dos registros, e nenhum fornecedor passa de um quarto do total. Os dois maiores somam 44,12%. Não há dependência extrema, mas a diretoria pode acompanhar o indicador para evitar que um fornecedor ultrapasse um limite que a própria empresa defina.

### KPI 06 — Valor potencial por categoria

- **Objetivo:** ver onde se concentra o valor potencial disponível.
- **Tabela e colunas:** `tb_vendas_agro` — `categoria`, `quantidade`, `valor_unitario`, `estoque`.
- **Regra de cálculo:** valor potencial da categoria ÷ valor potencial total disponível × 100. O total vem de uma **subquery**.
- **Numerador:** soma de `quantidade × valor_unitario` da categoria. **Denominador:** R$ 769.784,00.
- **Filtros:** `estoque = true` (apenas disponíveis), na consulta principal e na subquery.
- **Unidade:** reais (R$) e percentual (%).
- **Resultado:**

| Categoria | Valor potencial (R$) | % do disponível |
|-----------|----------------------|-----------------|
| Grãos | 338.018,00 | 43,91% |
| Fertilizantes | 120.755,00 | 15,69% |
| Defensivos | 101.155,00 | 13,14% |
| Rações | 92.089,20 | 11,96% |
| Minerais | 77.968,00 | 10,13% |
| Sementes | 39.798,80 | 5,17% |

- **Interpretação:** Grãos concentram 43,91% do valor potencial disponível e merecem prioridade de gestão. Defensivos têm o maior valor unitário médio, mas só 13,14% do valor potencial disponível, porque têm poucas unidades e boa parte dos registros está bloqueada.

### KPI 07 — Distribuição de unidades por estado

- **Objetivo:** comparar os estados pelo volume físico armazenado (logística).
- **Tabela e colunas:** `tb_vendas_agro` — `estado`, `quantidade`.
- **Regra de cálculo:** soma de `quantidade` do estado ÷ soma total de `quantidade` × 100. O total vem de uma **subquery**.
- **Numerador:** unidades do estado. **Denominador:** 7.387 unidades.
- **Filtros:** nenhum (todos os registros).
- **Unidade:** unidades e percentual (%).
- **Resultado:**

| Estado | Unidades | % |
|--------|----------|---|
| PR | 2.107 | 28,52% |
| MT | 1.561 | 21,13% |
| MS | 1.227 | 16,61% |
| GO | 899 | 12,17% |
| SC | 614 | 8,31% |
| RS | 415 | 5,62% |
| MG | 320 | 4,33% |
| SP | 244 | 3,30% |

- **Interpretação:** PR, MT e MS concentram 66,26% das unidades. Esse ranking difere do ranking por registros (KPI da Parte 2): o PR lidera em unidades por causa dos registros grandes de Calcário, enquanto o MT lidera em número de registros. Pode apoiar decisões de distribuição e capacidade de armazenagem por região.

### KPI 08 — Taxa de indisponibilidade por categoria

- **Objetivo:** apontar as categorias com maior proporção de itens indisponíveis.
- **Tabela e colunas:** `tb_vendas_agro` — `categoria`, `estoque`.
- **Regra de cálculo:** registros da categoria com `estoque = false` ÷ registros da categoria × 100.
- **Numerador:** registros indisponíveis da categoria. **Denominador:** registros da categoria.
- **Filtros:** nenhum (todos os registros).
- **Unidade:** percentual (%).
- **Resultado:**

| Categoria | Indisponíveis | Registros | % |
|-----------|---------------|-----------|---|
| Defensivos | 7 | 14 | 50,00% |
| Sementes | 4 | 9 | 44,44% |
| Fertilizantes | 3 | 9 | 33,33% |
| Grãos | 3 | 16 | 18,75% |
| Rações | 2 | 13 | 15,38% |
| Minerais | 1 | 7 | 14,29% |

- **Interpretação:** metade dos registros de Defensivos está indisponível. Desses 7, 5 foram bloqueados pela decisão da diretoria (valor unitário acima de R$ 800,00) e 2 já estavam indisponíveis. Sementes vêm em seguida, com 44,44%, sem relação com o bloqueio. A diretoria pode reavaliar o bloqueio de defensivos e investigar a falta de Sementes. A comparação usa a maior taxa como critério de prioridade, não uma meta da empresa.

### KPI 09 — Volume em grandes registros

- **Objetivo:** medir se o volume está concentrado em poucos registros grandes.
- **Tabela e colunas:** `tb_vendas_agro` — `quantidade`.
- **Regra de cálculo:** (a) registros com `quantidade > 200` ÷ total de registros × 100; (b) unidades desses registros ÷ total de unidades × 100.
- **Numeradores:** 11 registros e 3.030 unidades. **Denominadores:** 68 registros e 7.387 unidades.
- **Filtros:** `quantidade > 200` no numerador, sem filtro no denominador. O limite de 200 unidades é uma **sugestão do grupo**, não foi fornecido pela empresa.
- **Unidade:** registros, unidades e percentual (%).
- **Resultado:** 11 de 68 registros (**16,18%**) respondem por 3.030 de 7.387 unidades (**41,02%**).
- **Interpretação:** pouco mais de 16% dos registros concentram 41% do volume físico, o que indica dependência de poucos lotes grandes. Cinco desses registros são de Calcário no PR. A logística pode priorizar o monitoramento desses lotes.

### KPI 10 — Indisponibilidade por fornecedor

- **Objetivo:** identificar os fornecedores com mais produtos indisponíveis.
- **Tabela e colunas:** `tb_vendas_agro` — `fornecedor`, `estoque`.
- **Regra de cálculo:** registros do fornecedor com `estoque = false` ÷ registros do fornecedor × 100.
- **Numerador:** registros indisponíveis do fornecedor. **Denominador:** registros do fornecedor.
- **Filtros:** nenhum (todos os registros).
- **Unidade:** percentual (%).
- **Resultado:**

| Fornecedor | Indisponíveis | Registros | % |
|------------|---------------|-----------|---|
| AgroMax | 5 | 8 | 62,50% |
| BioPlant | 4 | 9 | 44,44% |
| AgroSul | 3 | 11 | 27,27% |
| Campo Verde | 4 | 16 | 25,00% |
| Solo Forte | 2 | 10 | 20,00% |
| NutriCampo | 2 | 14 | 14,29% |

- **Interpretação:** AgroMax tem a maior taxa (62,50%). Três dos seus 5 registros indisponíveis são fungicidas bloqueados pela regra de preço, e os outros dois são fertilizantes. Em seguida vem BioPlant (44,44%). Campo Verde, apesar de ser o maior fornecedor em registros, tem 25,00% de indisponibilidade. A diretoria pode priorizar a conversa com AgroMax e BioPlant.

### Atendimento às regras da atividade

| Regra | KPIs |
|-------|------|
| Percentuais (numerador e denominador identificados) | 01, 02, 03, 05, 06, 07, 08, 09, 10 |
| Financeiros em reais | 03, 04, 06 |
| Comparam fornecedores, categorias ou estados | 05, 06, 07, 08, 10 |
| Usam subquery | 03, 05, 06, 07 |
| Tratam divisão por zero (`NULLIF`) | Todos |
| Consideram todos os registros | 01, 02, 04, 05, 07, 08, 09, 10 |
| Consideram apenas disponíveis | 03, 06 |

---

## 6. Conclusão gerencial

Entre os 10 indicadores, os três mais relevantes para a diretoria são **KPI 03**, **KPI 08** e **KPI 10**.

**1. KPI 03 — Valor potencial do estoque disponível (R$ 769.784,00; 70,21% do total).**
Dimensiona, em reais, o que a empresa pode comercializar hoje. Os R$ 326.690,50 restantes estão parados por indisponibilidade. Apoia decisões sobre o impacto financeiro do bloqueio de defensivos e sobre quais indisponibilidades vale regularizar primeiro. Por ser valor potencial, não deve ser lido como receita.

**2. KPI 08 — Taxa de indisponibilidade por categoria (Defensivos 50,00%; Sementes 44,44%).**
Aponta onde está o problema de disponibilidade. Em Defensivos, 5 dos 7 registros indisponíveis vieram da decisão de bloqueio da diretoria, o que dá a ela um número concreto para reavaliar a medida. Sementes tem taxa próxima sem relação com o bloqueio, e merece apuração das causas.

**3. KPI 10 — Indisponibilidade por fornecedor (AgroMax 62,50%; BioPlant 44,44%).**
Transforma o problema de disponibilidade em ação com fornecedores. Apoia a priorização de negociações e a decisão de diversificar a compra, já que a base é distribuída (KPI 05) e há margem para isso.

### Recomendações

- Reavaliar o bloqueio de defensivos acima de R$ 800,00, ponderando o risco que o bloqueio evita contra o valor potencial que fica parado.
- Investigar a indisponibilidade de Sementes, que não decorre do bloqueio.
- Acompanhar os lotes grandes (KPI 09), em especial o Calcário no PR, que concentra volume físico.
- Reforçar a validação na entrada de dados (siglas, categorias, valores positivos e datas), já que os problemas tratados na Parte 1 se repetiriam em novas cargas.

> Metas e limites citados neste documento (como o corte de 200 unidades do KPI 09) são **sugestões do grupo**, pois não foram fornecidos pela empresa.

---

## Entrega

Link do repositório para o Blackboard: `https://github.com/vieiraphr/analise_de_dados_agrotech`. 
