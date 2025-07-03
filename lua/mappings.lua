require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")


-- Run Cargo keymappings
local function cargo_terminal(cmd)
  vim.cmd("vsplit")                  -- open vertical split
  vim.cmd("terminal")               -- start terminal in the new split
  vim.fn.chansend(vim.b.terminal_job_id, cmd .. "\n")  -- send the cargo command
end

map("n", "<leader>rr", function() cargo_terminal("cargo run") end, { desc = "Cargo Run", silent = true })
map("n", "<leader>rc", function() cargo_terminal("cargo check") end, { desc = "Cargo Check", silent = true })
map("n", "<leader>rl", function() cargo_terminal("cargo clippy") end, { desc = "Cargo Clippy", silent = true })
map("n", "<leader>rb", function() cargo_terminal("cargo build") end, { desc = "Cargo Build", silent = true })
map("n", "<leader>rt", function() cargo_terminal("cargo test") end, { desc = "Cargo Test", silent = true })
map("n", "<leader>rf", function() cargo_terminal("cargo fmt") end, { desc = "Cargo Format", silent = true })
map('n', '<leader>tk', function()
  local bufnr = vim.api.nvim_get_current_buf()
  local chan_id = vim.b.terminal_job_id
  if chan_id then
    vim.fn.jobstop(chan_id) -- Gracefully stop job (sends SIGTERM)
  end
  vim.cmd("bd!") -- Force delete buffer
end, { desc = "Kill terminal and its process" })



-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("n", "<leader>df", vim.diagnostic.open_float, { desc = "Open diagnostic float" })

map(
  "n", 
  "<leader>a", 
  function()
    vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
    -- or vim.lsp.buf.codeAction() if you don't want grouping.
  end,
  { silent = true, }
)
map(
  "n", 
  "K",  -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
  function()
    vim.cmd.RustLsp({'hover', 'actions'})
  end,
  { silent = true, }
)
