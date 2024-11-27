extends Node

@export var isGreenOn : bool
@export var timerTrigger : bool
@onready var timer : Timer = $Timer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
var timerSoundPlayed : bool


func receive_input(state_on) -> void:
	#Toggles between green and red
	isGreenOn = state_on
	get_tree().call_group("TogglePlatform", "toggleState", isGreenOn)

func _process(_delta: float) -> void:
	if((timerTrigger) and (timer.time_left <= 3) and (not timerSoundPlayed)):
		audio_stream_player.play()
		timerSoundPlayed = true
	
func _on_timer_timeout() -> void:
	if(timerTrigger):
		#Toggles between green and red
		timerSoundPlayed = false
		isGreenOn = not isGreenOn
		get_tree().call_group("TogglePlatform", "toggleState", isGreenOn)
