# Dotfiles

Dotfiles that make anywhere feel like `/home`.

## Setting Up Shop

> "Ond’ io per lo tuo me’ penso e discerno che tu mi segui, e io sarò tua guida, e trarrotti di qui per loco etterno" ([Inferno I, 112-114](https://digitaldante.columbia.edu/dante/divine-comedy/inferno/inferno-1/)).

Are you ready to set up a new computer for me? Fire up your favorite terminal and let's get started!

### Generate SSH Key

Generate a new SSH key using `ssh-keygen` and share it with GitHub. You can use the [GitHub CLI](https://cli.github.com/manual/) to do that without a browser.

```sh
# Name the new SSH key
KEY_LOGIN='<login>'
KEY_HOST='<hostname>.<home|work>'

# Generate a new Ed25519 key
ssh-keygen -o -a 256 -t ed25519 -C "$KEY_LOGIN@$KEY_HOST"

# Don't add your SSH key yet!
gh auth login -s write:public_key -s codespace

# Add your SSH key with a title
gh ssh-key add ~/.ssh/id_ed25519.pub --title "$KEY_HOST"
```

### Install Oh My Zsh

Install Zsh and [Oh My Zsh](https://ohmyz.sh/).

```sh
gh repo clone ohmyzsh/ohmyzsh
./ohmyzsh/tools/install.sh

# Using sudo without a password?
sudo chsh -s /bin/zsh jungaretti
```

### Install (These) Dotfiles

Clone this repo and install my dotfiles using `./install`. I use [Dotbot](https://github.com/anishathalye/dotbot) to manage my dotfiles. It's an elegant and simple solution that works well for me.

```sh
gh repo clone jungaretti/dotfiles
./dotfiles/install
```

### Install Apps and Tools

Install tools with custom installers:

- [rustup](https://rustup.rs/)
- [fnm](https://github.com/Schniz/fnm)

Next, check out my platform-specific repos to install all of my apps and tools:

- [jungaretti/stuff-macos](https://github.com/jungaretti/stuff-macos)
- [jungaretti/stuff-windows](https://github.com/jungaretti/stuff-windows)
- [jungaretti/stuff-archlinux](https://github.com/jungaretti/stuff-archlinux)

### Configure B2 Backups

I use [restic](https://github.com/restic/restic) and [crestic](https://github.com/nils-werner/crestic) to back up my data to [Backblaze B2](https://www.backblaze.com/b2/cloud-storage.html).

Log into Backblaze to create a new storage bucket and generate a new application key. Then, add the following lines to `~/.zshenv` and paste their values from Backblaze.

```sh
# Backblaze application key
export B2_ACCOUNT_ID=KEY_ID
export B2_ACCOUNT_KEY=APPLICATION_KEY

# restic repository password
export RESTIC_PASSWORD=PASSWORD
```

## Notes

- I use MaterialDark from https://github.com/mbadolato/iTerm2-Color-Schemes.

## Built With

- [Dotbot](https://github.com/anishathalye/dotbot)
