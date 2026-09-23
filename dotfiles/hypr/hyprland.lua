hl.monitor({
	output = "eDP-1",
	mode = "1920x1200@60",
	scale = 1.33,
	bitdepth = 8,
})

hl.monitor({
	output = "DP-2",
	mode = "1920x1080@165",
	position = "2048x000",
	scale = 1,
	transform = 3,
	bitdepth = 6,
})

hl.monitor({
	output = "HDMI-A-3",
	mode = "1024x600@60",
	position = "3000x290",
	scale = 1,
	transform = 3,
})

hl.monitor({
	output = "tablet",
	mode = "1340x800@60",
	position = "0x1080",
	scale = 1,
})

local terminals = {
	"foot",
	"alacritty",
	"kitty",
	"wezterm",
	"konsole",
	"ghostty",
}

-- local terminal = "foot"
-- local file_manager = "thunar"
local file_manager = "dolphin"
local terminal = "foot"
local launcher = "noctalia msg panel-toggle launcher"
-- local launcher = "dms ipc call launcher toggle"
local session_launcher = "noctalia msg panel-toggle session"
-- local session_launcher = "dms ipc call powermenu toggle"
local clipboard_manager = "noctalia msg panel-toggle clipboard"
-- local clipboard_manager = "dms ipc call clipboard toggle"
local task_manager = "foot btop"
local task_manager_quick = "noctalia msg panel-toggle control-center system"
-- local task_manager = "dms ipc call processlist toggle"

hl.on("hyprland.start", function()
	hl.exec_cmd("bash ~/.config/hypr/scripts/autostart.sh")
	hl.exec_cmd("noctalia")
	-- hl.exec_cmd("dms run")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-color-scheme prefer-dark")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'")

	hl.exec_cmd("kwalletd6")
	-- hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")

	-- hl.exec_cmd("com.mastermindzh.tidal-hifi")
	hl.exec_cmd("vivaldi")
	hl.exec_cmd("steam -silent")
end)

-- hl.env("XCURSOR_SIZE", 24)
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("NVD_BACKEND", "direct")

hl.env("GTK_THEME", "Breeze-Dark")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_MENU_PREFIX", "plasma-")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

hl.env("BROWSER", "vivaldi")
hl.env("FILE_MANAGER", file_manager)
hl.env("TERMINAL", terminal)
hl.env("EDITOR", "nvim")

hl.config({
	general = {
		-- gaps_in = 4,
		-- gaps_out = 8,
		gaps_in = 4,
		gaps_out = 8,
		border_size = 2,

		resize_on_border = true,
		allow_tearing = true,
		layout = "scrolling",
	},

	decoration = {
		rounding = 8,

		active_opacity = 1.0,
		inactive_opacity = 0.98,

		blur = {
			enabled = true,
			size = 2,
			passes = 2,
		},
	},

	animations = {
		enabled = true,
	},

	input = {
		kb_layout = "us,mk",
		kb_options = "grp:win_space_toggle",

		accel_profile = "flat",

		touchpad = {
			natural_scroll = true,		
		},
	},

	scrolling = {
		column_width = 0.5,
		explicit_column_widths = "0.333, 0.5, 0.667, 1.0",
	},

	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
	},

	xwayland = {
		force_zero_scaling = true,
	},
})

hl.animation({
	leaf = "workspaces",
	enabled = true,
	speed = 2,
	bezier = "default",
})

hl.animation({
	leaf = "windows",
	enabled = true,
	speed = 2,
	bezier = "default",
})

local function toggle_special_workspace(name, programs, close_on_hide)
	local special_workspace = hl.get_active_special_workspace()

	local special_name = "special:" .. name

	if special_workspace ~= nil and special_workspace.name == special_name then
		if close_on_hide then
			for _, window in ipairs(hl.get_workspace_windows(special_name)) do
				hl.dispatch(hl.dsp.window.close({ window = window }))
			end
		end
		hl.dispatch(hl.dsp.workspace.toggle_special(name))
	else
		hl.dispatch(hl.dsp.workspace.toggle_special(name))
		for _, program in ipairs(programs) do
			hl.dispatch(hl.dsp.exec_cmd(program))
		end
	end
end

hl.bind("SUPER + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + q", hl.dsp.window.close())

hl.bind("SUPER + h", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + l", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + j", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + k", hl.dsp.focus({ direction = "up" }))

hl.bind("SUPER + SHIFT + h", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + SHIFT + l", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER + SHIFT + j", hl.dsp.window.move({ direction = "down" }))
hl.bind("SUPER + SHIFT + k", hl.dsp.window.move({ direction = "up" }))

hl.bind("SUPER + f", hl.dsp.window.fullscreen())
hl.bind("SUPER + SHIFT + f", hl.dsp.window.float())

hl.bind("SUPER + n", hl.dsp.layout("colresize +conf"))
hl.bind("SUPER + SHIFT + n", hl.dsp.layout("colresize -conf"))
hl.bind("SUPER + c", hl.dsp.layout("fit active"))

-- workspaces
hl.bind("SUPER + 1", hl.dsp.focus({ workspace = 1, on_current_monitor = true }))
hl.bind("SUPER + 2", hl.dsp.focus({ workspace = 2, on_current_monitor = true }))
hl.bind("SUPER + 3", hl.dsp.focus({ workspace = 3, on_current_monitor = true }))
hl.bind("SUPER + 4", hl.dsp.focus({ workspace = 4, on_current_monitor = true }))
hl.bind("SUPER + 5", hl.dsp.focus({ workspace = 5, on_current_monitor = true }))
hl.bind("SUPER + 6", hl.dsp.focus({ workspace = 6, on_current_monitor = true }))
hl.bind("SUPER + 7", hl.dsp.focus({ workspace = 7, on_current_monitor = true }))
hl.bind("SUPER + 8", hl.dsp.focus({ workspace = 8, on_current_monitor = true }))
hl.bind("SUPER + 9", hl.dsp.focus({ workspace = 9, on_current_monitor = true }))
hl.bind("SUPER + 0", hl.dsp.focus({ workspace = 10, on_current_monitor = true }))

hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = 1, on_current_monitor = true }))
hl.bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = 2, on_current_monitor = true }))
hl.bind("SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = 3, on_current_monitor = true }))
hl.bind("SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = 4, on_current_monitor = true }))
hl.bind("SUPER + SHIFT + 5", hl.dsp.window.move({ workspace = 5, on_current_monitor = true }))
hl.bind("SUPER + SHIFT + 6", hl.dsp.window.move({ workspace = 6, on_current_monitor = true }))
hl.bind("SUPER + SHIFT + 7", hl.dsp.window.move({ workspace = 7, on_current_monitor = true }))
hl.bind("SUPER + SHIFT + 8", hl.dsp.window.move({ workspace = 8, on_current_monitor = true }))
hl.bind("SUPER + SHIFT + 9", hl.dsp.window.move({ workspace = 9, on_current_monitor = true }))
hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = 10, on_current_monitor = true }))

-- noctalia
hl.bind("SUPER + D", hl.dsp.exec_cmd(launcher))
hl.bind("SUPER + P", hl.dsp.exec_cmd(session_launcher))
hl.bind("SUPER + X", hl.dsp.exec_cmd(clipboard_manager))
hl.bind("SUPER + Tab", hl.dsp.exec_cmd(task_manager_quick))
-- hl.bind("SUPER + Period", hl.dsp.exec_cmd("dms ipc call launcher openQuery :e "))
-- hl.bind("SUPER + Comma", hl.dsp.exec_cmd("dms ipc call launcher openQuery gif "))

-- programs
hl.bind("SUPER + B", hl.dsp.exec_cmd("vivaldi-stable"))
hl.bind("SUPER + E", hl.dsp.exec_cmd(file_manager))

hl.bind("SUPER + SHIFT + E", function()
	toggle_special_workspace("file_manager", { file_manager }, true)
end)

hl.bind("SUPER + T", function()
	toggle_special_workspace("music", { "com.mastermindzh.tidal-hifi" }, false)
end)

hl.bind("SUPER + SHIFT + Tab", function()
	toggle_special_workspace("system_monitor", { task_manager }, true)
end)

hl.bind("SUPER + R", hl.dsp.exec_cmd("foot nvim scratchpad.txt"))

hl.bind("SUPER + SHIFT + C", hl.dsp.exec_cmd("noctalia msg panel-toggle control-center calendar"))

-- hl.bind("SUPER + mouse_wheel_up", hl.dsp.focus({ workspace = "e+1" }))
-- hl.bind("SUPER + mouse_wheel_down", hl.dsp.exec_cmd({ workspace = "e-1" }))
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("amixer -D pulse sset Master 5%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("amixer -D pulse sset Master 5%-"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("amixer sset Master toggle"))

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

hl.bind("print", hl.dsp.exec_cmd("noctalia msg screenshot-region"))
hl.bind("SHIFT + print", hl.dsp.exec_cmd("noctalia msg screenshot-fullscreen"))
-- hl.bind("print", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
-- hl.bind("SHIFT + print", hl.dsp.exec_cmd("hyprshot -m fullscreen"))

hl.gesture({ fingers = 3, direction = "horizontal", action = "scroll_move" })
hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })

-- rules

hl.window_rule({
	name = "slack",
	workspace = 4,
	match = {
		title = "Slack",
	},
})

hl.window_rule({
	name = "tidal",
	workspace = 3,
	match = {
		class = ".*tidal.*",
	},
})

hl.window_rule({
	name = "vivaldi",
	workspace = 1,
	match = {
		class = ".*vivaldi.*",
	},
})

hl.window_rule({
	name = "dms_float",
	float = true,
	match = {
		class = ".*dms.*",
	},
})

hl.window_rule({
	name = "music",
	workspace = "special:music silent",
	match = {
		class = "com.mastermindzh.tidal-hifi",
	},
})

-- for _, terminal_class in ipairs(terminals) do
-- 	hl.notification.create({
-- 		text = "Applying opacity rule for terminal class: " .. terminal_class,
-- 		duration = 2000,
-- 	})
-- 	hl.window_rule({
-- 		match = {
-- 			class = ".*" .. terminal_class .. ".*",
-- 		},
-- 		opacity = "0.95 override 0.7 1",
-- 	})
-- end

-- DMS Include Configs
-- require("dms.layout")
-- require("dms.binds")
-- require("dms.binds-user")
-- require("dms.windowrules")

-- For Noctalia Color templates
require("noctalia").apply_theme()

-- >>> HYPRLAND VISUAL EDITOR (HVE) <<<
pcall(function()
	dofile(os.getenv("HOME") .. "/.cache/noctalia/HVE/overlay.lua")
end)
-- <<< HYPRLAND VISUAL EDITOR (HVE) <<<
