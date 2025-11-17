extends Node2D
@onready var nextlevel: Area2D = $Nextlevel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	nextlevel.monitoring = false
	nextlevel.monitorable = false
	pass


func activate_nextlevel():
	nextlevel.monitoring = true
	nextlevel.monitorable = true
