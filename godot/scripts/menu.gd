extends Node

func mute_sound(flag):
	if flag:
		get_node("SoundButton").set_normal_texture(load(Global.ASSETS_PATH + "sound_no.webp"))
		AudioServer.set_bus_mute(1, true)
	else:
		get_node("SoundButton").set_normal_texture(load(Global.ASSETS_PATH + "sound.webp"))
		AudioServer.set_bus_mute(1, false)

func _on_Album_pressed():
	get_node(Global.ALBUM_NODE).open()


func _on_Reload_pressed():
		get_node(Global.TRACKING_NODE).level_restarting(Global.current_level)
		get_tree().reload_current_scene()


func _on_Sound_pressed():
		get_node(Global.MENU_SOUND_NODE).play()
		if !Global.sound_enabled:
			Global.sound_enabled = 1
			mute_sound(false)
			get_node(Global.LEVEL_NODE).save()
		else:
			Global.sound_enabled = 0
			mute_sound(true)
			get_node(Global.LEVEL_NODE).save()


func _on_HintButton_pressed():
	get_node(Global.MENU_SOUND_NODE).play()
	get_node(Global.HINT_POPUP_NODE).show()
	get_node(Global.BOARD_NODE).hide()
	get_node(Global.MENU_NODE).hide()
	pass # Replace with function body.
