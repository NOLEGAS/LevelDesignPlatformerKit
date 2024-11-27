extends Node

@export var isGreenOn : bool
@export var timerTrigger : bool
@onready var timer : Timer = $Timer


func receive_input(state_on) -> void:
	#Toggles between green and red
	isGreenOn = state_on
	get_tree().call_group("TogglePlatform", "toggleState", isGreenOn)


func _on_timer_timeout() -> void:
	if(timerTrigger):
		#Toggles between green and red
		isGreenOn = not isGreenOn
		get_tree().call_group("TogglePlatform", "toggleState", isGreenOn)
