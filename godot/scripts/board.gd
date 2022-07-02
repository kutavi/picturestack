extends Node2D

func _ready():
	yield(VisualServer, "frame_post_draw")
	for n in range(1, len(get_node(Global.LEVEL_NODE).images) + 1):
		var board_part = get_node(Global.BOARD_NODE).get_node(Global.BOARD_PART + String(n))
		build_collisions_from_image(board_part)

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed() \
	and !get_node(Global.LEVEL_NODE).game_ended \
	and !get_node(Global.ALBUM_NODE).is_visible() \
	and !get_node(Global.HINT_POPUP_NODE).is_visible():
		var click_position = get_global_mouse_position()
		var objects_clicked = get_world_2d().direct_space_state.intersect_point(click_position, 10, [], 2, false, true )
		var top_element
		for item in objects_clicked:
			var element = item.collider
			if !top_element:
				top_element = element
			if element.z_index > top_element.z_index:
				top_element = element
		if (top_element.name == "Canvas"): # if clicking on the canvas, remove the last placed image
			for n in range(1, len(get_node(Global.LEVEL_NODE).images) + 1):
				var board_part = get_node(Global.BOARD_NODE).get_node(Global.BOARD_PART + String(n))
				if (board_part.z_index > top_element.z_index):
					top_element = board_part
		if (top_element.name != "Canvas"):
			var which_one_to_handle = top_element.name[1]
			var images = get_node(Global.IMAGE_PARTS_NODE)
			var image = images.get_node(Global.IMAGE_PART + which_one_to_handle)
			if (image && top_element.z_index):
				image.remove_image()


func build_collisions_from_image(board_part):	
	var bitmap := BitMap.new()
	var which_one_to_handle = board_part.name[1]
	var images = get_node(Global.IMAGE_PARTS_NODE)
	var image = images.get_node(Global.IMAGE_PART + which_one_to_handle).get_node("Sprite")
	bitmap.create_from_image_alpha(image.texture.get_data())

	# This will generate polygons for the given coordinate rectangle within the bitmap
	var polygons = bitmap.opaque_to_polygons(Rect2(Vector2(0,0), bitmap.get_size()))

	# Now create a collision polygon for each polygon returned
	for polygon in polygons:
		var collider := CollisionPolygon2D.new()

		var newpoints := Array()
		var board_tile = board_part.get_node("Sprite").texture
		for point in polygon:
			var boardX = board_tile.get_width() / 2
			var boardY = board_tile.get_height() / 2
			newpoints.push_back(Vector2(point.x - boardX, point.y - boardY))
		collider.polygon = newpoints
		board_part.add_child(collider)
