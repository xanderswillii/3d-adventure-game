extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.node_position != "":
		var spawn_point = find_child(Global.node_position)
		if spawn_point:
			print("Spawning player at:", spawn_point.global_position)
			$Player.global_position = spawn_point.global_position
			$Player.rotation_degrees.y = Global.rotation
