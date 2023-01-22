#!/usr/bin/sudo bash

returnbacklight() {
  cat /sys/class/backlight/amdgpu_bl0/brightness
}

setbacklight() {
    echo "Set brightness level"
    echo -n "Current level: $(returnbacklight) max level $(cat /sys/class/backlight/amdgpu_bl0/max_brightness):"
    read setvalue
    echo $setvalue > /sys/class/backlight/amdgpu_bl0/brightness
}

setbacklight
