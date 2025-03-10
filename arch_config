# Config multiple screens

In .bashrc, add

```{bash}
alias lid-close="(
  xrandr --output DP-2-1 --auto --primary \
         --output DP-2-2 --auto --right-of DP-2-1 \
         --output eDP-1 --off && \
  i3-msg workspace '1' && \
  i3-msg move container to output DP-2-1 && \
  i3-msg workspace '2' && \
  i3-msg move container to output DP-2-2
)"

alias lid-open="(
  xrandr --output eDP-1 --auto --primary \
         --output DP-2-1 --right-of eDP-1 --auto \
         --output DP-2-2 --right-of DP-2-1 --auto && \
  i3-msg workspace '1' && \
  i3-msg move container to output eDP-1 && \
  i3-msg workspace '2' && \
  i3-msg move container to output DP-2-1 && \
  i3-msg workspace '3' && \
  i3-msg move container to output DP-2-2
)"
```
# Picom config

```
~/.config/picom/picom.conf
```
```
#################################
#             Shadows           #
#################################

# Enabled client-side shadows on windows. Note desktop windows
# (windows with '_NET_WM_WINDOW_TYPE_DESKTOP') never get shadow,
# unless explicitly requested using the wintypes option.
#
# Can be set per-window using rules.
#
# Default: false
shadow = true;

# The blur radius for shadows, in pixels.
#
# Default: 12
shadow-radius = 7;

# The opacity of shadows.
#
# Range: 0.0 - 1.0
# Default: 0.75
# shadow-opacity = .75

# The left offset for shadows, in pixels.
#
# Default: -15
shadow-offset-x = -7;

# The top offset for shadows, in pixels.
#
# Default: -15
shadow-offset-y = -7;

# Hex string color value of shadow. Formatted like "#RRGGBB", e.g. "#C0FFEE".
#
# Default: #000000
# shadow-color = "#000000"

# Crop shadow of a window fully on a particular monitor to that monitor. This is
# currently implemented using the X RandR extension.
#
# Default: false
# crop-shadow-to-monitor = false


#################################
#           Fading              #
#################################

# Fade windows in/out when opening/closing and when opacity changes,
# unless no-fading-openclose is used. Can be set per-window using rules.
#
# Default: false
fading = true;

# Opacity change between steps while fading in. (0.01 - 1.0, defaults to 0.028)
fade-in-step = 0.03;

# Opacity change between steps while fading out. (0.01 - 1.0, defaults to 0.03)
fade-out-step = 0.03;

# The time between steps in fade step, in milliseconds. (> 0, defaults to 10)
# fade-delta = 10

# Do not fade on window open/close.
# no-fading-openclose = false

# Do not fade destroyed ARGB windows with WM frame. Workaround of bugs in Openbox, Fluxbox, etc.
# no-fading-destroyed-argb = false


#################################
#   Transparency / Opacity      #
#################################

# Opacity of window titlebars and borders.
#
# Range: 0.1 - 1.0
# Default: 1.0 (disabled)
frame-opacity = 0.9;

# Use fixed inactive dim value, instead of adjusting according to window opacity.
#
# Default: false
# inactive-dim-fixed = true

#################################
#           Corners             #
#################################

# Sets the radius of rounded window corners. When > 0, the compositor will
# round the corners of windows. Does not interact well with
# `transparent-clipping`.
#
# Default: 0 (disabled)
corner-radius = 0

#################################
#            Blur               #
#################################

# Parameters for background blurring, see BLUR section in the man page for more information.
blur-method = "dual_kawase"
# blur-size = 12
#
# blur-deviation = false
#
blur-strength = 5

# Blur background of semi-transparent / ARGB windows.
# Can be set per-window using rules.
#
# Default: false
blur-background = true

# Blur background of windows when the window frame is not opaque.
# Implies:
#    blur-background
#
# Default: false
blur-background-frame = true

# Use fixed blur strength rather than adjusting according to window opacity.
#
# Default: false
blur-background-fixed = true


# Specify the blur convolution kernel, with the following format:
# example:
#   blur-kern = "5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1";
# Can also be a pre-defined kernel, see the man page.
#
# Default: ""
blur-kern = "5x5gaussian";

#################################
#       General Settings        #
#################################

# Enable remote control via D-Bus. See the man page for more details.
#
# Default: false
# dbus = true

# Daemonize process. Fork to background after initialization. Causes issues with certain (badly-written) drivers.
daemon = true

# Specify the backend to use: `xrender`, `glx`, or `egl`.
#
# Default: "xrender"
backend = "glx"

# Use higher precision during rendering, and apply dither when presenting the
# rendered screen. Reduces banding artifacts, but may cause performance
# degradation. Only works with OpenGL.
dithered-present = false;

# Enable/disable VSync.
#
# Default: false
vsync = true;

# Try to detect windows with rounded corners and don't consider them
# shaped windows. The accuracy is not very high, unfortunately.
#
# Has nothing to do with `corner-radius`.
#
# Default: false
detect-rounded-corners = true;

# Detect '_NET_WM_WINDOW_OPACITY' on client windows, useful for window managers
# not passing '_NET_WM_WINDOW_OPACITY' of client windows to frame windows.
#
# Default: false
detect-client-opacity = true;

# Use EWMH '_NET_ACTIVE_WINDOW' to determine currently focused window,
# rather than listening to 'FocusIn'/'FocusOut' event. May be more accurate,
# provided that the WM supports it.
#
# Default: false
# use-ewmh-active-win = false

# Unredirect all windows if a full-screen opaque window is detected,
# to maximize performance for full-screen windows. Known to cause flickering
# when redirecting/unredirecting windows.
#
# Default: false
# unredir-if-possible = false

# Delay before unredirecting the window, in milliseconds.
#
# Default: 0.
# unredir-if-possible-delay = 0

# Use 'WM_TRANSIENT_FOR' to group windows, and consider windows
# in the same group focused at the same time.
#
# Default: false
detect-transient = true;

# Use 'WM_CLIENT_LEADER' to group windows, and consider windows in the same
# group focused at the same time. This usually means windows from the same application
# will be considered focused or unfocused at the same time.
# 'WM_TRANSIENT_FOR' has higher priority if detect-transient is enabled, too.
#
# Default: false
# detect-client-leader = false

# Use of damage information for rendering. This cause the only the part of the
# screen that has actually changed to be redrawn, instead of the whole screen
# every time. Should improve performance.
#
# Default: false
use-damage = true;

# Use X Sync fence to wait for the completion of rendering of other windows,
# before using their content to render the current screen.
#
# Required for explicit sync drivers, such as nvidia.
#
# Default: false
# xrender-sync-fence = false

# GLX backend: Use specified GLSL fragment shader for rendering window
# contents. Read the man page for a detailed explanation of the interface.
#
# Can be set per-window using rules.
#
# window-shader-fg = "default"

# Force all windows to be painted with blending. Useful if you
# have a `window-shader-fg` that could turn opaque pixels transparent.
#
# Default: false
# force-win-blend = false

# Do not use EWMH to detect fullscreen windows.
# Reverts to checking if a window is fullscreen based only on its size and coordinates.
#
# Default: false
# no-ewmh-fullscreen = false

# Dimming bright windows so their brightness doesn't exceed this set value.
# Brightness of a window is estimated by averaging all pixels in the window,
# so this could comes with a performance hit.
# Setting this to 1.0 disables this behaviour. Requires --use-damage to be disabled.
#
# Default: 1.0 (disabled)
# max-brightness = 1.0

# Make transparent windows clip other windows like non-transparent windows do,
# instead of blending on top of them. e.g. placing a transparent window on top
# of another window will cut a "hole" in that window, and show the desktop background
# underneath.
#
# Default: false
# transparent-clipping = false

# Set the log level. Possible values are:
#  "trace", "debug", "info", "warn", "error"
# in increasing level of importance. Case insensitive.
# If using the "TRACE" log level, it's better to log into a file
# using *--log-file*, since it can generate a huge stream of logs.
#
# Default: "warn"
# log-level = "warn";

# Set the log file.
# If *--log-file* is never specified, logs will be written to stderr.
# Otherwise, logs will to written to the given file, though some of the early
# logs might still be written to the stderr.
# When setting this option from the config file, it is recommended to use an absolute path.
#
# log-file = "/path/to/your/log/file"

# Write process ID to a file.
# write-pid-path = "/path/to/your/log/file"

# Rule-based per-window options.
#
# See WINDOW RULES section in the man page for how these work.
rules: ({
  match = "window_type = 'tooltip'";
  fade = false;
  shadow = true;
  opacity = 0.75;
  full-shadow = false;
}, {
  match = "window_type = 'dock'    || "
          "window_type = 'desktop' || "
          "_GTK_FRAME_EXTENTS@";
  blur-background = false;
}, {
  match = "window_type != 'dock'";
  # shader = "my_shader.frag";
}, {
  match = "window_type = 'dock' || "
          "window_type = 'desktop'";
  corner-radius = 0;
}, {
  match = "name = 'Notification'   || "
          "class_g = 'Conky'       || "
          "class_g ?= 'Notify-osd' || "
          "class_g = 'Cairo-clock' || "
          "_GTK_FRAME_EXTENTS@";
  shadow = false;
})

# `@include` directive can be used to include additional configuration files.
# Relative paths are search either in the parent of this configuration file
# (when the configuration is loaded through a symlink, the symlink will be
# resolved first). Or in `$XDG_CONFIG_HOME/picom/include`.
#
# @include "extra.conf"
```

# alacritty config

```
# $HOME/.config/alacritty/alacritty.toml
# by Rito Ghosh 2023-10-06

# Alacritty now uses TOML formatting for its config files.
# This is a simple example.

# There are the specification here: https://github.com/alacritty/alacritty/blob/master/extra/man/alacritty.5.scd
# It is not obvious how it translates to TOML. But it is extremely straightforward.

# example: WINDOW, COLORS, etc. are tables, and should be represented as [window], [colors], respectively.
# specifics of variables go under them. e.g.- look under "dynamic_padding" under-
# https://github.com/alacritty/alacritty/blob/master/extra/man/alacritty.5.scd#window
# write `dynamic_padding = true` (without backticks -`) under the table [window]
# for variables with multiple values, use "dotted keys". Like setting `padding.x = 5` under [window].
# This is simple. If not clear, do several trials and errors.

# Below is my initial set-up. The TOML homepage (https://toml.io/en/v1.0.0) was very helpful in figuring this out.
# I put the file alacritty.toml in $HOME/.config/alacritty. However it can be kept anywhere among the places mentioned in
# https://github.com/alacritty/alacritty/tree/master#configuration

[window]

opacity = 0.4

padding.x = 10
padding.y = 10

decorations_theme_variant = "Dark" # "Light"

dynamic_title = true
decorations = "full"  # Autres options : "none", "borderless"



# Configuration d'Alacritty

[font]
normal.family = "Source Code Pro"
bold.family = "Source Code Pro"
italic.family = "Source Code Pro"
bold_italic.family = "Source Code Pro"
normal.style = "Semi-Bold"

size = 12.0

# Tip: for inspiration, look for values in the source code files of your favorite VS Code themes, and use the color picker in
# Google to test colors before setting a value, or simply using an editor such as VS Code where colors are displayed in a
# small box when a HEX is detected by the editor.
```
