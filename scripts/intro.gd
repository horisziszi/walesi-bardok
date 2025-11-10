extends Node2D
@onready var intro_collision: CollisionShape2D = $"Grounds/Versszak-grounds/Intro/Intro-collision"
@onready var intro_hang: AudioStreamPlayer2D = $"Grounds/Versszak-grounds/Intro/Intro-hang"



func _on_elso_body_entered(_body: Node2D) -> void:
	intro_hang.play()
	intro_collision.queue_free()
