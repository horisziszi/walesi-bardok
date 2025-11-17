extends Node2D

# Next Level area
@onready var nextlevel: Area2D = $Grounds/Nextlevel



# Lock-in collisions
@onready var left_lock: CollisionShape2D = $"Grounds/Lock-in/left-lock"
@onready var right_lock: CollisionShape2D = $"Grounds/Lock-in/right-lock"
@onready var szekenbelul: CollisionShape2D = $Grounds/versszakok/szekenbelul/szekenbelul


# Main01 script
@onready var main_01_collision: CollisionShape2D = $"Grounds/versszakok/Main01/Main01-collision"
@onready var main_01_hang: AudioStreamPlayer2D = $"Grounds/versszakok/Main01/Main01-hang"

# Main02 script
@onready var bard_3: Area2D = $Grounds/versszakok/Main02/Bard3
@onready var main_02_kiraly: AudioStreamPlayer2D = $"Grounds/versszakok/Main02/Main02-kiraly"
@onready var main_02_narrator: AudioStreamPlayer2D = $"Grounds/versszakok/Main02/Main02-narrator"
@onready var main_02_bard: AudioStreamPlayer2D = $"Grounds/versszakok/Main02/Bard3/Main02-bard"

# Main03 script
@onready var bard_2: Area2D = $Grounds/versszakok/Main03/Bard2
@onready var main_03_kiralynarrator: AudioStreamPlayer2D = $"Grounds/versszakok/Main03/Main03-kiralynarrator"
@onready var main_03_bard: AudioStreamPlayer2D = $"Grounds/versszakok/Main03/Bard2/Main03-bard"

# Main04 script
@onready var bard_1: Area2D = $Grounds/versszakok/Main04/Bard1
@onready var main_04_narrator: AudioStreamPlayer2D = $"Grounds/versszakok/Main04/Main04-narrator"
@onready var main_04_bard: AudioStreamPlayer2D = $"Grounds/versszakok/Main04/Bard1/Main04-bard"

# Main05
@onready var main_05_kiralynarrator: AudioStreamPlayer2D = $"Grounds/versszakok/Main05/Main05-kiralynarrator"


var inside_szek = false

var main02_finished = false
var main03_finished = false
var main04_finished = false
var main05_finished = false

var next_scene = 2   # The first scene to start after sitting in the chair



func _ready() -> void:
	apply_settings_recursive(self)
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
	
func apply_settings_recursive(node: Node):
	if node is AudioStreamPlayer2D:
		node.attenuation = 0
		node.max_distance = 100000

	for child in node.get_children():
		apply_settings_recursive(child)


func _on_main_01_body_entered(_body: Node2D) -> void:
	main_01_hang.attenuation = 0
	main_01_hang.max_distance = 100000
	main_01_hang.play()
	main_01_collision.queue_free()


# Checking if the player is in the chair
func _on_szekenbelul_body_entered(body: Node2D) -> void:
	if body.name == "player":
		inside_szek = true
		print("true")


func _on_szekenbelul_body_exited(body: Node2D) -> void:
	if body.name == "player":
		inside_szek = false

func _input(event):
	if inside_szek and event.is_action_pressed("interact"):
		left_lock.disabled = false
		right_lock.disabled = false
		match next_scene:
			2:
				start_Main02()
			3:
				start_Main03()
			4:
				start_Main04()
			5:
				start_Main05()


func start_Main02():
	print("Starting Main02")
	bard_3.visible = true
	main_02_kiraly.play()
	szekenbelul.disabled = true
	next_scene = 0    # Block further presses until finished



func _on_main_02_kiraly_finished() -> void:
	main_02_narrator.play()


func _on_main_02_narrator_finished() -> void:
	main_02_bard.play()


func _on_main_02_bard_finished():
	print("Main02 finished")
	main02_finished = true
	next_scene = 3       # Now pressing interact starts Main03
	szekenbelul.disabled = false
	


func start_Main03():
	print("Starting Main03")
	bard_3.queue_free()
	bard_2.visible = true
	main_03_kiralynarrator.play()
	szekenbelul.disabled = true
	next_scene = 0
	
func _on_main_03_kiralynarrator_finished():
	main_03_bard.play()

func _on_main_03_bard_finished():
	print("Main03 finished")
	main03_finished = true
	next_scene = 4
	szekenbelul.disabled = false
	
	
func start_Main04():
	print("Starting Main04")
	bard_2.queue_free()
	bard_1.visible = true
	main_04_narrator.play()
	szekenbelul.disabled = true
	next_scene = 0
	
func _on_main_04_narrator_finished():
	main_04_bard.play()
	
func _on_main_04_bard_finished():
	print("Main04 finished")
	main04_finished = true
	next_scene = 5
	szekenbelul.disabled = false
	

func start_Main05():
	print("Starting Main05")
	bard_1.queue_free()
	main_05_kiralynarrator.play()
	next_scene = 0
	
func _on_main_05_kiralynarrator_finished():
	print("Main05 finished!")
	main05_finished = true

	# ✔ Remove locks
	left_lock.queue_free()
	right_lock.queue_free()

	# ✔ Disable the szekenbelul collision permanently
	szekenbelul.queue_free()

	# ✔ Allow the player to enter the next level
	nextlevel.monitoring = true
	nextlevel.monitorable = true

	# No next_scene here, because this is the end

	
