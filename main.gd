extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var enemy: EnemyBasic = $EnemyBasic


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemy.target = player

	
