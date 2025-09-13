#!/bin/bash

# Complete Settings Sync - Cursor, VS Code, and Chezmoi
# This script manages bidirectional sync between all settings

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

show_usage() {
    echo "Usage: sync-all-settings [push|pull|status|init]"
    echo ""
    echo "Commands:"
    echo "  push    - Push chezmoi templates to global settings (Cursor + VS Code)"
    echo "  pull    - Pull current global settings to chezmoi templates"
    echo "  status  - Show current settings status for all editors"
    echo "  init    - Initialize chezmoi templates from current global settings"
    echo ""
    echo "Examples:"
    echo "  sync-all-settings push   # Update all global settings from chezmoi"
    echo "  sync-all-settings pull   # Update chezmoi templates from all globals"
    echo "  sync-all-settings init   # First-time setup from current globals"
    echo "  sync-all-settings status # Show what's different"
}

# Paths
CHEZMOI_CURSOR_TEMPLATE="/Users/davidpanzarella/.local/share/chezmoi/home/dot_cursor/settings/cursor-global-settings.json"
CHEZMOI_VSCODE_TEMPLATE="/Users/davidpanzarella/.local/share/chezmoi/home/dot_cursor/settings/vscode-global-settings.json"
CURSOR_GLOBAL="/Users/davidpanzarella/Library/Application Support/Cursor/User/settings.json"
VSCODE_GLOBAL="/Users/davidpanzarella/Library/Application Support/Code/User/settings.json"
BACKUP_DIR="/Users/davidpanzarella/.local/share/chezmoi/home/dot_cursor/settings/backups"

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Function to create VS Code template from current settings
create_vscode_template() {
    local global_file="$1"
    local output_file="$2"
    
    if [[ ! -f "$global_file" ]]; then
        print_warning "VS Code global settings not found, creating minimal template"
        cat > "$output_file" << 'EOF'
{
  "// VS Code Global Settings": "Template for VS Code global configuration",
  "// Add your VS Code specific settings here": "This will be merged with existing settings"
}
EOF
        return
    fi
    
    # Extract relevant settings from VS Code global
    cat > "$output_file" << 'EOF'
{
  "// VS Code Global Settings": "Template for VS Code global configuration",
  "// Terminal Configuration": "VS Code terminal settings",
  "terminal.integrated.fontFamily": "MesloLGS NF",
  "terminal.integrated.fontSize": 16,
  "terminal.integrated.confirmOnExit": "always",
  "terminal.integrated.scrollback": 5000,
  "terminal.integrated.tabs.enabled": true,
  "terminal.integrated.shellIntegration.enabled": false,
  "terminal.external.osxExec": "iTerm.app",
  
  "// Editor Configuration": "VS Code editor settings",
  "editor.minimap.enabled": true,
  "editor.minimap.autohide": true,
  "files.autoSave": "off",
  "files.insertFinalNewline": true,
  
  "// Debug Configuration": "VS Code debug settings",
  "debug.terminal.clearBeforeReusing": true
}
EOF
    
    print_status "Created VS Code template from current global settings"
}

# Function to push all templates to global settings
push_all() {
    print_status "Pushing all chezmoi templates to global settings..."
    
    # Push Cursor settings
    if [[ -f "$CHEZMOI_CURSOR_TEMPLATE" ]]; then
        print_status "Pushing Cursor settings..."
        bash /Users/davidpanzarella/.local/share/chezmoi/home/dot_local/bin/executable_sync-cursor-settings.sh push
    else
        print_warning "Cursor template not found"
    fi
    
    # Push VS Code settings
    if [[ -f "$CHEZMOI_VSCODE_TEMPLATE" ]]; then
        print_status "Pushing VS Code settings..."
        
        # Backup current VS Code settings
        if [[ -f "$VSCODE_GLOBAL" ]]; then
            cp "$VSCODE_GLOBAL" "$BACKUP_DIR/vscode-settings-$(date +%Y%m%d-%H%M%S).json"
        fi
        
        # Merge VS Code settings
        if command -v jq >/dev/null 2>&1; then
            if [[ -f "$VSCODE_GLOBAL" ]]; then
                jq -s '.[0] * .[1]' "$VSCODE_GLOBAL" "$CHEZMOI_VSCODE_TEMPLATE" > "$VSCODE_GLOBAL.tmp"
                mv "$VSCODE_GLOBAL.tmp" "$VSCODE_GLOBAL"
            else
                cp "$CHEZMOI_VSCODE_TEMPLATE" "$VSCODE_GLOBAL"
            fi
            print_success "VS Code settings merged and pushed"
        else
            print_warning "jq not found, using simple copy for VS Code"
            cp "$CHEZMOI_VSCODE_TEMPLATE" "$VSCODE_GLOBAL"
        fi
    else
        print_warning "VS Code template not found"
    fi
}

# Function to pull all global settings to templates
pull_all() {
    print_status "Pulling all global settings to chezmoi templates..."
    
    # Pull Cursor settings
    bash /Users/davidpanzarella/.local/share/chezmoi/home/dot_local/bin/executable_sync-cursor-settings.sh pull
    
    # Pull VS Code settings
    create_vscode_template "$VSCODE_GLOBAL" "$CHEZMOI_VSCODE_TEMPLATE"
    
    print_success "All settings pulled to chezmoi templates"
}

# Function to show comprehensive status
show_status() {
    print_status "Complete settings status:"
    echo ""
    
    echo "📁 Chezmoi Templates:"
    if [[ -f "$CHEZMOI_CURSOR_TEMPLATE" ]]; then
        echo "  ✅ Cursor template: $(wc -c < "$CHEZMOI_CURSOR_TEMPLATE") bytes"
    else
        echo "  ❌ Cursor template missing"
    fi
    
    if [[ -f "$CHEZMOI_VSCODE_TEMPLATE" ]]; then
        echo "  ✅ VS Code template: $(wc -c < "$CHEZMOI_VSCODE_TEMPLATE") bytes"
    else
        echo "  ❌ VS Code template missing"
    fi
    
    echo ""
    echo "🌐 Global Settings:"
    if [[ -f "$CURSOR_GLOBAL" ]]; then
        echo "  ✅ Cursor global: $(wc -c < "$CURSOR_GLOBAL") bytes"
        if grep -q "foam.dailyNote" "$CURSOR_GLOBAL"; then
            echo "    📝 Foam settings: Present"
        else
            echo "    📝 Foam settings: Missing"
        fi
    else
        echo "  ❌ Cursor global missing"
    fi
    
    if [[ -f "$VSCODE_GLOBAL" ]]; then
        echo "  ✅ VS Code global: $(wc -c < "$VSCODE_GLOBAL") bytes"
        if grep -q "terminal.integrated" "$VSCODE_GLOBAL"; then
            echo "    🖥️  Terminal settings: Present"
        else
            echo "    🖥️  Terminal settings: Missing"
        fi
    else
        echo "  ❌ VS Code global missing"
    fi
    
    echo ""
    echo "💾 Backups:"
    if [[ -d "$BACKUP_DIR" ]]; then
        local backup_count=$(ls -1 "$BACKUP_DIR" 2>/dev/null | wc -l)
        echo "  📦 $backup_count backup files in $BACKUP_DIR"
    else
        echo "  ❌ No backup directory"
    fi
}

# Function to initialize templates from current globals
init_templates() {
    print_status "Initializing chezmoi templates from current global settings..."
    
    # Initialize Cursor template
    bash /Users/davidpanzarella/.local/share/chezmoi/home/dot_local/bin/executable_sync-cursor-settings.sh pull
    
    # Initialize VS Code template
    create_vscode_template "$VSCODE_GLOBAL" "$CHEZMOI_VSCODE_TEMPLATE"
    
    print_success "Templates initialized from current global settings"
    print_status "You can now edit templates in chezmoi and use 'sync-all-settings push' to apply changes"
}

# Main function
main() {
    case "${1:-status}" in
        "push")
            push_all
            ;;
        "pull")
            pull_all
            ;;
        "init")
            init_templates
            ;;
        "status")
            show_status
            ;;
        "help"|"-h"|"--help")
            show_usage
            ;;
        *)
            print_error "Unknown command: $1"
            show_usage
            exit 1
            ;;
    esac
}

main "$@"
