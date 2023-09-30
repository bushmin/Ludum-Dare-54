extends KinematicBody2D

var holding = false
var holdPosition = Vector2.ZERO

onready var MY_SIZE = $TextureRect.rect_size /  2

const FORCE_PARAM = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func disable_click():
	print('disabling_click')
	holding = false
	
func move_mouse(event):
	if not holding: return
	var deltaTransform = get_block_transform(holdPosition, event.speed)
	move_and_slide(deltaTransform.deltaPos)
	print(deltaTransform)
	if not test_move(Transform2D(rotation + deltaTransform.deltaAngle, position), deltaTransform.deltaPos):
		rotation += deltaTransform.deltaAngle

func _on_input_event(viewport, event, shape_idx):
	if event.is_action('press_mouse'):
		if event.is_pressed():
			#print('pressed', to_local(event.position))
			holding = true
			holdPosition = to_local(event.position)
		else:
			print('not pressed')
			holding = false
			
func get_block_transform(holdPos: Vector2, deltaMouse: Vector2):
	var rotatedHoldPos = holdPos.rotated(rotation)
	#print(holdPos, rotatedHoldPos)
	var deltaCenterPos = rotatedHoldPos + deltaMouse - holdPos.length()*(rotatedHoldPos + deltaMouse).normalized()
	var deltaAngle = rotatedHoldPos.angle_to(rotatedHoldPos + deltaMouse) * 0.1
	if holdPos.length() < 0.5*MY_SIZE.length(): deltaAngle = 0
	return {"deltaPos":deltaCenterPos, "deltaAngle":deltaAngle}