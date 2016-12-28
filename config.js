
module.exports = {
  brew: [
    // http://conqueringthecommandline.com/book/ack_ag
    'ack',
    'ag',
    // https://github.com/wting/autojump
    'autojump',
    // alternative to `cat`: https://github.com/sharkdp/bat
    'bat',
    'brew-cask-completion',
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
    'n',
    'openconnect',
    'reattach-to-user-namespace',
    'tmux',
    'todo-txt',
    'tree',
    'ttyrec',
    'vim --with-client-server --with-override-system-vi',
    'watch',
    'wget --enable-iri',
		'wifi-password'
  ],
  cask: [
		'1password',
		'adobe-creative-cloud',
		'adobe-reader',
		'alfred',
		'betterzipql',
		'firefox',
		'flux',
		'google-chrome',
		'google-drive',
		'gpgtools',
		'gyazo',
		'hammerspoon',
		'imagealpha',
		'imageoptim',
		'imazing',
		'macdown',
		'qlcolorcode',
		'qlimagesize',
		'qlmarkdown',
		'qlprettypatch',
		'qlstephen',
		'qlvideo'
		'quicklook-csv',
		'quicklook-json',
		'quicklookase',
		'sketch-toolbox',
		'suspicious-package',
		'textwrangler',
		'webpquicklook',
	  'docker',
    'diffmerge',
    'evernote',
    'iterm2',
    'macbreakz',
    'omnifocus',
    'opera',
    'rescuetime',
    'signal',
    'sizeup',
    'sketch',
    'sourcetree',
    'the-unarchiver',
    'visual-studio-code',
    'vlc',
  ],
  gem: [
  ],
  npm: [
    'antic',
		'diff-so-fancy',
    'eslint',
    'generator-dockerize',
    'git-open',
    'git-recent',
    'instant-markdown-d',
    'npm-check-updates',
    'npm-check',
    'generator-dockerize',
    'prettyjson',
		'servedir',
    'trash',
    'vtop'
  ]
};
