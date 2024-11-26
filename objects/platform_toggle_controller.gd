extends Node

@export var isGreenOn : bool

func receive_input(state_on) -> void:
	#Toggles between green and red
	isGreenOn = state_on
	get_tree().call_group("TogglePlatform", "toggleState", isGreenOn)
