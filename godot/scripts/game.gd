extends Node

const FRAME_SCALE = Vector2(0.8, 0.8)
const BOARD_SCALE = Vector2(0.7, 0.7)
const PART_SCALE = Vector2(0.58, 0.58)

var game_ended = false
var images = []
var winning_order


func _ready():
	if (!Global.has_loaded):
		_load()

	_ui_setup()
	if (Global.current_level <= Global.total_levels):
		_level_select()
	else:
		get_node(Global.BOARD_NODE).hide()
		get_node(Global.MENU_NODE).get_node("ReloadButton").hide()
		get_node(Global.MENU_NODE).get_node("HintButton").hide()
		get_node(Global.VICTORY_NODE).show()
		get_node(Global.VICTORY_NODE).get_node("CompleteGame").play()
	
	_level_setup()
		


func check_winning():
	var board = get_node(Global.BOARD_NODE)
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
		if (Global.current_level >= Global.reached_level):
			Global.reached_level = Global.current_level + 1
			save()
		get_node(Global.WIN_SOUND_NODE).play()
		# place picture into the winning frame
		get_node(Global.WINNING_POPUP_NODE).show()
		get_node(Global.MENU_NODE).get_node("HintButton").hide()
		for n in range (1, len(images) + 1):
			var node = board.get_node(Global.BOARD_PART + String(n))
			node.set_scale(FRAME_SCALE)
			node.position.y = node.position.y - 80
			node.position.x = node.position.x - 40
			node.set_rotation(0.124)


func _ui_setup():
	get_node(Global.WINNING_POPUP_NODE).hide()
	get_node(Global.BOARD_NODE).show()
	get_node(Global.IMAGE_PARTS_NODE).show()
	get_node(Global.MENU_NODE).show()
	get_node(Global.HINT_POPUP_NODE).hide()
	get_node(Global.ALBUM_NODE).hide()
	get_node(Global.VICTORY_NODE).hide()
	if (!Global.sound_enabled):
		get_node(Global.MENU_NODE).mute_sound(true)

func _level_select():
		var level = Global.levels[Global.current_level - 1]
		match level:
			"heart":
				images.append(preload("res://assets/level_parts/heart.webp"))
				images.append(preload("res://assets/level_parts/arrow.webp"))
				winning_order = [null, [1]] # 1st asset doesnt matter, 2nd should be before 1st
			"hourglass":
				images.append(preload("res://assets/level_parts/glass3.webp"))
				images.append(preload("res://assets/level_parts/case.webp"))
				images.append(preload("res://assets/level_parts/sand.webp"))
				winning_order = [[3], null, [2]]
			"apple":
				images.append(preload("res://assets/level_parts/worm.webp"))
				images.append(preload("res://assets/level_parts/apple.webp"))
				images.append(preload("res://assets/level_parts/leaves.webp"))
				images.append(preload("res://assets/level_parts/plate.webp"))
				winning_order = [[2], null, [2], [2]]
			"watch":
				images.append(preload("res://assets/level_parts/glass.webp"))
				images.append(preload("res://assets/level_parts/dial.webp"))
				images.append(preload("res://assets/level_parts/strap.webp"))
				images.append(preload("res://assets/level_parts/metal.webp"))
				images.append(preload("res://assets/level_parts/hands.webp"))
				winning_order = [null, [5], [4], [2], [1]]
			"flower":
				images.append(preload("res://assets/level_parts/bee.webp"))
				images.append(preload("res://assets/level_parts/flowerpot.webp"))
				images.append(preload("res://assets/level_parts/soil.webp"))
				images.append(preload("res://assets/level_parts/flower.webp"))
				images.append(preload("res://assets/level_parts/drawing.webp"))
				images.append(preload("res://assets/level_parts/stem.webp"))
				winning_order = [null, [3, 5], [6], [1], null, [4]]
			"photo":
				images.append(preload("res://assets/level_parts/sky3.webp"))
				images.append(preload("res://assets/level_parts/glass2.webp"))
				images.append(preload("res://assets/level_parts/bunny.webp"))
				images.append(preload("res://assets/level_parts/frame.webp"))
				images.append(preload("res://assets/level_parts/land.webp"))
				winning_order = [[5], [4], [2], null, [3]]
			"shirt":
				images.append(preload("res://assets/level_parts/cloud.webp"))
				images.append(preload("res://assets/level_parts/pen.webp"))
				images.append(preload("res://assets/level_parts/shirt.webp"))
				images.append(preload("res://assets/level_parts/unicorn.webp"))
				images.append(preload("res://assets/level_parts/pocket.webp"))
				images.append(preload("res://assets/level_parts/rainbow.webp"))
				images.append(preload("res://assets/level_parts/hanger.webp"))
				winning_order = [null, [5], [2, 6], null, null, [1, 4], [3]]
			"book":
				images.append(preload("res://assets/level_parts/magnify.webp"))
				images.append(preload("res://assets/level_parts/images.webp"))
				images.append(preload("res://assets/level_parts/text.webp"))
				images.append(preload("res://assets/level_parts/pencil.webp"))
				images.append(preload("res://assets/level_parts/book.webp"))
				images.append(preload("res://assets/level_parts/bookmark.webp"))
				winning_order = [null, [1, 4, 6], [2], null, [3], null]
			"milkshake":
				images.append(preload("res://assets/level_parts/cap.webp"))
				images.append(preload("res://assets/level_parts/cream.webp"))
				images.append(preload("res://assets/level_parts/straw.webp"))
				images.append(preload("res://assets/level_parts/cup2.webp"))
				images.append(preload("res://assets/level_parts/sticker.webp"))
				winning_order = [[4], [1], [2], [5], null]
			"darts":
				images.append(preload("res://assets/level_parts/board.webp"))
				images.append(preload("res://assets/level_parts/dart.webp"))
				images.append(preload("res://assets/level_parts/dot2.webp"))
				images.append(preload("res://assets/level_parts/guides.webp"))
				images.append(preload("res://assets/level_parts/dot3.webp"))
				images.append(preload("res://assets/level_parts/dot.webp"))
				images.append(preload("res://assets/level_parts/dot4.webp"))
				winning_order = [[7], null, [6], [2], [3], [4], [5]]
			"burger":
				images.append(preload("res://assets/level_parts/salad.webp"))
				images.append(preload("res://assets/level_parts/pickles.webp"))
				images.append(preload("res://assets/level_parts/breadup.webp"))
				images.append(preload("res://assets/level_parts/beef.webp"))
				images.append(preload("res://assets/level_parts/flag.webp"))
				images.append(preload("res://assets/level_parts/breaddown.webp"))
				images.append(preload("res://assets/level_parts/cheese.webp"))
				winning_order = [[3], [1], null, [7], [6], [4], [2]]
			"house":
				images.append(preload("res://assets/level_parts/road.webp"))
				images.append(preload("res://assets/level_parts/house.webp"))
				images.append(preload("res://assets/level_parts/grass.webp"))
				images.append(preload("res://assets/level_parts/sky.webp"))
				images.append(preload("res://assets/level_parts/fence.webp"))
				winning_order = [[2, 5], null, [1], [3], null] # 1st asset before 2nd AND 5th
			"train":
				images.append(preload("res://assets/level_parts/rails.webp"))
				images.append(preload("res://assets/level_parts/sky.webp"))
				images.append(preload("res://assets/level_parts/train.webp"))
				images.append(preload("res://assets/level_parts/mountain.webp"))
				images.append(preload("res://assets/level_parts/tunnel.webp"))
				winning_order = [[3], [4], null, [5], [1]]
			"vase":
				images.append(preload("res://assets/level_parts/cloth.webp"))
				images.append(preload("res://assets/level_parts/vase.webp"))
				images.append(preload("res://assets/level_parts/pictures.webp"))
				images.append(preload("res://assets/level_parts/flowers.webp"))
				images.append(preload("res://assets/level_parts/carpet.webp"))
				images.append(preload("res://assets/level_parts/table.webp"))
				winning_order = [[2], null, [4], [2], [6], [1]]
			"window":
				images.append(preload("res://assets/level_parts/bowl.webp"))
				images.append(preload("res://assets/level_parts/curtains.webp"))
				images.append(preload("res://assets/level_parts/window.webp"))
				images.append(preload("res://assets/level_parts/table3.webp"))
				images.append(preload("res://assets/level_parts/fruits.webp"))
				images.append(preload("res://assets/level_parts/view.webp"))
				images.append(preload("res://assets/level_parts/chairs.webp"))
				images.append(preload("res://assets/level_parts/wall.webp"))
				winning_order = [null, [4], [2, 5], null, [1], [3], [4], [6]]
			"board":
				images.append(preload("res://assets/level_parts/magnets.webp"))
				images.append(preload("res://assets/level_parts/magneticboard.webp"))
				images.append(preload("res://assets/level_parts/posts.webp"))
				images.append(preload("res://assets/level_parts/writing.webp"))
				images.append(preload("res://assets/level_parts/canvas.webp"))
				images.append(preload("res://assets/level_parts/marker.webp"))
				winning_order = [null, [4], [1, 6], [3], [2], null]
			"lamp":
				images.append(preload("res://assets/level_parts/table2.webp"))
				images.append(preload("res://assets/level_parts/bulb.webp"))
				images.append(preload("res://assets/level_parts/lamp.webp"))
				images.append(preload("res://assets/level_parts/cup.webp"))
				images.append(preload("res://assets/level_parts/spoon.webp"))
				images.append(preload("res://assets/level_parts/tea.webp"))
				images.append(preload("res://assets/level_parts/base.webp"))
				images.append(preload("res://assets/level_parts/pot.webp"))
				winning_order = [[7, 5], [7], null, [6, 8], [4], null, [3], null]
			"sea":
				images.append(preload("res://assets/level_parts/boat.webp"))
				images.append(preload("res://assets/level_parts/sea.webp"))
				images.append(preload("res://assets/level_parts/sea1.webp"))
				images.append(preload("res://assets/level_parts/sun.webp"))
				images.append(preload("res://assets/level_parts/shark.webp"))
				images.append(preload("res://assets/level_parts/island.webp"))
				winning_order = [[3], [6], [5], [3], [2], null]
			"bridge":
				images.append(preload("res://assets/level_parts/cars.webp"))
				images.append(preload("res://assets/level_parts/trees.webp"))
				images.append(preload("res://assets/level_parts/ground.webp"))
				images.append(preload("res://assets/level_parts/bird.webp"))
				images.append(preload("res://assets/level_parts/bridge.webp"))
				images.append(preload("res://assets/level_parts/ducks.webp"))
				images.append(preload("res://assets/level_parts/mountains.webp"))
				images.append(preload("res://assets/level_parts/river.webp"))
				winning_order = [[5], [1], [8], null, [4], [5], [3], [1, 6]]
			"crown":
				images.append(preload("res://assets/level_parts/jewels.webp"))
				images.append(preload("res://assets/level_parts/lolipops.webp"))
				images.append(preload("res://assets/level_parts/crownfront.webp"))
				images.append(preload("res://assets/level_parts/pillow.webp"))
				images.append(preload("res://assets/level_parts/crownhead.webp"))
				images.append(preload("res://assets/level_parts/crownback.webp"))
				winning_order = [null, [3], [1], [3], [3], [4, 5]]
			"nest":
				images.append(preload("res://assets/level_parts/branch.webp"))
				images.append(preload("res://assets/level_parts/houses.webp"))
				images.append(preload("res://assets/level_parts/egg_top.webp"))
				images.append(preload("res://assets/level_parts/eggs.webp"))
				images.append(preload("res://assets/level_parts/nest.webp"))
				images.append(preload("res://assets/level_parts/chick.webp"))
				winning_order = [[5], [1], null, [5], null, [4, 3]]
			"icecream":
				images.append(preload("res://assets/level_parts/ball2.webp"))
				images.append(preload("res://assets/level_parts/ball1.webp"))
				images.append(preload("res://assets/level_parts/caprise.webp"))
				images.append(preload("res://assets/level_parts/ball3.webp"))
				images.append(preload("res://assets/level_parts/cone.webp"))
				images.append(preload("res://assets/level_parts/sprinkles.webp"))
				winning_order = [[2], [6], [4], [1], [2], null]
			"carousel":
				images.append(preload("res://assets/level_parts/horses2.webp"))
				images.append(preload("res://assets/level_parts/roof.webp"))
				images.append(preload("res://assets/level_parts/columns.webp"))
				images.append(preload("res://assets/level_parts/base2.webp"))
				images.append(preload("res://assets/level_parts/pole.webp"))
				images.append(preload("res://assets/level_parts/horses1.webp"))
				winning_order = [[5], null, [1, 2, 4], null, [5, 2, 4], null]
			"fireplace":
				images.append(preload("res://assets/level_parts/candles.webp"))
				images.append(preload("res://assets/level_parts/painting.webp"))
				images.append(preload("res://assets/level_parts/place.webp"))
				images.append(preload("res://assets/level_parts/fire.webp"))
				images.append(preload("res://assets/level_parts/fireplace.webp"))
				images.append(preload("res://assets/level_parts/wood.webp"))
				images.append(preload("res://assets/level_parts/candelabra.webp"))
				winning_order = [[7], [1], [6], null, [3, 7], [4], null]
			"phone":
				images.append(preload("res://assets/level_parts/dial_pad.webp"))
				images.append(preload("res://assets/level_parts/cable.webp"))
				images.append(preload("res://assets/level_parts/phone.webp"))
				images.append(preload("res://assets/level_parts/phone_case.webp"))
				images.append(preload("res://assets/level_parts/dial2.webp"))
				images.append(preload("res://assets/level_parts/holder.webp"))
				winning_order = [null, [3, 4], [6], [5], [1], [4]]
			"umbrella":
				images.append(preload("res://assets/level_parts/shelf.webp"))
				images.append(preload("res://assets/level_parts/stick.webp"))
				images.append(preload("res://assets/level_parts/books.webp"))
				images.append(preload("res://assets/level_parts/wall2.webp"))
				images.append(preload("res://assets/level_parts/drawings.webp"))
				images.append(preload("res://assets/level_parts/umbrella.webp"))
				images.append(preload("res://assets/level_parts/toy.webp"))
				images.append(preload("res://assets/level_parts/teddy.webp"))
				winning_order = [[3, 7], [6], [6], [1, 2, 5], [2], null, [6, 8], null]


func _level_setup():
	var image_parts = get_node(Global.IMAGE_PARTS_NODE)
	var board = get_node(Global.BOARD_NODE)
	for n in range(1, len(images) + 1):
		var image_part = image_parts.get_node(Global.IMAGE_PART + String(n))
		var board_part = board.get_node(Global.BOARD_PART + String(n))
		image_part.get_node(Global.IMAGE_SPRITE_NODE).set_texture(images[n - 1])
		image_part.get_node(Global.IMAGE_SPRITE_NODE).set_scale(PART_SCALE)
		image_part.set_script(load(Global.SCRIPTS_PATH + "image_part.gd"))
		image_part.set_process_input(true) # we need to enable this since we load the script via code
		board_part.get_node("Sprite").set_texture(images[n - 1])
		board_part.set_scale(BOARD_SCALE)
		board_part.hide()
	for n in range(len(images) + 1, 9): # clean up the rest unused places
		image_parts.get_node(Global.IMAGE_PART + String(n)).queue_free()
		board.get_node(Global.BOARD_PART + String(n)).queue_free()


func _load():
	print("Loading...")
	Global.has_loaded = true

	var save_file = File.new()
	if not save_file.file_exists(Global.SAVE_FILE):
		print("No savefile")
		return

	save_file.open(Global.SAVE_FILE, File.READ)
	var saved_level = int(save_file.get_line())
	var sound_enabled = int(save_file.get_line())
	Global.reached_level = saved_level
	Global.current_level = saved_level
	Global.sound_enabled = sound_enabled

	save_file.close()


func save():
	print("Saving...")
	var save_file = File.new()
	save_file.open(Global.SAVE_FILE, File.WRITE)
	save_file.store_line(String(Global.reached_level))
	save_file.store_line(String(Global.sound_enabled))
	save_file.close()


func _on_NextLevel_pressed():
	var next_level = Global.current_level + 1
	Global.current_level = next_level
	get_node(Global.TRACKING_NODE).level_starting(next_level)
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()

