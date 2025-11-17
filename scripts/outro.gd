extends Node2D

@onready var outro_collision: CollisionShape2D = $"Grounds/Outro-script/Outro/Outro-collision"
@onready var outro_hang: AudioStreamPlayer2D = $"Grounds/Outro-script/Outro/Outro-hang"
@onready var exit_collision: CollisionShape2D = $"Grounds/Exit/Exit-collision"

var can_exit := false


func _on_outro_body_entered(_body: Node2D) -> void:
	outro_hang.attenuation = 0
	outro_hang.max_distance = 100000
	outro_hang.play()
	outro_collision.queue_free()
	print("is_playing: ", outro_hang.playing)


func _on_exit_body_entered(body: Node2D) -> void:
	can_exit = true
	print("Exit area entered, press interact to quit.")


func _on_exit_body_exited(body: Node2D) -> void:
	can_exit = false


func _input(event: InputEvent) -> void:
	if can_exit and event.is_action_pressed("interact"):
		print("Quitting game...")
		get_tree().quit()
