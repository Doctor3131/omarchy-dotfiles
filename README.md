# Omarchy Dotfiles

Dotfiles untuk setup [Omarchy 4.0](https://omarchy.org/) (Hyprland di Arch Linux) milik [@Doctor3131](https://github.com/Doctor3131/omarchy-dotfiles). Repo ini di-clone langsung di `~/.config` dengan strategi `ignore-all + un-ignore` — hanya file/folder yang di-whitelist di `.gitignore` yang di-track.

> **Remote:** `git@github.com:Doctor3131/omarchy-dotfiles.git` — branch `main`

## Struktur Repo

```
~/.config/
├── .gitignore                  # whitelist: hanya file/folder di bawah yang di-track
├── .zshrc                      # zsh + aliases + fungsi kustom
├── .vimrc                      # vim minimal (commentary, indent 4)
├── README.md                   # dokumen ini
├── alacritty/
│   └── alacritty.toml          # terminal Alacritty (opacity, font, keybinds)
├── ghostty/                    # config Ghostty (di-track, kosong/opsional)
├── hypr/
│   ├── hyprland.lua            # entry point Hyprland (load Omarchy defaults + override)
│   ├── monitors.lua            # placeholder - monitor real ada di hyprmoncfg-monitors.lua
│   ├── hyprmoncfg-monitors.lua # GENERATED oleh hyprmoncfg (jangan edit manual)
│   ├── input.lua               # input & touchpad overrides
│   ├── looknfeel.lua           # decoration (rounding, dim_inactive)
│   ├── bindings.lua            # keybindings personal
│   └── autostart.lua           # autostart apps
├── nvim/
│   └── lazy-lock.json          # lock file LazyVim / plugin versions
├── wallpaper/                  # koleksi wallpaper
└── zed/                        # config Zed editor
```

### File yang di-track (whitelist `.gitignore`)

| Pattern | Keterangan |
|---------|------------|
| `!.zshrc`, `!.vimrc`, `!.gitignore`, `!README.md` | file dot root |
| `!nvim/**`, `!zed/**`, `!alacritty/**`, `!ghostty/**`, `!hypr/**`, `!wallpaper/**` | folder yang di-sync |

Semua file lain di `~/.config` (mis. `Code/`, `BraveSoftware/`, `obsidian/` dll) di-ignore.

## Prasyarat

- Arch Linux + Omarchy 4.0
- Hyprland, `hyprmoncfg` / `nwg-displays` untuk manajemen monitor
- `alacritty`, `zsh` + `powerlevel10k`, `eza`, `zoxide`, `fzf`, `tmux`
- Neovim + LazyVim (untuk `nvim/lazy-lock.json`)

## Instalasi

```bash
# backup config lama (jika ada)
mv ~/.config ~/.config.bak

# clone
git clone git@github.com:Doctor3131/omarchy-dotfiles.git ~/.config
cd ~/.config

# cek whitelist
git status

# install deps Omarchy (jika fresh install)
# ikuti panduan https://omarchy.org/install
```

> Repo ini menggunakan `*` di `.gitignore`, jadi `git add .` hanya akan menambahkan file yang di-whitelist.

## Kustomisasi Utama

### 1. Zsh (`.zshrc`)

Aliases dikelompokkan per section (`t1`..`t16` + `endt*`) agar `show` (`grep -E '^(alias|alias t[0-8]=|alias endt[0-8]=)' ~/.zshrc`) tampil rapi.

- **Compilation & execution** — `com1`, `cr1`, `run1` (gcc/python/manim)
- **File utils** — `rmo`, `la`/`ls`/`ll`/`lt` via `eza`, `cdl`/`lsd`
- **Git** — `gst`, `ga`, `gcm`, `gcam`, `glogp` dll
- **Tools** — `ytd` (yt-dlp mp3), `gdownh`, `fzf` hints, `tmux` (`ts`, `create`/`get`)
- **Toggle transparency** — `toggle` / `toggletransparency` (sed `opacity` di `alacritty.toml`)
- **Port info (baru)** — `portinfo` / `t16`:
  ```zsh
  portinfo
  # PORT     | PID      | APP_PATH
  # 3000     | 12345    | /home/sirifari/project/app
  ```
  Menggunakan `ss -tlnp` + `pwdx` untuk mapping `port → pid → path`.

Path tambahan: `~/.local/bin`, `~/.cargo/bin`, `~/.config/composer/vendor/bin`, `~/.opencode/bin`, `~/.spicetify`, `anaconda3`.

### 2. Alacritty (`alacritty/alacritty.toml`)

- Font: `JetBrainsMono Nerd Font` size 12
- `opacity = 0.9` (sebelumnya 0.8), `decorations = "None"`, padding 0
- Keybinds: `Shift+Insert` paste, `Ctrl+Insert` copy, CSI-u untuk `Shift+Enter` / `Alt+Shift+Enter` (kompatibel tmux/TUI)

Toggle via:
```bash
toggle  # 0.8 <-> 1.0
```

### 3. Hyprland (`hypr/*.lua`)

Semua file lua di-load setelah `default.hypr.omarchy` sehingga override aman terhadap update Omarchy.

- **`hyprland.lua`** — entry point; baris terakhir `dofile(.../hyprmoncfg-monitors.lua)` memastikan rule monitor dari `hyprmoncfg` selalu load paling akhir (tidak bisa di-override sebelumnya).
- **`monitors.lua`** — sekarang hanya placeholder/comment. Rule asli dipindah ke `hyprmoncfg-monitors.lua` agar `hyprmoncfg` tidak overwrite kustomisasi manual.
- **`hyprmoncfg-monitors.lua`** (generated):
  ```lua
  hl.monitor({ output = "desc:SKYDATA S.P.A. H24G30Q", mode = "2560x1440@120.00", position = "1440x0", scale = 1.25 })
  hl.monitor({ output = "desc:Samsung Display Corp. 0x4154", disabled = true })
  ```
  → external 2K 120Hz sebagai primary, layar laptop disabled.
- **`input.lua`** — touchpad diaktifkan:
  - `natural_scroll = true`, `clickfinger_behavior = true`, `scroll_factor = 0.4`, `disable_while_typing = false`, `drag_3fg = 1`
  - `sensitivity = 0.8`, `kb_options = "compose:ralt"`
  - gesture 3 jari up/down untuk `omarchy-shell mirador`
- **`looknfeel.lua`** — decoration aktif:
  - `rounding = 10`, `dim_inactive = true`, `dim_strength = 0.15`

### 4. Neovim (`nvim/lazy-lock.json`)

Lock file LazyVim — update terbaru (di commit ini):
`SchemaStore`, `kulala`, `mason-lspconfig`, `nui`, `nvim-lint`, `nvim-lspconfig`, `nvim-treesitter`, `opencode.nvim`, `solarized-osaka`, `telescope` dll. Jalankan `:Lazy sync` setelah pull.

### 5. Vim (`.vimrc`)

Minimal: `number` + `relativenumber`, `tabstop=4`, `expandtab`, plus `commentary.vim` inline (`gc`/`gcc`).

## Perubahan di Commit Ini

Commit ini mengkonsolidasikan beberapa tweak yang sebelumnya belum di-commit:

| File | Perubahan |
|------|-----------|
| `.zshrc` | + fungsi `portinfo()` & alias `t16`/`endt16` (tabel PORT\|PID\|APP_PATH) |
| `alacritty/alacritty.toml` | `opacity 0.8 → 0.9` |
| `hypr/hyprland.lua` | + `dofile(...hyprmoncfg-monitors.lua)` di akhir |
| `hypr/input.lua` | uncomment & aktifkan blok `touchpad` |
| `hypr/looknfeel.lua` | uncomment & aktifkan `decoration` (rounding 10, dim) |
| `hypr/monitors.lua` | jadi placeholder, rule dipindah |
| `hypr/hyprmoncfg-monitors.lua` | **file baru** (generated hyprmoncfg) |
| `nvim/lazy-lock.json` | bump 12 plugin |

Lihat diff lengkap: `git show` setelah pull.

## Perintah Git yang Direkomendasikan

Repo ini ada di `~/.config`, jadi hati-hati dengan `git add .`:

```bash
cd ~/.config
git status
git diff
git add .zshrc alacritty/alacritty.toml hypr/ nvim/lazy-lock.json README.md .gitignore
git commit -m "pesan commit"
git push
```

Alias yang sudah ada di `.zshrc`: `gst`, `ga`, `gcm`, `gcam`, `gp`, `gl`.

## Catatan

- `hyprmoncfg-monitors.lua` bersifat generated — edit via `hyprmoncfg` atau `nwg-displays`, jangan manual.
- Jika wallpaper tidak muncul, cek `wallpaper/` sudah ter-track dan path di Hyprland benar.
- Untuk menambah file/folder baru ke versioning, tambahkan rule `!nama/` di `.gitignore`.

## Lisensi

Dotfiles pribadi — bebas di-fork untuk penggunaan personal.
