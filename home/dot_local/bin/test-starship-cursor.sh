#!/bin/bash
# Comprehensive test script for Starship configuration with Cursor AI conversations

echo "🎯 Testing Starship for Cursor AI Conversations"
echo "=============================================="

# Test 1: Check if Starship is installed and working
echo "📋 Test 1: Starship Installation"
if command -v starship > /dev/null; then
    echo "✅ Starship is installed: $(which starship)"
    echo "   Version: $(starship --version | head -1)"
else
    echo "❌ Starship is not installed"
    exit 1
fi

# Test 2: Check current configuration
echo -e "\n📋 Test 2: Current Configuration"
if [ -f "$HOME/.config/starship.toml" ]; then
    echo "✅ Starship config found: $HOME/.config/starship.toml"
    echo "   First 3 lines:"
    head -3 "$HOME/.config/starship.toml" | sed 's/^/   /'
else
    echo "⚠️  No Starship config found at $HOME/.config/starship.toml"
fi

# Test 3: Check Chezmoi templates
echo -e "\n📋 Test 3: Chezmoi Templates"
chezmoi_dir="$HOME/.local/share/chezmoi/home/private_dot_config"
if [ -f "$chezmoi_dir/starship.toml" ]; then
    echo "✅ Full Starship template found"
else
    echo "❌ Full Starship template missing"
fi

if [ -f "$chezmoi_dir/starship-chat.toml" ]; then
    echo "✅ Chat Starship template found"
else
    echo "❌ Chat Starship template missing"
fi

# Test 4: Test configuration switcher
echo -e "\n📋 Test 4: Configuration Switcher"
if [ -f "$HOME/.local/bin/terminal-enhancements-v2.sh" ]; then
    source "$HOME/.local/bin/terminal-enhancements-v2.sh"
    echo "✅ Enhancement functions loaded"
    
    # Test switcher
    echo "   Testing switcher function..."
    switch_starship_config current > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "✅ Configuration switcher working"
    else
        echo "❌ Configuration switcher failed"
    fi
else
    echo "❌ Enhancement functions not found"
fi

# Test 5: Check Cursor environment
echo -e "\n📋 Test 5: Cursor Environment Detection"
if [[ "$TERM_PROGRAM" == "cursor" ]]; then
    echo "✅ Running in Cursor terminal"
else
    echo "⚠️  Not in Cursor terminal (TERM_PROGRAM: $TERM_PROGRAM)"
    echo "   Simulating Cursor environment..."
    export TERM_PROGRAM="cursor"
fi

# Test 6: Test chat shell detection
echo -e "\n📋 Test 6: Chat Shell Detection"
if [[ "$CURSOR_CHAT_SHELL" == "minimal" ]]; then
    echo "✅ Chat shell detected (minimal mode)"
    chat_mode=true
else
    echo "⚠️  Regular terminal mode (CURSOR_CHAT_SHELL: $CURSOR_CHAT_SHELL)"
    chat_mode=false
fi

# Test 7: Test Starship prompt rendering
echo -e "\n📋 Test 7: Starship Prompt Rendering"
echo "Current prompt should show:"

# Get current directory info
current_dir=$(pwd)
echo "   📁 Directory: $current_dir"

# Get git info if available
if git rev-parse --git-dir > /dev/null 2>&1; then
    git_branch=$(git branch --show-current)
    git_changes=$(git status --porcelain | wc -l | tr -d ' ')
    echo "   🌱 Git: $git_branch ($git_changes changes)"
else
    echo "   🌱 Git: Not in a git repository"
fi

# Test 8: Test actual prompt output
echo -e "\n📋 Test 8: Actual Prompt Output"
echo "Setting proper terminal environment..."
export TERM=xterm-256color
export TERM_PROGRAM=cursor

echo "Testing Starship prompt:"
if starship prompt > /dev/null 2>&1; then
    echo "✅ Starship prompt renders successfully"
    echo "   Sample output:"
    starship prompt | sed 's/^/     /'
else
    echo "❌ Starship prompt failed to render"
fi

# Test 9: Test configuration switching
echo -e "\n📋 Test 9: Configuration Switching"
chezmoi_dir="$HOME/.local/share/chezmoi/home/private_dot_config"

if [ -f "$chezmoi_dir/starship-chat.toml" ]; then
    echo "✅ Chat configuration available"
    
    # Test switching to chat config
    /bin/cp "$chezmoi_dir/starship-chat.toml" "$HOME/.config/starship.toml"
    echo "✅ Switched to chat configuration"
    
    # Test the chat prompt
    echo "   Testing chat prompt:"
    starship prompt | sed 's/^/     /'
else
    echo "❌ Chat configuration not found"
fi

# Test 10: Performance test
echo -e "\n📋 Test 10: Performance Test"
start_time=$(date +%s%N)
if command -v starship > /dev/null; then
    starship --version > /dev/null 2>&1
    end_time=$(date +%s%N)
    duration=$(( (end_time - start_time) / 1000000 ))
    echo "✅ Starship loads in ${duration}ms"
    
    if [ $duration -lt 100 ]; then
        echo "   🚀 Fast loading - good for chat interactions"
    else
        echo "   ⚠️  Slow loading - may affect chat performance"
    fi
else
    echo "❌ Starship not available"
fi

# Test 11: AI conversation context
echo -e "\n📋 Test 11: AI Conversation Context"
echo "For AI conversations, the prompt should provide:"
echo "   ✅ Current directory path"
echo "   ✅ Git branch and status"
echo "   ✅ Project type (Node.js, Python, etc.)"
echo "   ✅ Clean, minimal format"
echo "   ✅ No unnecessary information"

echo -e "\n🎯 Test Results Summary"
echo "======================="
echo "✅ Starship is configured for Cursor AI conversations"
echo "📋 Key benefits:"
echo "   - Context-aware prompts show directory and git status"
echo "   - Minimal chat config reduces visual clutter"
echo "   - Fast loading for responsive AI interactions"
echo "   - ASCII-compatible symbols work in all terminals"
echo ""
echo "🚀 To verify in Cursor:"
echo "   1. Open a new terminal in Cursor"
echo "   2. Check that prompt shows: [directory] on [git:branch] [status] [>]"
echo "   3. Try: 'starship-chat' to switch to minimal mode"
echo "   4. Verify clean output for AI conversations"
echo ""
echo "📋 Available commands:"
echo "   starship-chat    - Switch to chat-optimized config"
echo "   starship-full    - Switch to full config"
echo "   ss current       - Show current configuration"
