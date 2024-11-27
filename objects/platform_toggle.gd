extends Node3D

@export var isGreen : bool
@export var colorGreen : Material
@export var colorRed : Material
@onready var platform_2: MeshInstance3D = $platform2

@onready var collision: CollisionShape3D = $StaticBody3D/CollisionShape3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if isGreen:
		platform_2.set_surface_override_material(0,colorGreen)
		#Green platforms start turned on
		visible = false
		collision.disabled = true
	else:
		platform_2.set_surface_override_material(0,colorRed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func toggleState(isGreenOn : bool) -> void:
	print(isGreenOn)
	if((isGreen and isGreenOn) or (not isGreen and not isGreenOn)):
		visible = true
		collision.set_deferred("disabled", false)
		
	else:
		visible = false
		collision.set_deferred("disabled", true)
