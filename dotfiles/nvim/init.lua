-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("oil").setup({
  view_options = {
    show_hidden = true, -- Show hidden files
    show_icons = true, -- Show icons
  },
  buffer_options = {
    -- Options for the buffer
    buflisted = false, -- Make the buffer listed
    swapfile = false, -- Disable swap files
    bufhidden = "hide",
  },
})
