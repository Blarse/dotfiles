# from qtile_extras import widget
from libqtile import widget

# from qtile_extras.widget.decorations import RectDecoration

import os

HOME = os.path.expanduser("~")
theme = dict(
    foreground="#e8eaf0",
    background="#000000",
    color0="#9cb27d",  # light green
    color1="#cf868a",  # red
    color2="#4c2061",  # purple
    color3="#ead88e",  # yellow
    color4="#58acad",  # cyan
    color5="#5aa3da",  # blue
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


current_layout_indicator = []


class MyVolume(widget.Volume):
    def _update_drawer(self):
        if self.volume <= 0:
            self.text = "婢"
        elif self.volume <= 15:
            self.text = f" {self.volume}%"
        elif self.volume < 50:
            self.text = f" {self.volume}%"
        else:
            self.text = f" {self.volume}%"


widget_defaults = dict(
    font="Ubuntu Nerd Font Bold",
    fontsize=14,
    foreground="#FFFFFF",
    background=None,
    padding=2,
)

graph_widget_defaults = dict(
    border_width=1,
    line_width=2,
    margin_x=0,
    margin_y=3,
    samples=100,
    graph_color="#ffffff",
    fill_color="aaaaaa",
    width=64,
)

spacer = widget.Spacer(length=5)
pomodoro = widget.Pomodoro()

def screen_widgets(primary=False):
    widget_list = [
        spacer,
        widget.GroupBox(
            disable_drag=True,
            margin_y=3,
            margin_x=10,
            padding_y=0,
            padding_x=8,
            borderwidth=1,
            rounded=True,
            highlight_method="line",
            highlight_color="#555555",
            active="#cccccc",
            inactive="#999999",
            block_highlight_text_color="#FF0000",
            this_current_screen_border=colors[9],
        ),
        widget.WindowName(),
        # widget.WindowCount(),
        # widget.TaskList(),
        widget.Spacer(length=0),
        widget.Chord(),
        widget.CurrentLayoutIcon(
            custom_icon_paths=[os.path.expanduser(f"{HOME}/.config/qtile/icons")],
            scale=0.65,
        ),
        widget.CurrentLayout(),
        spacer,
        pomodoro,
        spacer,
        widget.TextBox("", fontsize=20),
        widget.CPUGraph(**graph_widget_defaults),
        spacer,
        widget.TextBox("", fontsize=20),
        widget.MemoryGraph(**graph_widget_defaults),
        spacer,
        widget.TextBox("", fontsize=20),
        widget.HDDBusyGraph(**graph_widget_defaults),
        spacer,
        widget.Battery(
            charge_char="",
            discharge_char="",
            empty_char="",
            full_char="",
            unknown_char="",
            show_short_text=False,
            format="[{char} {percent:2.0%}]",
            update_interval=30,
        ),
        spacer,
        widget.ThermalSensor(
            foreground_alert="#FF0000",
            threshold=70,
            fmt="[{}]",
        ),
        spacer,
        widget.Backlight(
            backlight_name=os.listdir("/sys/class/backlight")[0],
            step=1,
            update_interval=30,
            format="[{percent:5.0%}]",
            change_command=None,
        ),
        spacer,
        MyVolume(
            cardid="0",
            channel="PCM",
            step=1,
            # volume_up_command="amixer -c 0 set PCM 3%+",
            # volume_down_command="amixer -c 0 set PCM 3%-",
            # get_volume_command="",
            # mute_command="amixer -c 0 set PCM 3%-",
            volume_app="kitty --name dialog alsamixer",
            fmt="[{}]",
            scroll=True,
        ),
        spacer,
        widget.Clock(
            format="[%l:%M %p]",
        ),
    ]

    if primary:
        widget_list.extend(
            [
                widget.Spacer(length=8),
                widget.Systray(
                    padding=2,
                    background="#00000000",
                ),
                widget.Spacer(length=8),
            ]
        )

    return widget_list
