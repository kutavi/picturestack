extends Node

const FRAME_SCALE = Vector2(0.45, 0.45)

var page = 0
var levels_per_page = 8
var starting_level
var images = []


func _ready():
	_prepare_levels()
	var levels = self.get_node("Levels")
	for n in range(1, levels.get_child_count() + 1):
		var level_select = levels.get_node('L' + String(n))
		level_select.set_script(load(Global.SCRIPTS_PATH + "level.gd"))
		level_select.set_process_input(true) # we need to enable this since we load the script via code

func _prepare_levels():
	images.append(preload("res://assets/levels/level_heart.webp"))
	images.append(preload("res://assets/levels/level_hourglass.webp"))
	images.append(preload("res://assets/levels/level_apple.webp"))
	images.append(preload("res://assets/levels/level_watch.webp"))
	images.append(preload("res://assets/levels/level_flower.webp"))
	images.append(preload("res://assets/levels/level_photo.webp"))
	images.append(preload("res://assets/levels/level_shirt.webp"))
	images.append(preload("res://assets/levels/level_book.webp"))
	images.append(preload("res://assets/levels/level_darts.webp"))
	images.append(preload("res://assets/levels/level_house.webp"))
	images.append(preload("res://assets/levels/level_train.webp"))
	images.append(preload("res://assets/levels/level_vase.webp"))
	images.append(preload("res://assets/levels/level_window.webp"))
	images.append(preload("res://assets/levels/level_board.webp"))
	images.append(preload("res://assets/levels/level_lamp.webp"))
	images.append(preload("res://assets/levels/level_sea.webp"))
	images.append(preload("res://assets/levels/level_bridge.webp"))

func _handle_page_change():
	starting_level = page * levels_per_page + 1
	get_node('NextPage').show()
	get_node('PrevPage').show()
	get_node("Reset").hide()
	if (page == 0):
		get_node('PrevPage').hide()
	if (page == Global.total_levels / levels_per_page):
		get_node('NextPage').hide()
	var levels = self.get_node("Levels")
	for m in range(0, levels.get_child_count()):
		var level_select = levels.get_node('L' + String(m + 1))
		var which_level = starting_level + m
		if (starting_level + m) <= Global.total_levels:
			level_select.show()
			if which_level < Global.reached_level:
				level_select.get_node(Global.FRAME_SPRITE).set_texture(images[which_level - 1])
				level_select.disabled = false
				level_select.level_number = which_level
				level_select.get_node(Global.FRAME_SPRITE).set_scale(FRAME_SCALE)
			elif which_level == Global.reached_level:
				level_select.get_node(Global.FRAME_SPRITE).set_texture(load('res://assets/unlocked.png'))
				level_select.disabled = false
				level_select.level_number = which_level
				level_select.get_node(Global.FRAME_SPRITE).set_scale(Vector2(1, 1))
			else:
				level_select.get_node(Global.FRAME_SPRITE).set_texture(load('res://assets/locked.webp'))
				level_select.disabled = true
				level_select.get_node(Global.FRAME_SPRITE).set_scale(Vector2(1, 1))
		else:
			level_select.hide()
			get_node("Reset").show()

func open(): 
	get_node(Global.ALBUM).show()
	get_node(Global.BOARD).hide()
	get_node(Global.WINNING_POPUP).hide()
	get_node(Global.VICTORY).hide()
	# open page showing the current level
	if Global.current_level % levels_per_page:
		page = Global.current_level / levels_per_page
	else:
		page = Global.current_level / levels_per_page - 1 # to cover the case of the last item on a page
	_handle_page_change()
	
func _close():
	get_node(Global.BOARD).show()
	if get_node(Global.LEVEL).game_ended:
		get_node(Global.WINNING_POPUP).show()
	if Global.current_level > Global.total_levels:
		get_node(Global.BOARD).hide()
		get_node(Global.VICTORY).show()
	get_node(Global.ALBUM).hide()
	
func _on_NextPage_pressed():
	page = page + 1
	_handle_page_change()

func _on_PrevPage_pressed():
	page = page - 1
	_handle_page_change()

func _on_Close_pressed():
	_close()

func _on_Open_pressed():
	open()

func _on_Reset_pressed():
	var confirmation = get_node("/root/Level/ConfirmationDialog")
	confirmation.popup()
	
func _on_Reset_confirm():
	Global.reached_level = 0
	var dir = Directory.new()
	dir.remove(Global.SAVE_FILE)
	_close()
	get_tree().reload_current_scene()
