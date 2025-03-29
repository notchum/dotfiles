require("full-border"):setup()

th.git = th.git or {}
th.git.ignored = ui.Style():fg 'darkgray'
-- th.git.ignored_sign = '!'
th.git.untracked = ui.Style():fg 'yellow'
th.git.untracked_sign = 'U'
th.git.added = ui.Style():fg 'green'
th.git.added_sign = 'A'
th.git.modified = ui.Style():fg 'blue'
th.git.modified_sign = 'M'
th.git.updated = ui.Style():fg 'blue'
-- th.git.updated_sign = '~'
th.git.deleted = ui.Style():fg 'red'
th.git.deleted_sign = 'D'
require('git'):setup()

Header:children_add(function()
	if ya.target_family() ~= "unix" then
		return ""
	end
	return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("blue")
end, 500, Header.LEFT)
