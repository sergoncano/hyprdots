-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'xiyaowong/transparent.nvim'
  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
                            , branch = '0.1.x',
  	requires = { {'nvim-lua/plenary.nvim'} }
	}
  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        require("nvim-autopairs").setup {}
    end
  }

  -- Lazy loading:
  -- Load on specific commands
  -- use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

  -- Load on an autocommand event
  -- use {'andymass/vim-matchup', event = 'VimEnter'}

  -- Load on a combination of conditions: specific filetypes or commands
  -- Also run code after load (see the "config" key)

  -- Plugins can have dependencies on other plugins

  -- Plugins can also depend on rocks from luarocks.org:

  -- You can specify rocks in isolation


  -- You can alias plugin names
end)
