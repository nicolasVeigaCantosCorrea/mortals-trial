extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var survival_timer: Timer = $SurvivalTimer
@onready var result_label: Label = $CanvasLayer/ResultLabel

@export var run_time: float = 60.0
@export var enemy_scene: PackedScene

var is_run_finished: bool = false

func _ready() -> void:
	result_label.hide()
	start_run()
	
func start_run() -> void:
	is_run_finished = false
	spawn_enemy()
	survival_timer.start(run_time)
	player.died.connect(_on_player_death)
		
func end_run() -> void:
	result_label.show()
	is_run_finished = true
	get_tree().paused = true

func restart_run() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _input(event: InputEvent) -> void:
	if not is_run_finished: return
	if event.is_action_pressed("action"):		
		restart_run()

func _on_timer_timeout() -> void:
	if not is_run_finished:
		print("[GAME]: Victory! You survived for ", run_time, "s")
		result_label.text = "Victory - You survived"
		end_run()

func _on_player_death() -> void:
	if not is_run_finished:
		print("[GAME]: DEFEAT! You died")
		result_label.text = "DEFEAT! You died"
		survival_timer.stop()
		end_run()

func _on_enemy_death() -> void:
	if not is_run_finished:
		spawn_enemy()

func spawn_enemy() -> void:
	var new_enemy: EnemyBasic = enemy_scene.instantiate()
	add_child(new_enemy)
	new_enemy.target = player
	new_enemy.enemy_died.connect(_on_enemy_death)
