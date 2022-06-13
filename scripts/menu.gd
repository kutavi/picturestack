extends Node

func mute_music(flag):
	if flag:
		get_node("MusicButton").set_normal_texture(load(Global.ASSETS_PATH + "music_no.webp"))
		AudioServer.set_bus_mute(2, true)
	else:
		get_node("MusicButton").set_normal_texture(load(Global.ASSETS_PATH + "music.webp"))
		AudioServer.set_bus_mute(2, false)

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
	if !get_node(Global.ALBUM_NODE).is_visible():
		get_node(Global.MENU_SOUND_NODE).play()
		get_tree().reload_current_scene()


func _on_Music_pressed():
	if !Global.music_enabled:
		Global.music_enabled = 1
		mute_music(false)
		get_node(Global.LEVEL_NODE).save_level()
	else:
		Global.music_enabled = 0
		mute_music(true)
		get_node(Global.LEVEL_NODE).save_level()


func _on_Sound_pressed():
	if !Global.sound_enabled:
		Global.sound_enabled = 1
		mute_sound(false)
		get_node(Global.LEVEL_NODE).save_level()
	else:
		Global.sound_enabled = 0
		mute_sound(true)
		get_node(Global.LEVEL_NODE).save_level()
