local wezterm = require("wezterm")
local launch_menu = {}
local config = {}
local session_manager = require("session-manager")

local act = wezterm.action

local keys = {
	{ key = "s", mods = "LEADER", action = wezterm.action({ EmitEvent = "save_session" }) },
	{ key = "l", mods = "LEADER", action = wezterm.action({ EmitEvent = "load_session" }) },
	{ key = "r", mods = "LEADER", action = wezterm.action({ EmitEvent = "restore_session" }) },
	--{ key = "w", mods = "CTRL|SHIFT", action = act.SwitchToWorkspace({ name = "default" }) },
	{ key = "i", mods = "CTRL|SHIFT", action = act.SwitchToWorkspace },
	{
		key = "9",
		mods = "ALT",
		action = act.ShowLauncherArgs({
			flags = "FUZZY|WORKSPACES",
		}),
	},
}

wezterm.on("save_session", function(window)
	session_manager.save_state(window)
end)
wezterm.on("load_session", function(window)
	session_manager.load_state(window)
end)
wezterm.on("restore_session", function(window)
	session_manager.restore_state(window)
end)

wezterm.on("update-right-status", function(window, pane)
	local leader = ""
	if window:leader_is_active() then
		leader = "LEADER"
	end
	window:set_right_status(leader)
end)

wezterm.on("update-right-status", function(window, pane)
	window:set_right_status(window:active_workspace())
end)

config.font = wezterm.font("JetBrains Mono")
config.keys = keys
config.color_scheme = "Hardcore"
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }
config.launch_menu = launch_menu
config.default_cwd = "C:/repos"
config.default_prog = { "cmd.exe", "/k", "C:\\Users\\charles.porter\\scripts\\alias.bat" }

return config
