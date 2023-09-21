extends Area2D

@export var _enemy_speed = 250

signal died

func _physics_process(delta):
	global_position.x -= _enemy_speed * delta

func die():
	emit_signal("died")
	queue_free()

func _on_body_entered(body):
	body.take_damage()
	die()
