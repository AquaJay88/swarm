extends CharacterBody2D

# Preload the gem scene so the enemy can "spawn" it
const EXP_GEM = preload("res://ExpGem.tscn")

var damage = 10
var speed = 80.0

@onready var player = get_tree().get_first_node_in_group("player")

func _physics_process(_delta):
	if player:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		move_and_slide()

# 2. This function replaces the old logic of just disappearing
func die():
	var gem = EXP_GEM.instantiate()
	# Add the gem to the main world scene, not as a child of the enemy
	get_tree().current_scene.add_child(gem)
	gem.global_position = global_position
	queue_free()
