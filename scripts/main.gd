extends Node2D

# Next Level area
@onready var nextlevel: Area2D = $Grounds/Nextlevel

# Main01 script
@onready var main_01_collision: CollisionShape2D = $"Grounds/versszakok/Main01/Main01-collision"
@onready var main_01_hang: AudioStreamPlayer2D = $"Grounds/versszakok/Main01/Main01-hang"

# Lock-in collisions
@onready var left_lock: CollisionShape2D = $"Grounds/Lock-in/left-lock"
@onready var right_lock: CollisionShape2D = $"Grounds/Lock-in/right-lock"

# Beszélő bárdok
@onready var bard_3: Area2D = $Grounds/versszakok/Main02/Bard3
@onready var bard_2: Area2D = $Grounds/versszakok/Main03/Bard2
@onready var bard_1: Area2D = $Grounds/versszakok/Main04/Bard1

var inside_szek = false


func _ready() -> void:
	
	# Hides the Bárdok
	bard_3.visible = false
	bard_2.visible = false
	bard_1.visible = false
	
	# Disables nextlevel
	nextlevel.monitoring = false
	nextlevel.monitorable = false
	
	# Disable locks at start
	left_lock.disabled = true
	right_lock.disabled = true

func _on_main_01_body_entered(body: Node2D) -> void:
	main_01_hang.attenuation = 0
	main_01_hang.max_distance = 100000
	main_01_hang.play()
	main_01_collision.queue_free()



func _input(event):
	if inside_szek and event.is_action_pressed("interact"):
		left_lock.disabled = false
		right_lock.disabled = false
		print("locked in")
		
func _on_szekenbelul_body_entered(body: Node2D) -> void:
	if body.name == "player":
		inside_szek = true
		print("true")


func _on_szekenbelul_body_exited(body: Node2D) -> void:
	if body.name == "player":
		inside_szek = false
