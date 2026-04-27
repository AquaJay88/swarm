extends Node2D

const ENEMY_SCENE = preload("res://Enemy.tscn")

func _on_timer_timeout():
	var enemy = ENEMY_SCENE.instantiate()
	
	# Spawn at a random position for now
	# Later, we can make them spawn only at the screen edges
	enemy.global_position = Vector2(randf_range(0, 1000), randf_range(0, 1000))
	
	get_parent().add_child(enemy)
