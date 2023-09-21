extends CharacterBody2D

signal took_damage

var speed = 300

var rocket_scene = preload("res://Scenes/rocket.tscn")

@onready var rocket_container = $RocketContainer #get_node("RocketContainer")
@onready var shoot_sound = $ShootSound

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		_shoot()

func _physics_process(delta):
	velocity = Vector2(0,0)
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
	if Input.is_action_pressed("move_down"):
		velocity.y = speed
	if Input.is_action_pressed("move_up"):
		velocity.y = -speed
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
	move_and_slide()
	
	var screen_size = get_viewport_rect().size
	
	var screen_clampxy = Vector2(screen_size.x-38, screen_size.y-50)
	global_position = global_position.clamp(Vector2(35,55), screen_clampxy)


func _shoot():
	shoot_sound.play()
	var rocket_instance = rocket_scene.instantiate()
	rocket_container.add_child(rocket_instance)
	rocket_instance.global_position = global_position
	rocket_instance.global_position.x += 80
	
func take_damage():
	emit_signal("took_damage")
	
func die():
	queue_free()
