# vim: set ts=8 sw=4 tw=0 et :
# vim: filetype=i3

# i3 configuration
# Author: Tomáš Sandrini

set $mod Mod4
set $background {{ black }}

set $foreground {{ white }}
set $gray       {{ alt_black }}
set $primary    {{ primary }}
set $secondary  {{ secondary }}
set $tertiary   {{ tertiary }}
set $warning    {{ special }}
set $terminal   urxvt -uc
set $browser    chromium
set $screencast --no-startup-id bash ~/.config/scripts/screencast.sh
set $stoprec    --no-startup-id killall ffmpeg & killall screenkey
set $fmanager   urxvt -uc -e "ranger"

set $mplayer    urxvt -uc -e "ncmpcpp"
set $mplayerVolUp --no-startup-id mpc volume +5
set $mplayerVolDown --no-startup-id mpc volume -5
set $mplayerNext --no-startup-id mpc next
set $mplayerPrevious --no-startup-id mpc prev
set $mplayerToggle --no-startup-id mpc toggle
set $mplayerStop --no-startup-id mpc stop

set $ws1  "1: "
set $ws2  "2: "
set $ws3  "3: "
set $ws4  "4: "
set $ws5  "5: "
set $ws6  "6: "
set $ws7  "7: 7"
set $ws8  "8: 8"
set $ws9  "9: 9"
set $ws10 "10: 10"

hide_edge_borders both
new_window none
for_window [class="^.*"] border pixel 0
gaps inner 25
gaps outer 20

font pango:{{ fontName }} {{ fontSize }}

floating_modifier $mod

bindsym $mod+Shift+q kill

bindsym $mod+Return exec --no-startup-id $terminal
bindsym $mod+d exec rofi --no-startup-id -show run -run-command "/bin/zsh -i -c '{cmd}'"
bindsym $mod+c exec --no-startup-id rofi -show find -modi find:~/.config/scripts/rofi/rofi-file.sh

bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right

bindsym $mod+Shift+h move left
bindsym $mod+Shift+j move down
bindsym $mod+Shift+k move up
bindsym $mod+Shift+l move right

bindsym $mod+b split h
bindsym $mod+v split v

bindsym $mod+z fullscreen

# bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split

bindsym $mod+space focus mode_toggle
bindsym $mod+Shift+space floating toggle

#bindsym $mod+a focus parent
#bindsym $mod+d focus child

bindsym $mod+1 workspace $ws1
bindsym $mod+2 workspace $ws2
bindsym $mod+3 workspace $ws3
bindsym $mod+4 workspace $ws4
bindsym $mod+5 workspace $ws5
bindsym $mod+6 workspace $ws6
bindsym $mod+7 workspace $ws7
bindsym $mod+8 workspace $ws8
bindsym $mod+9 workspace $ws9
bindsym $mod+0 workspace $ws10
bindsym $mod+Tab workspace back_and_forth

set $mode_gaps Gaps: (o) outer, (i) inner
set $mode_gaps_outer Outer Gaps: +|-|0 (local), Shift + +|-|0 (global)
set $mode_gaps_inner Inner Gaps: +|-|0 (local), Shift + +|-|0 (global)
bindsym $mod+Shift+g mode "$mode_gaps"

mode "$mode_gaps" {
        bindsym o      mode "$mode_gaps_outer"
        bindsym i      mode "$mode_gaps_inner"
        bindsym Return mode "default"
        bindsym Escape mode "default"
}

mode "$mode_gaps_inner" {
        bindsym plus  gaps inner current plus 5
        bindsym minus gaps inner current minus 5
        bindsym 0     gaps inner current set 0

        bindsym Shift+plus  gaps inner all plus 5
        bindsym Shift+minus gaps inner all minus 5
        bindsym Shift+0     gaps inner all set 0

        bindsym Return mode "default"
        bindsym Escape mode "default"
}
mode "$mode_gaps_outer" {
        bindsym plus  gaps outer current plus 5
        bindsym minus gaps outer current minus 5
        bindsym 0     gaps outer current set 0

        bindsym Shift+plus  gaps outer all plus 5
        bindsym Shift+minus gaps outer all minus 5
        bindsym Shift+0     gaps outer all set 0

        bindsym Return mode "default"
        bindsym Escape mode "default"
}


workspace_auto_back_and_forth yes

bindsym $mod+Control+Shift+Left move window to workspace prev
bindsym $mod+Control+Shift+Right move window to workspace next

bindsym $mod+Control+Shift+Prior move container to output left
bindsym $mod+Control+Shift+Next move container to output right

bindsym $mod+Shift+1 move container to workspace number $ws1
bindsym $mod+Shift+2 move container to workspace number $ws2
bindsym $mod+Shift+3 move container to workspace number $ws3
bindsym $mod+Shift+4 move container to workspace number $ws4
bindsym $mod+Shift+5 move container to workspace number $ws5
bindsym $mod+Shift+6 move container to workspace number $ws6
bindsym $mod+Shift+7 move container to workspace number $ws7
bindsym $mod+Shift+8 move container to workspace number $ws8
bindsym $mod+Shift+9 move container to workspace number $ws9
bindsym $mod+Shift+0 move container to workspace number $ws10


# colors                BORDER      BACKGROUND TEXT        INDICATOR
client.focused          $primary    $primary   $background $primary
client.focused_inactive $background $primary   $foreground $background
client.unfocused        $gray       $gray      $background $secondary
client.urgent           $warning    $warning   $foreground $warning

for_window [window_role="pop-up"] floating enable
for_window [window_role="task_dialog"] floating enable
for_window [title="GIMP Startup"] move workspace $ws6
for_window [class="Gimp"] move workspace $ws6
for_window [window_role="gimp-dock"] floating disable; move left; resize shrink width 50 px or 50ppt
for_window [window_role="gimp-toolbox"] floating disable; move right; resize grow width 30 px or 30pptor_window [instance="float"] floating enable

assign [class="Chromium"] $ws1

for_window [window_role="pop-up"] floating enable
for_window [window_role="bubble"] floating enable
for_window [window_role="task_dialog"] floating enable
for_window [window_role="Preferences"] floating enable

for_window [window_type="dialog"] floating enable
for_window [window_type="menu"] floating enable

bindsym $mod+p resize shrink width 10 px or 10 ppt
bindsym $mod+i resize grow height 10 px or 10 ppt
bindsym $mod+o resize shrink height 10 px or 10 ppt
bindsym $mod+u resize grow width 10 px or 10 ppt

bindsym $mod+shift+minus move scratchpad
bindsym $mod+minus scratchpad show

set $mode_power lock(L) | logout(E) | suspend(S) | hibernate(H) | reboot(R) | shutdown(P)
bindsym $mod+shift+m mode "$mode_power"
mode "$mode_power" {
    bindsym l mode "default", exec --no-startup-id ~/.i3/i3exit lock
    bindsym e mode "default", exec --no-startup-id ~/.i3/i3exit logout
    bindsym s mode "default", exec --no-startup-id ~/.i3/i3exit suspend
    bindsym h mode "default", exec --no-startup-id ~/.i3/i3exit hibernate
    bindsym r mode "default", exec --no-startup-id ~/.i3/i3exit reboot
    bindsym p mode "default", exec --no-startup-id ~/.i3/i3exit shutdown

    bindsym Return mode "default"
    bindsym Escape mode "default"
}

bindsym $mod+Shift+c reload
bindsym $mod+Shift+r exec --no-startup-id ~/.config/scripts/i3/reload.sh

bindsym $mod+Insert exec $screencast
bindsym $mod+Pause exec $video
bindsym $mod+Delete exec $stoprec

bindsym $mod+f exec $fmanager

bindsym $mod+m exec $mplayer
bindsym $mod+equal exec $mplayerVolUp
bindsym $mod+shift+equal exec $mplayerVolDown
bindsym $mod+n exec $mplayerNext
bindsym $mod+shift+n exec $mplayerPrevious
bindsym $mod+s exec $mplayerToggle
bindsym $mod+shift+s exec $mplayerStop

bindsym F1 exec --no-startup-id echo  "no need for help" > /dev/null
bindsym Print exec --no-startup-id xfce4-screenshooter
bindsym $mod+shift+i exec --no-startup-id i3lock-fancy

bindsym XF86AudioRaiseVolume exec --no-startup-id pulseaudio-ctl up
bindsym XF86AudioLowerVolume exec --no-startup-id pulseaudio-ctl down
bindsym XF86AudioMute exec --no-startup-id pulseaudio-ctl mute

bindsym XF86MonBrightnessUp exec --no-startup-id light -A 5
bindsym XF86MonBrightnessDown exec --no-startup-id light -U 5
bindsym XF86ScreenSaver exec --no-startup-id i3lock-fancy
bindsym XF86Display exec --no-startup-id arandr
bindsym XF86Close kill
#bindsym XF86WLAN exec --no-startup-id sudo sv restart NetworkManager

exec_always --no-startup-id feh --bg-scale ~/.wallpaper.png
exec_always --no-startup-id ~/.config/scripts/screen.sh v
exec --no-startup-id compton &
exec --no-startup-id unclutter &
exec --no-startup-id nm-applet &
exec --no-startup-id dunst &
exec --no-startup-id thermald &
exec --no-startup-id kalu &
exec --no-startup-id polybar top_bar &
exec --no-startup-id polybar bottom_bar &
exec --no-startup-id xfce4-clipman &
