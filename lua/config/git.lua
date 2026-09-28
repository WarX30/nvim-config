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

local function git_commit()
	local message = vim.fn.input("Commit message: ")

	if message == "" then
		return
	end

	vim.cmd("!git commit -m " .. vim.fn.shellescape(message))
end

local function git_push()
	vim.cmd("!git push")
end

return {
	status = git_status,
	diff = git_diff,
	add = git_add,
	commit = git_commit,
	push = git_push,
}
