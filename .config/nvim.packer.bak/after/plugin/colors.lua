require('rose-pine').setup({
    -- disable_background = true
})

function ColorMyPencils(color)
    -- color = color or "catppuccin-latte"
    color = color or "rose-pine"
    vim.cmd.colorscheme(color)

    -- Now using transparent plugina 
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    -- vim.cmd('highlight Normal guibg=none')
    -- vim.cmd('highlight NonText guibg=none')
    -- vim.cmd('highlight Normal ctermbg=none')
    -- vim.cmd('highlight NonText ctermbg=none')
end

ColorMyPencils()

-- local systemSetting = vim.fn.system('/Users/nikhil/.config/check_dark_mode.sh')
-- local dark_mode = string.sub(systemSetting, 1, -2) == "dark"

-- local dark_mode = true
-- local test = string.sub(systemSetting, 1, -2)
-- print(test)
-- print(dark_mode)

-- if dark_mode then
--     ColorMyPencils("catppuccin-macchiato")
-- else
--     ColorMyPencils("catppuccin-latte")
-- end
