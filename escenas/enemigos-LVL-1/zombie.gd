func _process(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2(0, -1))

	if is_on_floor() and randf() < 0.01 and not is_attacking:
		jump()

	if is_attacking:
		# Lógica de ataque aquí

func jump():
	velocity.y = jump_force

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		is_attacking = true

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		is_attacking = false

func _on_RayCast2D_body_entered(body):
	# Detecta precipicios y gira enemigo
	if body.is_in_group("ground"):
		velocity.x *= -1

