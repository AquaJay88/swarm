extends CharacterBody2D

# Core stats that all characters share
@export var speed: float = 300.0
@export var health: int = 100
@export var experience: int = 0

@onready var hurtbox = %Hurtbox # Using a unique name for the Area2D

func _physics_process(delta):
	# Core WASD Movement logic
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
	
	# Check for incoming damage from the swarm
	check_for_damage()

func check_for_damage():
	var overlapping_enemies = hurtbox.get_overlapping_areas()
	if overlapping_enemies.size() > 0:
		health -= 1 # Simple damage logic for now
		# Add logic here to update your HUD HealthBar

# PLACEHOLDER: This will be unique for each character
func attack():
	pass # Child characters like the Tactical Yordle will override this
