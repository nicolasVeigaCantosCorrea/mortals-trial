class_name HealthComponent
extends Node

var current_health: int
var is_dead: bool = false
signal died

func initialize(max_health: int):
	current_health = max_health
	is_dead = false

func take_damage(amount: int):
	if is_dead:
		return
	current_health = maxi(0, current_health-amount)
	
	if current_health <= 0:
		is_dead = true
		died.emit()
