extends CanvasLayer

func _ready():
	# This function runs ONCE when the game starts to position your UI
	
	# 1. Experience Bar (The long purple line at the bottom)
	if has_node("%ExpBar"):
		%ExpBar.set_anchors_and_offsets_preset(Control.PRESET_BOTTOM_WIDE)
		%ExpBar.custom_minimum_size.y = 12
		%ExpBar.modulate = Color("8e44ad")

	# 2. Central UI Container (Where the portrait and health live)
	if has_node("%Control"):
		%Control.set_anchors_and_offsets_preset(Control.PRESET_CENTER_BOTTOM)
		%Control.position.y -= 50

	# 3. Health Bar (Green)
	if has_node("%HealthBar"):
		%HealthBar.size = Vector2(300, 25)
		%HealthBar.modulate = Color("2ecc71")
		%HealthBar.value = 100 # Fill it up at start
