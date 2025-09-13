#!/bin/bash

# Memory Optimizer Script
# A comprehensive memory optimization tool for macOS
# Usage: ./memory-optimizer.sh [option]
# Options: clean, status, smart, notify, help

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to display help
show_help() {
    echo -e "${CYAN}Memory Optimizer - macOS Memory Management Tool${NC}"
    echo -e "${CYAN}================================================${NC}"
    echo ""
    echo "Usage: $0 [option]"
    echo ""
    echo "Options:"
    echo "  clean     - Perform comprehensive memory cleanup with status reporting"
    echo "  status    - Show current memory status and statistics"
    echo "  smart     - Smart optimization (only when memory is low)"
    echo "  notify    - Memory cleanup with desktop notification"
    echo "  top       - Show top memory consuming processes"
    echo "  help      - Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 clean    # Full memory optimization"
    echo "  $0 status   # Check memory status"
    echo "  $0 smart    # Smart optimization"
    echo ""
}

# Function to get memory stats in MB
get_memory_stats() {
    local free=$(vm_stat | grep "Pages free" | awk '{print $3}' | sed 's/\.//')
    local active=$(vm_stat | grep "Pages active" | awk '{print $3}' | sed 's/\.//')
    local inactive=$(vm_stat | grep "Pages inactive" | awk '{print $3}' | sed 's/\.//')
    local purgeable=$(vm_stat | grep "Pages purgeable" | awk '{print $3}' | sed 's/\.//')
    local wired=$(vm_stat | grep "Pages wired down" | awk '{print $4}' | sed 's/\.//')
    
    echo "$((free * 16 / 1024)) $((active * 16 / 1024)) $((inactive * 16 / 1024)) $((purgeable * 16 / 1024)) $((wired * 16 / 1024))"
}

# Function to perform memory cleanup
memory_cleanup() {
    echo -e "${BLUE}🧹 Starting memory optimization...${NC}"
    
    # Get initial memory stats
    local initial_stats=($(get_memory_stats))
    local initial_free=${initial_stats[0]}
    local initial_inactive=${initial_stats[2]}
    local initial_purgeable=${initial_stats[3]}
    
    echo -e "${CYAN}📊 Initial state:${NC}"
    echo -e "   Free: ${GREEN}${initial_free} MB${NC}"
    echo -e "   Inactive: ${YELLOW}${initial_inactive} MB${NC}"
    echo -e "   Purgeable: ${PURPLE}${initial_purgeable} MB${NC}"
    
    # Purge memory caches
    echo -e "${BLUE}🔄 Purging memory caches...${NC}"
    if sudo purge; then
        echo -e "${GREEN}✅ Purge command executed successfully${NC}"
    else
        echo -e "${RED}❌ Purge command failed${NC}"
        return 1
    fi
    
    # Wait for system to update
    sleep 2
    
    # Get final memory stats
    local final_stats=($(get_memory_stats))
    local final_free=${final_stats[0]}
    local final_inactive=${final_stats[2]}
    local final_purgeable=${final_stats[3]}
    
    echo -e "${CYAN}📊 Final state:${NC}"
    echo -e "   Free: ${GREEN}${final_free} MB${NC}"
    echo -e "   Inactive: ${YELLOW}${final_inactive} MB${NC}"
    echo -e "   Purgeable: ${PURPLE}${final_purgeable} MB${NC}"
    
    # Calculate improvements
    local free_gained=$((final_free - initial_free))
    local inactive_freed=$((initial_inactive - final_inactive))
    local purgeable_freed=$((initial_purgeable - final_purgeable))
    
    echo -e "${GREEN}✅ Memory optimization complete!${NC}"
    echo -e "   Free memory gained: ${GREEN}+${free_gained} MB${NC}"
    echo -e "   Inactive memory freed: ${YELLOW}${inactive_freed} MB${NC}"
    echo -e "   Purgeable memory freed: ${PURPLE}${purgeable_freed} MB${NC}"
    
    # Show total improvement
    local total_improvement=$((free_gained + inactive_freed + purgeable_freed))
    echo -e "${CYAN}📈 Total memory improvement: ${GREEN}${total_improvement} MB${NC}"
}

# Function to show memory status
memory_status() {
    echo -e "${CYAN}📊 Current Memory Status${NC}"
    echo -e "${CYAN}========================${NC}"
    
    # Get memory pressure
    echo -e "${BLUE}🔍 Memory Pressure:${NC}"
    memory_pressure | head -5
    
    echo ""
    echo -e "${BLUE}📈 Detailed Memory Stats:${NC}"
    vm_stat | grep -E "(Pages free|Pages active|Pages inactive|Pages speculative|Pages wired down|Pages purgeable)"
    
    echo ""
    echo -e "${BLUE}💾 Memory Usage Summary:${NC}"
    local stats=($(get_memory_stats))
    local free=${stats[0]}
    local active=${stats[1]}
    local inactive=${stats[2]}
    local purgeable=${stats[3]}
    local wired=${stats[4]}
    
    echo -e "   Free: ${GREEN}${free} MB${NC}"
    echo -e "   Active: ${BLUE}${active} MB${NC}"
    echo -e "   Inactive: ${YELLOW}${inactive} MB${NC}"
    echo -e "   Purgeable: ${PURPLE}${purgeable} MB${NC}"
    echo -e "   Wired: ${RED}${wired} MB${NC}"
    echo -e "   Total Available: ${GREEN}$((free + inactive + purgeable)) MB${NC}"
    
    # Memory health indicator
    local total_available=$((free + inactive + purgeable))
    if [ $total_available -gt 2000 ]; then
        echo -e "   Status: ${GREEN}✅ Healthy${NC}"
    elif [ $total_available -gt 1000 ]; then
        echo -e "   Status: ${YELLOW}⚠️  Moderate${NC}"
    else
        echo -e "   Status: ${RED}❌ Low${NC}"
    fi
}

# Function to show top memory consumers
memory_top() {
    echo -e "${CYAN}🔍 Top Memory Consumers${NC}"
    echo -e "${CYAN}=======================${NC}"
    ps aux | sort -nr -k 4 | head -10 | awk '{printf "%-8s %-6s %6s%% %s\n", $1, $2, $4, $11}'
}

# Function for smart memory optimization
smart_memory() {
    local stats=($(get_memory_stats))
    local free=${stats[0]}
    local total_available=$((free + ${stats[2]} + ${stats[3]}))
    
    echo -e "${BLUE}🧠 Smart Memory Check${NC}"
    echo -e "   Available memory: ${GREEN}${total_available} MB${NC}"
    
    if [ $total_available -lt 1000 ]; then
        echo -e "${YELLOW}⚠️  Low memory detected (< 1GB available). Running optimization...${NC}"
        memory_cleanup
    else
        echo -e "${GREEN}✅ Memory levels are healthy. No optimization needed.${NC}"
        echo -e "   Use '$0 clean' to force optimization if desired."
    fi
}

# Function for memory cleanup with notification
memory_cleanup_notify() {
    memory_cleanup
    
    # Send notification if terminal-notifier is available
    if command -v terminal-notifier >/dev/null 2>&1; then
        terminal-notifier -title "Memory Optimization" -message "Memory cleanup completed successfully" -sound Glass
        echo -e "${GREEN}📱 Desktop notification sent${NC}"
    else
        echo -e "${YELLOW}💡 Install terminal-notifier for desktop notifications${NC}"
    fi
}

# Main script logic
main() {
    case "${1:-help}" in
        "clean")
            memory_cleanup
            ;;
        "status")
            memory_status
            ;;
        "smart")
            smart_memory
            ;;
        "notify")
            memory_cleanup_notify
            ;;
        "top")
            memory_top
            ;;
        "help"|"-h"|"--help")
            show_help
            ;;
        *)
            echo -e "${RED}❌ Unknown option: $1${NC}"
            echo ""
            show_help
            exit 1
            ;;
    esac
}

# Run main function with all arguments
main "$@"
