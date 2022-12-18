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

import sys
import importlib

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
from libqtile.utils import guess_terminal, send_notification

from libqtile.log_utils import logger

from libqtile.widget.backlight import ChangeDirection
from libqtile.widget.battery import Battery, BatteryState

from random import randint

import os
import subprocess


def reload(module):
    if module in sys.modules:
        importlib.reload(sys.modules[module])


reload("widgets")
import widgets


mod = "mod4"
terminal = guess_terminal("kitty")
browser = "firefox"

HOME = os.path.expanduser("~")
# wallpaper = "/usr/share/wallpapers/AltMorningMist/contents/images/3840x2160.png"
wallpaper = None

theme = dict(
    foreground="#FFC745",
    background="#003B3A",
    color0="#04D9C4",
    color1="#15038C",
    color2="#1D0259",
    color3="#074A59",
    color4="#067373",
    color5="#110273",
    color6="#FF0000",
    color7="#FF0000",
    color8="#ff6c6b",
    color9="#98be65",
    color10="#da8548",
    color11="#51afef",
    color12="#c678dd",
    color13="#46d9ff",
    color14="#a9a1e1",
    color15="#FF0000",
)

colors = [theme[f"color{n}"] for n in range(16)]
background = theme["background"]
foreground = theme["foreground"]
color_focussed = "#6fa3e0"
color_unfocussed = "#0e101c"

border_focus = [colors[5]]
border_normal = "#001122"

inner_gaps = 8
outer_gaps = 0

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


layout_theme = {
    "border_width": 2,
    "margin": 8,
    "border_focus": "e1acff",
    "border_normal": "1D2330",
}

layouts = [
    layout.Tile(
        name="tile",
        ratio=0.5,
        border_on_single=False,
        margin_on_single=False,
        border_width=2,
        margin=0,
        border_focus="e1acff",
        border_normal="1D2330",
    ),
    layout.Max(name="max"),
]

floating_layout = layout.Floating(
    border_width=3,
    border_focus="#FF0000",
    border_normal="00000000",
    fullscreen_border_width=0,
    max_border_width=0,
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        # can be removed:
        Match(title="Capturing"),
        Match(wm_class="graphics"),
    ],
)


widget_defaults = widgets.widget_defaults
extension_defaults = widget_defaults.copy()


screens = [
    Screen(
        top=bar.Bar(
            widgets=widgets.screen_widgets(primary=True),
            size=24,
            background="#000000",
            border_color="#000000",
            border_width=0,
            opacity=1,
            margin=0,
        ),
        wallpaper=wallpaper,
        wallpaper_mode="fill",
    ),
    Screen(
        top=bar.Bar(
            widgets=widgets.screen_widgets(),
            size=24,
            background="#000000",
            border_color="#000000",
            border_width=0,
            opacity=1,
            margin=0,
        ),
        wallpaper=wallpaper,
        wallpaper_mode="fill",
    ),
]


@lazy.function
def _send_notification(qtile, title, message, id=None):
    send_notification(title, f"{randint(10, 1000)} {message}", id_=id)


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
    Key("M-<Return>", lazy.spawn("/usr/bin/kitty -1"), desc="Launch terminal"),
    Key("M-<Tab>", lazy.screen.toggle_group(), desc="Toggle between last groups"),
    Key("M-<space>", lazy.next_layout()),
    Key("M-S-c", lazy.window.kill(), desc="Kill focused window"),
    Key("M-C-r", lazy.restart(), desc="Restart Qtile"),
    Key("M-S-r", lazy.reload_config(), "Reload Qtile Config"),
    Key("M-S-C-q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key("M-<period>", lazy.next_screen()),
    Key("M-<comma>", lazy.prev_screen()),
    Key("M-S-<period>", window_to_next_screen),
    Key("M-S-<comma>", window_to_prev_screen),
    Key("M-i", lazy.spawn("slock"), desc="Lock screen"),
    Key(
        "<XF86MonBrightnessDown>",
        lazy.widget["backlight"].change_backlight(ChangeDirection.DOWN, 1),
        lazy.widget["backlight"].eval("self.update(self.poll())"),
    ),
    Key(
        "<XF86MonBrightnessUp>",
        lazy.widget["backlight"].change_backlight(ChangeDirection.UP, 1),
        lazy.widget["backlight"].eval("self.update(self.poll())"),
    ),
    Key(
        "M-<F1>",
        lazy.widget["backlight"].change_backlight(ChangeDirection.DOWN, 1),
        lazy.widget["backlight"].eval("self.update(self.poll())"),
    ),
    Key(
        "M-<F2>",
        lazy.widget["backlight"].change_backlight(ChangeDirection.UP, 1),
        lazy.widget["backlight"].eval("self.update(self.poll())"),
    ),
    Key(
        "<XF86AudioMute>",
        lazy.widget["myvolume"].mute(),
    ),
    Key(
        "<XF86AudioRaiseVolume>",
        lazy.widget["myvolume"].increase_vol(),
    ),
    Key(
        "<XF86AudioLowerVolume>",
        lazy.widget["myvolume"].decrease_vol(),
    ),
]

groups = [
    Group(name="1"),
    Group(
        name="2",
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
        matches=[
            Match(wm_class=["firefox-default"]),
        ],
    ),
    ScratchPad(
        "scratchpad",
        [
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
                "thunderbird",
                ["/usr/bin/thunderbird"],
                match=Match(wm_class=["thunderbird-default"]),
                height=0.98,
                width=0.9,
                x=0.05,
                y=0.01,
                opacity=0.95,
                on_focus_lost_hide=False,
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
            ),
            Key("M-s", lazy.group["scratchpad"].dropdown_toggle("telegram")),
        ],
    )
)

for k, group in zip(["1", "2", "3", "4", "5", "6", "7", "8", "9"], groups):
    keys.append(Key("M-" + (k), lazy.group[group.name].toscreen()))
    keys.append(Key("M-S-" + (k), lazy.window.togroup(group.name, switch_group=True)))
    keys.append(Key("M-C-" + (k), lazy.window.togroup(group.name, switch_group=False)))


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


# dgroups_key_binder = None
# dgroups_app_rules = []

auto_fullscreen = True
auto_minimize = True
bring_front_click = True
cursor_warp = False
focus_on_window_activation = "smart"
follow_mouse_focus = True
reconfigure_screens = True
wmname = "qtile"
