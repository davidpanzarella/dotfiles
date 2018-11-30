
module.exports = {
  brew: [
    // http://conqueringthecommandline.com/book/ack_ag
    'ack',
    'ag',
    // alternative to `cat`: https://github.com/sharkdp/bat
    'bat',
    // Install GNU core utilities (those that come with macOS are outdated)
    // Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
    'coreutils',
    'dos2unix',
    // Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
    'findutils',
    // 'fortune',
    'fzf',
    'readline', // ensure gawk gets good readline
    'gawk',
    'gh',
    // http://www.lcdf.org/gifsicle/ (because I'm a gif junky)
    'gifsicle',
		'git-extras',
    'gnupg',
    // Install GNU `sed`, overwriting the built-in `sed`
    // so we can do "sed -i 's/foo/bar/' file" instead of "sed -i '' 's/foo/bar/' file"
    'gnu-sed --with-default-names',
    // upgrade grep so we can get things like inverted match (-v)
    'grep --with-default-names',
    // better, more recent grep
		// better/more recent version of grep, nano, openssh, & screen
    'homebrew/dupes/grep',
		'homebrew/dupes/nano',
		'homebrew/dupes/openssh',
		'homebrew/dupes/screen',
		'homebrew/dupes/rsync',

    // https://github.com/jkbrzt/httpie
    'httpie',
    // jq is a sort of JSON grep
    'jq',
    // Mac App Store CLI: https://github.com/mas-cli/mas
    'mas',
    // Install some other useful utilities like `sponge`
    'moreutils',
    'nmap',
    'openconnect',
    'reattach-to-user-namespace',
		'homebrew/completions/brew-cask-completion',
    'tmux',
    'todo-txt',
    'tree',
    'ttyrec',
    // better, more recent vim
    'vim --with-override-system-vi',
    'watch',
    // Install wget with IRI support
    'wget --enable-iri',
		'wifi-password'
  ],
  cask: [
		'1password',
		'adobe-creative-cloud',
		'adobe-reader',
    'alfred',
    'amazon-drive',
    'atom',
	  'dash',
    'diffmerge',
	  'disk-inventory-x',
	  'dropbox',
    'docker', // docker for mac
    'evernote',
    'iterm2',
		'firefox',
		'flux',
		'forklift',
		'gemini',
		'google-chrome',
		'google-drive',
		'grammarly',
		'malwarebytes-anti-malware',
    'omnifocus',
		'quicklook-csv',
		'quicklook-json',
		'quicklookase',
    'setapp',
    'sketch',
    'slack',
    'sourcetree',
		'sketch-toolbox',
		'textwrangler',
		'webpquicklook',
    'the-unarchiver',
    'visual-studio-code',
    'vlc',
    'yarn'
  ],
  gem: [
  ],
  npm: [
		'diff-so-fancy',
    'eslint',
    'git-open',
    'git-recent',
    'gulp',
    'vtop'
  ]
};
