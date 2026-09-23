{ config, pkgs, ... }:

{
	programs.noctalia = {
		enable = true;
		settings = {
		      location.address = "Skopje, North Macedonia";
			theme = {
				mode = "dark";
				source = "wallpaper";
				wallpaper_scheme = "m3-content";
				shell_mode = "follow";
				templates = {
					enable_community_templates = true;
					builtin_ids = [
						"foot"
						"btop"
						"hyprland"
						"cava"
						"niri"
						"mango"
						"umbriel"
						"gtk3"
						"gtk4"
						"kcolorscheme"
						"qt"
						"wezterm"
					];

					community_ids = [
					    "claude-code"
					    "discord"
					    "heroiclauncher"
					    "steam"
					    "fastfetch"
					    "zellij"
					    "hyprtoolkit"
					    "bat"
					    "fzf"
					    "tmux"
					    "yazi"
					];
				};
			};

			wallpaper = {
				enabled = true;
				transition = [ "stripes" ];
				transition_duration = 1000;
				transition_on_startup = true;
			};

			dock = {
				enabled = true;
				radius = 8;
				icon_size = 24;
				background_opacity = 0.4;
				main_axis_padding = 4;
				cross_axis_padding = 4;
				magnification_scale = 1.2;
				radius_bottom_left = 16;
				radius_bottom_right = 16;
				reserve_space = false;
				show_dots = true;
				smart_auto_hide = true;
			};

			bar.default = {
				background_opacity = 0.4;
				capsule_opacity = 0.4;
				start = [
					"workspaces"
				];
				center = [
					"media"
				];
				end = [
				  "tray"
				  "clipboard"
				  "network"
				  "bluetooth"
				  "volume"
				  "brightness"
				  "battery"
				  "clock"
				  "control-center"
				  "notifications"
				];
				margin_ends = 0;
				padding = 12;
				radius = 0;
				radius_bottom_left = 4;
				radius_bottom_right = 4;
			};

			bar.side = {
				background_opacity = 0.4;
				reserve_space = false;
				auto_hide = true;
				capsule_opacity = 0.4;
				position = "left";
				start = [
					"launcher"
					"control-center"
				];
				center = [
				];
				end = [
					"wallhaven"
					"wallpaper"
				  "session"
				];
				margin_ends = 200;
				padding = 12;
				radius = 0;
				radius_top_right = 4;
				radius_bottom_right = 4;
			};

		      idle = {
			behavior_order = [ "lock" "screen-off" "lock-and-suspend" ];
			behavior = {
			  lock = {
			    action = "lock";
			    enabled = true;
			    timeout = 600.0;
			  };
			  "lock-and-suspend" = {
			    action = "lock_and_suspend";
			    enabled = true;
			    timeout = 900.0;
			  };
			  "screen-off" = {
			    action = "screen_off";
			    enabled = true;
			    timeout = 660.0;
			  };
			};
		      };

		      nightlight = {
			enabled = true;
			temperature_night = 5100;
		      };

		      notification = {
			background_opacity = 0.4;
			history_retention_hours = 4;
		      };

		      osd.background_opacity = 0.4;
		      shell = {
			animation.speed = 0.8;
			polkit_agent = true;
			greeter_sync.auto_sync = true;

			panel = {
			  clipboard_placement = "attached";
			  launcher_placement = "attached";
			  polkit_placement = "attached";
			  transparency_mode = "glass";
			};

			session.actions = [
			  {
			    action = "lock";
			    countdown_seconds = 0.0;
			    enabled = true;
			    shortcut = "1";
			    variant = "default";
			  }
			  {
			    action = "logout";
			    countdown_seconds = 0.0;
			    enabled = true;
			    shortcut = "2";
			    variant = "default";
			  }
			  {
			    action = "lock_and_suspend";
			    countdown_seconds = 0.0;
			    enabled = true;
			    shortcut = "3";
			    variant = "default";
			  }
			  {
			    action = "reboot";
			    countdown_seconds = 0.0;
			    enabled = true;
			    shortcut = "4";
			    variant = "default";
			  }
			  {
			    action = "shutdown";
			    countdown_seconds = 0.0;
			    enabled = true;
			    shortcut = "5";
			    variant = "destructive";
			  }
			  {
			    action = "command";
			    command = "systemctl hibernate";
			    countdown_seconds = 0.0;
			    enabled = true;
			    glyph = "zzz";
			    label = "Hibernate";
			    variant = "default";
			  }
			];
		      };
		      system.monitor = {
			cpu_poll_seconds = 1;
			gpu_poll_seconds = 2;
			memory_poll_seconds = 1;
		      };

		      plugins = {
			enabled = ["noctalia/wallhaven"];
			auto_update = "all";
		      };
		      
		      widget.wallhaven = {
		      	type = "noctalia/wallhaven:wallhaven";
		      };

		};
	};
}
