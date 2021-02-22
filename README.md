# Dotfiles

Dotfiles that make anywhere feel like `$HOME`.

## Getting Started

Ready to set up a new computer for me? Grab your terminal and let's get started!

### Moving In

Let's start by installing the essentials. I'm a macOS and Arch Linux user, so you'll see guides for both.

First things first, gain access to our data. Set up our password manager and generate a new SSH key. Be sure to register this SSH key before cloning any more repos.

```shell
ssh-keygen -m PEM -t rsa -b 4096
# Check out ~/.ssh/id_rsa.pub
```

Go ahead and clone (or move) this repo to `~/.dotfiles`.

```shell
git clone https://github.com/jungaretti/dotfiles.git ~/.dotfiles
```

### Assembly

Now that we're moved in, let's set up our stuff! We'll install everything using [Homebrew](https://github.com/Homebrew/brew) on macOS and [pacman](https://wiki.archlinux.org/index.php/Pacman) on Arch Linux.

###### macOS

[Install Homebrew.](https://brew.sh/) Next, grab your list of applications or `git clone git@github.com:jungaretti/stuff-macos.git`.

```shell
git clone git@github.com:jungaretti/stuff-macos.git
cd stuff-macos

# Install mas-cli
`brew install mas`

# Install everything else (this takes quite a while)
./install.sh src/Brewfile
```

###### Arch Linux

`pacman -Syu` and `pacman -S base-devel git zsh`. Then, grab your list of programs or `git clone git@github.com:jungaretti/stuff-arch-linux.git`.

```shell
git clone git@github.com:jungaretti/stuff-arch-linux.git
cd stuff-arch-linux

./install.sh src/Pacfile
```

[Install Yay](https://github.com/Jguer/yay) to automate AUR installations.

```shell
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

###### Everywhere

[Install Oh My Zsh.](https://ohmyz.sh/) It's not my favorite, but it gets the job done.

```shell
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Make sure to set the default shell
sudo chsh -s /bin/zsh jungaretti
```

Now it's time to install our dotfiles. I use Dotbot to install my dotfiles. It's an elegant and simple solution that world well for me.

```shell
# Clean up after Oh My Zsh
rm ~/.zshrc

cd ~/.dotfiles
./install.bash
```

We're nearly finished! Our last step is to install _special_ tools.

##### rustup

[Install rustup.](https://rustup.rs/)

```shell
# You should probably check the website
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

##### fnm

[Install fnm.](https://github.com/Schniz/fnm). Then, install Node.js!

```shell
cargo install fnm
```

Be sure to add `eval "$(fnm env)"` to `~/.zprofile` or `~/.zshenv`.

## Built With

- [Dotbot](https://github.com/anishathalye/dotbot)
