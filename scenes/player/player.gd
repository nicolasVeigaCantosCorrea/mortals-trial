class_name Player
extends CharacterBody2D

@export var stats: CharacterStats

@onready var health_component: HealthComponent = $HealthComponent
@onready var sweep_attack: SweepAttack = $SweepAttack

signal player_death

func _ready() -> void:
	health_component.initialize(stats.max_health)
	health_component.died.connect(_die)
	
	sweep_attack.initialize(stats.attack_power)

func _physics_process(delta: float) -> void:
	var direction: Vector2 = Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)
	
	velocity = direction * stats.move_speed
	move_and_slide()

func take_damage(amount: int) -> void :
	health_component.take_damage(amount)

func _die() -> void:
	print("[PLAYER]: player has died!")
	player_death.emit()
	queue_free()
