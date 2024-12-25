# Dotfiles

Dotfiles that make anywhere feel like `/home`.

> "Ond’ io per lo tuo me’ penso e discerno che tu mi segui, e io sarò tua guida, e trarrotti di qui per loco etterno" ([Inferno I, 112-114](https://digitaldante.columbia.edu/dante/divine-comedy/inferno/inferno-1/)).

## Prerequisites

Are you ready to set up a new computer for me? Fire up your favorite terminal and let's get started!

### Install Homebrew

On macOS, [install Homebrew](https://brew.sh/).

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Then, add Oh My Zsh to `~/.zprofile`.

```
# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### Install Oh My Zsh

Install Zsh and [Oh My Zsh](https://ohmyz.sh/).

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

If needed, change the default shell to Zsh.

```
sudo chsh -s /bin/zsh "$USER"
```

### Generate SSH Key

Use `ssh-keygen` to generate a new SSH key.

```sh
# Set to username@hostname[.home|work]
read KEY_COMMENT

ssh-keygen -o -a 256 -t ed25519 -C "$KEY_COMMENT"
```

#### Add SSH Key to GitHub

You must add the new SSH key to GitHub in order to clone this repository. Visit https://github.com/settings/keys or use the [GitHub CLI](https://cli.github.com/manual/) to add the key.

```sh
# Don't add your SSH key yet!
gh auth login -s write:public_key

gh ssh-key add ~/.ssh/id_ed25519.pub --title "$KEY_COMMENT"
```

## Install (these) Dotfiles

Clone this repo and install my dotfiles using `./install.sh`.

```sh
git clone git@github.com:jungaretti/dotfiles.git

cd dotfiles
./install.sh
```

## Install (other) Stuff

Install developer tools with custom installers. Then, see [jungaretti/stuff](https://github.com/jungaretti/stuff) to install all of my apps and tools.

### rustup

Install [`rustup`](https://rustup.rs/).

```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Then, add Rustup to `~/.zprofile`.

```sh
# rustup
. "$HOME/.cargo/env"
```

### fnm

Install [fnm](https://github.com/Schniz/fnm?tab=readme-ov-file#installation).

```sh
curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
```

Then, add fnm to `~/.zprofile`.

```sh
# fnm
eval "$(fnm env --use-on-cd --shell zsh)"
```

### pyenv

Install [pyenv](https://github.com/pyenv/pyenv?tab=readme-ov-file#installation).

```sh
brew install pyenv
```

Then, add pyenv to `~/.zprofile`.

```sh
# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
```

## Configure Backups

I use [restic](https://github.com/restic/restic) and [crestic](https://github.com/nils-werner/crestic) to back up my data to [Backblaze B2](https://www.backblaze.com/b2/cloud-storage.html).

```sh
sudo cp ./src/crestic/crestic.py /usr/local/bin/crestic
```

### Create Storage Bucket

Log into [Backblaze](https://secure.backblaze.com/b2_buckets.htm) and [create a new storage bucket](https://www.backblaze.com/docs/cloud-storage-create-and-manage-buckets#create-a-bucket).

### Generate Application Key

Next, generate a [new application key](https://secure.backblaze.com/app_keys.htm) for the new storage bucket.

Then, add the following lines to `~/.zshenv` and paste their values from Backblaze.

```sh
# Backblaze application key
export B2_ACCOUNT_ID=KEY_ID
export B2_ACCOUNT_KEY=APPLICATION_KEY
```

### Generate Repository Password

Generate a new repository password. Then, create a `<host>.password.txt` file in `~/.config/restic/`.

### Add Configuration to Crestic

Add new `b2` and `nas` configurations to [`src/crestic/config.cfg`](src/crestic/config.cfg) for the new computer.

```
[HOSTNAME@]
password-file: ~/.config/restic/HOSTNAME.password.txt

[HOSTNAME@b2]
repo: b2:restic-HOSTNAME:HOSTNAME.restic

[HOSTNAME@nas]
repo: /Volumes/Venus/HOSTNAME.restic

[HOSTNAME@.backup]
host: HOSTNAME
_arguments: /Users/jungaretti
```

### Initialize Repository

Initialize new `b2` and `nas` repositories.

```
blackbird@b2 init
blackbird@nas init
```
