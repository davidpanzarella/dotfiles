
module.exports = {
  brew: [
    // http://conqueringthecommandline.com/book/ack_ag
    'ag',
    // https://github.com/wting/autojump
    'autojump',
    'awscli',
    // alternative to `cat`: https://github.com/sharkdp/bat
    'bat',
    'brew-cask-completion',
    // Install GNU core utilities (those that come with macOS are outdated)
    // Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
    'coreutils',
    // Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
    'findutils',
    'fzf',
    'readline', // ensure gawk gets good readline
    'gawk',
		'git-extras',
    'gnupg',
    // Install GNU `sed`, overwriting the built-in `sed`
    // so we can do "sed -i 's/foo/bar/' file" instead of "sed -i '' 's/foo/bar/' file"
    'gnu-sed --with-default-names',
    // upgrade grep so we can get things like inverted match (-v)
    'grep --with-default-names',
    // better, more recent grep
		// better/more recent version of grep, nano, openssh, & screen
    'grep',
		'nano',
		'openssh',
    // https://github.com/jkbrzt/httpie
    'httpie',
    // jq is a sort of JSON grep
    'jq',
    // Mac App Store CLI: https://github.com/mas-cli/mas
    'mas',
    // Install some other useful utilities like `sponge`
    'moreutils',
    'nmap',
    'n',
    'tree',
    'vim --with-client-server --with-override-system-vi',
    'wget --enable-iri',
		'wifi-password'
  ],
  cask: [
    '1password',
		'adobe-creative-cloud',
		'adobe-reader',
		'alfred',
    'diffmerge',
    'docker',
    'evernote',
		'firefox',
		'flux',
		'google-chrome',
		'google-drive',
		'grammarly',
    'iterm2',
		'macdown',
    'omnifocus',
		'qlcolorcode',
		'qlimagesize',
		'qlmarkdown',
		'qlprettypatch',
		'qlstephen',
		'qlvideo'
		'quicklook-csv',
		'quicklook-json',
		'quicklookase',
    'rescuetime',
    'sketch',
		'sketch-toolbox',
    'sourcetree',
		'suspicious-package',
		'textwrangler',
    'the-unarchiver',
    'visual-studio-code',
    'vlc',
		'webpquicklook'
  ],
  gem: [
  ],
  npm: [
		'diff-so-fancy',
    'eslint',
    'git-open',
    'git-recent',
    'instant-markdown-d',
    'npm-check-updates',
    'npm-check',
    'vtop'
  ]
};
