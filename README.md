# Dotfiles

Dotfiles that make anywhere feel like `$HOME`.

## Getting Started

Ready to set up a new macOS or Arch Linux computer for me? Grab your terminal and let's get started!

### Moving In

First things first, gain access to your data. Set up your password manager and generate a new SSH key. Be sure to register this fresh SSH public key with GitHub before cloning any more repos.

```shell
ssh-keygen -m PEM -t rsa -b 4096
# Check out ~/.ssh/id_rsa.pub
```

Then, clone or move this repo to `~/.dotfiles`.

```shell
# Ideal method (using SSH)
git clone git@github.com:jungaretti/dotfiles.git ~/.dotfiles

# Less-ideal method (using HTTPS)
git clone https://github.com/jungaretti/dotfiles.git ~/.dotfiles
```

### Unpacking

Next, install everything using [Homebrew](https://github.com/Homebrew/brew) on macOS and [pacman](https://wiki.archlinux.org/index.php/Pacman) on Arch Linux.

###### macOS

[Install Homebrew.](https://brew.sh/) Next, grab your list of favorite applications or `git clone git@github.com:jungaretti/stuff-macos.git`.

```shell
git clone git@github.com:jungaretti/stuff-macos.git
cd stuff-macos

# Install mas-cli
brew install mas

# Install everything else (this takes quite a long time)
./install.sh
```

###### Arch Linux

Install essential packages with `pacman -Syu base-devel git zsh`. Then, grab your list of favorite programs or `git clone git@github.com:jungaretti/stuff-arch-linux.git`.

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

# Use chsh if you're using The Cloud™ or don't have a user password
sudo chsh -s /bin/zsh jungaretti
```

Now it's time to "install" your dotfiles. I use Dotbot to install my dotfiles; it's an elegant and simple solution that works well for me.

```shell
# Clean up after Oh My Zsh
rm ~/.zshrc

cd ~/.dotfiles
./install.bash
```

### Decorating

Our last step is to install _special_ tools.

#### rustup

[Install rustup.](https://rustup.rs/)

```shell
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

#### fnm

[Install fnm.](https://github.com/Schniz/fnm) Then, install Node.js!

```shell
cargo install fnm
echo 'eval "$(fnm env)"' >> ~/.zprofile

eval "$(fnm env)"
fnm install --lts
```

## Built With

- [Dotbot](https://github.com/anishathalye/dotbot)
