# ROLGEST — o ecrã de entrada

O primeiro ecrã da plataforma que substitui o ERP em Delphi, desenhado numa
tela como a do `Figma-PDA-Armazem`: o mesmo editor, apontado ao ERP.

| Ficheiro | Para quê |
| --- | --- |
| `importar/01-ecra-entrada.png` | O ecrã a 1440×900, para ver e para colar numa apresentação |
| `importar/01-ecra-entrada.pdf` | **Importar no Canva ou no Figma.** O mesmo, em vetor e com o texto editável |
| `importar/gerar.sh` | Gera os dois a partir do HTML. Mudar um token ou um texto e voltar a correr |

## O código: `web/`

```
web/
  index.html                  o ecrã, em modo de edição
  documentacao.html           o sistema documentado, com exemplos vivos
  como-funciona.html          o que isto é e porque não é o Figma
  assets/css/tokens.css       os valores do manual de UI da Romafe, sem alterar
  assets/css/base.css         botão, campo, opção, segmentado, marca
  assets/css/entrada.css      só o layout deste ecrã
  assets/css/editor.css       a moldura do editor
  assets/js/tema.js           claro, escuro, auto — a chave é 'uiux:tema'
  assets/js/entrada.js        mostrar/ocultar, e a recusa de credenciais
  assets/js/editor.js         o editor: camadas, propriedades, «Ver o CSS»
  assets/fonts/               Motor, Jost e Lato em woff2
  assets/img/armazem.png      o fundo. Sem ele fica o azul de superfície invertida
```

Abre `web/index.html` no navegador. Não precisa de servidor nem de build.
A página **abre em modo de edição**: camadas à esquerda, tela ao centro,
propriedades à direita. `web/index.html#so=ecra` tira a moldura — é o que o
gerador fotografa, e o que se mostra numa reunião.

Acrescentar um ecrã é acrescentar um `<div class="ecra" data-ecra="…"
data-nome="02 · …">` ao HTML. O seletor em cima das camadas passa a tê-lo.

## O que este ecrã decide

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
