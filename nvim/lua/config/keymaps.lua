-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- required in which-key plugin spec in plugins/ui.lua as `require 'config.keymap'`
local wk = require("which-key")
local ms = vim.lsp.protocol.Methods

local runner = require("quarto.runner")
vim.keymap.set("n", "<localleader>rc", runner.run_cell, { desc = "run cell", silent = true })
vim.keymap.set("n", "<localleader>ra", runner.run_above, { desc = "run cell and above", silent = true })
vim.keymap.set("n", "<localleader>rA", runner.run_all, { desc = "run all cells", silent = true })
vim.keymap.set("n", "<localleader>rl", runner.run_line, { desc = "run line", silent = true })
vim.keymap.set("v", "<localleader>r", runner.run_range, { desc = "run visual range", silent = true })
vim.keymap.set("n", "<localleader>RA", function()
  runner.run_all(true)
end, { desc = "run all cells of all languages", silent = true })

local nmap = function(key, effect)
  vim.keymap.set("n", key, effect, { silent = true, noremap = true })
end

local vmap = function(key, effect)
  vim.keymap.set("v", key, effect, { silent = true, noremap = true })
end

local imap = function(key, effect)
  vim.keymap.set("i", key, effect, { silent = true, noremap = true })
end

local cmap = function(key, effect)
  vim.keymap.set("c", key, effect, { silent = true, noremap = true })
end

local function send_cell()
  if vim.b["quarto_is_r_mode"] == nil then
    vim.fn["slime#send_cell"]()
    return
  end
  if vim.b["quarto_is_r_mode"] == true then
    vim.g.slime_python_ipython = 0
    local is_python = require("otter.tools.functions").is_otter_language_context("python")
    if is_python and not vim.b["reticulate_running"] then
      vim.fn["slime#send"]("reticulate::repl_python()" .. "\r")
      vim.b["reticulate_running"] = true
    end
    if not is_python and vim.b["reticulate_running"] then
      vim.fn["slime#send"]("exit" .. "\r")
      vim.b["reticulate_running"] = false
    end
    vim.fn["slime#send_cell"]()
  end
end

--- Send code to terminal with vim-slime
--- If an R terminal has been opend, this is in r_mode
--- and will handle python code via reticulate when sent
--- from a python chunk.
local slime_send_region_cmd = ":<C-u>call slime#send_op(visualmode(), 1)<CR>"
slime_send_region_cmd = vim.api.nvim_replace_termcodes(slime_send_region_cmd, true, false, true)
local function send_region()
  -- if filetyps is not quarto, just send_region
  if vim.bo.filetype ~= "quarto" or vim.b["quarto_is_r_mode"] == nil then
    vim.cmd("normal" .. slime_send_region_cmd)
    return
  end
  if vim.b["quarto_is_r_mode"] == true then
    vim.g.slime_python_ipython = 0
    local is_python = require("otter.tools.functions").is_otter_language_context("python")
    if is_python and not vim.b["reticulate_running"] then
      vim.fn["slime#send"]("reticulate::repl_python()" .. "\r")
      vim.b["reticulate_running"] = true
    end
    if not is_python and vim.b["reticulate_running"] then
      vim.fn["slime#send"]("exit" .. "\r")
      vim.b["reticulate_running"] = false
    end
    vim.cmd("normal" .. slime_send_region_cmd)
  end
end

-- send code with ctrl+Enter
-- just like in e.g. RStudio
-- needs kitty (or other terminal) config:
-- map shift+enter send_text all \x1b[13;2u
-- map ctrl+enter send_text all \x1b[13;5u
nmap("<c-cr>", send_cell)
nmap("<s-cr>", send_cell)
imap("<c-cr>", send_cell)
imap("<s-cr>", send_cell)

--- Show R dataframe in the browser
-- might not use what you think should be your default web browser
-- because it is a plain html file, not a link
-- see https://askubuntu.com/a/864698 for places to look for
local function show_r_table()
  local node = vim.treesitter.get_node({ ignore_injections = false })
  assert(node, "no symbol found under cursor")
  local text = vim.treesitter.get_node_text(node, 0)
  local cmd = [[call slime#send("DT::datatable(]] .. text .. [[)" . "\r")]]
  vim.cmd(cmd)
end

local is_code_chunk = function()
  local current, _ = require("otter.keeper").get_current_language_context()
  if current then
    return true
  else
    return false
  end
end

--- Insert code chunk of given language
--- Splits current chunk if already within a chunk
--- @param lang string
local insert_code_chunk = function(lang)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "n", true)
  local keys
  if is_code_chunk() then
    keys = [[o```<cr><cr>```{]] .. lang .. [[}<esc>o]]
  else
    keys = [[o```{]] .. lang .. [[}<cr>```<esc>O]]
  end
  keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
end

local insert_r_chunk = function()
  insert_code_chunk("r")
end

local insert_py_chunk = function()
  insert_code_chunk("python")
end

local insert_lua_chunk = function()
  insert_code_chunk("lua")
end

local insert_julia_chunk = function()
  insert_code_chunk("julia")
end

local insert_bash_chunk = function()
  insert_code_chunk("bash")
end

local insert_ojs_chunk = function()
  insert_code_chunk("ojs")
end

--show kepbindings with whichkey
--add your own here if you want them to
--show up in the popup as well

-- normal mode
wk.add({
  { "<cm-i>", insert_py_chunk, desc = "python code chunk" },
  { "<m-i>", insert_py_chunk, desc = "python code chunk" },
  { "<m-I>", insert_r_chunk, desc = "r code chunk" },
  { "[q", ":silent cprev<cr>", desc = "[q]uickfix prev" },
  { "]q", ":silent cnext<cr>", desc = "[q]uickfix next" },
}, { mode = "n", silent = true })

-- visual mode
wk.add({
  {
    mode = { "v" },
    { "<cr>", send_region, desc = "run code region" },
  },
})

-- insert mode
wk.add({
  {
    mode = { "i" },
    { "<c-x><c-x>", "<c-x><c-o>", desc = "omnifunc completion" },
    { "<cm-i>", insert_py_chunk, desc = "python code chunk" },
    { "<m-->", " <- ", desc = "assign" },
    { "<m-i>", insert_py_chunk, desc = "python code chunk" },
    { "<m-I>", insert_r_chunk, desc = "r code chunk" },
    { "<m-m>", " |>", desc = "pipe" },
  },
}, { mode = "i" })

local function new_terminal(lang)
  vim.cmd("vsplit term://" .. lang)
end

local function new_terminal_python()
  new_terminal("python")
end

local function new_terminal_r()
  new_terminal("R --no-save")
end

local function new_terminal_ipython()
  new_terminal("ipython --no-confirm-exit")
end

local function new_terminal_julia()
  new_terminal("julia")
end

local function new_terminal_shell()
  new_terminal("$SHELL")
end

local function get_otter_symbols_lang()
  local otterkeeper = require("otter.keeper")
  local main_nr = vim.api.nvim_get_current_buf()
  local langs = {}
  for i, l in ipairs(otterkeeper.rafts[main_nr].languages) do
    langs[i] = i .. ": " .. l
  end
  -- promt to choose one of langs
  local i = vim.fn.inputlist(langs)
  local lang = otterkeeper.rafts[main_nr].languages[i]
  local params = {
    textDocument = vim.lsp.util.make_text_document_params(),
    otter = {
      lang = lang,
    },
  }
  -- don't pass a handler, as we want otter to use it's own handlers
  vim.lsp.buf_request(main_nr, ms.textDocument_documentSymbol, params, nil)
end

vim.keymap.set("n", "<leader>os", get_otter_symbols_lang, { desc = "otter [s]ymbols" })

-- normal mode with <leader>
wk.add({
  {
    { "<leader><cr>", send_cell, desc = "run code cell" },
    { "<leader>c", group = "[c]ode / [c]ell / [c]hunk" },
    { "<leader>ci", new_terminal_ipython, desc = "new [i]python terminal" },
    { "<leader>cj", new_terminal_julia, desc = "new [j]ulia terminal" },
    { "<leader>cn", new_terminal_shell, desc = "[n]ew terminal with shell" },
    { "<leader>cp", new_terminal_python, desc = "new [p]ython terminal" },
    { "<leader>cr", new_terminal_r, desc = "new [R] terminal" },
    { "<leader>ht", group = "[t]reesitter" },
    { "<leader>htt", vim.treesitter.inspect_tree, desc = "show [t]ree" },
    { "<leader>l", group = "[l]anguage/lsp" },
    { "<leader>la", vim.lsp.buf.code_action, desc = "code [a]ction" },
    { "<leader>ld", group = "[d]iagnostics" },
    {
      "<leader>ldd",
      function()
        vim.diagnostic.enable(false)
      end,
      desc = "[d]isable",
    },
    { "<leader>lde", vim.diagnostic.enable, desc = "[e]nable" },
    { "<leader>le", vim.diagnostic.open_float, desc = "diagnostics (show hover [e]rror)" },
    { "<leader>lg", ":Neogen<cr>", desc = "neo[g]en docstring" },
    { "<leader>o", group = "[o]tter & c[o]de" },
    { "<leader>oa", require("otter").activate, desc = "otter [a]ctivate" },
    { "<leader>ob", insert_bash_chunk, desc = "[b]ash code chunk" },
    { "<leader>oc", "O# %%<cr>", desc = "magic [c]omment code chunk # %%" },
    { "<leader>od", require("otter").activate, desc = "otter [d]eactivate" },
    { "<leader>oj", insert_julia_chunk, desc = "[j]ulia code chunk" },
    { "<leader>ol", insert_lua_chunk, desc = "[l]lua code chunk" },
    { "<leader>oo", insert_ojs_chunk, desc = "[o]bservable js code chunk" },
    { "<leader>op", insert_py_chunk, desc = "[p]ython code chunk" },
    { "<leader>or", insert_r_chunk, desc = "[r] code chunk" },
    { "<leader>q", group = "[q]uarto" },
    {
      "<leader>qE",
      function()
        require("otter").export(true)
      end,
      desc = "[E]xport with overwrite",
    },
    { "<leader>qa", ":QuartoActivate<cr>", desc = "[a]ctivate" },
    { "<leader>qe", require("otter").export, desc = "[e]xport" },
    { "<leader>qh", ":QuartoHelp ", desc = "[h]elp" },
    { "<leader>qp", ":lua require'quarto'.quartoPreview()<cr>", desc = "[p]review" },
    { "<leader>qq", ":lua require'quarto'.quartoClosePreview()<cr>", desc = "[q]uiet preview" },
    { "<leader>qr", group = "[r]un" },
    { "<leader>qra", ":QuartoSendAll<cr>", desc = "run [a]ll" },
    { "<leader>qrb", ":QuartoSendBelow<cr>", desc = "run [b]elow" },
    { "<leader>qrr", ":QuartoSendAbove<cr>", desc = "to cu[r]sor" },
    { "<leader>r", group = "[r] R specific tools" },
    { "<leader>rt", show_r_table, desc = "show [t]able" },
    { "<leader>v", group = "[v]im" },
    { "<leader>vc", ":Telescope colorscheme<cr>", desc = "[c]olortheme" },
    { "<leader>vh", ':execute "h " . expand("<cword>")<cr>', desc = "vim [h]elp for current word" },
    { "<leader>vl", ":Lazy<cr>", desc = "[l]azy package manager" },
    { "<leader>vm", ":Mason<cr>", desc = "[m]ason software installer" },
    { "<leader>vs", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k<cr>", desc = "[s]ettings, edit vimrc" },
    { "<leader>x", group = "e[x]ecute" },
    { "<leader>xx", ":w<cr>:source %<cr>", desc = "[x] source %" },
  },
}, { mode = "n" })
