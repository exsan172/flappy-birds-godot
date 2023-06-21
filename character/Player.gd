extends RigidBody2D

class_name player
signal died

export var FLAP_FORCE = -314
const MAX_ROTATE = -30.0
onready var animator = $AnimationPlayer
onready var hitSound = $hit
onready var flySound = $fly
var start = false
var life = true

func _physics_process(_delta):
	if Input.is_action_pressed("flap") && life:
		if !start:
			start_game()
		flap()
		
	if rotation_degrees <= MAX_ROTATE:
		angular_velocity = 0
		rotation_degrees = MAX_ROTATE
	
	if linear_velocity.y > 0:
		if rotation_degrees <= 90:
			angular_velocity = 5
		else:
			angular_velocity = 0
		
			
			
func start_game():
	if start: return
	
	start = true
	gravity_scale = 10.0
	animator.play("flap")

func flap():
	linear_velocity.y = FLAP_FORCE
	angular_velocity = -8.0
	flySound.play()

func die():
	if !life: return
	life = false
	animator.stop()
	hitSound.play()
	emit_signal("died")
