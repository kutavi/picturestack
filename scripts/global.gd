extends Node

var reached_level = 0
var current_level = 0

const BOARD_PART = "b"
const IMAGE_PART = "P"
const ALBUM_PART = "L"

const levels = [
	'heart',
	'hourglass',
	'apple',
	"watch",
	"flower",
	"photo",
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
	"bridge"
]

var total_levels = len(levels)

const LEVEL_NODE = "/root/Level/"
const BOARD_NODE = "/root/Level/Board"
const ALBUM_NODE = "/root/Level/Menu/Album"
const WINNING_POPUP_NODE = "/root/Level/Win"
const RESET_CONFIRM_NODE = "/root/Level/ConfirmationDialog"
const VICTORY_NODE = "/root/Level/Victory"
const RULES_TEXT_NODE = "/root/Level/Board/Rules"
const ALBUM_LEVELS_NODE = "/root/Level/Menu/Album/Levels"
const IMAGE_PARTS_NODE = "/root/Level/ImageParts"

const IMAGE_SPRITE_NODE = "Sprite"
const FRAME_SPRITE_NODE = "Frame/Sprite"

const ASSETS_PATH = "res://assets/"
const ALBUM_PATH = "res://assets/levels/"
const SCRIPTS_PATH = "res://scripts/"

const SAVE_FILE = "user://savefile.save"
