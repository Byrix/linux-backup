return {

  { -- profile your config to see what code is executed
    'stevearc/profile.nvim',
    enabled = false,
    config = function()
      local should_profile = os.getenv 'NVIM_PROFILE'
      if should_profile then
        require('profile').instrument_autocmds()
        if should_profile:lower():match '^start' then
          require('profile').start '*'
        else
          require('profile').instrument '*'
        end
      end

      local function toggle_profile()
        local prof = require 'profile'
        if prof.is_recording() then
          prof.stop()
          vim.ui.input({ prompt = 'Save profile to:', completion = 'file', default = 'profile.json' }, function(filename)
            if filename then
              prof.export(filename)
              vim.notify(string.format('Wrote %s', filename))
            end
          end)
        else
          prof.start '*'
        end
      end
      vim.keymap.set('', '<f1>', toggle_profile)
    end,
  },
  { 
    'jose-elias-alvarez/null-ls.nvim',
    dependancies = {
      'nvim-lua/plenary.nvim'
    },
  },
  {
    'nvimtools/none-ls.nvim',
    enabled = false,
    event = 'VeryLazy',
    opts = function()
      return require "config.none-ls"
    end,
  },
}
