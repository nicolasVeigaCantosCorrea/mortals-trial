class_name EnemyBasic
extends CharacterBody2D

@onready var sprite : Sprite2D = $Sprite2D
@onready var health_component : HealthComponent = $HealthComponent
@onready var sweep_attack: SweepAttack = $SweepAttack
@export var stats : CharacterStats

var target: Node2D

signal enemy_died

func _ready() -> void:
	health_component.initialize(stats.max_health)
	print("[ENEMY] Stats texture: ", stats.sprite)
	print("[ENEMY] Texture path: ",
		stats.sprite.resource_path if stats.sprite != null else "NULL")
	sprite.texture = stats.sprite
	health_component.died.connect(_die)
	
	sweep_attack.initialize(stats.attack_power)

func _physics_process(delta: float) -> void:
	if not is_instance_valid(target):
		velocity = Vector2.ZERO
		return
	
	var direction: Vector2 = global_position.direction_to(
		target.global_position
	)
	
	velocity = direction * stats.move_speed
	move_and_slide()

func take_damage(amount: int) -> void:
	health_component.take_damage(amount)

func _die() -> void:
	print("[ENEMY]: enemy died!")
	enemy_died.emit()
	queue_free()
		
