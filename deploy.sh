#!/usr/bin/env bash
PS3='Deploy for which platform? Enter a number: '
options=("default" "cmg")
select opt in "${options[@]}"
do
    case $opt in
        "default")
            echo "Exporting for $opt..."
            cp -f platforms/$opt/platform.gd godot/scripts/platform.gd
            cp -f platforms/$opt/override.cfg godot/override.cfg
            ~/godot.exe --path ./godot/ --export "HTML5"
            rm -rf docs/splash.png
            break
            ;;
        "cmg")
            echo "Exporting for $opt..."
            cp -f platforms/$opt/platform.gd godot/scripts/platform.gd
            cp -f platforms/$opt/override.cfg godot/override.cfg
            ~/godot.exe --path ./godot/ --export "HTML5"
            echo "Copying files to export folder..."
            cp -f platforms/$opt/index.html docs/index.html
            cp -f platforms/$opt/splash.png docs/splash.png
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

echo "Creating final zip..."
rm -rf picturestack_$opt.zip
powershell "Compress-Archive docs/* picturestack_$opt.zip"

echo "Done."