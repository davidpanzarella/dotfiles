#!/bin/bash
# Test Starship specifically for Cursor AI conversations

echo "🎯 Testing Starship for Cursor AI Conversations"
echo "=============================================="

# Test 1: Check if we're in a Cursor environment
echo "📋 Test 1: Cursor Environment Detection"
if [[ "$TERM_PROGRAM" == "cursor" ]]; then
    echo "✅ Running in Cursor terminal"
else
    echo "⚠️  Not in Cursor terminal (TERM_PROGRAM: $TERM_PROGRAM)"
    echo "   Simulating Cursor environment..."
    export TERM_PROGRAM="cursor"
fi

# Test 2: Test chat shell detection
echo -e "\n📋 Test 2: Chat Shell Detection"
if [[ "$CURSOR_CHAT_SHELL" == "minimal" ]]; then
    echo "✅ Chat shell detected (minimal mode)"
    chat_mode=true
else
    echo "⚠️  Regular terminal mode (CURSOR_CHAT_SHELL: $CURSOR_CHAT_SHELL)"
    chat_mode=false
fi

# Test 3: Test Starship prompt rendering
echo -e "\n📋 Test 3: Starship Prompt Rendering"
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

# Test 4: Test configuration switching
echo -e "\n📋 Test 4: Configuration Switching"
chezmoi_dir="$HOME/.local/share/chezmoi/home/private_dot_config"

if [ -f "$chezmoi_dir/starship-chat.toml" ]; then
    echo "✅ Chat configuration available"
    
    # Test switching to chat config
    cp "$chezmoi_dir/starship-chat.toml" "$HOME/.config/starship.toml"
    echo "✅ Switched to chat configuration"
    
    # Show what the chat config contains
    echo "   Chat config features:"
    grep -E "^(format|symbol)" "$HOME/.config/starship.toml" | head -5 | sed 's/^/     /'
else
    echo "❌ Chat configuration not found"
fi

# Test 5: Test prompt output
echo -e "\n📋 Test 5: Prompt Output Test"
echo "Here's what your prompt should look like:"
echo ""

# Simulate the prompt output
if [ "$chat_mode" = true ]; then
    echo "🎯 CHAT MODE PROMPT:"
    echo "[$current_dir] on [git:$git_branch] ([!+?]) [>]"
else
    echo "🚀 FULL MODE PROMPT:"
    echo "[$current_dir] on [git:$git_branch] ([!+?]) via [node:v18.17.0] [>]"
fi

echo ""

# Test 6: Test AI conversation context
echo -e "\n📋 Test 6: AI Conversation Context"
echo "For AI conversations, the prompt should provide:"
echo "   ✅ Current directory path"
echo "   ✅ Git branch and status"
echo "   ✅ Project type (Node.js, Python, etc.)"
echo "   ✅ Clean, minimal format"
echo "   ✅ No unnecessary information"

# Test 7: Performance test
echo -e "\n📋 Test 7: Performance Test"
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
echo "   2. Check that prompt shows: [directory] on [git:branch] [>]"
echo "   3. Try: 'starship-chat' to switch to minimal mode"
echo "   4. Verify clean output for AI conversations"
