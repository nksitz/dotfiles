#!/bin/bash

sketchybar --add item memory right \
           --set memory update_freq=2 \
                          script="$PLUGIN_DIR/memory.sh"

