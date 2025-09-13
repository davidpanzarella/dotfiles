#!/bin/bash

# Update Cursor Global Settings from Chezmoi Source
# This script merges our template settings with existing Cursor settings

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

# Paths
CHEZMOI_SETTINGS="/Users/davidpanzarella/.local/share/chezmoi/home/dot_cursor/settings/cursor-global-settings.json"
CURSOR_SETTINGS="/Users/davidpanzarella/Library/Application Support/Cursor/User/settings.json"
CURSOR_BACKUP="/Users/davidpanzarella/Library/Application Support/Cursor/User/settings.json.backup"

# Check if chezmoi settings exist
if [[ ! -f "$CHEZMOI_SETTINGS" ]]; then
    print_error "Chezmoi settings template not found: $CHEZMOI_SETTINGS"
    exit 1
fi

# Backup existing Cursor settings
if [[ -f "$CURSOR_SETTINGS" ]]; then
    print_status "Backing up existing Cursor settings..."
    cp "$CURSOR_SETTINGS" "$CURSOR_BACKUP"
    print_success "Backup created: $CURSOR_BACKUP"
fi

# Function to merge JSON settings
merge_settings() {
    local template_file="$1"
    local existing_file="$2"
    local output_file="$3"
    
    # Use jq to merge JSON files
    if command -v jq >/dev/null 2>&1; then
        # Merge template with existing settings (template takes precedence)
        jq -s '.[0] * .[1]' "$existing_file" "$template_file" > "$output_file.tmp"
        mv "$output_file.tmp" "$output_file"
        print_success "Settings merged using jq"
    else
        print_warning "jq not found, using simple replacement"
        # Simple fallback: append template settings to existing
        cp "$existing_file" "$output_file"
        # Extract settings from template (remove comments and merge)
        grep -v '^[[:space:]]*"//' "$template_file" | jq -r 'to_entries[] | "\(.key): \(.value)"' >> "$output_file"
    fi
}

# Update Cursor settings
print_status "Updating Cursor global settings from chezmoi source..."

if [[ -f "$CURSOR_SETTINGS" ]]; then
    merge_settings "$CHEZMOI_SETTINGS" "$CURSOR_SETTINGS" "$CURSOR_SETTINGS"
else
    print_status "No existing Cursor settings found, creating new file..."
    cp "$CHEZMOI_SETTINGS" "$CURSOR_SETTINGS"
fi

print_success "Cursor global settings updated successfully!"
print_status "Restart Cursor to apply changes"

# Show what was updated
print_status "Updated settings:"
grep -E '"(foam|terminal|files)' "$CURSOR_SETTINGS" | head -10
