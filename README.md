# Pixel Fighter — HaxeFlixel Android Starter

Protótipo inicial de jogo de luta 2D em HaxeFlixel, pensado para Android em modo paisagem e visual pixel art.

## O que já está incluído

- Projeto OpenFL/Lime com alvo Android.
- Resolução lógica de 640x360 (16:9).
- Lutador controlável e rival com IA simples.
- Movimento lateral, gravidade e pulo.
- Ataque normal e ataque especial de teste.
- Vida e energia.
- Controles virtuais: esquerda/direita, A (pulo), B (ataque), C (especial).
- Controles de teclado para testar no computador.

Os personagens e o cenário são formas provisórias geradas pelo código. A próxima etapa é substituir esses placeholders por spritesheets e animações reais.

## Instalação das ferramentas

Instale Haxe e depois execute:

```bash
haxelib install flixel
haxelib run lime setup
haxelib run lime setup flixel
haxelib install flixel-tools
haxelib run flixel-tools setup
```

Configure o ambiente Android:

```bash
lime setup android
```

O setup do Android precisa do Android SDK, Android NDK e ferramentas compatíveis. O assistente do Lime ajuda a configurar esses componentes.

## Compilar para Android

Na pasta que contém `Project.xml`:

```bash
lime test android
```

Para gerar uma compilação de distribuição, consulte as opções atuais do Lime/OpenFL para o seu ambiente.

## Controles

| Ação | Android | Teclado (desktop) |
|---|---|---|
| Mover | Direcional virtual | A/D ou setas |
| Pular | A | Espaço / W / ↑ |
| Ataque | B | J / X |
| Especial | C | K / C |

## Estrutura

```text
source/
  Main.hx
  states/PlayState.hx
  objects/Fighter.hx
  systems/CombatSystem.hx
  ui/FightHUD.hx
assets/
Project.xml
```

## Observações

- O projeto é um ponto de partida, não um clone de Dragon Ball FighterZ.
- Os valores de combate são provisórios e devem ser ajustados em testes.
- O pacote Android definido em `Project.xml` é `com.samuel.pixelfighter`; altere se quiser outro identificador exclusivo.
- O código foi montado como template inicial, mas ainda precisa ser compilado no ambiente Haxe/Lime para validar a combinação exata de versões e SDK instalada.
