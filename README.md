# Dotfiles

Dotfiles and programs that make anywhere feel like `$HOME`.

## Getting Started

Ready to set up a new macOS or Arch Linux computer for me? Fire up your favorite terminal and let's get started!

### Moving In

First things first, gain access to your data. Sign into your password manager and generate a new SSH key. Add that fresh SSH key to GitHub before cloning any repos.

You can use the [GitHub CLI](https://cli.github.com/manual/) to upload your SSH key from the command line.

```bash
# Check out ~/.ssh/id_rsa.pub
ssh-keygen -m PEM -t rsa -b 4096

gh auth login -s write:public_key

gh ssh-key add ~/.ssh/id_rsa.pub -t "myfavoritecomputer"
```

Then, clone or move this repo to `~/.dotfiles`.

```bash
gh repo clone jungaretti/dotfiles ~/.dotfiles
```

### Unpacking

Next, install everything using [Homebrew](https://github.com/Homebrew/brew) on macOS and [pacman](https://wiki.archlinux.org/index.php/Pacman) on Arch Linux.

###### macOS

[Install Homebrew.](https://brew.sh/) Then, check out `src/stuff/macos/README.md`.

```bash
# Install mas-cli
brew install mas

# Install everything else (this takes quite a long time)
cd src/stuff/macos
./install.sh
```

###### Arch Linux

Install essential packages with `pacman -Syu base-devel git zsh`. Then, check out `src/stuff/arch-linux/README.md`.

```bash
cd src/stuff/arch-linux
./install.sh
```

###### Everywhere

[Install Oh My Zsh.](https://ohmyz.sh/) It's not my favorite, but it gets the job done.

```bash
gh repo clone ohmyzsh/ohmyzsh
cd ohmyzsh
./tools/install.sh

# Use chsh if you're using The Cloud™ or don't have a user password
sudo chsh -s /bin/zsh jungaretti
```

Now it's time to "install" your dotfiles. I use Dotbot to install my dotfiles; it's an elegant and simple solution that works well for me.

```bash
# Clean up after Oh My Zsh
rm ~/.zshrc

cd ~/.dotfiles
./install.bash
```

### Decorating

Our last step is to install _special_ tools.

#### rustup

[Install rustup.](https://rustup.rs/)

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

#### fnm

[Install fnm.](https://github.com/Schniz/fnm) Then, install Node.js!

```bash
cargo install fnm

# Set up current shell
eval "$(fnm env)"

# Set up future shells
echo 'eval "$(fnm env)"' >> .zshenv

fnm install --lts
```

### Settling In

#### restic

I use [restic](https://github.com/restic/restic) and [crestic](https://github.com/nils-werner/crestic) to back up my stuff to [Backblaze B2](https://www.backblaze.com/b2/cloud-storage.html).

**You need to export a few shell variables in order for restic/crestic to work correctly.** Add the following lines to `.zshenv` and paste their values from Backblaze or your password manager.

```bash
# Backblaze application key
export B2_ACCOUNT_ID=KEY_ID
export B2_ACCOUNT_KEY=APPLICATION_KEY

# restic repository password
export RESTIC_PASSWORD=PASSWORD
```

## Built With

- [Dotbot](https://github.com/anishathalye/dotbot)
