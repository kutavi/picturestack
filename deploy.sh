#!/usr/bin/env bash
prepareExport () {
    echo "Exporting for $1..."
    cp -f platforms/$1/platform.gd godot/scripts/platform.gd
    cp -f platforms/$1/override.cfg godot/override.cfg
    ~/godot.exe --path ./godot/ --export "HTML5"
}

prepareFile () {
    echo "Creating final zip..."
    rm -rf picturestack_$1.zip
    powershell "Compress-Archive docs/* picturestack_$1.zip"
}

PS3='Deploy for which platform? Enter a number: '
options=("default" "cmg" "all")
select opt in "${options[@]}"
do
    case $opt in
        "all"|"default")
            prepareExport "default"
            rm -rf docs/splash.png
            prepareFile "web"
            ;;&
        "all"|"cmg")
            prepareExport "cmg"
            echo "Copying files to export folder..."
            cp -f platforms/cmg/index.html docs/index.html
            cp -f platforms/cmg/splash.png docs/splash.png
            prepareFile "cmg"
            ;;&
        *) echo "Exiting..." break;;
    esac
done

echo "Done."