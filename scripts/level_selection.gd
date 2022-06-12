extends Node

var disabled = false
var level_number = 0


func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		if !disabled:
			Global.current_level = level_number
			get_tree().reload_current_scene()
