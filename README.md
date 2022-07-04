# Picturestack
A casual puzzle game where you stack images to create a picture.

Play it on [itch.io](https://ffviikh.itch.io/picturestack)

## Built with
- Godot engine
- Assets from [flaticon](https://www.flaticon.com/)
- Sound effects from [freesound](https://www.freesound.org/)

## How to run
- install [Godot](https://godotengine.org/download)
- open the project
- press play button in the editor to run

## Project structure
- `godot/assets/` - folder with all the game assets (graphics, fonts, sounds)
- `godot/scripts/` - folder with all the project's scripts written in GDScript
- `docs/` - folder that will be created during export
- `platforms/` - platform specific files. Each platfrom has a separate folder the contents of which are used in the export script to build the game for that platform

## Exporting for HTML5
- place the godot executable to the root folder and rename to godot.exe (alternatively open the deploy.sh script and change the ~/godot.exe line with the path you have godot exeat)
- run `deploy.sh` script and select the web platform you are exporting to. This will export the project and prepare the final zip to be uploaded to that platform

## Adding a new level
To add a new level in the game follow this process:
- export the images for the level with size 512x512 and add them to the `level_parts` folder in assets
- decide a unique key identifier for the new level (example of current first level: "heart")
- export an image of the completed level (512x512) and add it to the `levels` folder in assets. The name should be `level_` + the level key. This image will be used in the album and level hint.
- in `game.gd` script at the `_level_select` function, add a new case using the level's key to preload the level's images and add the winning order array
- in `global.gd` add the level's key in the `levels` array. The position in the array determines the order this level will appear