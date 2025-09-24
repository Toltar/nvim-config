vim.api.nvim_create_autocmd('FileType', {
  pattern = 'java',
  callback = function(args)
    local jdtls = require('jdtls')
    local jdtls_dap = require("jdtls.dap")
    local jdtls_setup = require("jdtls.setup")
    local home = os.getenv("HOME")
    local path_to_mason_packages = home .. "/.local/share/nvim/mason/packages"

    local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
    local root_dir = jdtls_setup.find_root(root_markers)

    local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
    local workspace_dir = home .. "/.cache/jdtls/workspace" .. project_name

    local path_to_jdtls = path_to_mason_packages .. "/jdtls"
    local path_to_jdebug = path_to_mason_packages .. "/java-debug-adapter"
    local path_to_jtest = path_to_mason_packages .. "/java-test"

    local path_to_config = path_to_jdtls .. "/config_mac_arm"
    local lombok_path = path_to_jdtls .. "/lombok.jar"

    local path_to_jar = path_to_jdtls .. "/plugins/org.eclipse.equinox.launcher_1.7.0.v20250519-0528.jar"

    local bundles = {
      vim.fn.glob(path_to_jdebug .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", true),
    }
    vim.list_extend(bundles, vim.split(vim.fn.glob(path_to_jtest .. "/extension/server/*.jar", true), "\n"))
    local javaPath = home .. '/.sdkman/candidates/java/21.0.8-amzn/bin/java'
    local config = {
				-- The command that starts the language server
				-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
				cmd = {

					-- 💀
					javaPath, -- or '/path/to/java17_or_newer/bin/java'
					-- depends on if `java` is in your $PATH env variable and if it points to the right version.

					"-Declipse.application=org.eclipse.jdt.ls.core.id1",
					"-Dosgi.bundles.defaultStartLevel=4",
					"-Declipse.product=org.eclipse.jdt.ls.core.product",
					"-Dlog.protocol=true",
					"-Dlog.level=ALL",
					"-Xmx1g",
					"--add-modules=ALL-SYSTEM",
					"--add-opens",
					"java.base/java.util=ALL-UNNAMED",
					"--add-opens",
					"java.base/java.lang=ALL-UNNAMED",

					-- 💀
					"-jar",
					path_to_jar,
					-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
					-- Must point to the                                                     Change this to
					-- eclipse.jdt.ls installation                                           the actual version

					-- 💀
					"-configuration",
          path_to_config,
					-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
					-- Must point to the                      Change to one of `linux`, `win` or `mac`
					-- eclipse.jdt.ls installation            Depending on your system.

					-- 💀
					-- See `data directory configuration` section in the README
					"-data",
					workspace_dir,
				},
        root_dir = root_dir,
        settings = {
          java = {}
        },
        init_options = {
          bundles = {},
        },
    }
    jdtls.start_or_attach(config)
  end
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('matt-lsp-attach', { clear = true }),
  callback = function(event)
    print("LSP has attached itself")
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- Jump to the definition of the word under your cursor.
    --  This is where a variable was first declared, or where a function is defined, etc.
    --  To jump back, press <C-t>.
    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

    -- Find references for the word under your cursor.
    map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

    -- Jump to the implementation of the word under your cursor.
    --  Useful when your language has ways of declaring types without an actual implementation.
    map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

    -- Jump to the type of the word under your cursor.
    --  Useful when you're not sure what type a variable is and you want to see
    --  the definition of its *type*, not where it was *defined*.
    map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

    -- Fuzzy find all the symbols in your current document.
    --  Symbols are things like variables, functions, types, etc.
    map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

    -- Fuzzy find all the symbols in your current workspace.
    --  Similar to document symbols, except searches over your entire project.
    map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- Rename the variable under your cursor.
    --  Most Language Servers support renaming across files, etc.
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

    -- Execute a code action, usually your cursor needs to be on top of an error
    -- or a suggestion from your LSP for this to activate.
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local highlight_augroup = vim.api.nvim_create_augroup('matt-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
        end,
      })
    end
  end,
})
