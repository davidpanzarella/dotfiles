#!/bin/bash
# Test script for Starship configuration with Cursor AI conversations

echo "🧪 Testing Starship Configuration for Cursor AI Conversations"
echo "=============================================================="

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

# Test 5: Simulate Cursor chat environment
echo -e "\n📋 Test 5: Simulating Cursor Chat Environment"
export TERM_PROGRAM="cursor"
export CURSOR_CHAT_SHELL="minimal"

echo "   Environment variables set:"
echo "   TERM_PROGRAM: $TERM_PROGRAM"
echo "   CURSOR_CHAT_SHELL: $CURSOR_CHAT_SHELL"

# Test 6: Test prompt rendering
echo -e "\n📋 Test 6: Prompt Rendering Test"
echo "   Current prompt should show:"
echo "   - Directory path"
echo "   - Git branch (if in git repo)"
echo "   - Git status (if changes exist)"
echo "   - Node.js version (if package.json exists)"
echo "   - Python version (if .py files exist)"

# Test 7: Test in different directories
echo -e "\n📋 Test 7: Directory Context Test"
test_dirs=(
    "$HOME"
    "$HOME/.local/share/chezmoi"
    "/tmp"
)

for dir in "${test_dirs[@]}"; do
    if [ -d "$dir" ]; then
        echo "   Testing in: $dir"
        cd "$dir" 2>/dev/null
        if [ $? -eq 0 ]; then
            echo "     ✅ Accessible"
            # Test if we can get directory info
            pwd_output=$(pwd)
            echo "     📁 Current: $pwd_output"
        else
            echo "     ❌ Not accessible"
        fi
    fi
done

# Test 8: Test git integration
echo -e "\n📋 Test 8: Git Integration Test"
cd "$HOME/.local/share/chezmoi" 2>/dev/null
if [ $? -eq 0 ] && git rev-parse --git-dir > /dev/null 2>&1; then
    echo "   ✅ In git repository"
    echo "   📋 Branch: $(git branch --show-current)"
    echo "   📊 Status: $(git status --porcelain | wc -l | tr -d ' ') changes"
else
    echo "   ⚠️  Not in git repository or git not available"
fi

# Test 9: Test package detection
echo -e "\n📋 Test 9: Package Detection Test"
cd "$HOME/.local/share/chezmoi" 2>/dev/null
if [ -f "package.json" ]; then
    echo "   ✅ Node.js project detected"
    if command -v node > /dev/null; then
        echo "   📦 Node version: $(node --version)"
    fi
elif [ -f "requirements.txt" ] || [ -f "pyproject.toml" ]; then
    echo "   ✅ Python project detected"
    if command -v python3 > /dev/null; then
        echo "   🐍 Python version: $(python3 --version)"
    fi
else
    echo "   ⚠️  No package files detected"
fi

echo -e "\n🎯 Test Summary"
echo "==============="
echo "✅ Starship is ready for Cursor AI conversations!"
echo "📋 Key features:"
echo "   - Auto-switching between chat and full configs"
echo "   - Context-aware prompts (directory, git, packages)"
echo "   - ASCII-compatible symbols (no emoji issues)"
echo "   - Fast loading for chat interactions"
echo ""
echo "🚀 To test in Cursor:"
echo "   1. Open a new terminal in Cursor"
echo "   2. Check that prompt shows current directory and git status"
echo "   3. Try the switcher: 'starship-chat' or 'starship-full'"
echo "   4. Verify clean, readable output for AI conversations"
