# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from typing import List  # noqa: F401

# os related libraries.
import os
import subprocess

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod4"
terminal = guess_terminal()

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(),
        desc="Move window focus to other window"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(),
        desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "shift"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"),
    Key([mod], "o", lazy.spawn("dmenu_run -i -b -fn 'SourceCodePro:bold:pixelsize=14' -p 'Run: '"),
        desc='Run Launcher'),
]

# Defining workspaces
wrkspc_names = {"1": "WEB", "2": "DEV", "3": "WRK", "4": "ENT", "5": "MISC"}
wrkspc_layouts = {"1": "monadtall", "2": "monadtall", "3": "monadtall", "4": "monadtall", "5": "bsp"}

groups = []

# iterating through names and layouts and appending to groups
for i in "12345":
    grp = Group(name = i, label = wrkspc_names[i], layout= wrkspc_layouts[i])
    groups.append(grp)

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),

        # mod1 + shift + letter of group = switch to & move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True),
        #     desc="Switch to & move focused window to group {}".format(i.name)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            desc="move focused window to group {}".format(i.name)),
        
        Key([mod], "Tab", lazy.window.next_window(),
            desc="Flipping through tabs."),

    ])

colors = [["#282c34", "#282c34"],
          ["#3d3f4b", "#434758"],
          ["#ffffff", "#ffffff"],
          ["#ff5555", "#ff5555"],
          ["#74438f", "#74438f"],
          ["#4f76c7", "#4f76c7"],
          ["#e1acff", "#e1acff"],
          ["#ecbbfb", "#ecbbfb"]]

layout_theme = {"border_width": 2,
                "margin": 8,
                "border_focus": "576EF3",
                "border_normal": "1D2330"
                }


layouts = [
    layout.Columns(border_focus_stack='#d75f5f'),
    #layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
     layout.Bsp(**layout_theme      
     ),
    # layout.Matrix(),
     layout.MonadTall(**layout_theme
        # border_width = 2,
        # border_focus = "#576EF3",
        # padding_left = 0,
        # padding_x = 0,
        # padding_y = 5,
        # section_top = 10,
        # section_bottom = 20,
        # level_shift = 8,
        # vspace = 3,
        # panel_width = 200
     ),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font='SourceCodePro-Bold',
    fontsize=14,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                # widget.Image(
                #     filename = "~/.config/qtile/icons/python_white.png",
                #     scale = "False"                    
                #     ),                
                widget.GroupBox(                    
                    background = colors[0],
                    margin_y = 3,
                    margin_x = 0,
                    padding_y = 5,
                    padding_x = 3,
                    borderwidth = 3,
                    active = colors[2],
                    inactive = colors[5],
                    rounded = False,
                    highlight_color = colors[1],
                    highlight_method = "line",
                    this_current_screen_border = colors[2],
                    this_screen_border = colors [4],
                    # other_current_screen_border = colors[6],
                    # other_screen_border = colors[4],
                    foreground = colors[2]
                ),
                #widget.Prompt(),
                #widget.CurrentLayout(),
                widget.Sep(
                    linewidth = 0,
                    padding = 6,
                    foreground = colors[2],
                    background = colors[0]
                ),
                widget.WindowName(                    
                    foreground = colors[2],
                    background = colors[0],
                    fmt="{}"                    
                ),
                widget.Chord(
                    chords_colors={
                        'launch': ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                #widget.TextBox("my config", name="default"),
                #widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
                # widget.Net(
                #     interface="wlp2s0"
                # ),
                widget.Sep(
                       linewidth = 0,
                       padding = 6,
                       foreground = colors[2],
                       background = colors[0]
                       ),
                # wifi icon gets added if we start nm-applet application.
                widget.Systray(
                    background = colors[0]
                ),
                widget.Sep(
                       linewidth = 0,
                       padding = 6,
                       foreground = colors[2],
                       background = colors[0]
                       ),
                widget.Memory(
                       foreground = colors[2],
                       background = colors[0],
                       measure_mem= "M",
                       #mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e htop')},
                       padding = 5
                       ),
                widget.TextBox(
                       text = " ⟳",
                       padding = 2,
                       foreground = colors[2],
                       background = colors[0],
                       fontsize = 14
                       ),       
                widget.CheckUpdates(
                       update_interval = 1800,
                       distro = "ManjaroLinux",
                       display_format = "Updates: {updates}",
                       foreground = colors[2],
                       #mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e sudo pacman -Syu')},
                       background = colors[0]
                       ),       
                widget.Volume(
                       foreground = colors[2],
                       background = colors[0],
                       fmt="VOL: {}",
                       #theme_path=[os.path.expanduser("~/.config/qtile/vol_icon.png")],
                       padding = 5
                       ),
                widget.Clock(
                    background = colors[0],
                    format="%a, %b %d - %H:%M"), #"'%d %b, %a %H:%M'),
                widget.Sep(
                       linewidth = 0,
                       padding = 6,
                       foreground = colors[2],
                       background = colors[0]
                       ),
                widget.QuickExit(
                    background = colors[0],
                    default_text="Log off",
                    countdown_format="[ {} ]"
                ),
            ],
            25,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"

# Configuring autostart applications.
@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~')
    subprocess.Popen([home + '/.config/qtile/autostart.sh'])


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
