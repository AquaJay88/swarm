extends Area2D

var speed = 600
var direction = Vector2.RIGHT # The bullet will start flying to the right

func _process(delta):
	# Move the bullet in its set direction every frame
	position += direction * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body):
	if body.is_in_group("enemy"):
		# 3. Call the die function we just created
		if body.has_method("die"):
			body.die()
		else:
			body.queue_free()
		queue_free()
