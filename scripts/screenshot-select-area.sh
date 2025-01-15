#!/bin/sh
SAVE_DIR="$HOME/qr_codes"  # Change this to your preferred directory
mkdir -p "$SAVE_DIR"

OUTPUT=$(grim -g "$(slurp)" - | zbarimg -q --raw -)

if [ -n "$OUTPUT" ]; then
    FILENAME=$(echo "$OUTPUT" | head -n1 | tr -cd '[:alnum:]._-')
    echo "$OUTPUT" > "$SAVE_DIR/${FILENAME}.txt"
    echo "Saved to $SAVE_DIR/${FILENAME}.txt"
else
    echo "No QR code detected or failed to capture"
fi
