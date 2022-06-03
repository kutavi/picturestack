extends Node

var gameEnded = false
var images = []
var winningOrder

# Called when the node enters the scene tree for the first time.
func _ready():
	# get_node("PopupPanel").popup()
	get_node("Win").hide()
	if (!Global.level):
		load_level()
	var level = Global.level
	if level == 1:
		images.append(preload("res://assets/arrow.png"))
		images.append(preload("res://assets/heart.webp"))
		images.append(preload("res://assets/background_blue.png"))
		winningOrder = [2, 0, 1] # 1 before 2, 2 doesnt matter, 3 before 1
	if level == 2:
		images.append(preload("res://assets/road.png"))
		images.append(preload("res://assets/house.png"))
		images.append(preload("res://assets/clouds.png"))
		images.append(preload("res://assets/fence.webp"))
		winningOrder = [2, 4, 2, 0]
	if level == 3:
		images.append(preload("res://assets/boat.webp"))
		images.append(preload("res://assets/sea.webp"))
		images.append(preload("res://assets/sea1.webp"))
		images.append(preload("res://assets/sun.webp"))
		images.append(preload("res://assets/shark.webp"))
		images.append(preload("res://assets/island.webp"))
		winningOrder = [3, 6, 5, 3, 2, 0]
	_level_setup()
		

func _check_winning():
	var board = get_node('Board')
	var won = true
	for n in range (1, len(images) + 1):
		if !board.get_node("b" + String(n)).is_visible():
			return
	for n in range(0, len(images)):
		var itemIndex = n + 1
		var shouldBeBefore = winningOrder[n] 
		if shouldBeBefore:
			if board.get_node("b" + String(itemIndex)).z_index > board.get_node("b" + String(shouldBeBefore)).z_index:
				won = false
	if won:
		gameEnded = true
		for n in range (1, len(images) + 1):
			var node = board.get_node("b" + String(n))
			node.set_scale(Vector2(0.75, 0.75))
			node.position.y = node.position.y - 80
			node.position.x = node.position.x - 70
			node.set_rotation(0.124)
		get_node("Win").show()
		save_level()

func _level_setup():
	var imageParts = get_node('ImageParts')
	var board = get_node('Board')
	for n in range(1, len(images) + 1):
		var image_part = imageParts.get_node("P" + String(n))
		var board_part = board.get_node("b" + String(n))
		image_part.get_node('Sprite').set_texture(images[n - 1])
		image_part.get_node('Sprite').set_scale(Vector2(0.35,0.35))
		image_part.set_script(load("res://scripts/image_part.gd"))
		image_part.set_process_input(true)
		board_part.set_texture(images[n - 1])
		board_part.set_scale(Vector2(0.2,0.2))
		board_part.hide()
	for n in range(len(images) + 1, 9): # clean up the rest
		imageParts.get_node("P" + String(n)).queue_free()
		board.get_node("b" + String(n)).queue_free()
			

func load_level():
	print("Loading...")
	var dir = Directory.new()
	dir.remove("user://savegame.save")
	var save_file = File.new()
	if not save_file.file_exists("user://savefile.save"):
		print("Aborting, no savefile")
		Global.level = 1
		return

	save_file.open("user://savefile.save", File.READ)
	Global.level = int(save_file.get_line())
	if (!Global.level):
		Global.level = 1
	save_file.close()

func save_level():
	print("Saving...")

	var save_file = File.new()
	save_file.open("user://savefile.save", File.WRITE)
	save_file.store_line(String(Global.level + 1))
	save_file.close()

func _on_NextLevel_pressed():
	Global.level = Global.level + 1
	get_tree().reload_current_scene()

