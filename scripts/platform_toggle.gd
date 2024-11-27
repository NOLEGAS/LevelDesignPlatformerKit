extends Node3D

@export var isGreen : bool
@export var colorGreen : Material
@export var colorRed : Material
@onready var mesh: MeshInstance3D = $platform2

@onready var collision: CollisionShape3D = $StaticBody3D/CollisionShape3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if isGreen:
		mesh.set_surface_override_material(0,colorGreen)
		#Green platforms start turned on
		visible = false
		collision.disabled = true
	else:
		mesh.set_surface_override_material(0,colorRed)


func toggleState(isGreenOn : bool) -> void:
	if((isGreen and isGreenOn) or (not isGreen and not isGreenOn)):
		visible = true
		collision.set_deferred("disabled", false)
		
	else:
		visible = false
		collision.set_deferred("disabled", true)
