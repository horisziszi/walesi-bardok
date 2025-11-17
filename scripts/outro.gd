extends Node2D
@onready var outro_collision: CollisionShape2D = $"Grounds/Versszak-grounds/Outro/Outro-collision"
@onready var outro_hang: AudioStreamPlayer2D = $"Grounds/Versszak-grounds/Outro/Outro-hang"


func _on_outro_body_entered(_body: Node2D) -> void:
	outro_hang.attenuation = 0
	outro_hang.max_distance = 100000
	outro_hang.play()
	outro_collision.queue_free()
	print("is_playing: ", outro_hang.playing)
