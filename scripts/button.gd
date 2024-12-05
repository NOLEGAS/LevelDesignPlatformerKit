extends Node3D
@export var targets : Array [Node3D]
@export var pressed_by_default : bool
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var button_state : bool = false
@onready var cooldown_timer: Timer = $CooldownTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if pressed_by_default:
		button_state = true
		animation_player.play("toggle-on",-1,10.0)
		if targets.size() > 0 :
			for _target in targets :
				if _target.has_method("receive_input"):
					_target.receive_input(button_state)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_button_area_3d_area_entered(_area: Area3D) -> void:
	if cooldown_timer.is_stopped():
		cooldown_timer.start()
		if not animation_player.is_playing():
			if button_state:
				button_state = false
				animation_player.play("toggle-off")
			else:
				button_state = true
				animation_player.play("toggle-on")
			
			if targets.size() > 0 :
				for _target in targets :
					if _target.has_method("receive_input"):
						_target.receive_input(button_state)
