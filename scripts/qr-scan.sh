#!/bin/sh
grim -g "$(slurp)" - | zbarimg -q --raw -
