--
-- Autostart necessary processes (like notifications daemons, status bars, etc.)
local terminal = "alacritty"

hl.on("hyprland.start", function()
  hl.exec_cmd(terminal)
  --   hl.exec_cmd("nm-applet")
  --   -- Terminal on workspace 1
  hl.exec_cmd(terminal, { workspace = "1 silent" })
  hl.exec_cmd("google-chrome", { workspace = "2 silent" })
  hl.exec_cmd(terminal, { workspace = "2 silent" , size = "40% 100%" , move = "right", })
  hl.exec_cmd("emacs", { workspace = "3 silent" })
  -- hl.exec_cmd("[workspace 4 silent] ghostty")

  --   hl.exec_cmd("waybar & hyprpaper & firefox")
end)
--
--
--
-- Touchpad gesture: 3-finger horizontal swipe switches workspaces
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Layout controls
hl.bind("SUPER + Return", hl.dsp.layout("swapwithmaster"))
hl.bind("SUPER + R", hl.dsp.layout("orientationcycle"))

-- Window management
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("CTRL + ALT + Q", hl.dsp.exec_cmd("uwsm stop"))
hl.bind("SUPER + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + M", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind("SUPER + SHIFT + M", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- Special workspace
hl.bind("SUPER + P", hl.dsp.workspace.toggle_special())
hl.bind("SUPER + SHIFT + P", hl.dsp.window.move({ workspace = "special", follow = false }))

-- Move focus with SUPER + vim keys
hl.bind("SUPER + l", hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + h", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + k", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + j", hl.dsp.focus({ direction = "d" }))

-- Move windows with SUPER + CTRL + vim keys
hl.bind("SUPER + CTRL + h", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + CTRL + j", hl.dsp.window.move({ direction = "d" }))
hl.bind("SUPER + CTRL + k", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + CTRL + l", hl.dsp.window.move({ direction = "r" }))

-- Resize windows with SUPER + SHIFT + arrow keys
hl.bind("SUPER + SHIFT + left", hl.dsp.window.resize({ x = -50, y = 0, relative = true }))
hl.bind("SUPER + SHIFT + right", hl.dsp.window.resize({ x = 50, y = 0, relative = true }))
hl.bind("SUPER + SHIFT + up", hl.dsp.window.resize({ x = 0, y = -50, relative = true }))
hl.bind("SUPER + SHIFT + down", hl.dsp.window.resize({ x = 0, y = 50, relative = true }))

-- Center focused window
hl.bind("CTRL + ALT + C", hl.dsp.window.center())

-- Switch workspaces with SUPER + [1-5]
hl.bind("SUPER + 1", hl.dsp.focus({ workspace = "1" }))
hl.bind("SUPER + 2", hl.dsp.focus({ workspace = "2" }))
hl.bind("SUPER + 3", hl.dsp.focus({ workspace = "3" }))
hl.bind("SUPER + 4", hl.dsp.focus({ workspace = "4" }))
hl.bind("SUPER + 5", hl.dsp.focus({ workspace = "5" }))

-- Move active window to a workspace with SUPER + SHIFT + [1-5]
hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = "1" }))
hl.bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = "2" }))
hl.bind("SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = "3" }))
hl.bind("SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = "4" }))
hl.bind("SUPER + SHIFT + 5", hl.dsp.window.move({ workspace = "5" }))

-- Scroll through existing workspaces with SUPER + scroll
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Launch applications
hl.bind("SUPER + SHIFT + Return", hl.dsp.exec_cmd("alacritty"))
hl.bind("SUPER + SHIFT + B", hl.dsp.exec_cmd("google-chrome"))
hl.bind("SUPER + SHIFT + F", hl.dsp.exec_cmd("nautilus"))
hl.bind("SUPER + SHIFT + T", hl.dsp.exec_cmd("Telegram"))
hl.bind("CTRL + ALT + P", hl.dsp.exec_cmd("gnome-pomodoro --start-stop"))

-- Application launcher
hl.bind("CTRL + Space", hl.dsp.exec_cmd("noctalia-shell ipc call launcher toggle"))

-- Clipboard history
hl.bind("ALT + SHIFT + V", hl.dsp.exec_cmd("noctalia-shell ipc call launcher clipboard"))

-- Pick color from screen and copy to clipboard
hl.bind("SUPER + SHIFT + C", hl.dsp.exec_cmd("hyprpicker -a"))

-- OCR
hl.bind("ALT + SHIFT + 2", hl.dsp.exec_cmd("ocr"))

-- Screenshot area
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("wayblast area | swappy -f -"))

-- Screenshot entire screen
hl.bind("SUPER + CTRL + S", hl.dsp.exec_cmd("wayblast fullscreen | swappy -f -"))

-- Screen recording
hl.bind("SUPER + SHIFT + R", hl.dsp.exec_cmd("toggle-screen-recording"))

-- Lock screen
hl.bind("CTRL + ALT + L", hl.dsp.exec_cmd("noctalia-shell ipc call lockScreen lock"))

-- Toggle control center panel
hl.bind("SUPER + C", hl.dsp.exec_cmd("noctalia-shell ipc call controlCenter toggle"))

-- Open notifications history
hl.bind("SUPER + N", hl.dsp.exec_cmd("noctalia-shell ipc call notifications toggleHistory"))

-- Clear all notifications
hl.bind("SUPER + SHIFT + Backspace", hl.dsp.exec_cmd("noctalia-shell ipc call notifications clear"))

-- Adjust brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("noctalia-shell ipc call brightness increase"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("noctalia-shell ipc call brightness decrease"))

-- Adjust volume
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("noctalia-shell ipc call volume increase"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("noctalia-shell ipc call volume decrease"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("noctalia-shell ipc call volume muteOutput"))

-- Adjust mic sensitivity
hl.bind("SHIFT + XF86AudioRaiseVolume", hl.dsp.exec_cmd("noctalia-shell ipc call volume increaseInput"))
hl.bind("SHIFT + XF86AudioLowerVolume", hl.dsp.exec_cmd("noctalia-shell ipc call volume decreaseInput"))
hl.bind("SHIFT + XF86AudioMute", hl.dsp.exec_cmd("noctalia-shell ipc call volume muteInput"))

-- Move/resize windows with SUPER + LMB/RMB and dragging
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Window rules (evaluated top to bottom)
-- Workspace assignments trikl: do not bind apps to spec workspaces
-- hl.window_rule({ match = { class = [[^(brave-browser)$]] }, workspace = "1" })
-- hl.window_rule({ match = { class = [[^(Alacritty)$]] }, workspace = "2" })
-- hl.window_rule({ match = { class = [[^(org\.telegram\.desktop)$]] }, workspace = "3" })
-- hl.window_rule({ match = { class = [[^(steam)$]] }, workspace = "4" })
-- hl.window_rule({ match = { class = [[^(steam_app_\d+)$]] }, workspace = "5" })
-- hl.window_rule({ match = { class = [[^(gnome-pomodoro)$]] }, workspace = "special" })

-- Center all floating windows
hl.window_rule({ match = { float = true }, center = true })

-- Floating dialogs (sized)
hl.window_rule({
  match = { class = [[^(xdg-desktop-portal-gtk)$]] },
  float = true,
  size = { "monitor_w*0.4", "monitor_h*0.4" },
})
hl.window_rule({
  match = { class = [[^(org.pulseaudio.pavucontrol)$]] },
  float = true,
  size = { "monitor_w*0.5", "monitor_h*0.5" },
})
hl.window_rule({
  match = { initial_title = [[^(_crx_.*)$]] },
  float = true,
  size = { "monitor_w*0.15", "monitor_h*0.4" },
})

-- Floating dialogs (auto-size)
hl.window_rule({ match = { class = [[^(gnome-calculator|org\.gnome\.Calculator)$]] }, float = true })

-- Screen sharing
hl.window_rule({ match = { title = [[^(Select what to share)$]] }, float = true })
hl.window_rule({
  match = { title = [[^(.*is sharing (your screen|a window)\.)$]] },
  float = true,
  pin = true,
  border_size = 0,
  move = { "(monitor_w-window_w)/2", "monitor_h-window_h" },
})

--
