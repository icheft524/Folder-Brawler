extends Node

const adblocker_displayename = "Adblocker"
const adblocker_details = "I HATE Ads"

const antivirus_displayname = "Anti Virus"
const antivirus_details = "Critical Hit"

const harddisk_displayname = "Hard Disk"
const harddisk_details = "Max Capacity"

const increasedpi_displayname = "DPI"
const increasedpi_details = "Speedy Folder"

const shock_displayname = "System Shock"
const shock_details = "Stun Click"

const endtask_displayname = "End Task"
const endtask_details = "Clean Folder!"

const ICON_Path = "res://art/icon/"
const ART_Path = "res://art/"

const UPGRADES = {
	"Adblocker1": {
		"icon": ICON_Path + "iconads.png",
		'displayname': adblocker_displayename,
		'details': adblocker_details,
		'level': 'level: 1',
		'prerequisite': []
	},
	"Adblocker2": {
		"icon": ICON_Path + "iconads.png",
		'displayname': adblocker_displayename,
		'details': adblocker_details,
		'level': 'level: 2',
		'prerequisite': ["Adblocker1"]
	},

	"Antivirus1": {
		"icon": ICON_Path + "iconcri.png",
		'displayname': antivirus_displayname,
		'details': antivirus_details,
		'level': 'level: 1',
		'prerequisite': []
	},
	"Antivirus2": {
		"icon": ICON_Path + "iconcri.png",
		'displayname': antivirus_displayname,
		'details': antivirus_details,
		'level': 'level: 2',
		'prerequisite': ["Antivirus1"]
	},
	"Harddisk1": {
		"icon": ICON_Path + "iconcap.png",
		'displayname': harddisk_displayname,
		'details': harddisk_details,
		'level': 'level: 1',
		'prerequisite': []
	},
	"Harddisk2": {
		"icon": ICON_Path + "iconcap.png",
		'displayname': harddisk_displayname,
		'details': harddisk_details,
		'level': 'level: 2',
		'prerequisite': ["Harddisk1"]
	},
	"increasedpi": {
		"icon": ICON_Path + "iconspeed.png",
		'displayname': increasedpi_displayname,
		'details': increasedpi_details,
		'level': 'level: 1',
		'prerequisite': []
	},
	"increasedp2": {
		"icon": ICON_Path + "iconspeed.png",
		'displayname': increasedpi_displayname,
		'details': increasedpi_details,
		'level': 'level: 2',
		'prerequisite': ["increasedpi"]
	},
	"shock": {
		"icon": ICON_Path + "iconstun.png",
		'displayname': shock_displayname,
		'details': shock_details,
		'level': 'N/A',
		'prerequisite': []
	},
	"Endtask": {
		"icon": ICON_Path + "iconclear.png",
		"displayname": endtask_displayname,
		'details': endtask_details,
		'level': 'N/A',
		'prerequisite': []
	}
}
