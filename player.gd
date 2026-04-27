extends CharacterBody2D

# 1. Constants and Preloads
const SPEED = 400.0
const BULLET_SCENE = preload("res://Bullet.tscn") # Restore this to shoot!

# 2. Stats
var max_health = 100
var current_health = 100
var health_bar_node = null

func _ready():
	print("PLAYER SYSTEM: Online")
	# Stable search for the HUD HealthBar regardless of scene structure
	health_bar_node = get_tree().root.find_child("HealthBar", true, false)
	
	if health_bar_node == null:
		print("UI WARNING: Could not find HealthBar in the game world!")

func _physics_process(_delta):
	# 3. Movement Logic
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED if direction else velocity.move_toward(Vector2.ZERO, SPEED)
	move_and_slide()
	
	# 4. Damage Logic (Uses the Unique Name %Hurtbox)
	if %Hurtbox != null:
		var bodies = %Hurtbox.get_overlapping_bodies()
		for body in bodies:
			if body.is_in_group("enemy"):
				take_damage(0.5) # Constant damage per frame while touching
	else:
		print("PHYSICS ERROR: Player is missing the '%Hurtbox' node!")

# 5. Restored Shooting Logic (Triggered by Timer)
func _on_timer_timeout():
	# If this prints but no bullet appears, check your Bullet.tscn filename!
	
	var bullet = BULLET_SCENE.instantiate()
	get_parent().add_child(bullet) # Add bullet to the World, not the Player
	bullet.global_position = global_position
	
	# Aim toward the current mouse position
	var target = get_global_mouse_position()
	bullet.direction = (target - global_position).normalized()

func take_damage(amount):
	current_health -= amount
	
	# Update Health Bar visually
	if health_bar_node != null:
		health_bar_node.value = current_health
	
	if current_health <= 0:
		die()

func die():
	print("GAME OVER: Restarting...")
	get_tree().reload_current_scene()
