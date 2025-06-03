#!/usr/bin/bash

DIR=$PWD
cd zmk/app/ || exit

# ENDGAME
west build -p -b rp2040_zero -- -DSHIELD=endgame -DZMK_CONFIG="$DIR/boards/shields/endgame/config" -DZMK_EXTRA_MODULES="$DIR/modules/zmk-component-rp2040-zero"
mv build/zephyr/zmk.uf2 "$DIR"/flash/endgame.uf2 || exit

# KLOTZ
west build -p -b nice_nano_v2 -- -DSHIELD=klotz_left -DZMK_CONFIG="$DIR/boards/shields/klotz/config"
mv build/zephyr/zmk.uf2 "$DIR"/flash/klotz_left.uf2 || exit
west build -p -b nice_nano_v2 -- -DSHIELD=klotz_right -DZMK_CONFIG="$DIR/boards/shields/klotz/config"
mv build/zephyr/zmk.uf2 "$DIR"/flash/klotz_right.uf2 || exit

echo "Flash file for Endgame stored: $DIR/flash/endgame.uf2 "
echo "Flash files for KLOTZ stored: $DIR/flash/klotz_left.uf2 and $DIR/flash/klotz_right.uf2"

cd "$DIR" || exit
