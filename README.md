# ROLGEST — os ecrãs e o fluxo

Os ecrãs do ERP que substitui o Delphi — 23, em sete fluxos —, desenhados
com os tokens do [manual de UI da Romafe](https://romafe-work.github.io/UIUX/),
uma tela para os editar e o mapa de navegação entre eles.

## Abrir

`web/index.html` abre em modo de edição: camadas à esquerda, tela ao centro,
propriedades à direita. Não precisa de servidor nem de build.
Por baixo do seletor de ecrã, **Fluxo** mostra o mapa com as setas.
`web/index.html#so=ecra&ecra=inicio` mostra um ecrã sem a moldura, e aí os
botões levam de ecrã em ecrã, como um protótipo.

`web/documentacao.html` documenta o sistema — cor, tipografia, espaçamento,
botões, campos, marca — com exemplos que mudam de tema.

`web/como-funciona.html` explica o que isto é e porque não é o Figma.

## O que há aqui

| Pasta | O que é |
| --- | --- |
| `web/` | Os ecrãs em HTML, CSS e JS, o editor e o mapa |
| `importar/` | O PNG e o PDF de cada ecrã, o mapa em PNG, e o `gerar.sh` que os faz |

O fluxo, o porquê de cada decisão — a empresa que não se escolhe antes de
entrar, as três recusas com três donos, a troca de empresa que fecha tudo, o
lugar antes das permissões — e o que fica por decidir estão no
[LEIA-ME](LEIA-ME.md).
