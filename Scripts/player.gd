extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var sensitivity = 0.003
var onCooldown = false

var gold = 15
var hp = 50
var maxHP = 50
var damage = 10
var target = []

@onready var goldLabel = $HUD/Label
@onready var hpBar = $HUD/HpBar
@onready var camera = $FirstPerson
@onready var animationPlayer = $AnimationPlayer
@onready var cooldown = $AttackCooldown

func player():
	pass

func _ready():
	hpBar.max_value = 50
	$FirstPerson.current = true
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func deal_damage():
	for enemies in target:
		enemies.hp -= damage

func attack():
	if Input.is_action_just_pressed("attack") and onCooldown == false:
		animationPlayer.play("SwordSwing")
		onCooldown = true
		cooldown.start()

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * sensitivity)
		camera.rotate_x(-event.relative.y * sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(70))

func _switch_view():
	if Input.is_action_just_pressed("switch"):
		if camera == $FirstPerson:
			camera = $Head
			$Head/ThirdPerson.current = true
		else:
			camera = $FirstPerson
			$FirstPerson.current = true 

func update_HUD():
	hpBar.value = hp
	goldLabel.text = str(gold)

func _process(delta):
	update_HUD()
	attack()
	_switch_view()
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
		
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	move_and_slide()


func _on_attack_cooldown_timeout() -> void:
	onCooldown = false


func _on_attack_zone_body_entered(body: Node3D) -> void:
	if body.has_method("enemy"):
		target.append(body)

 
func _on_attack_zone_body_exited(body: Node3D) -> void:
	if body.has_method("enemy"):
		target.erase(body)
