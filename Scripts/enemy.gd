extends CharacterBody3D


enum States {attack, idle, chase, die}

var state = States.idle
var hp = 15
var speed = 2


func _process(delta):
	behaviors()


func behaviors():
	if state == States.idle:
		print("idle")
		velocity = Vector3.ZERO
	elif state == States.chase:
		print("chase")
		velocity == Vector3.ZERO
	elif state == States.attack:
		print("attack")
		velocity = Vector3.ZERO
	elif state == States.die:
		velocity = Vector3.ZERO


func _on_chase_area_body_entered(body: Node3D) -> void:
	if body.has_method("player"):
		state = States.chase


func _on_chase_area_body_exited(body: Node3D) -> void:
	if body.has_method("player"):
		state = States.idle


func _on_attack_area_body_entered(body: Node3D) -> void:
	if body.has_method("player"):
		state = States.attack


func _on_attack_area_body_exited(body: Node3D) -> void:
	if body.has_method("player"):
		state = States.chase
