[global]
    alignment = left
    allow_markup = yes
    bounce_freq = 0
    browser = /usr/bin/chromium
    dmenu = /usr/bin/rofi -p dunst:
    font = {{ fontName }} {{ fontSize }}
    format = "<b>%s</b>\n%b"
    geometry = "425x5-40+32"
    history_length = 20
    horizontal_padding = 8
    idle_threshold = 120
    ignore_newline = no
    indicate_hidden = yes
    line_height = 1
    monitor = 0
    padding = 8
    separator_color = frame
    separator_height = 1
    show_age_threshold = 60
    show_indicators = yes
    shrink = no
    sort = yes
    startup_notification = false
    sticky_history = yes
    transparency = 15
    word_wrap = yes

    # When having multiple monitors, display notifications on the which has
    # active keyboard activity
    follow = keyboard

[frame]
    width = 1
    color = "{{ primary }}"

[urgency_low]
    background = "{{ secondary }}"
    foreground = "#FFFFFF"
    timeout = 10

[urgency_normal]
    background = "{{ tertiary }}"
    foreground = "#FFFFFF"
    timeout = 20

[urgency_critical]
    background = "{{ special }}"
    foreground = "#D46A6A"
    timeout = 0

[irc]
    appname = "weechat"
    format  = "%s: %b"
    urgency = low
    background = "#83c83d"
    foreground = "#000000"
