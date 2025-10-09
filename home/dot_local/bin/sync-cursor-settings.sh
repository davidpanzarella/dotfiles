#!/bin/bash
# Sync Cursor terminal settings between Chezmoi and main settings file

set -e

CURSOR_SETTINGS="$HOME/Library/Application Support/Cursor/User/settings.json"
CHEZMOI_TERMINAL_SETTINGS="$HOME/.cursor/settings/cursor-terminal-settings.json"
BACKUP_DIR="$HOME/.cursor/settings/backups"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Function to backup current settings
backup_settings() {
    local timestamp=$(date +"%Y%m%d_%H%M%S")
    cp "$CURSOR_SETTINGS" "$BACKUP_DIR/settings-backup-$timestamp.json"
    echo "✅ Backed up current settings to $BACKUP_DIR/settings-backup-$timestamp.json"
}

# Function to merge terminal settings
merge_terminal_settings() {
    echo "🔄 Merging terminal settings from Chezmoi to main Cursor settings..."
    
    # Backup current settings
    backup_settings
    
    # Use jq to merge the terminal settings
    if command -v jq &> /dev/null; then
        # Merge terminal settings using jq
        jq --slurpfile terminal "$CHEZMOI_TERMINAL_SETTINGS" '
            . as $main |
            $terminal[0] as $term |
            $main * $term |
            # Ensure terminal settings take precedence
            .terminal = $term.terminal
        ' "$CURSOR_SETTINGS" > "$CURSOR_SETTINGS.tmp" && mv "$CURSOR_SETTINGS.tmp" "$CURSOR_SETTINGS"
        
        echo "✅ Successfully merged terminal settings"
    else
        echo "❌ jq not found. Please install jq to use this script."
        echo "   brew install jq"
        exit 1
    fi
}

# Function to extract terminal settings from main file
extract_terminal_settings() {
    echo "🔄 Extracting terminal settings from main Cursor settings..."
    
    if command -v jq &> /dev/null; then
        # Extract only terminal-related settings
        jq '{
            "terminal.integrated.defaultProfile.osx": .["terminal.integrated.defaultProfile.osx"],
            "terminal.integrated.profiles.osx": .["terminal.integrated.profiles.osx"],
            "terminal.integrated.inheritEnv": .["terminal.integrated.inheritEnv"],
            "terminal.integrated.shellIntegration.enabled": .["terminal.integrated.shellIntegration.enabled"],
            "terminal.integrated.shellIntegration.decorationsEnabled": .["terminal.integrated.shellIntegration.decorationsEnabled"],
            "terminal.integrated.shellIntegration.history": .["terminal.integrated.shellIntegration.history"],
            "terminal.integrated.fontFamily": .["terminal.integrated.fontFamily"],
            "terminal.integrated.fontSize": .["terminal.integrated.fontSize"],
            "terminal.integrated.scrollback": .["terminal.integrated.scrollback"],
            "terminal.integrated.tabs.enabled": .["terminal.integrated.tabs.enabled"],
            "terminal.integrated.minimumContrastRatio": .["terminal.integrated.minimumContrastRatio"],
            "terminal.integrated.env.osx": .["terminal.integrated.env.osx"]
        }' "$CURSOR_SETTINGS" > "$CHEZMOI_TERMINAL_SETTINGS"
        
        echo "✅ Extracted terminal settings to Chezmoi template"
    else
        echo "❌ jq not found. Please install jq to use this script."
        echo "   brew install jq"
        exit 1
    fi
}

# Main script logic
case "${1:-merge}" in
    "merge")
        merge_terminal_settings
        ;;
    "extract")
        extract_terminal_settings
        ;;
    "backup")
        backup_settings
        ;;
    *)
        echo "Usage: $0 [merge|extract|backup]"
        echo ""
        echo "Commands:"
        echo "  merge   - Merge terminal settings from Chezmoi to main Cursor settings (default)"
        echo "  extract - Extract terminal settings from main Cursor settings to Chezmoi template"
        echo "  backup  - Create a backup of current Cursor settings"
        echo ""
        echo "Examples:"
        echo "  $0 merge    # Apply Chezmoi terminal settings to Cursor"
        echo "  $0 extract  # Sync Cursor terminal changes back to Chezmoi"
        echo "  $0 backup   # Just backup current settings"
        exit 1
        ;;
esac
