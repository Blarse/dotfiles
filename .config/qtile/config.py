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

from libqtile import bar, layout, widget, hook
from libqtile.layout.slice import Single
from libqtile.config import (
    Click,
    Drag,
    Group,
    Match,
    Screen,
    EzKey as Key,
    ScratchPad,
    DropDown,
    KeyChord,
)
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

from libqtile.log_utils import logger

import os
import subprocess

mod = "mod4"
terminal = guess_terminal("kitty")
browser = "firefox"

HOME = os.path.expanduser("~")


@lazy.function
def window_to_next_screen(qtile):
    p = qtile.screens.index(qtile.current_screen)
    sl = len(qtile.screens)
    n = (p + 1) % sl

    group = qtile.screens[n].group.name
    qtile.current_window.togroup(group)
    qtile.focus_screen(n)


@lazy.function
def window_to_prev_screen(qtile):
    p = qtile.screens.index(qtile.current_screen)
    sl = len(qtile.screens)
    n = (p - 1) % sl

    group = qtile.screens[n].group.name
    qtile.current_window.togroup(group)
    qtile.focus_screen(n)


@hook.subscribe.startup_once
def start_once():
    subprocess.call([HOME + "/.config/qtile/autostart.sh"])


keys = [
    Key("M-m", lazy.group.setlayout("max"), desc="go to max layout"),

    Key("M-t", lazy.layout.down(), desc="Move focus down"),

    Key(
        "M-S-<Return>",
        lazy.spawn("rofi -monitor -1 -show combi"),
        desc="Spawn rofi application launcher",
    ),

    Key("M-<Return>", lazy.spawn(terminal), desc="Launch terminal"),
    Key("M-<Tab>", lazy.screen.toggle_group(), desc="Toggle between last groups"),
    Key("M-<space>", lazy.next_layout()),
    Key("M-S-c", lazy.window.kill(), desc="Kill focused window"),
    Key("M-C-r", lazy.restart(), desc="Restart Qtile"),
    Key("M-S-C-q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key("M-<period>", lazy.next_screen()),
    Key("M-<comma>", lazy.prev_screen()),
    Key("M-S-<period>", window_to_next_screen),
    Key("M-S-<comma>", window_to_prev_screen),
    Key("M-i", lazy.spawn("slock"), desc="Lock screen"),
]


layout_theme = {
    "border_width": 2,
    "margin": 8,
    "border_focus": "e1acff",
    "border_normal": "1D2330",
}

COLOR_BG = "#161F38"
COLOR_FG = "#FFFFFF"


layouts = [
    layout.Tile(name="tile", ratio=0.5, **layout_theme),
    layout.Max(name="max"),
]

groups = [
    Group(name="1"),
    Group(
        name="2",
        layout="max",
        matches=[
            Match(wm_instance_class=["emacs"], wm_class=["Emacs"]),
            Match(wm_class=["kitty_emacs_window"]),
        ],
    ),
    Group(name="3"),
    Group(name="4"),
    Group(name="5"),
    Group(name="6"),
    Group(name="7"),
    Group(name="8"),
    Group(
        name="9",
        layout="max",
        matches=[
            Match(wm_class=["firefox-default"]),
        ],
    ),
    ScratchPad(
        "scratchpad",
        [
            DropDown(
                "term",
                ["kitty"],
                height=0.8,
                width=0.8,
                x=0.1,
                y=0.1,
                opacity=0.95,
            ),
            DropDown(
                "telegram",
                ["/usr/bin/telegram"],
                match=Match(wm_class=["TelegramDesktop"]),
                height=0.9,
                width=0.9,
                x=0.05,
                y=0.01,
                opacity=0.95,
                warp_pointer=True,
                on_focus_lost_hide=False,
            ),
            DropDown(
                "pavu",
                ["/usr/bin/pavucontrol"],
                height=0.5,
                width=0.5,
                x=0.25,
                y=0.25,
                opacity=1,
                warp_pointer=True,
            ),
            DropDown(
                "thunderbird",
                ["/usr/bin/thunderbird"],
                match=Match(wm_class=["Thunderbird"]),
                height=0.98,
                width=0.9,
                x=0.05,
                y=0.01,
                opacity=0.95,
            ),
        ],
    ),
]

keys.append(
    KeyChord(
        [mod],
        "s",
        [
            Key("M-p", lazy.group["scratchpad"].dropdown_toggle("pavu")),
            Key(
                "M-t",
                lazy.group["scratchpad"].dropdown_toggle("thunderbird"),
                lazy.widget["checkmails"].eval("self.update(self.poll())"),
            ),
            Key("M-s", lazy.group["scratchpad"].dropdown_toggle("telegram")),
        ],
    )
)

for k, group in zip(["1", "2", "3", "4", "5", "6", "7", "8", "9"], groups):
    keys.append(Key("M-" + (k), lazy.group[group.name].toscreen()))
    keys.append(Key("M-S-" + (k), lazy.window.togroup(group.name, switch_group=True)))
    keys.append(Key("M-C-" + (k), lazy.window.togroup(group.name, switch_group=False)))


widget_defaults = dict(
    font="monospace",
    fontsize=14,
    padding=3,
)
extension_defaults = widget_defaults.copy()


colors = [
    ["#282c34", "#282c34"],
    ["#1c1f24", "#1c1f24"],
    ["#dfdfdf", "#dfdfdf"],
    ["#ff6c6b", "#ff6c6b"],
    ["#98be65", "#98be65"],
    ["#da8548", "#da8548"],
    ["#51afef", "#51afef"],
    ["#c678dd", "#c678dd"],
    ["#46d9ff", "#46d9ff"],
    ["#a9a1e1", "#a9a1e1"],
]

checkmail_widget = widget.GenPollText(
    name="checkmails",
    background=colors[1],
    func=lambda: subprocess.check_output(HOME + "/.scripts/checkmails.sh").decode(
        "utf-8"
    ),
    update_interval=1800,
    max_chars=3,
    fmt="✉️ {}",
    mouse_callbacks={
        "Button1": lazy.screen.widget["checkmails"].eval("self.update(self.poll())"),
    },
)


def init_widgets_list():
    widgets_list = [
        widget.GroupBox(
            font="Ubuntu Bold",
            fontsize=9,
            margin_y=3,
            margin_x=0,
            padding_y=5,
            padding_x=3,
            borderwidth=3,
            active=colors[2],
            inactive=colors[7],
            rounded=False,
            highlight_color=colors[1],
            highlight_method="line",
            this_current_screen_border=colors[6],
            this_screen_border=colors[4],
            other_current_screen_border=colors[6],
            other_screen_border=colors[4],
            foreground=colors[2],
            background=colors[0],
        ),
        widget.TextBox(
            text="|",
            font="Ubuntu Mono",
            background=colors[0],
            foreground="474747",
            padding=2,
            fontsize=14,
        ),
        widget.CurrentLayoutIcon(
            custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons")],
            foreground=colors[2],
            background=colors[0],
            padding=0,
            scale=0.7,
        ),
        widget.CurrentLayout(foreground=colors[2], background=colors[0], padding=5),
        widget.TextBox(
            text="|",
            font="Ubuntu Mono",
            background=colors[0],
            foreground="474747",
            padding=2,
            fontsize=14,
        ),
        widget.WindowName(foreground=colors[6], background=colors[0], padding=0),
        widget.Sep(linewidth=0, padding=6, foreground=colors[0], background=colors[0]),
        widget.Systray(background=colors[0], padding=5),
        checkmail_widget,
        widget.ThermalSensor(
            foreground=colors[1],
            background=colors[4],
            threshold=90,
            fmt="Temp: {}",
            padding=5,
        ),
        widget.Memory(
            foreground=colors[1],
            background=colors[6],
            mouse_callbacks={"Button1": lambda: qtile.cmd_spawn(myTerm + " -e htop")},
            fmt="Mem: {}",
            padding=5,
        ),
        widget.Volume(
            foreground=colors[1], background=colors[7], fmt="Vol: {}", padding=5
        ),
        widget.KeyboardLayout(
            configured_keyboards=["us", "ru phonetic"],
            option="",
            foreground=colors[1],
            background=colors[8],
            fmt="Keyboard: {}",
            padding=5,
        ),
        widget.Clock(
            foreground=colors[1], background=colors[9], format="%A, %B %d - %H:%M "
        ),
    ]
    return widgets_list


def init_screens():
    return [
        Screen(top=bar.Bar(widgets=init_widgets_list(), opacity=1.0, size=20)),
        Screen(top=bar.Bar(widgets=init_widgets_list(), opacity=1.0, size=20)),
    ]


def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)


def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)


def switch_screens(qtile):
    i = qtile.screens.index(qtile.current_screen)
    group = qtile.screens[i - 1].group
    qtile.current_screen.set_group(group)


if __name__ in ["config", "__main__"]:
    screens = init_screens()
    # widgets_list = init_widgets_list()
    # widgets_screen1 = init_widgets_screen1()
    # widgets_screen2 = init_widgets_screen2()


# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.toggle_floating()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
# focus_on_window_activation = "smart"
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
