extends Node

const adblocker_displayename = "adblocker"
const adblocker_details = "kuy"

const antivirus_displayname = "anti virus"
const antivirus_details = "eiei"

const harddisk_displayname = "hard disk"
const harddisk_details = "meaw"

const increasedpi_displayname = "increase dpi"
const increasedpi_details = "fast"

const shock_displayname = "shock"
const shock_details = "surprise"

const endtask_displayname = "endtask"
const endtask_details = "end"

const ICON_Path = "res://art/icon/"
const ART_Path = "res://art/"

const UPGRADES = {
	"Adblocker1": {
		"icon": ICON_Path + "adblocker.png",
		'displayname': adblocker_displayename,
		'details': adblocker_details,
		'level': 'level: 1',
		'prerequisite': []
	},
	"Adblocker2": {
		"icon": ICON_Path + "adblocker.png",
		'displayname': adblocker_displayename,
		'details': adblocker_details,
		'level': 'level: 2',
		'prerequisite': []
	},
	"Adblocker3": {
		"icon": ICON_Path + "adblocker.png",
		'displayname': adblocker_displayename,
		'details': adblocker_details,
		'level': 'level: 3',
		'prerequisite': []
	},
	"Antivirus1": {
		"icon": ICON_Path + "antivirus.png",
		'displayname': antivirus_displayname,
		'details': antivirus_details,
		'level': 'level: 1',
		'prerequisite': []
	},
	"Antivirus2": {
		"icon": ICON_Path + "antivirus.png",
		'displayname': antivirus_displayname,
		'details': antivirus_details,
		'level': 'level: 2',
		'prerequisite': []
	},
	"Antivirus3": {
		"icon": ICON_Path + "antivirus.png",
		'displayname': antivirus_displayname,
		'details': antivirus_details,
		'level': 'level: 3',
		'prerequisite': []
	},
	"Harddisk1": {
		"icon": ICON_Path + "harddisk.png",
		'displayname': harddisk_displayname,
		'details': harddisk_details,
		'level': 'level: 1',
		'prerequisite': []
	},
	"Harddisk2": {
		"icon": ICON_Path + "harddisk.png",
		'displayname': harddisk_displayname,
		'details': harddisk_details,
		'level': 'level: 2',
		'prerequisite': []
	},
	"Harddisk3": {
		"icon": ICON_Path + "harddisk.png",
		'displayname': harddisk_displayname,
		'details': harddisk_details,
		'level': 'level: 3',
		'prerequisite': []
	},
	"increasedpi": {
		"icon": ICON_Path + "increasedpi.png",
		'displayname': increasedpi_displayname,
		'details': increasedpi_details,
		'level': 'level: 1',
		'prerequisite': []
	},
	"increasedp2": {
		"icon": ICON_Path + "increasedpi.png",
		'displayname': increasedpi_displayname,
		'details': increasedpi_details,
		'level': 'level: 2',
		'prerequisite': []
	},
	"increasedp3": {
		"icon": ICON_Path + "increasedpi.png",
		'displayname': increasedpi_displayname,
		'details': increasedpi_details,
		'level': 'level: 3',
		'prerequisite': []
	},
	"shock1": {
		"icon": ICON_Path + "shock.png",
		'displayname': shock_displayname,
		'details': shock_details,
		'level': 'level: 1',
		'prerequisite': []
	},
	"shock2": {
		"icon": ICON_Path + "shock.png",
		'displayname': shock_displayname,
		'details': shock_details,
		'level': 'level: 2',
		'prerequisite': []
	},
	"shock3": {
		"icon": ICON_Path + "shock.png",
		'displayname': shock_displayname,
		'details': shock_details,
		'level': 'level: 3',
		'prerequisite': []
	},
	"Endtask": {
		"icon": ICON_Path + "endtask.png",
		"displayname": endtask_displayname,
		'details': endtask_details,
		'level': 'N/A',
		'prerequisite': []
	}
}
