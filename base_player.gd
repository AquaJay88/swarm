extends CharacterBody2D

# --- Stats (Exported so child scenes can easily change them) ---
@export var max_health: float = 100.0
@export var current_health: float = 100.0
@export var current_exp: int = 0
@export var exp_to_level: int = 100
@export var speed: float = 400.0

# --- References ---
@onready var hurtbox: Area2D = %Hurtbox
@onready var health_bar = get_tree().root.find_child("HealthBar", true, false)
@onready var exp_bar = get_tree().root.find_child("ExpBar", true, false)

const BULLET_SCENE = preload("res://Bullet.tscn")

func _physics_process(_delta):
	# 1. Movement logic
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()

	# 2. Manual Damage Detection (The "Swarm" Overlap Check)
	if hurtbox:
		var bodies = hurtbox.get_overlapping_bodies()
		for body in bodies:
			if body.is_in_group("enemy"):
				take_damage(body.damage * _delta)

# --- Combat Logic ---

# This function is triggered by your Timer node.
# It handles the "When" to attack.
func _on_timer_timeout():
	attack()

# This function handles the "How" to attack. 
# Child scripts will override this function to change the weapon behavior.
func attack():
	var bullet = BULLET_SCENE.instantiate()
	get_parent().add_child(bullet)
	bullet.global_position = global_position
	bullet.direction = (get_global_mouse_position() - global_position).normalized()

func take_damage(amount):
	current_health -= amount
	if health_bar:
		health_bar.value = current_health
	if current_health <= 0:
		get_tree().reload_current_scene()

# --- Progression Logic ---

func gain_exp(amount):
	current_exp += amount
	if exp_bar:
		exp_bar.value = current_exp
		exp_bar.max_value = exp_to_level
	if current_exp >= exp_to_level:
		level_up()

func level_up():
	current_exp = 0
	# Future step: Open the upgrade menu here
	print("LEVEL UP!")
