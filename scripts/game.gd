extends Node

const FRAME_SCALE = Vector2(0.8, 0.8)
const BOARD_SCALE = Vector2(0.7, 0.7)
const PART_SCALE = Vector2(0.58, 0.58)

var game_ended = false
var images = []
var winning_order

func _ready():
	get_node(Global.WINNING_POPUP).hide()
	get_node(Global.BOARD).show()
	get_node(Global.IMAGE_PARTS_GROUP).show()
	get_node(Global.ALBUM).hide()
	get_node(Global.VICTORY).hide()

	if (!Global.reached_level):
		_load_level()
	var level = Global.current_level
	if level == 1:
		images.append(preload("res://assets/level_parts/heart.webp"))
		images.append(preload("res://assets/level_parts/arrow.webp"))
		winning_order = [null, [1]] # 1st asset doesnt matter, 2nd should be before 1st
	elif level == 2:
		images.append(preload("res://assets/level_parts/glass3.webp"))
		images.append(preload("res://assets/level_parts/case.webp"))
		images.append(preload("res://assets/level_parts/sand.webp"))
		winning_order = [[3], null, [2]]
	elif level == 3:
		images.append(preload("res://assets/level_parts/worm.webp"))
		images.append(preload("res://assets/level_parts/apple.webp"))
		images.append(preload("res://assets/level_parts/leaves.webp"))
		images.append(preload("res://assets/level_parts/plate.webp"))
		winning_order = [[2], null, [2], [2]]
	elif level == 4:
		images.append(preload("res://assets/level_parts/glass.webp"))
		images.append(preload("res://assets/level_parts/dial.webp"))
		images.append(preload("res://assets/level_parts/strap.webp"))
		images.append(preload("res://assets/level_parts/metal.webp"))
		images.append(preload("res://assets/level_parts/hands.webp"))
		winning_order = [null, [5], [4], [2], [1]]
	elif level == 5:
		images.append(preload("res://assets/level_parts/bee.webp"))
		images.append(preload("res://assets/level_parts/flowerpot.webp"))
		images.append(preload("res://assets/level_parts/soil.webp"))
		images.append(preload("res://assets/level_parts/flower.webp"))
		images.append(preload("res://assets/level_parts/drawing.webp"))
		images.append(preload("res://assets/level_parts/stem.webp"))
		winning_order = [null, [3, 5], [6], [1], null, [4]]
	elif level == 6:
		images.append(preload("res://assets/level_parts/sky3.webp"))
		images.append(preload("res://assets/level_parts/glass2.webp"))
		images.append(preload("res://assets/level_parts/bunny.webp"))
		images.append(preload("res://assets/level_parts/frame.webp"))
		images.append(preload("res://assets/level_parts/land.webp"))
		winning_order = [[5], [4], [2], null, [3]]
	elif level == 7:
		images.append(preload("res://assets/level_parts/cloud.webp"))
		images.append(preload("res://assets/level_parts/pen.webp"))
		images.append(preload("res://assets/level_parts/shirt.webp"))
		images.append(preload("res://assets/level_parts/unicorn.webp"))
		images.append(preload("res://assets/level_parts/pocket.webp"))
		images.append(preload("res://assets/level_parts/rainbow.webp"))
		images.append(preload("res://assets/level_parts/hanger.webp"))
		winning_order = [null, [5], [2, 6], null, null, [1, 4], [3]]
	elif level == 8:
		images.append(preload("res://assets/level_parts/magnify.webp"))
		images.append(preload("res://assets/level_parts/images.webp"))
		images.append(preload("res://assets/level_parts/text.webp"))
		images.append(preload("res://assets/level_parts/pencil.webp"))
		images.append(preload("res://assets/level_parts/book.webp"))
		images.append(preload("res://assets/level_parts/bookmark.webp"))
		winning_order = [null, [1, 4, 6], [2], null, [3], null]
	elif level == 9:
		images.append(preload("res://assets/level_parts/board.webp"))
		images.append(preload("res://assets/level_parts/dart.webp"))
		images.append(preload("res://assets/level_parts/dot2.webp"))
		images.append(preload("res://assets/level_parts/guides.webp"))
		images.append(preload("res://assets/level_parts/dot3.webp"))
		images.append(preload("res://assets/level_parts/dot.webp"))
		images.append(preload("res://assets/level_parts/dot4.webp"))
		winning_order = [[7], null, [6], [2], [3], [4], [5]]
	elif level == 10:
		images.append(preload("res://assets/level_parts/road.webp"))
		images.append(preload("res://assets/level_parts/house.webp"))
		images.append(preload("res://assets/level_parts/grass.webp"))
		images.append(preload("res://assets/level_parts/sky.webp"))
		images.append(preload("res://assets/level_parts/fence.webp"))
		winning_order = [[2, 5], null, [1], [3], null] # 1st asset before 2nd AND 5th
	elif level == 11:
		images.append(preload("res://assets/level_parts/rails.webp"))
		images.append(preload("res://assets/level_parts/sky.webp"))
		images.append(preload("res://assets/level_parts/train.webp"))
		images.append(preload("res://assets/level_parts/mountain.webp"))
		images.append(preload("res://assets/level_parts/tunnel.webp"))
		winning_order = [[3], [4], null, [5], [1]]
	elif level == 12:
		images.append(preload("res://assets/level_parts/cloth.webp"))
		images.append(preload("res://assets/level_parts/vase.webp"))
		images.append(preload("res://assets/level_parts/pictures.webp"))
		images.append(preload("res://assets/level_parts/flowers.webp"))
		images.append(preload("res://assets/level_parts/carpet.webp"))
		images.append(preload("res://assets/level_parts/table.webp"))
		winning_order = [[2], null, [4], [2], [6], [1]]
	elif level == 13:
		images.append(preload("res://assets/level_parts/bowl.webp"))
		images.append(preload("res://assets/level_parts/curtains.webp"))
		images.append(preload("res://assets/level_parts/window.webp"))
		images.append(preload("res://assets/level_parts/cupboard.webp"))
		images.append(preload("res://assets/level_parts/fruits.webp"))
		images.append(preload("res://assets/level_parts/view.webp"))
		images.append(preload("res://assets/level_parts/wall.webp"))
		winning_order = [null, [4], [2, 5], null, [1], [3], [6]]
	elif level == 14:
		images.append(preload("res://assets/level_parts/magnets.webp"))
		images.append(preload("res://assets/level_parts/magneticboard.webp"))
		images.append(preload("res://assets/level_parts/posts.webp"))
		images.append(preload("res://assets/level_parts/writing.webp"))
		images.append(preload("res://assets/level_parts/canvas.webp"))
		images.append(preload("res://assets/level_parts/marker.webp"))
		winning_order = [null, [4], [1, 6], [3], [2], null]
	elif level == 15:
		images.append(preload("res://assets/level_parts/table2.webp"))
		images.append(preload("res://assets/level_parts/bulb.webp"))
		images.append(preload("res://assets/level_parts/lamp.webp"))
		images.append(preload("res://assets/level_parts/cup.webp"))
		images.append(preload("res://assets/level_parts/spoon.webp"))
		images.append(preload("res://assets/level_parts/tea.webp"))
		images.append(preload("res://assets/level_parts/base.webp"))
		images.append(preload("res://assets/level_parts/pot.webp"))
		winning_order = [[7, 5], [7], null, [6, 8], [4], null, [3], null]
	elif level == 16:
		images.append(preload("res://assets/level_parts/boat.webp"))
		images.append(preload("res://assets/level_parts/sea.webp"))
		images.append(preload("res://assets/level_parts/sea1.webp"))
		images.append(preload("res://assets/level_parts/sun.webp"))
		images.append(preload("res://assets/level_parts/shark.webp"))
		images.append(preload("res://assets/level_parts/island.webp"))
		winning_order = [[3], [6], [5], [3], [2], null]
	elif level == 17:
		images.append(preload("res://assets/level_parts/cars.webp"))
		images.append(preload("res://assets/level_parts/trees.webp"))
		images.append(preload("res://assets/level_parts/ground.webp"))
		images.append(preload("res://assets/level_parts/bridge.webp"))
		images.append(preload("res://assets/level_parts/ducks.webp"))
		images.append(preload("res://assets/level_parts/mountains.webp"))
		images.append(preload("res://assets/level_parts/river.webp"))
		winning_order = [[4], [1], [7], null, [4], [3], [1, 5]]
	else:
		get_node(Global.BOARD).hide()
		# get_node(Global.ALBUM).open()
		get_node(Global.VICTORY).show()
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
		Global.reached_level = 1
		Global.current_level = 1
		return

	save_file.open(Global.SAVE_FILE, File.READ)
	var saved_level = int(save_file.get_line())
	Global.reached_level = saved_level
	Global.current_level = saved_level

	if (!Global.reached_level):
		Global.reached_level = 1
		Global.current_level = 1
	save_file.close()

func _save_level():
	if (Global.current_level >= Global.reached_level):
		print("Saving...")
		var next_level = Global.current_level + 1
		var save_file = File.new()
		save_file.open(Global.SAVE_FILE, File.WRITE)
		save_file.store_line(String(next_level))
		Global.reached_level = next_level
		save_file.close()

func _on_NextLevel_pressed():
	Global.current_level = Global.current_level + 1
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()

