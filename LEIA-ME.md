# ROLGEST — os ecrãs e o fluxo

Os ecrãs da plataforma que substitui o ERP em Delphi, desenhados numa tela
como a do `Figma-PDA-Armazem`: o mesmo editor, apontado ao ERP. São 27, em
sete fluxos, e o mapa de navegação desenha as setas entre eles.

| Ficheiro | Para quê |
| --- | --- |
| `importar/00-fluxo.png` | O mapa de navegação: os ecrãs todos, uma linha por fluxo, com as setas |
| `importar/NN-<ecrã>.png` | Cada ecrã a 1440×900, para ver e para colar numa apresentação |
| `importar/NN-<ecrã>.pdf` | **Importar no Canva ou no Figma.** O mesmo, em vetor e com o texto editável |
| `importar/gerar.sh` | Gera tudo a partir do HTML. Mudar um token ou um texto e voltar a correr |

## O fluxo

| Fluxo | Ecrãs | O que decide |
| --- | --- | --- |
| Entrar | 01 Entrar → 01b A palavra-passe → 01c O código da aplicação → 02 Escolher a empresa · 01 → 01d O início de sessão da empresa → 02 · 03 Aplicação fora do contrato | Em dois passos: primeiro o endereço, e o domínio decide o caminho — conta nossa (palavra-passe no Keycloak, realm rolgest) ou cliente federado (a página do fornecedor dele, por exemplo o Entra ID). Os ecrãs 01 a 01c são páginas do Keycloak com o tema Rolgest; a aplicação só redireciona. O 01c é proposta: segundo fator também na conta nossa. Com uma só empresa, o 02 salta-se. O 03 é a recusa à porta de v10 §4.11, com código para o apoio |
| Trabalhar numa empresa | 04 Início → 05 O menu de Vendas → 06 Encomendas de clientes → 07 Uma encomenda · 08 Sem ligação | A casca de v10 §6.9: os quinze menus de topo com a grafia antiga, separadores, e a empresa sempre à vista (na barra e no rodapé) |
| Trocar de empresa | 07 → 09 Trocar de empresa → 10 Depois da troca | Troca-se sem sair; fecha tudo o que estava aberto e diz antes o que se perde (v10 §4.16) |
| Lugares e permissões | 04 → 11 Pessoas e lugares → 12 Dar lugares → 13 Permissões por empresa · 11 → 20 Retirar um lugar | Primeiro o lugar, depois as permissões, como um percurso (v10 §4.21). Um módulo cheio recusa no 12. Retirar liberta o lugar logo e guarda as permissões (§4.10) |
| Procurar, criar e gravar | 04 → 14 Procurar · 06 → 15 Nova encomenda · 16 Alguém gravou primeiro · 04 → 17 Notificações | Ctrl K abre qualquer ecrã ou documento da empresa ativa. Criar diz o que falta ao gravar. Quem grava em segundo não apaga o primeiro (§5.5) |
| Quando a sessão ou a licença acabam | 18 A sessão terminou · 19 Licença em leitura | Volta-se a entrar sem perder os separadores. Em leitura consulta-se e exporta-se, não se grava (§4.9) |
| A licença e o apoio | 21 A licença está a acabar → 22 A licença · 21 → 23 Acesso do apoio | O aviso dos 30 dias só aparece a quem administra. O apoio entra só com aprovação, por tempo contado (§5.8) |

O 03, o 08, o 16, o 18 e o 19 não têm seta a entrar: são estados (a licença
recusou, a rede caiu, outra pessoa gravou, a sessão expirou, a licença
acabou), e não um sítio aonde se vá por um botão. O 21 é o Início de quem
administra.

## Como se mexe

Abre `web/index.html`. A página **abre em modo de edição**: camadas à
esquerda, tela ao centro, propriedades à direita. O seletor de ecrã está
agrupado por fluxo, e por baixo dele há **Ecrãs | Fluxo**.

- **Fluxo** mostra o mapa. Clicar num ecrã abre-o para editar. Ctrl + roda
  faz zoom.
- As setas saem de qualquer peça com `data-ir="<ecrã>"`. Mudar o atributo no
  HTML muda a seta. As peças que se repetem em todos os ecrãs (a empresa na
  barra, o separador Início) levam também `data-sem-seta`: navegam, mas não
  se desenham.
- No painel de propriedades, uma peça com ligação mostra **Leva a** e o botão
  *Ir para lá*.
- Acrescentar um ecrã é acrescentar um `<div class="ecra" data-ecra="…"
  data-nome="NN · …" data-fluxo="…" data-objetivo="…" hidden>`. Um fluxo novo
  ganha a sua descrição no `<template id="fluxos">`.

Endereços: `#ecra=menu` abre nesse ecrã; `#so=ecra&ecra=menu` mostra-o sem a
moldura, e aí os botões funcionam como protótipo, de ecrã em ecrã;
`#so=fluxo` é só o mapa; `#doc=fluxo` é o editor já no mapa.

## O código: `web/`

```
web/
  index.html                  os ecrãs, em modo de edição
  documentacao.html           o sistema documentado, com exemplos vivos
  como-funciona.html          o que isto é e porque não é o Figma
  assets/css/tokens.css       os valores do manual de UI da Romafe, sem alterar
  assets/css/base.css         botão, campo, opção, segmentado, marca
  assets/css/entrada.css      o palco com fotografia: 01 a 01d, 02 e 03
  assets/css/casca.css        a aplicação por dentro: 04 a 23
  assets/css/editor.css       a moldura do editor e o mapa
  assets/js/tema.js           claro, escuro, auto — a chave é 'uiux:tema'
  assets/js/entrada.js        mostrar/ocultar, e a recusa de credenciais
  assets/js/ecras.js          qual ecrã se vê, e o protótipo fora do editor
  assets/js/fluxo.js          o mapa de navegação e as setas
  assets/js/editor.js         o editor: camadas, propriedades, «Ver o CSS»
  assets/fonts/               Motor, Jost e Lato em woff2
  assets/img/armazem.png      o fundo. Sem ele fica o azul de superfície invertida
```

Não precisa de servidor nem de build.

## O que o ecrã de entrada decide

O resumo da v10 diz, em §5, que há **três perguntas e três donos**, e que
nenhum consulta os outros: a identidade é do Keycloak, a licença é do servidor
de licenças, as permissões são de tabelas do ERP. O ecrã foi desenhado a partir
daí.

**Só se pergunta quem é a pessoa.** Não há campo de empresa. A lista de
empresas vive dentro da licença, e não se sabe quais são as de alguém antes de
saber quem esse alguém é — um seletor de empresa antes de entrar ou estaria
vazio, ou diria a um estranho que empresas existem. A empresa activa escolhe-se
a seguir, e viaja depois em `X-Rolgest-Empresa`, verificada em cada pedido.

**Três recusas, três mensagens.** Estão as três no cartão, escondidas menos a
primeira; mostram-se no painel, em *Peça → Visível*, para se verem lado a lado.

| Quem recusa | O que se vê | Cor |
| --- | --- | --- |
| Keycloak | «Utilizador ou palavra-passe incorretos.» | vermelho |
| Servidor de licenças | «A licença da sua empresa expirou…» | amarelo |
| Tabelas de permissões | «Entrou, mas não tem lugar em nenhum módulo.» | azul |

Só a primeira é um erro de quem escreveu. As outras duas são respostas de outro
dono, e não levam o vermelho.

**Não há «Pedir acesso».** Num ERP ninguém se inscreve: a conta nasce no
administrador da empresa e o lugar vem da licença. A frase no fim do formulário
diz a quem pedir, que é a única coisa útil ali.

**«Manter sessão iniciada» começa desligada**, com a dica — 19 §5. Um posto de
ERP também é partilhado: o balcão, a expedição, a oficina.

## O que fica por decidir

- **Utilizador ou email?** O ecrã aceita os dois porque o Keycloak aceita os
  dois. Qual é o que se pede às pessoas é decisão de quem administra o realm.
- **Este ecrã é do Rolgest ou do Keycloak?** Com OIDC, quem mostra o formulário
  costuma ser o Keycloak, e então isto é um tema do realm `rolgest`, não uma
  página da aplicação. Muda quem escreve o HTML; não muda o desenho.
- **O tema escuro** ainda não está desenhado. Os tokens existem, o cartão não.
- **O telefone do apoio** é um exemplo, e o número da versão também.

## O que os ecrãs novos deixam por decidir

- **A barra de estado contraria o manual.** O 05 §5.4 do manual diz «sem
  rodapé» para o painel web; a v10 §6.9 pede a barra de estado com o
  utilizador, o ponto de venda, a ligação e o servidor. Seguiu-se a v10.
- **O menu abre num painel ao lado da barra**, porque o 06 §5.3 tira os
  submenus de dentro dela. Com 326 itens, a procura (Ctrl K) é por onde
  entra quem já sabe o nome do ecrã.
- **«Por converter» no menu** é o mapa da migração de v10 §6.9. Se o Rolgest
  só entra quando tudo estiver convertido (não há convivência com o Delphi),
  este estado só existe durante o desenvolvimento.
- **Trocar com alterações por gravar.** O 09 oferece «Fechar sem gravar e
  trocar». A alternativa é obrigar a gravar ou descartar separador a
  separador antes de deixar trocar.
- **O que é exemplo:** os itens dos menus (a árvore transcrita do
  Principal.dfm não está neste projeto), os 112 de 326 convertidos, as
  empresas, os NIF, as pessoas, os clientes, os artigos e os números de
  lugares. Os códigos de permissão seguem a convenção de v10 §4.20, mas os
  nomes das áreas e dos ecrãs são inventados.
- **Encomenda e não fatura**, de propósito: uma fatura obriga a ATCUD, SAF-T
  e encadeamento, que a v10 ainda não trata.

