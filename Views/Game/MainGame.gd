extends Node2D

onready var Levels = [
	$ROOMS/ROOM_1,
	$ROOMS/ROOM_2
]

var currentLevel = 0


func _ready():
	Levels[currentLevel].activate()
	#_on_win_room()

func _input(event):
	if event.is_action('press_mouse') and not event.is_pressed():
		get_tree().call_group("FURNITURE", "disable_click")
	elif event is InputEventMouseMotion:
		get_tree().call_group("FURNITURE", "move_mouse", event)



func _on_win_room():
	if currentLevel == Levels.size():
		print('FINAL WIN')
		return
		
	currentLevel += 1;
	Levels[currentLevel].activate()
	$Camera2D.move_to(Levels[currentLevel])
	$UI/SOLUTION.show_image(currentLevel)


func _on_Reset_button_down():
	Levels[currentLevel].reset()
