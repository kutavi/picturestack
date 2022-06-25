extends Node

func _on_Reveal_pressed():
	get_node(Global.MENU_SOUND_NODE).play()
	var hintImage = get_node(Global.HINT_POPUP_NODE).get_node("FinalImage/Sprite")
	var currentLevelKey = Global.levels[Global.current_level - 1]
	hintImage.set_texture(load(Global.ALBUM_PATH + "level_" + currentLevelKey + ".webp"))
	hintImage.set_scale(Vector2(0.45, 0.45))
	get_node(Global.HINT_POPUP_NODE).get_node("Reveal").hide()
	get_node(Global.HINT_POPUP_NODE).get_node("Prompt").hide()
	


func _on_Close_pressed():
	get_node(Global.MENU_SOUND_NODE).play()
	get_node(Global.HINT_POPUP_NODE).hide()
	get_node(Global.BOARD_NODE).show()
	get_node(Global.MENU_NODE).show()
