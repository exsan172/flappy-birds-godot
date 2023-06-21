extends Node2D

signal obs_created(obs)
onready var timer = $Timer
var Obstacle = preload("res://environtment/Pipe.tscn")

func _ready():
	randomize()
	
func _on_Timer_timeout():
	spawn_obstacle()
	
func spawn_obstacle():
	var obs = Obstacle.instance()
	add_child(obs)
	obs.position.y = randi()%400+150
	emit_signal("obs_created", obs)
	
func start():
	timer.start()
	
func stop():
	timer.stop()
