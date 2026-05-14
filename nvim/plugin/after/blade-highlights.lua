local function set_blade_highlights()
	vim.api.nvim_set_hl(0, "@tag.blade", { link = "PreProc" })
	vim.api.nvim_set_hl(0, "@punctuation.bracket.blade", { link = "Special" })
	vim.api.nvim_set_hl(0, "@punctuation.delimiter.blade", { link = "Special" })
	vim.api.nvim_set_hl(0, "@keyword.directive.blade", { link = "PreProc" })
	vim.api.nvim_set_hl(0, "@punctuation.special.blade", { link = "Special" })
end

set_blade_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("blade_highlights", { clear = true }),
	callback = set_blade_highlights,
})
