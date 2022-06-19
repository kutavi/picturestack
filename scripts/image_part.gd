extends Node

var _placed_on_board = false

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed() \
	and !get_node(Global.LEVEL_NODE).game_ended \
	and !get_node(Global.ALBUM_NODE).is_visible():
		self._place_image()
		get_node(Global.LEVEL_NODE).check_winning()


func _place_image():
	var board = get_node(Global.BOARD_NODE)
	get_node(Global.RULES_TEXT_NODE).hide()
	var which_one_to_handle = self.name[1]
	var board_part = board.get_node(Global.BOARD_PART + which_one_to_handle)
	var image_sprite = self.get_node(Global.IMAGE_SPRITE_NODE)

	if _placed_on_board:
		board_part.hide()
		board_part.z_index = 0
		# re-enable image part
		image_sprite.modulate = Color(1, 1, 1, 1)
		_placed_on_board = false
		get_node(Global.SELECT_SOUND_NODE).pitch_scale = 0.4
		get_node(Global.SELECT_SOUND_NODE).play()
	else:
		board_part.show()
		# move the image part being placed on top of the others
		var max_index = 0
		for n in range(1, board.get_child_count()):
			var z_index = board.get_node(Global.BOARD_PART + String(n)).z_index
			if (z_index > max_index):
				max_index = z_index
		board_part.z_index = max_index + 1
		# disable image part
		image_sprite.modulate = Color(1, 1, 1, 0.4)
		_placed_on_board = true
		get_node(Global.SELECT_SOUND_NODE).pitch_scale = rand_range(0.8, 1.1)
		get_node(Global.SELECT_SOUND_NODE).play()
