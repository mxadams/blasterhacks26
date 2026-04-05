extends Node

const CACHE_STORAGE = preload("uid://ba7moxb5lk3hg")
const MACHINE_ARGS = preload("uid://c4hg576et111m")
const MACHINE_BIN = preload("uid://cftwdqrqd6tee")
const MACHINE_FILE = preload("uid://b2fd55n82g2af")
const MACHINE_FLAGS = preload("uid://bl3l8wxpmmnyr")
const MACHINE_IO = preload("uid://bi48bhopw2x4q")
const MACHINE_NET = preload("uid://45xpvfp7miu5")
const WALL = preload("uid://bbe4ld36dyanf")

var CMD_QUEUE = []
var SUBMIT_QUEUE = []

class PlayerData:
	const MOVE_SPEED_BASE: float = 40000.0
	var move_speed: float = MOVE_SPEED_BASE
var PLAYER := PlayerData.new()

class ComponentData:
	const ERROR_INDEX: int = -2
	const NUM_TYPES: int = 5
	const MAP := {
		ERROR_INDEX: "Hallucination",
		-1: "NULL",
		0: "[bin req]",
		1: "[flag req]",
		2: "[arg req]",
		3: "[file req]",
		4: "[net req]",
		5: "[io req]",
		10: "[bin ref]",
		11: "[flags]",
		12: "[args]",
		13: "[file ref]",
		14: "[net data]",
		15: "[io data]",
	}
	const COLORS := {
		ERROR_INDEX: "ffffff",
		-1: "ffffff",
		0: "#b21818",
		1: "#b26818",
		2: "#18b218",
		3: "#18b2b2",
		4: "#1818b2",
		5: "#b218b2",
		10: "#ff5454",
		11: "#ffff54",
		12: "#54ff54",
		13: "#54ffff",
		14: "#5454ff",
		15: "#ff54ff",
	}
	const SPRITES := {
		0: MACHINE_BIN,
		1: MACHINE_FLAGS,
		2: MACHINE_ARGS,
		3: MACHINE_FILE,
		4: MACHINE_NET,
		5: MACHINE_IO,
	}
var COMPONENT := ComponentData.new()

class GameRuleData:
	var difficulty_level: int = 0
	var max_command_length: int = 1
	var score: int = 0
	const COMMAND_SPAWN_TIME: float = 10.0 # seconds
	const DIFFICULTY_INCREASE_TIME: float = 20.0 # seconds
	const PLAYER_SPEED_INCREASE: float = 0.004 * Global.PLAYER.MOVE_SPEED_BASE
var GAMERULE := GameRuleData.new()
