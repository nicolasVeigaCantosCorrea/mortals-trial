class_name EnemyBasic
extends CharacterBody2D

@export var speed: float = 100.0
@export var max_health: int = 3
@export var attack_damage: int = 1

var target: Node2D
var health: int

signal enemy_died

func _ready() -> void:
	health = max_health

func _physics_process(delta: float) -> void:
	if not is_instance_valid(target):
		velocity = Vector2.ZERO
		return
	
	var direction: Vector2 = global_position.direction_to(
		target.global_position
	)
	
	velocity = direction * speed
	move_and_slide()

func take_damage(amount: int) -> void:
	health -= amount;
	print("[EnemyBasic]: enemy took damage of: ", amount)
	
	if is_dead():
		print("[EnemyBasic]: enemy died")
		enemy_died.emit()
		queue_free()
	
func is_dead() -> bool:
	return health <= 0
		

func _on_attack_timer_timeout() -> void:
	var bodies: Array[Node2D] = $AttackArea.get_overlapping_bodies()
	
	for body in bodies:
		if body is Player:
			print("[EnemyBasic]: Enemy attacked!!")
			body.take_damage(attack_damage)
			break
