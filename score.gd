extends Control
var highest_score = 0
func set_score(value):
	%score.text = str(value)
	
func set_highscore(value):
	%highscore.text = str(value)
	
func _process(delta):
	self.set_score(global.score)
	highest_score = global.score
	self.set_highscore(highest_score)
	global.save_game()
	self.visible = true

