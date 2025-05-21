# lualine-harpoon.nvim

![](assets/img/2025-05-21_12-16-25.webp)

A tiny [Lualine](https://github.com/nvim-lualine/lualine.nvim) component for
[ThePrimeagen/harpoon2](https://github.com/ThePrimeagen/harpoon).
Displays your current Harpoon mark as `[x/y]` in your statusline.

## Requirements

- Neovim 0.8+
- [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- [ThePrimeagen/harpoon](https://github.com/ThePrimeagen/harpoon) (harpoon2 branch)
- [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim)

> [!IMPORTANT]  
> Make sure to install [harpoon2](https://github.com/ThePrimeagen/harpoon/tree/harpoon2), not harpoon on `master` branch.

## Installation

### Using lazy.nvim

```lua
{
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "kristoferssolo/lualine-harpoon.nvim",
    dependencies = {
      { "ThePrimeagen/harpoon", branch = "harpoon2" }
      "nvim-lua/plenary.nvim",
    },
  },
}
```

## Basic Usage

Once installed, simply add `"harpoon"` to your `lualine.setup` sections.  
Lualine will auto-load `lua/lualine/components/harpoon.lua` for you:

```lua
require("lualine").setup({
  sections = {
    lualine_c = {
      "harpoon",
    },
  },
})
```

When you have Harpoon marks, you’ll see an indicator like `[2/5]` in your statusline.

## Default Options

You can pass options directly in your Lualine sections:

```lua
require("lualine").setup({
  sections = {
    lualine_c = {
      {
        "harpoon",
        symbol = {
          open = "[",
          close = "]",
          separator = "/",
          unknown = "?",
        },
        icon = "󰀱",
      },
    },
  },
})
```

## Acknowledgments and alternatives

This plugin was inspired by and serves as an alternative to [letieu/harpoon-lualine](https://github.com/letieu/harpoon-lualine).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
