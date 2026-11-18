# Dimidium themes for Herdr

Source: <https://github.com/dofuuz/dimidium> (checked 2026-11-18)

## `dimidium.json` (dark)

- From `main` branch, `config/dimidium-ghostty`
- Matches upstream except `selection`: Herdr has no selection text color,
  so `#8db8e5` (meant for dark `#141414` text) shows light text on light blue

## `dimidium-light.json` (light)

- Upstream: in development, not on `main`
  - `light` branch, commit "Light v0.5 - More darker, contrast..." (2026-11-01)
  - Its `config/*` files still hold the dark palette
  - Colors taken from `preview/tty-preview-nobold.html` CSS on that branch
- Palette swaps black/white: ansi 0 is `#fefefe`, ansi 7 is `#4b4a49`
- `selection` `#c4d9f0` is my own pick (upstream preview defines none)
- Update when upstream releases Light into `config/`
