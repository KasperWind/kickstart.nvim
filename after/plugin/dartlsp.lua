local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>fc', require('telescope').extensions.flutter.commands,'[F]lutter [C]ommands')

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

require("flutter-tools").setup{
  lsp = {
    color = { -- show the derived colours for dart variables
      enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
      background = false, -- highlight the background
      foreground = false, -- highlight the foreground
      virtual_text = true, -- show the highlight using virtual text
      virtual_text_str = "■", -- the virtual text character to highlight
    },
    on_attach = on_attach,
  }
} 

require("telescope").load_extension("flutter")

-- Neccessary until mason supprts dart
--
---- LSP settings.
----  This function gets run when an LSP connects to a particular buffer.
--  --
--local on_attach = function(_, bufnr)
--  -- NOTE: Remember that lua is a real programming language, and as such it is possible
--  -- to define small helper and utility functions so you don't have to repeat yourself
--  -- many times.
--  -- In this case, we create a function that lets us more easily define mappings specific
--  -- for LSP related items. It sets the mode, buffer and description for us each time.
--  local nmap = function(keys, func, desc)
--    if desc then
--      desc = 'LSP: ' .. desc
--    end
--
--    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
--  end
--
--  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
--  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
--
--  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
--  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
--  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
--  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
--  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
--  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
--
--  -- See `:help K` for why this keymap
--  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
--  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
--
--  -- Lesser used LSP functionality
--  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
--  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
--  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
--  nmap('<leader>wl', function()
--    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--  end, '[W]orkspace [L]ist Folders')
--
--  -- Create a command `:Format` local to the LSP buffer
--  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
--    vim.lsp.buf.format()
--  end, { desc = 'Format current buffer with LSP' })
--end
--
---- nvim-cmp supports additional completion capabilities, so broadcast that to servers
--local capabilities = vim.lsp.protocol.make_client_capabilities()
--capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
--
--require 'lspconfig'.dartls.setup {
--  capabilities = capabilities,
--  on_attach = on_attach,
--  settings = {
--    dart = {
--      lineLength = 120,
--      enableSnippets = true,
--    }
--  }
--}
