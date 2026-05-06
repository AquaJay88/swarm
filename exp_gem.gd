extends Area2D

var experience_value = 20
var move_speed = 0.0 # Starts at 0 and accelerates
var magnet_dist = 150.0 # How close the player must be to pull the gem

@onready var player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	if player:
		var distance = global_position.distance_to(player.global_position)
		
		# 4. If player is close, start flying toward them
		if distance < magnet_dist:
			move_speed += 20.0 # Accelerate over time
			var direction = global_position.direction_to(player.global_position)
			global_position += direction * move_speed * delta
			
			# 5. If it touches the player, collect it
			if distance < 15.0:
				collect()

func collect():
	if player.has_method("gain_exp"):
		player.gain_exp(experience_value)
	queue_free()
