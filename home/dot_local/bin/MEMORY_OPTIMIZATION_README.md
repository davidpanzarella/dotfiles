# Memory Optimization System

A comprehensive memory optimization toolkit for macOS, designed to integrate seamlessly with your development workflow.

## 🚀 Quick Start

### Command Line Usage

```bash
# Quick memory optimization (recommended)
mc

# Check memory status
ms

# Show top memory consumers
mt

# Smart optimization (only when needed)
sm

# Memory cleanup with notification
mcn
```

### Standalone Script Usage

```bash
# Full memory optimization with detailed output
~/.local/bin/memory-optimizer.sh clean

# Quick optimization for shortcuts/GUI
~/.local/bin/memory-shortcut.sh optimize

# Check memory status
~/.local/bin/memory-shortcut.sh status
```

## 📋 Available Commands

### Zsh Functions & Aliases

| Command | Function          | Description                                        |
| ------- | ----------------- | -------------------------------------------------- |
| `mc`    | `memclean`        | Comprehensive memory cleanup with status reporting |
| `ms`    | `memstat`         | Check current memory status and statistics         |
| `mt`    | `memtop`          | Show top memory consuming processes                |
| `sm`    | `smartmem`        | Smart optimization (only when memory is low)       |
| `mcn`   | `memclean-notify` | Memory cleanup with desktop notification           |
| `purge` | `sudo purge`      | Direct memory purge command                        |

### Standalone Scripts

| Script                | Purpose                           | Best For                            |
| --------------------- | --------------------------------- | ----------------------------------- |
| `memory-optimizer.sh` | Full-featured memory optimization | Terminal usage, detailed analysis   |
| `memory-shortcut.sh`  | Quick optimization for shortcuts  | GUI integration, Raycast, Automator |

## 🎯 Features

### Smart Memory Management

- **Automatic detection** of low memory conditions
- **Before/after reporting** with detailed statistics
- **Safe optimization** using macOS built-in `purge` command
- **Health indicators** for memory status

### Integration Options

- **Zsh functions** for terminal workflow
- **Keyboard shortcuts** via Raycast or Automator
- **Desktop notifications** for completion status
- **Color-coded output** for easy reading

### Best Practices

- **Non-destructive** - only purges caches, doesn't kill processes
- **Apple Silicon optimized** - works perfectly on M1/M2/M3 Macs
- **Sudo integration** - properly handles permissions
- **Error handling** - graceful failure with informative messages

## 🔧 Setup Instructions

### 1. Apply Configuration

```bash
# Apply the dotfiles configuration
PATH="/opt/homebrew/bin:$PATH" chezmoi apply
```

### 2. Reload Shell

```bash
# Reload your shell to activate new functions
reload
```

### 3. Test Installation

```bash
# Test the memory optimization
mc

# Check memory status
ms
```

## 🎨 Keyboard Shortcuts

### Raycast Integration

1. Copy `raycast-memory-extension.json` to your Raycast extensions
2. Set up keyboard shortcuts in Raycast preferences
3. Recommended shortcuts:
   - `Cmd+Shift+M` - Quick memory optimization
   - `Cmd+Shift+Ctrl+M` - Memory status check

### Automator Integration

1. Create a new "Quick Action" in Automator
2. Add "Run Shell Script" action
3. Use this command:
   ```bash
   ~/.local/bin/memory-shortcut.sh optimize
   ```
4. Save and assign a keyboard shortcut in System Preferences

## 📊 Understanding Memory Stats

### Memory Types

- **Free**: Immediately available memory
- **Active**: Memory currently in use by applications
- **Inactive**: Memory that was recently used but is now available
- **Purgeable**: Memory that can be freed by the system
- **Wired**: Memory that cannot be swapped to disk

### Health Indicators

- **✅ Healthy**: > 2GB available memory
- **⚠️ Moderate**: 1-2GB available memory
- **❌ Low**: < 1GB available memory

## 🔍 Troubleshooting

### Permission Issues

```bash
# If you get permission errors, ensure sudo is configured
sudo -v
```

### Script Not Found

```bash
# Ensure scripts are executable
chmod +x ~/.local/bin/memory-*.sh
```

### Functions Not Available

```bash
# Reload your shell configuration
reload

# Or manually source the functions
source ~/.config/zsh/zsh-functions
```

## 🎯 Best Practices

### When to Use

- **Before intensive tasks** (compilation, video editing, etc.)
- **When system feels sluggish** and memory usage is high
- **After closing large applications** to free up cached memory
- **Regular maintenance** (daily or weekly)

### When NOT to Use

- **During active work** (it's safe but unnecessary)
- **When memory is already healthy** (> 2GB free)
- **As a replacement for proper memory management**

### Integration Tips

- **Add to your daily routine** with a simple `mc` command
- **Use smart optimization** (`sm`) for automatic detection
- **Monitor with status checks** (`ms`) to understand your system
- **Set up keyboard shortcuts** for quick access during work

## 🔧 Customization

### Modify Thresholds

Edit the `smartmem` function in `zsh-functions` to change the low memory threshold:

```bash
# Change from 1000 MB to 500 MB
if [ $free_mb -lt 500 ]; then
```

### Add Custom Notifications

Modify the notification functions to use different sounds or messages:

```bash
terminal-notifier -title "Custom Title" -message "Custom message" -sound Custom
```

### Extend Functionality

Add new functions to `zsh-functions` for additional memory management tasks.

## 📈 Performance Impact

- **Minimal CPU usage** - only runs when called
- **Safe operation** - uses macOS built-in tools
- **No system interference** - doesn't affect running applications
- **Quick execution** - typically completes in 1-2 seconds

## 🤝 Contributing

This memory optimization system is part of your dotfiles configuration. To modify or extend:

1. Edit the functions in `~/.config/zsh/zsh-functions`
2. Update aliases in `~/.config/zsh/zsh-aliases.tmpl`
3. Modify scripts in `~/.local/bin/`
4. Apply changes with `chezmoi apply`

## 📚 Additional Resources

- [macOS Memory Management](https://developer.apple.com/documentation/kernel/memory_management)
- [vm_stat man page](https://developer.apple.com/library/archive/documentation/System/Conceptual/ManPages_iPhoneOS/man1/vm_stat.1.html)
- [purge man page](https://developer.apple.com/library/archive/documentation/System/Conceptual/ManPages_iPhoneOS/man8/purge.8.html)
