class_name EnemyBasic
extends CharacterBody2D

@export var speed: float = 100.0

var target: Node2D

func _physics_process(delta: float) -> void:
	if not is_instance_valid(target):
		velocity = Vector2.ZERO
		return
	
	var direction: Vector2 = global_position.direction_to(
		target.global_position
	)
	
	velocity = direction * speed
	move_and_slide()
