class_name SweepAttack
extends Node2D

@onready var attack_area: Area2D = $AttackArea
@onready var attack_shape: CollisionShape2D = $AttackArea/CollisionShape2D
@onready var attack_timer: Timer = $AttackTimer
@onready var explosion_particles: GPUParticles2D = $Explosion

@export_flags_2d_physics var target_mask: int = 0
@export_range(0.1, 10.0, 0.1) var attack_time: float = 1.0

var attack_power: int

func _ready() -> void:
	attack_area.collision_mask = target_mask

func initialize(attack_power:int) -> void:
	self.attack_power = attack_power
	attack_timer.start(attack_time)
	
# Attack here
func _on_timer_timeout() -> void:
	explosion_particles.restart()

	var bodies: Array[Node2D] = attack_area.get_overlapping_bodies()
	for body in bodies:
		if body.has_method("take_damage"):
			body.take_damage(attack_power)	
		
	
