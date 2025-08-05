# gradle-mod.nvim

Neovim plugin to create Gradle submodules easily.

## Features

- Create new Gradle submodules with a specified module name, group, and version.
- Automatically generates a basic project structure:
  - `build.gradle.kts`
  - `src/main/java`
  - `src/main/resources`
- Finds the closest `settings.gradle.kts` to include the new submodule automatically.

## Usage

Run the command inside Neovim:

```vim
:CreateSubmodule
