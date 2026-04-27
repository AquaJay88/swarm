extends CharacterBody2D

# Stats
var damage = 10 # This is the number the Player's Hurtbox looks for
var speed = 80.0 # Enemies move slower than the player

# Finding the Player
# This looks for the node you tagged in the "player" group
@onready var player = get_tree().get_first_node_in_group("player")

func _physics_process(_delta):
	if player:
		# 1. Calculate the direction toward the player
		var direction = global_position.direction_to(player.global_position)
		
		# 2. Set velocity and move
		velocity = direction * speed
		move_and_slide()
	else:
		# If the enemy can't find the player, it tries to find them again
		player = get_tree().get_first_node_in_group("player")
