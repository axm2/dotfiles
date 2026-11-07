# dotfiles

Managed with [chezmoi](https://chezmoi.io/).

## Machines

| Machine         | OS      | Notes                                         |
| --------------- | ------- | --------------------------------------------- |
| Personal MacBook | macOS   | fish, rift, alacritty, zed (`work: false`)    |
| Work Mac        | macOS   | fish, rift, alacritty, zed (`work: true`)     |
| axm-pc          | Windows | nushell, helix                                |
| (archived)      | Linux   | bspwm/sxhkd/X setup from the old Void thinkpad |

Templates branch on `.chezmoi.os` and `.work`, never on hostname.
`.chezmoiignore` decides which files each OS gets.

## Setup

macOS / Linux:

```sh
brew install chezmoi   # or: sh -c "$(curl -fsLS get.chezmoi.io)"
chezmoi init --branch chezmoi axm2/dotfiles
chezmoi diff           # review before applying
chezmoi apply
```

Windows:

```powershell
winget install twpayne.chezmoi
chezmoi init --branch chezmoi axm2/dotfiles
chezmoi diff
chezmoi apply
```

`chezmoi init` asks for git name/email and (on macOS) whether it's a work
machine. Answers live in `~/.config/chezmoi/chezmoi.yaml`; re-ask with
`chezmoi init --data=false`.

Fish plugins are listed in `fish_plugins` and installed by
`.chezmoiscripts/run_onchange_after_fisher-update.sh.tmpl`.

## License

MIT
