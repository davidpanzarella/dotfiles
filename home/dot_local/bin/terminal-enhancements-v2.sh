#!/bin/bash
# Enhanced Terminal Functions for Better Readability

# Color definitions
export TERM_RED='\033[0;31m'
export TERM_GREEN='\033[0;32m'
export TERM_YELLOW='\033[1;33m'
export TERM_BLUE='\033[0;34m'
export TERM_PURPLE='\033[0;35m'
export TERM_CYAN='\033[0;36m'
export TERM_WHITE='\033[1;37m'
export TERM_GRAY='\033[0;37m'
export TERM_BOLD='\033[1m'
export TERM_RESET='\033[0m'

# Visual separator function
term_separator() {
    local color=${1:-$TERM_GRAY}
    local char=${2:-─}
    local width=${3:-80}
    echo -e "${color}$(printf "%*s" $width | tr ' ' "$char")${TERM_RESET}"
}

# Enhanced cd with visual feedback
term_cd() {
    builtin cd "$@"
    if [ $? -eq 0 ]; then
        echo -e "${TERM_BLUE}📁 ${TERM_BOLD}$(pwd)${TERM_RESET}"
        term_separator $TERM_CYAN
    fi
}

# Git status helper
term_git_status() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        local git_status_output=$(git status --porcelain)
        local current_branch=$(git branch --show-current)
        if [ -n "$git_status_output" ]; then
            local change_count=$(echo "$git_status_output" | wc -l | tr -d ' ')
            echo -e "${TERM_YELLOW}📝 Git: ${current_branch} (${change_count} changes)${TERM_RESET}"
        else
            echo -e "${TERM_GREEN}✅ Git: ${current_branch} (clean)${TERM_RESET}"
        fi
    fi
}

# Command type highlighting
term_highlight_command() {
    local cmd="$1"
    case "$cmd" in
        git*) echo -e "${TERM_PURPLE}${cmd}${TERM_RESET}" ;;
        npm*|yarn*|pnpm*) echo -e "${TERM_YELLOW}${cmd}${TERM_RESET}" ;;
        docker*) echo -e "${TERM_BLUE}${cmd}${TERM_RESET}" ;;
        brew*) echo -e "${TERM_GREEN}${cmd}${TERM_RESET}" ;;
        *) echo -e "${TERM_WHITE}${cmd}${TERM_RESET}" ;;
    esac
}

# Error highlighting for output
term_highlight_output() {
    sed -E "s/(error|Error|ERROR|failed|Failed|FAILED)/${TERM_RED}\1${TERM_RESET}/g" | \
    sed -E "s/(warning|Warning|WARNING|warn|Warn|WARN)/${TERM_YELLOW}\1${TERM_RESET}/g" | \
    sed -E "s/(success|Success|SUCCESS|completed|Completed|COMPLETED)/${TERM_GREEN}\1${TERM_RESET}/g"
}

# Session start notification
term_session_start() {
    echo -e "${TERM_BOLD}${TERM_CYAN}🚀 Terminal Session Started${TERM_RESET}"
    echo -e "${TERM_GRAY}$(date '+%Y-%m-%d %H:%M:%S')${TERM_RESET}"
    term_separator $TERM_CYAN
}

# Log formatting helpers
term_json_format() {
    if command -v jq > /dev/null; then
        jq -r '.'
    else
        cat
    fi
}

# Command execution time tracking
term_preexec() {
    export TERM_CMD_START_TIME=$(date +%s)
}

term_precmd() {
    if [ -n "$TERM_CMD_START_TIME" ]; then
        local end_time=$(date +%s)
        local duration=$((end_time - TERM_CMD_START_TIME))
        if [ $duration -gt 2 ]; then
            echo -e "${TERM_GRAY}⏱️  Command took ${TERM_YELLOW}${duration}s${TERM_RESET}"
        fi
        unset TERM_CMD_START_TIME
    fi
}

# Export functions
export -f term_separator term_cd term_git_status term_highlight_command term_highlight_output term_session_start term_json_format term_preexec term_precmd
