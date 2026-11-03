class_name Player
extends CharacterBody2D

@export var speed: float = 200.0
@export var max_health: int = 5
@export var attack_damage: int = 1

var health: int
signal died

func _ready() -> void:
	health = max_health

func _physics_process(delta: float) -> void:
	var direction: Vector2 = Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)
	
	velocity = direction * speed
	move_and_slide()


func _on_attack_timer_timeout() -> void:
	var bodies: Array[Node2D] = $AttackArea.get_overlapping_bodies()
	
	for body in bodies:
		if body is EnemyBasic:
			print("[Player]: Attack! Enemy attacked!")
			body.take_damage(attack_damage)
			break

func take_damage(amount: int) -> void :
	health -= amount
	
	if is_dead():
		die()

func die() -> void:
	print("[PLAYER]: player has died :(")
	died.emit()
	queue_free()

func is_dead() -> bool:
	return health <= 0
