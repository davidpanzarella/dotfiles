# Legacy Configuration Files

This directory contains configuration files that were previously used but are no longer active in the current system.

## Moved Files

### `dot_shellaliases`

- **Original location**: `zsh/dot_shellaliases`
- **Reason moved**: Superseded by `zsh/zsh-aliases.tmpl` (14.5KB vs 4.9KB)
- **Status**: Not referenced anywhere in current configuration
- **Date moved**: 2025-09-12

### `iterm2/` directory

- **Original location**: `iterm2/`
- **Contents**:
  - `executable_dot_iterm2_shell_integration.zsh`
  - `colors.itermcolors`
- **Status**: **RESTORED** - iTerm2 is installed, shell integration was missing
- **Action taken**: Copied shell integration from iTerm2 app bundle to home directory
- **Date restored**: 2025-09-12

## Current Active Configuration

The following files are now the active configuration:

- **Git**: `git/config.tmpl` (comprehensive git configuration)
- **Starship**: `starship.toml` (prompt configuration)
- **Zsh**: `zsh/dot_zshrc.tmpl`, `zsh/zsh-aliases.tmpl`, `zsh/zsh-functions`, etc.

## Restoration

If you need to restore any of these files:

1. Move the file back to its original location
2. Update any references in the active configuration files
3. Test the configuration to ensure it works as expected

### Oh My Zsh Plugins (oh-my-zsh-plugins/)

- **zsh-abbr**: Abbreviation expansion plugin
- **zsh-history-substring-search**: History substring search
- **zsh-syntax-highlighting**: Syntax highlighting for zsh
- **powerlevel10k**: Theme (replaced by starship)
- **Reason moved**: Not used in current zshrc configuration
- **Date moved**: 2025-09-12

## Notes

- These files are preserved for historical reference
- They may contain useful configurations that could be integrated into the modern setup
- Consider reviewing them before deleting permanently
- Oh My Zsh plugins can be restored by moving them back to ~/.oh-my-zsh/custom/plugins/ or ~/.oh-my-zsh/custom/themes/
