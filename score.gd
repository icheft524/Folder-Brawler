extends Control

func set_score(value):
	%score.text = "Score: " + str(value)
	
func set_highscore(value):
	%highscore.text = "High Score: " + str(value)
	
func _process(delta):
	self.set_score(global.score)
	self.set_highscore(global.highscore)
	global.save_game()
	self.visible = true

