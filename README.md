# Picturestack
A casual puzzle game where you stack images to create a picture.

Play it on [Gihub pages](https://atseniklidou.github.io/picturestack/) or on [itch.io](https://ffviikh.itch.io/picturestack)

## Built with
- Godot engine
- Assets are from [Freepik - Flaticon](https://www.flaticon.com/)

## How to run
- install [Godot](https://godotengine.org/download)
- open the project
- press play button in the editor to run

## Project structure
- `assets/` - folder with all the game assets
- `scripts/` - folder with all the project's scripts written in GDScript
- `docs/` - folder of the exported project that loads in Github pages

## Adding a new level
To add a new level in the game follow this process:
- export the images for the level with size 512x512 and add them to the `level_parts` folder in assets
- decide a unique key identifier for the new level (example of current first level: "heart")
- export an image of the completed level (512x512) and add to the `levels` folder in assets. The name should be `level_` + the level key. This image will be used in the albmum for level selection
- in `game.gd` script at the `_level_select` function, using the level's key preload the level's images and add the winning order array
- in `global.gd` add the level's key in the `levels` array. The position in the array determines the order this level will appear