extends CharacterBody2D

# --- Stats ---
var max_health = 100
var current_health = 100
var current_exp = 0
var exp_to_level = 100
const SPEED = 400.0

# --- References ---
@onready var hurtbox: Area2D = %Hurtbox
const BULLET_SCENE = preload("res://Bullet.tscn")

# This helps the player find the bars in your HUD scene
@onready var health_bar = get_tree().root.find_child("HealthBar", true, false)
@onready var exp_bar = get_tree().root.find_child("ExpBar", true, false)

func _physics_process(_delta):
	# 1. Movement logic
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED
	move_and_slide()

	# 2. Manual Damage Detection (The "Swarm" Overlap Check)
	# This must be indented like the lines above to stay inside the function! 
	if hurtbox:
		var bodies = hurtbox.get_overlapping_bodies()
		for body in bodies:
			if body.is_in_group("enemy"):
				take_damage(body.damage * _delta) # Dealing damage over time while touching

# --- The Missing EXP Function ---
func gain_exp(amount):
	current_exp += amount
	
	# Update the purple bar visually
	if exp_bar:
		exp_bar.value = current_exp
		exp_bar.max_value = exp_to_level
	
	# Check for Level Up
	if current_exp >= exp_to_level:
		level_up()

func level_up():
	current_exp = 0
	# For now, we just print this to the console
	print("LEVEL UP!") 

func take_damage(amount):
	current_health -= amount
	if health_bar:
		health_bar.value = current_health
	if current_health <= 0:
		get_tree().reload_current_scene()

func _on_timer_timeout():
	var bullet = BULLET_SCENE.instantiate()
	get_parent().add_child(bullet)
	bullet.global_position = global_position
	bullet.direction = (get_global_mouse_position() - global_position).normalized()
