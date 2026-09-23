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
* installation et déploiement sur différentes machines

Le projet est développé progressivement, avec une priorité donnée à la compréhension de chaque outil, à la stabilité de la configuration et à sa portabilité.

---

## 📁 Architecture actuelle

```text
~/.config/nvim/
├── init.lua
├── lazy-lock.json
├── LICENSE
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
    │   ├── which-key.lua
    │   └── telescope.lua
    │
    └── plugins/
        ├── 42norm.lua
        ├── catppuccin.lua
        ├── comment.lua
        ├── completion.lua
        ├── lsp.lua
        ├── lualine.lua
        ├── nvim-tree.lua
        ├── telescope.lua
        ├── treesitter.lua
        └── which-key.lua
```

L'architecture sépare volontairement deux responsabilités :

```text
lua/config/
    ↓
Configuration et comportement des outils

lua/plugins/
    ↓
Déclarations des plugins et de leurs dépendances
```

`init.lua` est principalement responsable du bootstrap de Neovim, de Lazy.nvim et du chargement des modules de configuration.

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

Les plugins sont gérés avec **lazy.nvim**.

Le bootstrap de Lazy.nvim est effectué directement depuis `init.lua`.

Les déclarations des plugins sont séparées dans :

```text
lua/plugins/
```

Chaque fichier de ce dossier retourne une spécification Lazy.nvim.

Exemple :

```lua
return {
  "nvim-telescope/telescope.nvim",

  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}
```

La configuration fonctionnelle des plugins est séparée dans :

```text
lua/config/
```

Cette séparation permet notamment de distinguer :

```text
Plugin
   ↓
Dépendances / lazy-loading / build
   ↓
lua/plugins/

Configuration du plugin
   ↓
Options / keymaps / comportement
   ↓
lua/config/
```

## Lazy-lock

Le fichier :

```text
lazy-lock.json
```

est généré et maintenu par Lazy.nvim.

Il contient les commits exacts des plugins utilisés afin de permettre de conserver des versions reproductibles de la configuration.

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
<leader>g  Git
<leader>e  Explorateur
```

---

# 🔎 Recherche — Telescope

Telescope est utilisé comme interface principale de recherche et de navigation dans le projet.

## Recherche de fichiers

```text
<leader>ff
```

## Recherche dans les fichiers

```text
<leader>fg
```

## Buffers

```text
<leader>fb
```

## Fichiers récents

```text
<leader>fr
```

## Symboles du fichier

```text
<leader>fs
```

## Symboles du projet

```text
<leader>fS
```

## Diagnostics

```text
<leader>fd
```

## Git

```text
<leader>gs  Git status
<leader>gc  Git commits
<leader>gb  Git branches
<leader>gB  Commits du fichier
```

## Configuration

Telescope utilise notamment :

* une interface horizontale
* une largeur de fenêtre de 90 %
* une hauteur de fenêtre de 80 %
* une preview occupant environ 50 % de l'espace
* une preview visible au démarrage
* `Ctrl + J` pour descendre dans les résultats
* `Ctrl + K` pour remonter dans les résultats

Les mappings natifs de Telescope, notamment pour les actions sur les résultats, sont conservés.

La configuration est séparée dans :

```text
lua/config/telescope.lua
```

et sa déclaration Lazy.nvim dans :

```text
lua/plugins/telescope.lua
```

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

La configuration utilise l'API LSP de **Neovim 0.11**, notamment :

```text
vim.lsp.config()
vim.lsp.enable()
```

## C / C++

`clangd` est utilisé pour :

* analyse du code
* diagnostics
* navigation
* informations sur les symboles
* intégration avec l'autocomplétion

## Solidity

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

Les plugins nécessaires à l'autocomplétion sont regroupés dans :

```text
lua/plugins/completion.lua
```

tandis que leur comportement est configuré dans :

```text
lua/config/completion.lua
```

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

La configuration utilise également la mise à jour des parsers avec :

```text
:TSUpdate
```

La déclaration du plugin et son processus de build sont définis dans :

```text
lua/plugins/treesitter.lua
```

---

# 🎓 Norme 42

Le plugin **42norm.nvim** est intégré à la configuration.

Fonctionnalités utilisées :

* vérification de la Norme
* formatage
* génération/mise à jour du header 42

## Header 42

```text
F1
```

## Vérifier la Norme

```text
<leader>nc
```

## Formater

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

La configuration est développée et testée progressivement.

Les éléments actuellement validés comprennent :

* [x] Options générales
* [x] Keymaps
* [x] lazy.nvim
* [x] Catppuccin
* [x] NvimTree
* [x] Lualine
* [x] Telescope
* [x] Telescope buffers
* [x] Telescope fichiers récents
* [x] Telescope symboles LSP
* [x] Telescope diagnostics
* [x] Telescope Git
* [x] Configuration Telescope
* [x] Layout Telescope
* [x] Navigation Telescope
* [x] Preview Telescope
* [x] nvim-cmp
* [x] LuaSnip
* [x] Mason
* [x] Mason-LSPConfig
* [x] LSP
* [x] Treesitter
* [x] 42norm.nvim
* [x] Comment.nvim
* [x] Which-Key
* [x] Séparation `lua/config/` / `lua/plugins/`

Une vérification avec :

```text
:checkhealth
```

a également été effectuée.

Certains warnings correspondent à des dépendances ou fonctionnalités optionnelles qui ne sont actuellement pas nécessaires.

---

# 🚧 TODO

## Architecture

* [x] Séparer les déclarations Lazy.nvim des configurations
* [x] Utiliser `lua/plugins/` pour les specs Lazy.nvim
* [x] Utiliser `lua/config/` pour les configurations
* [x] Tester chaque migration individuellement
* [ ] Vérifier et améliorer progressivement l'organisation des modules

## Telescope

* [x] Configuration avancée
* [x] Buffers
* [x] Fichiers récents
* [x] Symboles LSP
* [x] Diagnostics
* [x] Keymaps
* [x] Git
* [x] Configuration du layout
* [x] Navigation personnalisée
* [x] Preview
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
* [x] Intégration Git avec Telescope

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

## Installation et portabilité

L'objectif est de pouvoir déployer la configuration sur une nouvelle machine sans supposer que l'utilisateur possède les droits administrateur.

* [ ] Détecter automatiquement les dépendances manquantes
* [ ] Distinguer les dépendances obligatoires des dépendances optionnelles
* [ ] Vérifier les outils déjà installés avant toute installation
* [ ] Prévoir une installation dans l'espace utilisateur lorsque `sudo` n'est pas disponible
* [ ] Gérer les outils externes nécessaires à certaines fonctionnalités
* [ ] Vérifier les versions des dépendances
* [ ] Créer un mécanisme de bootstrap
* [ ] Créer un `install.sh`
* [ ] Préparer l'installation sur une nouvelle machine
* [ ] Tester l'installation sur une deuxième machine
* [ ] Documenter le processus de déploiement

Le mécanisme d'installation devra éviter les installations inutiles et expliquer clairement les dépendances qui doivent être ajoutées ou mises à jour.

---

## Git de la configuration

* [x] Mettre cette configuration Neovim sur Git
* [x] Créer un dépôt dédié
* [x] Versionner `init.lua`
* [x] Versionner `lua/config/`
* [x] Versionner `lua/plugins/`
* [x] Versionner `lazy-lock.json`
* [x] Ajouter une licence MIT
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
                         Mini IDE 42
                              │
        ┌─────────────────────┼─────────────────────┐
        │                     │                     │
   Développement          Productivité          Intelligence
        │                     │                     │
   ├── C / C++           ├── Telescope          ├── IA
   ├── Solidity          ├── Git                ├── Analyse projet
   ├── LSP               ├── Buffers            └── Refactoring
   ├── Treesitter        └── Automatisation
   └── Norme 42
                              │
                              ↓
                       Maintenance
                              │
                              ↓
                    Installation portable
```

Le projet évoluera progressivement avec mon apprentissage.

L'objectif final n'est donc pas uniquement d'avoir une configuration fonctionnelle, mais de construire un **environnement cohérent, reproductible, maintenable et portable**, capable d'évoluer avec mes compétences et mes besoins.
