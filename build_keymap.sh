#!/usr/bin/bash

DIR="$PWD"
cd zmk/app/ || exit

# Check argument first if these are valid keyboards
if [ $# == 0 ]
then
   echo "USAGE: $0 [keyboard0] [keyboard1] ..."
   printf 'AVAILABLE KEYBOARDS: \t endgame\n \t\t\t klotz'
else
    for arg
    do
        case "$arg" in
            endgame)    ;;
            klotz)      ;;
            klor)       ;;
            *)          echo "ERROR: Keyboard '$arg' is invalid."
                        exit
                        ;;
        esac
    done
fi

for arg
do
    case "$arg" in
        endgame)    west build -p -b rp2040_zero -- -DSHIELD=endgame -DZMK_CONFIG="$DIR/boards/shields/endgame/config" -DZMK_EXTRA_MODULES="$DIR/modules/zmk-component-rp2040-zero"
                    mv build/zephyr/zmk.uf2 "$DIR/flash/endgame.uf2" || exit
                    ;;
        klotz)      west build -p -b nice_nano_v2 -- -DSHIELD=klotz_left -DZMK_CONFIG="$DIR/boards/shields/klotz/config"
                    mv build/zephyr/zmk.uf2 "$DIR/flash/klotz_left.uf2" || exit
                    west build -p -b nice_nano_v2 -- -DSHIELD=klotz_right -DZMK_CONFIG="$DIR/boards/shields/klotz/config"
                    mv build/zephyr/zmk.uf2 "$DIR/flash/klotz_right.uf2" || exit
                    ;;
        klor)       west build -p -b sparkfun_pro_micro_rp2040 -- -DSHIELD=klor_left -DZMK_CONFIG="$DIR/boards/shields/klor/config"
                    mv build/zephyr/zmk.uf2 "$DIR/flash/klor_left.uf2" || exit
                    west build -p -b sparkfun_pro_micro_rp2040 -- -DSHIELD=klor_right -DZMK_CONFIG="$DIR/boards/shields/klor/config"
                    mv build/zephyr/zmk.uf2 "$DIR/flash/klor_right.uf2" || exit
                    ;;
    esac
done

for arg
do
    case "$arg" in
        endgame)    echo "Flash file for Endgame stored: $DIR/flash/endgame.uf2"
                    ;;
        klotz)      echo "Flash files for KLOTZ stored: $DIR/flash/klotz_left.uf2 and $DIR/flash/klotz_right.uf2"
                    ;;
        klor)      echo "Flash files for KLOR stored: $DIR/flash/klor_left.uf2 and $DIR/flash/klor_right.uf2"
                    ;;
    esac
done

cd "$DIR" || exit
