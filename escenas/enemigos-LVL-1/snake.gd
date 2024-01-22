extends CharacterBody2D

var velocidad: int = 70
var vel_perseguir: int = 150
var perseguir: bool = false
var gravedad: int = 500


func _ready():
	$AnimatedSnake.play("walk")
	velocity.x = -velocidad

@warning_ignore("unused_parameter")
func _physics_process(delta):
	
	detectar()
	if !perseguir:
		if is_on_wall():
			if !$AnimatedSnake.flip_h:
				velocity.x = velocidad
			else:
				velocity.x = -velocidad
				
		if velocity.x < 0:
			$AnimatedSnake.flip_h = false
		elif velocity.x > 0:
			$AnimatedSnake.flip_h = true
			
		velocity.y += gravedad * delta
	move_and_slide()
	
func detectar():
	if $right.is_colliding():
		var obj = $right.get_collider()
		if obj.is_in_group("player") :
			perseguir = true
			velocity.x= vel_perseguir
			$AnimatedSnake.flip_h = true 
		else:
			perseguir = false
	if $left.is_colliding():
		var obj = $left.get_collider()
		if obj.is_in_group("player"): 
			perseguir = true
			velocity.x= -vel_perseguir
			$AnimatedSnake.flip_h = false
		else:
			perseguir = false

func _on_damage_body_entered(body):
	if body.is_in_group("player"):
		body.hit()
		$AnimatedSnake.play("attack")
		$snakeAttack.play()
		

func death():
	print("el enemigo esta muriendo")
	set_physics_process(false)
	$hit.play()
	$AnimatedSnake.play("death")
	
	$SnakeDeath.play()
	await ($AnimatedSnake.animation_finished)
	queue_free()


