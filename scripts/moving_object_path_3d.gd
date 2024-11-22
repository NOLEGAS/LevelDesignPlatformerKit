@tool
extends Path3D
@onready var path_follow_3d: PathFollow3D = $PathFollow3D
@onready var remote_transform_3d: RemoteTransform3D = $PathFollow3D/RemoteTransform3D
@export var move_with_coins : int = 0
@export var object_to_move : Node
@export var movement_speed : float = 1.0
@export var is_on_from_start : bool = true
@export var look_at_object_when_activated : bool
@export var ping_pong : bool
@export var one_way : bool

var original_object_pos : Vector3
var direction : float = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not Engine.is_editor_hint():
		if object_to_move == null:
			printerr("You need to set an object to move in ", name)
			get_tree().quit()
		else:
			remote_transform_3d.remote_path = object_to_move.get_path()
			object_to_move.set_deferred("position", Vector3.ZERO)
			global_position = Vector3.ZERO


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not Engine.is_editor_hint():
		if object_to_move and is_on_from_start:
			if ping_pong:
				if path_follow_3d.progress_ratio > 0.99:
					direction = -1
				if path_follow_3d.progress_ratio < 0.01:
					direction = 1
			elif one_way:
				if path_follow_3d.progress_ratio > 0.99:
					direction = 0
			path_follow_3d.progress += (delta*movement_speed*direction)

	if Engine.is_editor_hint() and global_position != Vector3.ZERO:
		global_position = Vector3.ZERO

func coin_amount_updated(coins_amount) -> void:
	print("worked 1")
	if move_with_coins > 0:
		if coins_amount >= move_with_coins:
			is_on_from_start = true

	if look_at_object_when_activated:
		get_tree().call_group("View", "look_at_target",object_to_move)

func receive_input(on : bool) -> void:
	is_on_from_start = on
	
	if on and look_at_object_when_activated:
		get_tree().call_group("View", "look_at_target",object_to_move)
