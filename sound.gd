extends Node2D

var music = load("res://sound/Folder_Brawler_25_11_23.wav")
var menumusic = load("res://sound/Menu_Music_25_11_23.wav")

func play_menumusic():
	$menumusic.stream = menumusic
	$menumusic.play()

func play_gametheme():
	$menumusic.stop()
	$gametheme.stream = music
	$gametheme.play()

func click():
	$click.play()

func enemyspawn():
	$enemyspawn.play()

func zipspawn():
	$zipspawn.play()

func enemyhit():
	$enemyhit.play()

func enemydeath():
	$enemydeath.play()

func zipdeath():
	$zipdeath.play()

func playerhit():
	$playerhit.play()

func playeropenfolder():
	$playeropenfolder.play()

func playergrab():
	$playergrab.play()

func adspawn():
	$adspawn.play()

func cantdelete():
	$cantdelete.play()

func critical():
	$critical.play()
