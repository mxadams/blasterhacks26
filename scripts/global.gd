extends Node

var CMD_QUEUE = []
var SUBMIT_QUEUE = []

class PlayerData:
	const MOVE_SPEED_BASE: float = 40000.0
	var move_speed: float = MOVE_SPEED_BASE
var PLAYER := PlayerData.new()

class ComponentData:
	const ERROR_INDEX: int = -2
	const NULL_INDEX: int = -1
	const MAP := {
		ERROR_INDEX: "Hallucination",
		NULL_INDEX: "NULL",
		0: "ls",
		1: "pwd",
		2: "cd",
		3: "mkdir",
		4: "touch",
		5: "mv",
		6: "cat",
		7: "man",
		10: "ls [fin]",
		11: "pwd [fin]",
		12: "cd [fin]",
		13: "mkdir [fin]",
		14: "touch [fin]",
		15: "mv [fin]",
		16: "cat [fin]",
		17: "man [fin]",
	}
	const NUM_TYPES: int = ((len(Global.COMPONENT.MAP) - 2)/2)-1
	const COLORS := {
		ERROR_INDEX: "#ababab",
		-1: "#ffffff",
		0: "#ea88a8",
		1: "#eb9167",
		2: "#c9a743",
		3: "#88bc6b",
		4: "#32c4ae",
		5: "#3cbbe5",
		6: "#8da6f9",
		7: "#c892e0",
	}
var COMPONENT := ComponentData.new()

class GameRuleData:
	var difficulty_level: int = 0
	var max_command_length: int = 1
	var score: int = 0
	const COMMAND_SPAWN_TIME: float = 10.0 # seconds
	const DIFFICULTY_INCREASE_TIME: float = 15.0 # seconds
	const PLAYER_SPEED_INCREASE: float = 1.01
	const MAX_SUBMIT_LEN: int = 16
var GAMERULE := GameRuleData.new()
