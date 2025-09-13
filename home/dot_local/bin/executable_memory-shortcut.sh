#!/bin/bash

# Memory Optimization Keyboard Shortcut Script
# This script is designed to be called from macOS shortcuts, Raycast, or Automator
# It provides quick memory optimization with minimal output for GUI integration

set -euo pipefail

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MEMORY_OPTIMIZER="$SCRIPT_DIR/memory-optimizer.sh"

# Function to show a quick status and perform optimization
quick_memory_optimization() {
    # Get current memory stats
    local free=$(vm_stat | grep "Pages free" | awk '{print $3}' | sed 's/\.//')
    local inactive=$(vm_stat | grep "Pages inactive" | awk '{print $3}' | sed 's/\.//')
    local purgeable=$(vm_stat | grep "Pages purgeable" | awk '{print $3}' | sed 's/\.//')
    local total_available=$(((free + inactive + purgeable) * 16 / 1024))
    
    # Show initial status
    echo "Memory Status: ${total_available} MB available"
    
    # Perform optimization
    if sudo purge; then
        # Wait for system to update
        sleep 1
        
        # Get final stats
        local final_free=$(vm_stat | grep "Pages free" | awk '{print $3}' | sed 's/\.//')
        local final_inactive=$(vm_stat | grep "Pages inactive" | awk '{print $3}' | sed 's/\.//')
        local final_purgeable=$(vm_stat | grep "Pages purgeable" | awk '{print $3}' | sed 's/\.//')
        local final_available=$(((final_free + final_inactive + final_purgeable) * 16 / 1024))
        
        local improvement=$((final_available - total_available))
        
        echo "✅ Memory optimized! Gained ${improvement} MB"
        echo "New status: ${final_available} MB available"
        
        # Send notification if available
        if command -v terminal-notifier >/dev/null 2>&1; then
            terminal-notifier -title "Memory Optimized" -message "Gained ${improvement} MB of memory" -sound Glass
        fi
    else
        echo "❌ Memory optimization failed"
        exit 1
    fi
}

# Function to show memory status only
show_memory_status() {
    local free=$(vm_stat | grep "Pages free" | awk '{print $3}' | sed 's/\.//')
    local active=$(vm_stat | grep "Pages active" | awk '{print $3}' | sed 's/\.//')
    local inactive=$(vm_stat | grep "Pages inactive" | awk '{print $3}' | sed 's/\.//')
    local purgeable=$(vm_stat | grep "Pages purgeable" | awk '{print $3}' | sed 's/\.//')
    
    local free_mb=$((free * 16 / 1024))
    local active_mb=$((active * 16 / 1024))
    local inactive_mb=$((inactive * 16 / 1024))
    local purgeable_mb=$((purgeable * 16 / 1024))
    local total_available=$((free_mb + inactive_mb + purgeable_mb))
    
    echo "📊 Memory Status:"
    echo "   Free: ${free_mb} MB"
    echo "   Active: ${active_mb} MB"
    echo "   Inactive: ${inactive_mb} MB"
    echo "   Purgeable: ${purgeable_mb} MB"
    echo "   Total Available: ${total_available} MB"
    
    # Health indicator
    if [ $total_available -gt 2000 ]; then
        echo "   Status: ✅ Healthy"
    elif [ $total_available -gt 1000 ]; then
        echo "   Status: ⚠️  Moderate"
    else
        echo "   Status: ❌ Low"
    fi
}

# Function to show top memory consumers
show_memory_top() {
    echo "🔍 Top Memory Consumers:"
    ps aux | sort -nr -k 4 | head -5 | awk '{printf "   %-6s %6s%% %s\n", $2, $4, $11}'
}

# Main function
main() {
    case "${1:-optimize}" in
        "optimize"|"clean")
            quick_memory_optimization
            ;;
        "status")
            show_memory_status
            ;;
        "top")
            show_memory_top
            ;;
        "full")
            # Run the full memory optimizer
            "$MEMORY_OPTIMIZER" clean
            ;;
        *)
            echo "Usage: $0 [optimize|status|top|full]"
            echo "  optimize - Quick memory optimization (default)"
            echo "  status   - Show memory status"
            echo "  top      - Show top memory consumers"
            echo "  full     - Run full memory optimizer"
            exit 1
            ;;
    esac
}

# Run main function
main "$@"
