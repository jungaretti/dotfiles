# Dotfiles

_Mia Commedia._ Dotfiles, configs, and lists of my stuff that make anywhere feel like `/home`.

## Getting Started

> "Ond’ io per lo tuo me’ penso e discerno che tu mi segui, e io sarò tua guida, e trarrotti di qui per loco etterno" ([Inferno I, 112-114](https://digitaldante.columbia.edu/dante/divine-comedy/inferno/inferno-1/)).

Benvenuti! Are you ready to set up a new macOS or Arch Linux computer for me? Fire up your favorite terminal and let's get started.

### Moving In

First things first, gain access to your data. This will be tough unless you're me. Sign into your password manager and generate a new SSH key using `ssh-keygen`. You'll probably want to share that fresh SSH key with GitHub before cloning any repos.

Pro tip: You can use the [GitHub CLI](https://cli.github.com/manual/) to do that without a browser.

```bash
ssh-keygen -m PEM -t rsa -b 4096
# Check out ~/.ssh/id_rsa.pub

gh auth login -s write:public_key

gh ssh-key add ~/.ssh/id_rsa.pub -t "hostname.domain"
```

Then, clone or move this repo to `~/Repos/.dotfiles`.

```bash
mkdir -p ~/Repos
gh repo clone jungaretti/dotfiles ~/Repos/.dotfiles
```

### Unpacking

Next, install apps and tools using [Homebrew](https://github.com/Homebrew/brew) on macOS and [pacman](https://wiki.archlinux.org/index.php/Pacman) on Arch Linux.

###### macOS

Check out `stuff/macos/README.md`.

###### Arch Linux

Install essential packages with `pacman -Syu base-devel git zsh`. Then, check out `stuff/arch-linux/README.md`.

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
# Script won't overwrite existing files
rm ~/.zshrc

cd ~/Repos/dotfiles
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
