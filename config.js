
module.exports = {
  brew: [
    // http://conqueringthecommandline.com/book/ack_ag
    'ack',
    'ag',
    // cmake is required to compile vim bundle YouCompleteMe
    'cmake',
    'commandbox',
    // Install GNU core utilities (those that come with OS X are outdated)
    // Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
    'coreutils',
    'dos2unix',
    // Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
    'findutils',
    'fortune',
    'fzf',
    'gawk',
    'gh',
    // http://www.lcdf.org/gifsicle/ (because I'm a gif junky)
    'gifsicle',
		'git-extras',
    'gnupg',
    // Install GNU `sed`, overwriting the built-in `sed`
    // so we can do "sed -i 's/foo/bar/' file" instead of "sed -i '' 's/foo/bar/' file"
    'gnu-sed --default-names',
    // better, more recent grep
		// better/more recent version of grep, nano, openssh, & screen
    'homebrew/dupes/grep',
		'homebrew/dupes/nano',
		'homebrew/dupes/openssh',
		'homebrew/dupes/screen',
		'homebrew/dupes/rsync',

    // https://github.com/jkbrzt/httpie
    'httpie',
    'imagemagick --with-webp',
    'imagesnap',
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
		'cleanmymac',
	  'dash',
	  'disk-inventory-x',
	  'docker',
	  'dropbox',
    'diffmerge',
    'dropbox',
    'evernote',
		'firefox',
		'flux',
		'forklift',
		'gemini',
		'glimmerblocker',
		'google-chrome',
		'google-chrome-canary',
		'google-drive',
		'google-play-music-desktop-player',
		'gpgtools',
		'grammarly',
		'gyazo',
		'hammerspoon',
		'imagealpha',
		'imageoptim',
		'imazing',
    'iterm2',
    'kaleidoscope',
    'little-snitch',
		'macdown',
		'malwarebytes-anti-malware',
    'micro-snitch',
    'omnifocus',
    'opera',
    'rescuetime',
    'screenflow',
    'sketch',
		'sketch-toolbox',
    'slack',
    'sourcetree',
    'sublime-text',
		'textwrangler',
    'the-unarchiver',
    'torbrowser',
    'vagrant',
    'virtualbox',
    'vlc',
		'qlcolorcode',
		'qlstephen',
		'qlmarkdown',
		'quicklook-json',
		'qlprettypatch',
		'quicklook-csv',
		'betterzipql',
		'qlimagesize',
		'webpquicklook',
		'suspicious-package',
		'quicklookase',
		'qlvideo'
  ],
  gem: [
    'git-up'
  ],
  npm: [
    'antic',
    'buzzphrase',
		'diff-so-fancy',
    'eslint',
    'generator-dockerize',
    'git-open',
    'git-recent',
    'instant-markdown-d',
    'npm-check-updates',
    'npm-check',
    'prettyjson',
		'servedir',
    'trash',
    'vtop',
    'vue-cli',
		'yo'
  ]
};
