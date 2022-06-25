extends Node

func level_starting(level_num):
	if Platform.code == 'cmg':
		JavaScript.eval('parent.cmgGameEvent("start","' + str(level_num) + '");', true)


func level_restarting(level_num):
	if Platform.code == 'cmg':
		JavaScript.eval('parent.cmgGameEvent("replay","' + str(level_num) + '");', true)
