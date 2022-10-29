from qtile_extras import widget
from qtile_extras.widget.decorations import RectDecoration

import os


HOME = os.path.expanduser("~")
theme = dict(
    foreground="#e8eaf0",
    background="#2a2d36",
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

groupbox = [
    widget.GroupBox(
        font="Ubuntu Bold",
        fontsize=9,
        margin_y=3,
        margin_x=0,
        padding_y=5,
        padding_x=3,
        borderwidth=3,
        active=foreground,
        inactive=colors[4],
        rounded=False,
        highlight_color=colors[1],
        highlight_method="line",
        this_current_screen_border=colors[0],
        this_screen_border=colors[1],
        other_current_screen_border=colors[0],
        other_screen_border=colors[1],
    ),
    widget.GroupBox(
        font="Ubuntu Bold",
        fontsize=9,
        margin_y=3,
        margin_x=0,
        padding_y=5,
        padding_x=3,
        borderwidth=3,
        active=foreground,
        inactive=colors[4],
        rounded=False,
        highlight_color=colors[1],
        highlight_method="line",
        this_current_screen_border=colors[0],
        this_screen_border=colors[1],
        other_current_screen_border=colors[0],
        other_screen_border=colors[1],
    ),
]

current_layout_indicator = []


def init_widgets_defaults():
    return dict(font="Hack Nerd", fontsize=16, padding=6)


widget_defaults = init_widgets_defaults()

cust_spacer = widget.Spacer(length=5)


def screen_widgets(primary=False):
    widget_list = [
        cust_spacer,
        widget.GroupBox(
            margin_y=3,
            margin_x=10,
            padding_y=0,
            padding_x=8,
            borderwidth=1,
            disable_drag=True,
            active=colors[12],
            inactive=colors[3],
            rounded=True,
            this_current_screen_border=colors[9],
            foreground=colors[3],
            decorations=[
                RectDecoration(colour=background, radius=10, filled=True, padding_y=0)
            ],
        ),
        # widget.GroupBox(
        #     margin_y=3,
        #     margin_x=10,
        #     padding_y=0,
        #     padding_x=8,
        #     borderwidth=1,
        #     disable_drag=True,
        #     active=colors[12],
        #     inactive=colors[3],
        #     rounded=True,
        #     this_current_screen_border=colors[9],
        #     foreground=colors[3],
        #     decorations=[
        #         RectDecoration(colour=background, radius=10, filled=True, padding_y=0)
        #     ],
        # ),
        widget.WindowName(font="Hack Nerd Bold", foreground=background),
#        widget.Spacer(),
        widget.Spacer(length=256),
        # TODO: brightness, keyboard layout, datetime
        widget.CurrentLayoutIcon(
            custom_icon_paths=[os.path.expanduser(f"{HOME}/.config/qtile/icons")],
            scale=0.65,
            decorations=[
                RectDecoration(
                    colour=background, radius=[10, 0, 0, 10], filled=True, padding_y=0
                )
            ],
        ),
        widget.CurrentLayout(
            width=64,
            padding=0,
            fmt="{}",
            decorations=[
                RectDecoration(
                    colour=background, radius=[0, 10, 10, 0], filled=True, padding_y=0
                )
            ],
        ),
        cust_spacer,
        widget.Battery(
            foreground=colors[3],
            format=" {percent:2.0%}",
            update_interval=1,
            decorations=[
                RectDecoration(colour=background, radius=10, filled=True, padding_y=0)
            ],
        ),
        cust_spacer,
        cust_spacer,
        widget.CPU(
            foreground=colors[0],
            format=" {load_percent}%",
            update_interval=1,
            decorations=[
                RectDecoration(colour=background, radius=10, filled=True, padding_y=0)
            ],
        ),
        cust_spacer,
        widget.Memory(
            foreground=colors[1],
            format=" {MemUsed: .1f}{mm}/{MemTotal: .1f}{mm}",
            measure_mem="G",
            decorations=[
                RectDecoration(colour=background, radius=10, filled=True, padding_y=0)
            ],
        ),
        cust_spacer,
        widget.ThermalSensor(
            foreground="#00FF00",
            foreground_alert="#FF0000",
            threshold=70,
            fmt=" {}",
            decorations=[
                RectDecoration(colour=background, radius=10, filled=True, padding_y=0)
            ],
        ),
        cust_spacer,
        widget.Volume(  # TODO
            foreground=colors[3],
            fmt="墳: {}",
            scroll=True,
            decorations=[
                RectDecoration(colour=background, radius=10, filled=True, padding_y=0)
            ],
        ),
        cust_spacer,
        widget.Clock(
            format="%l:%M %p",
            foreground=foreground,
            decorations=[
                RectDecoration(colour=background, radius=10, filled=True, padding_y=0)
            ],
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
