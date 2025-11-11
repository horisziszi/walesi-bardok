extends Area2D

const FILE_BEGIN = "res://scenes/level"

var player_in_area = false

func _on_body_entered(body):
	if body.name == "player": # optional, to ensure it's the player
		player_in_area = true
		print("Player entered area")

func _on_body_exited(body):
	if body.name == "player":
		player_in_area = false
		print("Player left area")

func _process(_delta):
	if player_in_area and Input.is_action_just_pressed("interact"):
		print("Pressed interact")
		var current_scene_file = get_tree().current_scene.scene_file_path
		# Extract the level number safely
		var current_level_number = int(current_scene_file.get_basename().replace("res://scenes/level", ""))
		var next_level_number = current_level_number + 1
		var next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn"
		print("Loading: ", next_level_path)
		get_tree().change_scene_to_file(next_level_path)
