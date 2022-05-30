extends Node

var level
var gameEnded = false
var images = []
var winningOrder

# Called when the node enters the scene tree for the first time.
func _ready():
	# get_node("PopupPanel").popup()
	print('LEVEL', level)
	get_node("Win").hide()
	if !level:
	  level = 1
	# images = []
	if level == 1:
		images.append(preload("res://assets/arrow.png"))
		images.append(preload("res://assets/heart.png"))
		images.append(preload("res://assets/background_blue.png"))
		winningOrder = [3, 1, 2]
	_level_setup()
		

func _check_winning():
	var board = get_node('Board')
	var won = true
	for n in range (1, len(images) + 1):
		if !board.get_node("b" + String(n)).is_visible():
			return
	for n in range(0, len(winningOrder) - 1):
		var first = winningOrder[n]
		var second = winningOrder[n + 1]
		if board.get_node("b" + String(first)).z_index > board.get_node("b" + String(second)).z_index:
			won = false
	if won:
		gameEnded = true
		for n in range (1, len(images) + 1):
			var node = board.get_node("b" + String(n))
			node.set_scale(Vector2(0.5, 0.5))
			node.position.y = node.position.y - 80
			node.position.x = node.position.x - 70
			node.set_rotation(0.124)
		get_node("Win").show()

func _level_setup():
	var imageParts = get_node('ImageParts')
	var board = get_node('Board')
	for n in range(1, len(images) + 1):
		var image_part = imageParts.get_node("P" + String(n))
		var board_part = board.get_node("b" + String(n))
		image_part.get_node('Sprite').set_texture(images[n - 1])
		image_part.get_node('Sprite').set_scale(Vector2(0.2,0.2))
		image_part.set_script(load("res://scripts/image_part.gd"))
		image_part.set_process_input(true)
		board_part.set_texture(images[n - 1])
		board_part.set_scale(Vector2(0.2,0.2))
		board_part.hide()
	for n in range(len(images) + 1, 9): # clean up the rest
		imageParts.get_node("P" + String(n)).queue_free()
		board.get_node("b" + String(n)).queue_free()
			

func _on_NextLevel_pressed():
	print('BUTTON')
	get_tree().root.level = get_tree().root.level + 1
	get_tree().reload_current_scene()

		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_NextLevel_button_down():
	print('BUTTON')
	level = level + 1
	get_tree().reload_current_scene()
