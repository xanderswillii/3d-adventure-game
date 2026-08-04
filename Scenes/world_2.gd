extends Node3D



func _ready() -> void:
	if Global.node_position != "":
		var spawn_point = find_child(Global.node_position)
		if spawn_point:
			$Player.global_position = spawn_point.global_position
			$Player.rotation_degrees.y = Global.rotation
			
