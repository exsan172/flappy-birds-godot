extends Node2D

onready var hud = $UiScore
onready var obs = $Spawner
onready var grnd = $Ground
onready var menu_game_over = $Menu

const SAVE_PATH = "user://savedata.save"
var score = 0 setget set_score
var heightScore = 0

func _ready():
	obs.connect("obs_created", self, "_on_obs_created")
	load_height_score()

func new_game():
	self.score = 0
	obs.start()

func player_score():
	self.score += 1

func set_score(new_score):
	score = new_score
	hud._update_score(score)

func _on_obs_created(obst):
	obst.connect("score", self, "player_score")

func _on_dedZone_body_entered(body):
	if body is player:
		if body.has_method("die"):
			body.die()

func _on_Player_died():
	game_over()
	
func game_over():
	obs.stop()
	grnd.get_node("AnimationPlayer").stop()
	get_tree().call_group("obs", "set_physics_process", false)
	
	if(score > heightScore):
		heightScore = score
		save_height_score()
	
	menu_game_over.init_game_over_menu(score, heightScore)

func _on_Menu_start_game():
	new_game()
	
func save_height_score():
	var file = File.new()
	file.open(SAVE_PATH, File.WRITE)
	file.store_var(heightScore)
	file.close()
	
func load_height_score():
	var file = File.new()
	if file.file_exists(SAVE_PATH):
		file.open(SAVE_PATH, File.READ)
		heightScore = file.get_var()
		file.close()
