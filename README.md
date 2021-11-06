# Dotfiles

Dotfiles, configs, and lists that make anywhere feel like `/home`.

## Getting Started

> "Ond’ io per lo tuo me’ penso e discerno che tu mi segui, e io sarò tua guida, e trarrotti di qui per loco etterno" ([Inferno I, 112-114](https://digitaldante.columbia.edu/dante/divine-comedy/inferno/inferno-1/)).

Are you ready to set up a new computer for me? Fire up your favorite terminal and let's get started!

### First Things First

Generate a new SSH key using `ssh-keygen`. You'll probably want to share this key with GitHub before cloning any repos. (You can use the [GitHub CLI](https://cli.github.com/manual/) to do that without a browser.) **Do not grant access to corporate organizations on personal devices.**

```sh
ssh-keygen -m PEM -t rsa -b 4096
# Check out ~/.ssh/id_rsa.pub

# You can't name the SSH key if you add it here
gh auth login -s write:public_key

gh ssh-key add ~/.ssh/id_rsa.pub -t "hostname.domain"
```

Next, clone this repo!

```sh
mkdir -p ~/Repos
gh repo clone jungaretti/dotfiles ~/Repos/dotfiles
```

### Installing Your Stuff

| Platform   | Tool                                                                | Stuff              |
| ---------- | ------------------------------------------------------------------- | ------------------ |
| Arch Linux | [pacman](https://wiki.archlinux.org/index.php/Pacman)               | `stuff/arch-linux` |
| macOS      | [brew](https://github.com/Homebrew/brew)                            | `stuff/macos`      |
| Windows    | [winget](https://docs.microsoft.com/en-us/windows/package-manager/) | `stuff/windows`    |

#### zsh

[Install Oh My Zsh.](https://ohmyz.sh/) It's not my favorite, but it gets the job done.

```sh
gh repo clone ohmyzsh/ohmyzsh
cd ohmyzsh
./tools/install.sh

# Use chsh if you're using The Cloud™ or don't have a user password
sudo chsh -s /bin/zsh jungaretti
```

#### dotfiles

Configure dotfiles from this repo using `./install` or `.\install.ps1`. I use Dotbot to manage my dotfiles; it's an elegant and simple solution that works well for me.

### Wrapping Up

Be sure to install tools that use custom installers.

| Tool   | Instructions                  |
| ------ | ----------------------------- |
| rustup | https://rustup.rs/            |
| fnm    | https://github.com/Schniz/fnm |

#### Backing Up to B2

I use [restic](https://github.com/restic/restic) and [crestic](https://github.com/nils-werner/crestic) to back up my stuff to [Backblaze B2](https://www.backblaze.com/b2/cloud-storage.html).

**You need to export a few shell variables in order for this stack to work correctly.** Add the following lines to `.zshenv` and paste their values from Backblaze or your password manager.

```sh
# Backblaze application key
export B2_ACCOUNT_ID=KEY_ID
export B2_ACCOUNT_KEY=APPLICATION_KEY

# restic repository password
export RESTIC_PASSWORD=PASSWORD
```

## Built With

- [Dotbot](https://github.com/anishathalye/dotbot)
