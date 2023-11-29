extends Node

const adblocker_displayename = "Adblocker"
const adblocker_details = "Decrease ad"

const antivirus_displayname = "Anti Virus"
const antivirus_details = "Increase Critical Chance"

const harddisk_displayname = "Hard disk"
const harddisk_details = "Increase max capacity"

const increasedpi_displayname = "increase dpi"
const increasedpi_details = "Move folder faster"

const shock_displayname = "Shock"
const shock_details = "Virus become slowed after getting click"

const endtask_displayname = "End Task"
const endtask_details = "Clear all virus in folder"

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
		'prerequisite': ["Adblocker1"]
	},
	"Adblocker3": {
		"icon": ICON_Path + "adblocker.png",
		'displayname': adblocker_displayename,
		'details': adblocker_details,
		'level': 'level: 3',
		'prerequisite': ["Adblocker2"]
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
		'prerequisite': ["Antivirus1"]
	},
	"Antivirus3": {
		"icon": ICON_Path + "antivirus.png",
		'displayname': antivirus_displayname,
		'details': antivirus_details,
		'level': 'level: 3',
		'prerequisite': ["Antivirus2"]
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
		'prerequisite': ["Harddisk1"]
	},
	"Harddisk3": {
		"icon": ICON_Path + "harddisk.png",
		'displayname': harddisk_displayname,
		'details': harddisk_details,
		'level': 'level: 3',
		'prerequisite': ["Harddisk2"]
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
		'prerequisite': ["increasedpi"]
	},
	"increasedp3": {
		"icon": ICON_Path + "increasedpi.png",
		'displayname': increasedpi_displayname,
		'details': increasedpi_details,
		'level': 'level: 3',
		'prerequisite': ["increasedp2"]
	},
	"shock": {
		"icon": ICON_Path + "shock.png",
		'displayname': shock_displayname,
		'details': shock_details,
		'level': 'N/A',
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
