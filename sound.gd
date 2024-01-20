extends Node2D

var music = load("res://sound/Folder_Brawler_25_11_23.wav")
var menumusic = load("res://sound/Menu_Music_25_11_23.wav")

func play_menumusic():
	$wintheme.stop()
	$menumusic.stream = menumusic
	$menumusic.play()
	$gametheme.stop()

func play_gametheme():
	$menumusic.stop()
	$gametheme.stream = music
	$gametheme.play()

func play_wintheme():
	$gametheme.stop()
	$wintheme.stream = music
	$wintheme.play()

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

func upgrade():
	$upgrade.play()

func playerhitbig():
	$playerhitbig.play()

func timer():
	$timer.play()
 
func fart():
	$"Fart Sound".play()

func Copter():
	$Copter.play()
