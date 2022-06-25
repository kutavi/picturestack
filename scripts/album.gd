extends Node

const FRAME_SCALE = Vector2(0.45, 0.45)

var page = 0
var levels_per_page = 8
var starting_level
var images = []


func _ready():
	for lvlKey in Global.levels:
		images.append(load(Global.ALBUM_PATH + "level_" + lvlKey + ".webp"))
	var levels = get_node(Global.ALBUM_LEVELS_NODE)
	for n in range(1, levels.get_child_count() + 1):
		var level_select = levels.get_node(Global.ALBUM_PART + String(n))
		level_select.set_script(load(Global.SCRIPTS_PATH + "level_selection.gd"))
		level_select.set_process_input(true) # we need to enable this since we load the script via code


func _handle_page_change():
	starting_level = page * levels_per_page + 1
	get_node("NextPage").show()
	get_node("PrevPage").show()
	get_node("Reset").hide()
	get_node("Credits").hide()
	if (page == 0):
		get_node("PrevPage").hide()
	if (page == Global.total_levels / levels_per_page):
		get_node("NextPage").hide()
	var levels =  get_node(Global.ALBUM_LEVELS_NODE)
	for m in range(0, levels.get_child_count()):
		var level_select = levels.get_node(Global.ALBUM_PART + String(m + 1))
		var which_level = starting_level + m
		if (starting_level + m) <= Global.total_levels:
			level_select.show()
			var sprite = level_select.get_node(Global.FRAME_SPRITE_NODE)
			if which_level < Global.reached_level:
				sprite.set_texture(images[which_level - 1])
				level_select.disabled = false
				level_select.level_number = which_level
				sprite.set_scale(FRAME_SCALE)
			elif which_level == Global.reached_level:
				sprite.set_texture(load(Global.ASSETS_PATH + "unlocked.png"))
				level_select.disabled = false
				level_select.level_number = which_level
				sprite.set_scale(Vector2(1, 1))
			else:
				sprite.set_texture(load(Global.ASSETS_PATH + "locked.webp"))
				level_select.disabled = true
				sprite.set_scale(Vector2(1, 1))
		else:
			level_select.hide()
			get_node("Reset").show()
			get_node("Credits").show()


func open(): 
	get_node(Global.ALBUM_NODE).show()
	get_node(Global.BOARD_NODE).hide()
	get_node(Global.WINNING_POPUP_NODE).hide()
	get_node(Global.MENU_NODE).hide()
	get_node(Global.VICTORY_NODE).hide()
	get_node("AlbumOpen").play()
	# open page showing the current level
	if Global.current_level % levels_per_page:
		page = Global.current_level / levels_per_page
	else:
		page = Global.current_level / levels_per_page - 1 # to cover the case of the last item on a page
	_handle_page_change()


func _close():
	get_node(Global.BOARD_NODE).show()
	get_node(Global.ALBUM_NODE).hide()
	get_node(Global.MENU_NODE).show()
	get_node("AlbumClose").play()
	if get_node(Global.LEVEL_NODE).game_ended:
		get_node(Global.WINNING_POPUP_NODE).show()
	if Global.current_level > Global.total_levels:
		get_node(Global.BOARD_NODE).hide()
		get_node(Global.VICTORY_NODE).show()


func _on_NextPage_pressed():
	page = page + 1
	get_node("PageFlip").pitch_scale = rand_range(0.9, 1)
	get_node("PageFlip").play()
	_handle_page_change()


func _on_PrevPage_pressed():
	page = page - 1
	get_node("PageFlip").pitch_scale = rand_range(1, 1.1)
	get_node("PageFlip").play()
	_handle_page_change()


func _on_Close_pressed():
	_close()


func _on_Reset_pressed():
	get_node(Global.MENU_SOUND_NODE).play()
	get_node(Global.RESET_CONFIRM_NODE).popup()


func _on_Reset_confirm():
	Global.reached_level = 1
	Global.current_level = 1
	get_node(Global.LEVEL_NODE).save()
	_close()
	get_tree().reload_current_scene()

