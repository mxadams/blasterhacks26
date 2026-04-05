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
	const COMMAND_SPAWN_TIME: float = 1.0 # seconds
	const DIFFICULTY_INCREASE_TIME: float = 2.0 # seconds
	const PLAYER_SPEED_INCREASE: float = 0.005 * Global.PLAYER.MOVE_SPEED_BASE
var GAMERULE := GameRuleData.new()
