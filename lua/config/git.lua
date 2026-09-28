-- ============================================================
-- Git
-- ============================================================

local function git_status()
	vim.cmd("!git status")
end

local function git_diff()
	vim.cmd("!git diff")
end

local function git_add()
	vim.cmd("!git add %")
end

return {
	status = git_status,
	diff = git_diff,
	add = git_add,
}
