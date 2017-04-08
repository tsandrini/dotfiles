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
set $ws4  "4: "
set $ws5  "5: "
set $ws6  "6: 6"
set $ws7  "7: 7"
set $ws8  "8: 8"
set $ws9  "9: 9"
set $ws10 "10: 10"

hide_edge_borders both
for_window [class="^.*"] border pixel 0
gaps inner 15
gaps outer 15

font pango:System San Francisco Display 11


floating_modifier $mod

bindsym $mod+Shift+q kill

bindsym $mod+Return exec --no-startup-id $terminal
bindsym $mod+d exec rofi --no-startup-id -show run

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

# Start i3bar to display a workspace bar (plus the system information i3status
# finds out, if available)
bar {
    status_command    conky -c ~/.i3/conky/conkyrc
    mode              dock
    position          top 
    workspace_buttons yes
    strip_workspace_numbers yes
 
    colors {
        background $background
        statusline $primary
        separator  $primary
        
        # Colors go <border> <background> <text> <indicator>
        focused_workspace $background $background $gray
        active_workspace $background $background $gray
        inactive_workspace $background $background $primary
        urgent_workspace $background $background $warning
    }
}


for_window [window_role="pop-up"] floating enable
for_window [window_role="task_dialog"] floating enable
for_window [instance="float"] floating enable

bindsym $mod+Shift+c reload
bindsym $mod+Shift+r exec "i3-msg restart; xrdb -load ~/.Xresources"
bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"

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
bindsym $mod+shift+g exec --no-startup-id i3lock-fancy
bindsym $mod+m exec --no-startup-id $terminal -e "cmus"

bindsym $mod+n exec --no-startup-id cmus-remote --next
bindsym $mod+p exec --no-startup-id cmus-remote --prev
bindsym $mod+u exec --no-startup-id cmus-remote --pause

exec --no-startup-id feh --bg-scale ~/.wallpaper.png
exec --no-startup-id compton -f --opengl --vsync opengl-swc --paint-on-overlay &
exec --no-startup-id nm-applet &
exec --no-startup-id cbatticon &
exec --no-startup-id dunst -fn "System San Francisco Display 11"
exec --no-startup-id redshift-gtk &
exec --no-startup-id Thermald &
exec --no-startup-id kalu &
exec --no-startup-id pasystray &
