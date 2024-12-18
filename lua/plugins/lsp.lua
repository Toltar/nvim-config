return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
      {
        "williamboman/mason.nvim"
      },
    },
    config = function()
      require("mason").setup()
      local function has_value (table, val)
        for _, value in ipairs(table) do
          if value == val then
            return true
          end
        end
        return false
      end
      local ensure_language_server_installed = {
        'lua-language-server',
        'angular-language-server',
        'vue-language-server',
        'ansible-language-server',
        'gopls',
        'zls',
        'typescript-language-server',
        'sqlls',
        'rust-analyzer',
        'eslint-lsp',
      }
      local installed_language_servers = {}
      for dir in io.popen([[ls -pa ~/.local/share/nvim/mason/packages]]):lines() do
        if dir ~= './' or dir ~= '../' then
          table.insert(installed_language_servers, dir:sub(1, -2))
          print(dir:sub(1,-2))
        end
      end

      for _, value in ipairs(ensure_language_server_installed) do
        if not has_value(installed_language_servers, value) then
          local command = string.format("MasonInstall %s", value)
          vim.cmd(command)
        end
      end

      require("lspconfig").lua_ls.setup {}
    end
  },
}
