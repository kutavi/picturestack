extends Node

var _placed_on_board = false

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed() \
	and !get_node(Global.LEVEL_NODE).game_ended \
	and !get_node(Global.ALBUM_NODE).is_visible() \
	and !get_node(Global.HINT_POPUP_NODE).is_visible():
		self._place_image()
		get_node(Global.LEVEL_NODE).check_winning()

func _get_board_piece(num):
	return get_node(Global.BOARD_NODE).get_node(Global.BOARD_PART + num)

func remove_image():
	var image = self.get_node(Global.IMAGE_SPRITE_NODE)
	var which_one_to_handle = self.name[1]
	var tile = _get_board_piece(which_one_to_handle)
	tile.hide()
	tile.set_collision_layer(1)
	tile.z_index = 0
	# re-enable image part
	image.modulate = Color(1, 1, 1, 1)
	_placed_on_board = false
	get_node(Global.SELECT_SOUND_NODE).pitch_scale = 0.4
	get_node(Global.SELECT_SOUND_NODE).play()
	
func _add_image():
	var image = self.get_node(Global.IMAGE_SPRITE_NODE)
	var which_one_to_handle = self.name[1]
	var tile = _get_board_piece(which_one_to_handle)
	tile.show()
	tile.set_collision_layer(2)
	# move the image part being placed on top of the others
	var max_index = 0
	for n in range(1, len(get_node(Global.LEVEL_NODE).images) + 1):
		var z_index = _get_board_piece(String(n)).z_index
		if (z_index > max_index):
			max_index = z_index
	tile.z_index = max_index + 1
	# disable image part
	image.modulate = Color(1, 1, 1, 0.4)
	_placed_on_board = true
	get_node(Global.SELECT_SOUND_NODE).pitch_scale = rand_range(0.8, 1.1)
	get_node(Global.SELECT_SOUND_NODE).play()

func _place_image():
	get_node(Global.RULES_TEXT_NODE).hide()
	if _placed_on_board:
		remove_image()
	else:
		_add_image()
