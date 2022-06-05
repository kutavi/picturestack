extends Node

const FRAME_SCALE = Vector2(0.8, 0.8)
const BOARD_SCALE = Vector2(0.7, 0.7)
const PART_SCALE = Vector2(0.58, 0.58)

var game_ended = false
var images = []
var winning_order

func _ready():
	get_node(Global.WINNING_POPUP).hide()
	if (!Global.level):
		_load_level()
	var level = Global.level

	if level == 1:
		images.append(preload("res://assets/heart.webp"))
		images.append(preload("res://assets/arrow.webp"))
		winning_order = [null, [1]] # 1st asset doesnt matter, 2nd should be before 1st
	if level == 2:
		images.append(preload("res://assets/worm.webp"))
		images.append(preload("res://assets/apple.webp"))
		images.append(preload("res://assets/leaves.webp"))
		images.append(preload("res://assets/plate.webp"))
		winning_order = [[2], null, [2], [2]]
	if level == 4:
		images.append(preload("res://assets/road.webp"))
		images.append(preload("res://assets/house.webp"))
		images.append(preload("res://assets/grass.webp"))
		images.append(preload("res://assets/sky.webp"))
		images.append(preload("res://assets/fence.webp"))
		winning_order = [[2, 5], null, [1], [3], null] # 1st asset before 2nd AND 5th
	if level == 3:
		images.append(preload("res://assets/cloud.webp"))
		images.append(preload("res://assets/pen.webp"))
		images.append(preload("res://assets/shirt.webp"))
		images.append(preload("res://assets/unicorn.webp"))
		images.append(preload("res://assets/pocket.webp"))
		images.append(preload("res://assets/rainbow.webp"))
		images.append(preload("res://assets/hanger.webp"))
		winning_order = [null, [5], [2, 6], null, null, [1, 4], [3]]
	if level == 5:
		images.append(preload("res://assets/cloth.webp"))
		images.append(preload("res://assets/vase.webp"))
		images.append(preload("res://assets/pictures.webp"))
		images.append(preload("res://assets/flowers.webp"))
		images.append(preload("res://assets/carpet.webp"))
		images.append(preload("res://assets/table.webp"))
		winning_order = [[2], null, [4], [2], [6], [1]]
	if level == 6:
		images.append(preload("res://assets/boat.webp"))
		images.append(preload("res://assets/sea.webp"))
		images.append(preload("res://assets/sea1.webp"))
		images.append(preload("res://assets/sun.webp"))
		images.append(preload("res://assets/shark.webp"))
		images.append(preload("res://assets/island.webp"))
		winning_order = [[3], [6], [5], [3], [2], null]
	_level_setup()
		

func check_winning():
	var board = get_node(Global.BOARD)
	var won = true
	for n in range (1, len(images) + 1):
		if !board.get_node(Global.BOARD_PART + String(n)).is_visible():
			return
	for n in range(0, len(images)):
		var item_index = n + 1
		var should_be_after_array = winning_order[n]
		if should_be_after_array:
			var item_placement = board.get_node(Global.BOARD_PART + str(item_index)).z_index
			for m in range(0, len(should_be_after_array)):
				var should_be_after_index = should_be_after_array[m]
				var item_that_should_be_after = board.get_node(Global.BOARD_PART + str(should_be_after_index)).z_index
				if item_placement > item_that_should_be_after:
					won = false
	if won:
		game_ended = true
		# place picture into the winning frame
		for n in range (1, len(images) + 1):
			var node = board.get_node(Global.BOARD_PART + String(n))
			node.set_scale(FRAME_SCALE)
			node.position.y = node.position.y - 80
			node.position.x = node.position.x - 70
			node.set_rotation(0.124)
		get_node(Global.WINNING_POPUP).show()
		_save_level()

func _level_setup():
	var image_parts = get_node(Global.IMAGE_PARTS_GROUP)
	var board = get_node(Global.BOARD)
	for n in range(1, len(images) + 1):
		var image_part = image_parts.get_node(Global.IMAGE_PART + String(n))
		var board_part = board.get_node(Global.BOARD_PART + String(n))
		image_part.get_node(Global.IMAGE_SPRITE).set_texture(images[n - 1])
		image_part.get_node(Global.IMAGE_SPRITE).set_scale(PART_SCALE)
		image_part.set_script(load(Global.SCRIPTS_PATH + "image_part.gd"))
		image_part.set_process_input(true) # we need to enable this since we load the script via code
		board_part.set_texture(images[n - 1])
		board_part.set_scale(BOARD_SCALE)
		board_part.hide()
	for n in range(len(images) + 1, 9): # clean up the rest unused places
		image_parts.get_node(Global.IMAGE_PART + String(n)).queue_free()
		board.get_node(Global.BOARD_PART + String(n)).queue_free()
			
																																																																																																																																																					   
func _load_level():
	print("Loading...")

	var save_file = File.new()
	if not save_file.file_exists(Global.SAVE_FILE):
		print("No savefile")
		Global.level = 1
		return

	save_file.open(Global.SAVE_FILE, File.READ)
	Global.level = int(save_file.get_line())
	if (!Global.level):
		Global.level = 1
	save_file.close()

func _save_level():
	print("Saving...")

	var save_file = File.new()
	save_file.open(Global.SAVE_FILE, File.WRITE)
	save_file.store_line(String(Global.level + 1))
	save_file.close()

func _on_NextLevel_pressed():
	Global.level = Global.level + 1
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()

