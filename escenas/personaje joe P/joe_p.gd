extends CharacterBody2D

var velocidad : int = 170
var salto : int = 250
var gravedad : int = 500
var atacar : bool = false



func _ready():
	
	$Area2D/CollisionShape2D.disabled = true

func _physics_process(delta):
	
	velocity.y += gravedad*delta

	if not atacar:
		if Input.is_action_pressed("ui_right"):
			$CollisionJP.position.x = 1
			$Area2D.position.x = 0
			velocity.x = velocidad
			$animacionesJP.flip_h = false
			
		elif Input.is_action_pressed("ui_left"):
			$animacionesJP.position.x = -1
			$Area2D.position.x = -60
			velocity.x = -velocidad
			$animacionesJP.flip_h = true
			
		else: 
			velocity.x = 0
			
		if is_on_floor():
			if  Input.is_action_just_pressed("ui_up"):
				velocity.y = -salto
			if Input.is_action_just_pressed("ui_accept"):
				atacar = true
				
		move_and_slide()
	else:
		$animacionesJP.play("attack2")
		$Area2D/CollisionShape2D.disabled = false
		await ($animacionesJP.animation_looped)
		$Area2D/CollisionShape2D.disabled = true
		atacar = false
		
		
		
		
	animaciones()

func animaciones():
	if is_on_floor():
		if velocity.x != 0:
			$animacionesJP.play("run")
		else:
			$animacionesJP.play("idle")
	
	else:
		$animacionesJP.play("jump")


func _on_area_2d_body_entered(body):
	if body.is_in_group("enemie"):
		body.death()


