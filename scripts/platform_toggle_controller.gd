extends Node

@export var isGreenOn : bool
@export var timerTrigger : bool
@onready var timer : Timer = $Timer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
var timerSoundPlayed : bool
var hud : Node
var seeAndHear : bool

func _ready() -> void:
	hud = get_tree().get_first_node_in_group("HUD")
func receive_input(state_on) -> void:
	#Toggles between green and red
	isGreenOn = state_on
	get_tree().call_group("TogglePlatform", "toggleState", isGreenOn)

func _process(_delta: float) -> void:
	#hud.showPlatformTimer(timer.time_left)
	if((timerTrigger) and (timer.time_left <= 3) and (not timerSoundPlayed) and seeAndHear):
		audio_stream_player.play()
		timerSoundPlayed = true
		vibrate()
		
	
func _on_timer_timeout() -> void:
	if(timerTrigger):
		#Toggles between green and red
		timerSoundPlayed = false
		isGreenOn = not isGreenOn
		get_tree().call_group("TogglePlatform", "toggleState", isGreenOn)


func _on_area_3d_body_entered(body: Node3D) -> void:
	seeAndHear = true


func _on_area_3d_body_exited(body: Node3D) -> void:
	seeAndHear = false
	
func vibrate():
	await get_tree().create_timer(1).timeout
	Input.start_joy_vibration(0, 0.25, 0.25, 0.2)
	
	await get_tree().create_timer(1).timeout
	Input.start_joy_vibration(0, 0.25, 0.25, 0.2)
	
	await get_tree().create_timer(1).timeout
	Input.start_joy_vibration(0, 0.5, 0.5, 0.2)
