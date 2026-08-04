extends Node3D

var has_triggered = false

var destinations : Dictionary = {
	forest_1_portal_1 = {
		scene = "res://Scenes/world.tscn",
		nameNode = "SpawnPoint1",
		rotationNode = -90
	},
	forest_2_portal_1 = {
		scene = "res://Scenes/world2.tscn",
		nameNode = "SpawnPoint2",
		rotationNode = -90
	}
}

@export var destination : String 

func change_world(_dest : String) -> void:
	print("Starting load...")
	var scene_destination = load(destinations[_dest].scene)
	print("Load finished")
	Global.node_position = destinations[_dest].nameNode
	Global.rotation = destinations[_dest].rotationNode
	get_tree().change_scene_to_packed(scene_destination)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player" and not has_triggered:
		has_triggered = true
		call_deferred("change_world", destination)
