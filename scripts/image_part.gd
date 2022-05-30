extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var placed_on_board = false

# Called when the node enters the scene tree for the first time.
func _ready():
	print('READY') # Replace with function body.

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed() \
	and !get_node('/root/Level').gameEnded:
		self._place_image()
		get_node('/root/Level')._check_winning()

func _place_image():
	var board = get_node('/root/Level/Board')
	board.get_node('rules').hide()
	var whichOneToHandle = self.name[1]
	var board_part = board.get_node("b" + whichOneToHandle)
	if placed_on_board:
		board_part.hide()
		board_part.z_index = 0
		self.get_node('Sprite').modulate = Color(1,1,1, 1)
		placed_on_board = false
	else:
		board_part.show()
		var maxIndex = 0
		for n in range(1, board.get_child_count()):
			var zIndex = board.get_node('b' + String(n)).z_index
			if (zIndex > maxIndex):
				maxIndex = zIndex
		board_part.z_index = maxIndex + 1
		board_part.set_scale(Vector2(0.5, 0.5))
		self.get_node('Sprite').modulate = Color(1,1,1, 0.5)
		placed_on_board = true
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
