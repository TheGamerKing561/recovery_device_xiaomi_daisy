#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2021-2026 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any part of it
#
FDEVICE="daisy"

fox_get_target_device() {
  if echo "$BASH_SOURCE" | grep -q "/$FDEVICE/"; then
      FOX_BUILD_DEVICE="$FDEVICE";
  elif set | grep BASH_ARGV | grep -w \"$FDEVICE\"; then
      FOX_BUILD_DEVICE="$FDEVICE";
  elif echo "${BASH_SOURCE[0]}" | grep -q "/$FDEVICE/"; then
      FOX_BUILD_DEVICE="$FDEVICE";
  elif echo "$0" | grep -q "$FDEVICE"; then
      FOX_BUILD_DEVICE="$FDEVICE";
  fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
	export LC_ALL="C"
 	export ALLOW_MISSING_DEPENDENCIES=true

    # A/B
    export FOX_AB_DEVICE=1
	export TARGET_DEVICE_ALT="daisy_sprout"
    export FOX_TARGET_DEVICES="daisy_sprout,daisy"

    # Keymaster version
    export OF_DEFAULT_KEYMASTER_VERSION=3.0

    # Screen
    export OF_SCREEN_H=2280
    export OF_STATUS_H=95
    export OF_STATUS_INDENT_LEFT=50
    export OF_STATUS_INDENT_RIGHT=50
    # our LED only blinks white
    export OF_USE_GREEN_LED=0
    export OF_CLOCK_POS=1

    # we don't have hardware buttons, so disable the option to hide navbar
    export OF_ALLOW_DISABLE_NAVBAR=0

    # vanilla build
	export FOX_VANILLA_BUILD=1

    # no additional check for MIUI props
	export OF_NO_ADDITIONAL_MIUI_PROPS_CHECK=1

    # Enable the FRP addon
    export OF_ENABLE_FRP_ADDON=1
else
	if [ -z "$FOX_BUILD_DEVICE" -a -z "$BASH_SOURCE" ]; then
		echo "I: This script requires bash. Not processing the $FDEVICE $(basename $0)"
	fi
fi