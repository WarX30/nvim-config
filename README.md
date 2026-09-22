# Mini IDE 42 — Neovim Configuration

Configuration personnelle de **Neovim 0.11.5**, pensée comme un environnement de développement adapté à mon parcours à **42**.

L'objectif est de construire progressivement un environnement capable de réunir :

* développement C / C++
* développement Solidity
* outils liés à la Norme 42
* LSP et autocomplétion
* recherche rapide dans les projets
* gestion Git
* outils d'IA
* automatisation et maintenance de la configuration

Le projet est développé progressivement, avec une priorité donnée à la compréhension de chaque outil et à la stabilité de la configuration.

---

## 📁 Architecture actuelle

```text
~/.config/nvim/
├── init.lua
│
└── lua/
    ├── config/
    │   ├── options.lua
    │   ├── keymaps.lua
    │   ├── completion.lua
    │   ├── lsp.lua
    │   ├── ui.lua
    │   ├── treesitter.lua
    │   ├── 42norm.lua
    │   ├── comment.lua
    │   └── which-key.lua
    │
    └── plugins/
```

Le dossier `lua/plugins/` existe actuellement et sera utilisé progressivement pour mieux séparer les déclarations de plugins de la configuration générale.

---

# ⚙️ Configuration

## Options générales

La configuration actuelle comprend notamment :

* numéros de lignes
* numéros de lignes relatifs
* couleurs 24 bits
* désactivation du wrapping
* indentation adaptée aux projets 42

Configuration actuelle :

```text
expandtab   = false
tabstop     = 4
shiftwidth  = 4
softtabstop = 4
smartindent = true
```

L'utilisation de tabulations plutôt que d'espaces est volontaire afin de respecter les contraintes habituelles des projets C de l'école 42.

---

# 🔌 Gestion des plugins

Les plugins sont actuellement gérés avec **lazy.nvim**.

Le bootstrap de Lazy.nvim est effectué directement depuis `init.lua`.

Les déclarations de plugins sont actuellement centralisées dans `init.lua`, tandis que leurs configurations commencent à être séparées dans :

```text
lua/config/
```

Une migration progressive vers :

```text
lua/plugins/
```

est prévue.

---

# 🎨 Interface utilisateur

## Catppuccin

Thème principal utilisé :

```text
catppuccin
```

## NvimTree

Explorateur de fichiers permettant notamment de naviguer dans l'arborescence du projet.

Raccourci :

```text
<leader>e
```

## Lualine

Statusline utilisée pour afficher les informations importantes dans Neovim.

## Which-Key

Which-Key permet de visualiser les raccourcis disponibles lorsque la touche `<leader>` est utilisée.

Les groupes actuels comprennent notamment :

```text
<leader>f  Recherche
<leader>n  42 Norme
<leader>e  Explorateur
```

---

# 🔎 Recherche — Telescope

Telescope est actuellement utilisé pour la recherche rapide.

### Rechercher un fichier

```text
<leader>ff
```

### Rechercher du texte

```text
<leader>fg
```

Telescope sera développé ultérieurement avec notamment :

* buffers
* fichiers récents
* symboles LSP
* diagnostics
* keymaps
* intégration Git

---

# 🧠 LSP

La configuration LSP utilise :

* Mason
* Mason-LSPConfig
* nvim-lspconfig
* nvim-cmp

Les serveurs actuellement configurés comprennent :

```text
clangd
bashls
lua_ls
pyright
solidity_ls_nomicfoundation
ts_ls
```

### C / C++

`clangd` est utilisé pour :

* analyse du code
* diagnostics
* navigation
* informations sur les symboles
* intégration avec l'autocomplétion

### Solidity

Un serveur LSP Solidity est également configuré :

```text
solidity_ls_nomicfoundation
```

Le type de fichier `.sol` est reconnu automatiquement comme :

```text
solidity
```

---

# ✨ Autocomplétion

L'autocomplétion est assurée par **nvim-cmp**.

Sources actuellement utilisées :

```text
nvim_lsp
buffer
luasnip
```

Raccourcis :

```text
Ctrl + Space → afficher l'autocomplétion

Tab          → élément suivant

Shift + Tab  → élément précédent

Enter        → confirmer
```

LuaSnip est utilisé pour la gestion des snippets.

---

# 🌳 Treesitter

Treesitter est utilisé pour améliorer l'analyse syntaxique et le highlighting.

Parsers actuellement configurés :

```text
C
Bash
Lua
Python
Solidity
```

La configuration utilise également la mise à jour automatique des parsers avec :

```text
:TSUpdate
```

---

# 🎓 Norme 42

Le plugin **42norm.nvim** est intégré à la configuration.

Fonctionnalités utilisées :

* vérification de la Norme
* formatage
* génération/mise à jour du header 42

### Header 42

```text
F1
```

### Vérifier la Norme

```text
<leader>nc
```

### Formater

```text
<leader>nf
```

Le header n'est volontairement **pas mis à jour automatiquement lors de la sauvegarde**.

---

# 💬 Commentaires

**Comment.nvim** est installé pour faciliter la création et la suppression de commentaires.

La configuration actuelle utilise simplement :

```lua
require("Comment").setup()
```

---

# 🗂️ Filetypes

Les fichiers Solidity possédant l'extension :

```text
.sol
```

sont automatiquement associés au filetype :

```text
solidity
```

---

# 🧪 Validation actuelle

La configuration a été testée progressivement après chaque modularisation.

Les éléments actuellement validés comprennent :

* [x] Options générales
* [x] Keymaps
* [x] lazy.nvim
* [x] Catppuccin
* [x] NvimTree
* [x] Lualine
* [x] Telescope
* [x] nvim-cmp
* [x] LuaSnip
* [x] Mason
* [x] Mason-LSPConfig
* [x] LSP
* [x] Treesitter
* [x] 42norm.nvim
* [x] Comment.nvim
* [x] Which-Key

Une vérification globale avec :

```text
:checkhealth
```

a également été effectuée.

Certains warnings correspondent à des dépendances optionnelles qui ne sont actuellement pas nécessaires.

---

# 🚧 TODO

## Architecture

* [ ] Restructurer progressivement `lua/plugins/`
* [ ] Séparer les déclarations Lazy.nvim des configurations
* [ ] Tester chaque migration individuellement

## Telescope

* [ ] Configuration avancée
* [ ] Buffers
* [ ] Fichiers récents
* [ ] Symboles LSP
* [ ] Diagnostics
* [ ] Keymaps
* [ ] Git
* [ ] Installer `fd`

## Which-Key

* [ ] Installer `mini.icons`

## Git

* [ ] Ajouter des commandes Git directement dans Neovim
* [ ] `status`
* [ ] `diff`
* [ ] `add`
* [ ] `commit`
* [ ] `push`
* [ ] Intégration Git avec Telescope

## Gestion des fenêtres

* [ ] Améliorer la gestion des buffers
* [ ] Conserver plusieurs fichiers ouverts
* [ ] Améliorer les splits
* [ ] Étudier un gestionnaire de buffers

## IA

* [ ] Intégrer des APIs d'IA dans Neovim
* [ ] Tester différents fournisseurs
* [ ] Explication de code
* [ ] Refactoring
* [ ] Debugging
* [ ] Génération contrôlée

## Analyse intelligente du projet

Objectif à terme :

```text
Modification d'un fichier
        ↓
Analyse des dépendances
        ↓
Détection d'une modification potentiellement nécessaire
        ↓
⚠️ Warning
        ↓
Analyse du contexte par une IA
        ↓
Proposition
        ↓
Validation humaine
```

L'IA ne devra pas modifier automatiquement le projet sans validation.

## Maintenance

* [ ] Analyser la croissance de `lsp.log`
* [ ] Mettre en place un audit mensuel
* [ ] Détecter les APIs dépréciées
* [ ] Détecter les options supprimées/renommées
* [ ] Détecter les changements de dépendances
* [ ] Identifier les fichiers/lignes concernés
* [ ] Automatiser uniquement les corrections sûres
* [ ] Créer un backup/commit avant modification
* [ ] Générer un rapport après l'audit

## Git de la configuration

* [ ] Mettre cette configuration Neovim sur Git
* [ ] Créer un dépôt dédié
* [ ] Versionner `init.lua`
* [ ] Versionner `lua/config/`
* [ ] Versionner `lua/plugins/`
* [ ] Préparer une installation sur une nouvelle machine
* [ ] Créer éventuellement un script d'installation
* [ ] Documenter le déploiement

---

# 🎯 Vision du projet

Ce projet n'a pas pour objectif de simplement accumuler des plugins.

L'objectif est de construire progressivement un **environnement de développement personnel**, adapté aux besoins rencontrés pendant mon parcours à 42.

Chaque nouvelle fonctionnalité doit répondre à un besoin réel et être comprise avant d'être intégrée.

À terme, l'objectif est d'obtenir un environnement combinant :

```text
Neovim
  │
  ├── C / C++
  ├── Solidity
  ├── LSP
  ├── Treesitter
  ├── Autocomplétion
  ├── Norme 42
  ├── Git
  ├── Recherche avancée
  ├── IA
  └── Automatisation
```

Le projet évoluera progressivement avec mon apprentissage.
