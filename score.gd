extends Control
var highest_score = 0
func set_score(value):
	%score.text = str(value)
	
func set_highscore(value):
	%highscore.text = str(value)
	
func _process(delta):
	self.set_score(global.score)
	if global.boss_rip:
		highest_score = global.highscore
		self.set_highscore(highest_score)
		global.save_game()
		global.boss_rip = false
	self.visible = true

