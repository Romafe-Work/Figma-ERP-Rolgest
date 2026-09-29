# ROLGEST — o ecrã de entrada

O primeiro ecrã do ERP que substitui o Delphi, desenhado com os tokens do
[manual de UI da Romafe](https://romafe-work.github.io/UIUX/), e uma tela para
o editar.

## Abrir

`web/index.html` abre em modo de edição: camadas à esquerda, tela ao centro,
propriedades à direita. Não precisa de servidor nem de build.
`web/index.html#so=ecra` mostra só o ecrã, sem a moldura.

`web/documentacao.html` documenta o sistema — cor, tipografia, espaçamento,
botões, campos, marca — com exemplos que mudam de tema.

`web/como-funciona.html` explica o que isto é e porque não é o Figma.

## O que há aqui

| Pasta | O que é |
| --- | --- |
| `web/` | O ecrã em HTML, CSS e JS, e o editor |
| `importar/` | O PNG e o PDF do ecrã, e o `gerar.sh` que os faz |

O porquê de cada decisão do ecrã — a empresa que não se escolhe antes de
entrar, as três recusas com três donos, o «Pedir acesso» que não existe — está
no [LEIA-ME](LEIA-ME.md).
