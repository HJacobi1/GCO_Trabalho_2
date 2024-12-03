# Trabalho 2 - Gerencia de Configuração

#### Este repositório trata-se de um exemplo de CI/CD utilizando uma página web (*index.html*) e um banco de dados.
--- 
### Estrutura de branches
O projeto é separado em duas branches principais:
`main` e `develop`
<br/><br/>
Todos os dias, às 21h (horário de Brasília), a estrutura da `main` é atualizada com o conteúdo nela presente.

[Acesso à página main](https://jolly-moss-087597f10.4.azurestaticapps.net)

[![Azure Static Web Apps CI/CD](https://github.com/HJacobi1/GCO_Trabalho_2/actions/workflows/azure-static-web-apps-jolly-moss-087597f10.yml/badge.svg)](https://github.com/HJacobi1/GCO_Trabalho_2/actions/workflows/azure-static-web-apps-jolly-moss-087597f10.yml)


Sempre que houver alguma alteração em forma de PR, a estrutura da `develop` é atualizada.

[Acesso à página develop](https://agreeable-bay-03af1ef10.4.azurestaticapps.net)

[![Azure Static Web Apps CI/CD](https://github.com/HJacobi1/GCO_Trabalho_2/actions/workflows/azure-static-web-apps-agreeable-bay-03af1ef10.yml/badge.svg?branch=develop)](https://github.com/HJacobi1/GCO_Trabalho_2/actions/workflows/azure-static-web-apps-agreeable-bay-03af1ef10.yml)

---
### Dependências
O projeto utiliza dois Static Web Apps do Azure para fazer o deploy da página html.<br/>
Nas configurações do projeto, em _Settings/Secrets and variables/Actions_ é possível encontrar os _secrets_ contendo os tokens necessários para a integração.
> AZURE_STATIC_WEB_APPS_API_TOKEN_AGREEABLE_BAY_03AF1EF10 para `develop`
> AZURE_STATIC_WEB_APPS_API_TOKEN_JOLLY_MOSS_087597F10 para `main`

O banco de dados do projeto é mantido em um projeto no Supabase.
Os demais _secrets_ presentes nas _Settings_ são utilizados na integração com o Supabase.

---

### Actions / Workflows
As atualizações citadas anteriormente são manejadas por meio do Github Actions, utilizando arquivos .yaml para rodar os serviços necessários na atualização. <br/>

Há um script .yaml para cada uma das branches principais.

Os scripts são muito semelhantes entre si, fazendo primeiramente a atualização do Static Web App no Azure, e após atualizando o Supabase.
A atualização do Supabase é feita por meio do bash `sql_scripts/aplica_migrations.sh`, onde são buscadas quais migrations não foram aplicadas ainda, executando-as.

---

### Passo a passo de uma atualização
- Realizar alteração e fazer um commit em uma nova branch
- Fazer um PR dessa alteração para a `develop`
- Completar o PR (a alteração já deve estar disponível para conferência no Supabase ou no endereço do Static Web App)
- Fazer um PR da `develop` para a `main`
- Aguardar a atualização da main às 21h
