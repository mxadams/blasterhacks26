extends Node

class PlayerData:
	var MOVE_SPEED: float = 45000.0

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
		10: "[binary]",
		11: "[flags]",
		12: "[args]",
		13: "[file ref]",
		14: "[net data]",
		15: "[io data]",
	}

class GameRuleData:
	var difficulty_level: int = 0
	var max_command_length: int = 1
	const COMMAND_SPAWN_TIME: float = 15.0 # seconds
	const DIFFICULTY_INCREASE_TIME: float = 60.0 # seconds
	const PLAYER_SPEED_INCREASE: float = 1.01

var PLAYER := PlayerData.new()
var COMPONENT := ComponentData.new()
var GAMERULE := GameRuleData.new()
