set $mod Mod4

set $background {{ black }}
set $foreground {{ white }}
set $gray       {{ alt_black }}
set $primary    {{ primary }}
set $secondary  {{ secondary }}
set $tertiary   {{ tertiary }}
set $warning    {{ special }}
set $terminal   urxvt -uc

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

bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split

bindsym $mod+space focus mode_toggle
bindsym $mod+Shift+space floating toggle

bindsym $mod+a focus parent
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
for_window [instance="float"] floating enable

bindsym $mod+Shift+c reload
bindsym $mod+Shift+r exec --no-startup-id ~/.i3/i3reset

mode "resize" {
        bindsym j resize shrink width 10 px or 10 ppt
        bindsym k resize grow height 10 px or 10 ppt
        bindsym l resize shrink height 10 px or 10 ppt
        bindsym odiaeresis resize grow width 10 px or 10 ppt

        bindsym Left resize shrink width 10 px or 10 ppt
        bindsym Down resize grow height 10 px or 10 ppt
        bindsym Up resize shrink height 10 px or 10 ppt
        bindsym Right resize grow width 10 px or 10 ppt

        bindsym Return mode "default"
        bindsym Escape mode "default"
}

bindsym $mod+r mode "resize"

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

assign [class="Chromium"] $ws1

for_window [window_role="pop-up"] floating enable
for_window [window_role="bubble"] floating enable
for_window [window_role="task_dialog"] floating enable
for_window [window_role="Preferences"] floating enable

for_window [window_type="dialog"] floating enable
for_window [window_type="menu"] floating enable

bindsym XF86AudioRaiseVolume exec --no-startup-id pulseaudio-ctl up
bindsym XF86AudioLowerVolume exec --no-startup-id pulseaudio-ctl down
bindsym XF86AudioMute exec --no-startup-id pulseaudio-ctl mute

bindsym XF86MonBrightnessUp exec --no-startup-id light -A 5
bindsym XF86MonBrightnessDown exec --no-startup-id light -U 5

bindsym XF86AudioPlay exec --no-startup-id cmus-remote --play
bindsym XF86AudioPause exec --no-startup-id cmus-remote --pause
bindsym XF86AudioNext exec --no-startup-id cmus-remote --next
bindsym XF86AudioPrev exec --no-startup-id cmus-remote --previous


bindsym $mod+f exec --no-startup-id $terminal -e "ranger"
bindsym F1 exec --no-startup-id echo  "no need for help" > /dev/null
bindsym Print exec --no-startup-id xfce4-screenshooter
bindsym $mod+shift+i exec --no-startup-id i3lock-fancy
bindsym $mod+m exec --no-startup-id i3-msg 'workspace $ws4; exec --no-startup-id $terminal -e "cmus"'

bindsym $mod+n exec --no-startup-id cmus-remote --next
bindsym $mod+p exec --no-startup-id cmus-remote --prev
bindsym $mod+u exec --no-startup-id cmus-remote --pause

exec_always --no-startup-id feh --bg-scale ~/.wallpaper.png
exec --no-startup-id compton -b &
exec --no-startup-id nm-applet &
exec --no-startup-id dunst &
exec --no-startup-id thermald &
exec --no-startup-id kalu &
exec --no-startup-id polybar main_bar &
