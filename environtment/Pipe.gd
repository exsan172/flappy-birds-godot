extends Node2D

signal score
const SPEED = 215
onready var pointSound = $point

func _physics_process(delta):
	position.x += -SPEED*delta
	if global_position.x <= -200:
		queue_free()

func _on_wall_body_entered(body):
	if body is player:
		if body.has_method("die"):
			body.die()
		

func _on_Score_body_exited(body):
	if body is player:
		pointSound.play()
		emit_signal("score")
