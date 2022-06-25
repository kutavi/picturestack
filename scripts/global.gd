extends Node

var reached_level = 1
var current_level = 1

var has_loaded = false
var sound_enabled = 1

const BOARD_PART = "b"
const IMAGE_PART = "P"
const ALBUM_PART = "L"

const levels = [
	'heart',
	'hourglass',
	'apple',
	"flower",
	"photo",
	"watch",
	"shirt",
	"book",
	"milkshake",
	"darts",
	"burger",
	"house",
	"train",
	"vase",
	"window",
	"board",
	"lamp",
	"sea",
	"bridge",
	"crown"
]

var total_levels = len(levels)

const LEVEL_NODE = "/root/Level/"
const BOARD_NODE = "/root/Level/Board"
const MENU_NODE = "/root/Level/Menu"
const ALBUM_NODE = "/root/Level/Album"
const ALBUM_LEVELS_NODE = "/root/Level/Album/Levels"
const WINNING_POPUP_NODE = "/root/Level/Win"
const HINT_POPUP_NODE = "/root/Level/Hint"
const RESET_CONFIRM_NODE = "/root/Level/ConfirmationDialog"
const VICTORY_NODE = "/root/Level/Victory"
const RULES_TEXT_NODE = "/root/Level/Board/Rules"
const IMAGE_PARTS_NODE = "/root/Level/ImageParts"

const MENU_SOUND_NODE = "/root/Level/MenuClick"
const SELECT_SOUND_NODE = "/root/Level/TileSelect"
const UNSELECT_SOUND_NODE = "/root/Level/TileRemove"
const WIN_SOUND_NODE = "/root/Level/Win/LevelWin"

const IMAGE_SPRITE_NODE = "Sprite"
const FRAME_SPRITE_NODE = "Frame/Sprite"

const ASSETS_PATH = "res://assets/"
const ALBUM_PATH = "res://assets/levels/"
const SCRIPTS_PATH = "res://scripts/"

const SAVE_FILE = "user://savefile.save"

