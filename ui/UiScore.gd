extends CanvasLayer

onready var score = $score

func _update_score(new_score):
	score.text = str(new_score)
