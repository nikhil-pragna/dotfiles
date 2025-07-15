-- Set the global namespace
_G.nk = {}

---Create an autocommand in Neovim
---@param autocmd string|table The autocmd event(s) to trigger the command
---@param opts {group: string, buffer: number, pattern: string, callback: function|string} Optional parameters for the autocmd
---@return nil
function nk.create_autocmd(autocmd, opts)
  opts = opts or {}

  -- Pattern takes precedence over buffer
  if opts.pattern and opts.buffer then
    opts.buffer = nil
  end

  vim.api.nvim_create_autocmd(autocmd, {
    group = opts.group,
    buffer = opts.buffer,
    pattern = opts.pattern,
    callback = type(opts.callback) == "function" and opts.callback or function()
      vim.cmd(opts.callback)
    end,
  })
end
