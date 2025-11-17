extends Node2D
@onready var intro_collision: CollisionShape2D = $"Grounds/Intro-script/Intro/Intro-collision"
@onready var intro_hang: AudioStreamPlayer2D = $"Grounds/Intro-script/Intro/Intro-hang"






func _on_intro_body_entered(_body: Node2D) -> void:
	intro_hang.attenuation = 0
	intro_hang.max_distance = 100000
	intro_hang.play()
	intro_collision.queue_free()
	
