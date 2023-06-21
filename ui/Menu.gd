extends CanvasLayer

signal start_game

onready var start_message = $New_game/TextureRect
onready var tween = $Tween
onready var score_label = $Game_over/VBoxContainer/Score_label
onready var height_score = $Game_over/VBoxContainer/Height_score_label
onready var game_over_menu = $Game_over

var game_started = false

func _input(event):
	if event.is_action_pressed("flap") && !game_started:
		emit_signal("start_game")
		tween.interpolate_property(start_message, "modulate:a", 1, 0, 0.5)
		tween.start()
		
		game_started = true

func init_game_over_menu(score, heightScore):
	score_label.text = "SCORE : "+str(score)
	height_score.text = "HEIGHT SCORE : "+str(heightScore)
	game_over_menu.visible = true

func _on_Restart_button_pressed():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
