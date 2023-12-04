extends CharacterBody2D

var velocidad : int = 170
var salto : int = 250
var gravedad : int = 500
var hitplayer = false



func _ready():

	$Area2D/CollisionShape2D.disabled = true

func _physics_process(delta):
	
	velocity.y += gravedad*delta
	if !hitplayer:
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
		else: 
			if Input.is_action_just_released("ui_up"):
				velocity.y += 6000*delta

					
		animaciones()
		
	move_and_slide()

func _input(event):
	if Input.is_action_just_pressed("ui_accept") and !hitplayer:
		set_physics_process(false)
		$animacionesJP.play("attack2")
		$Area2D/CollisionShape2D.disabled= false
		await $animacionesJP.animation_finished
		$Area2D/CollisionShape2D.disabled= true
		set_physics_process(true)
		
	elif Input.is_action_just_pressed("atacar2") and !hitplayer:
		set_physics_process(false)
		$animacionesJP.play("attack1")
		$Area2D/CollisionShape2D.disabled= false
		await $animacionesJP.animation_finished
		$Area2D/CollisionShape2D.disabled= true
		set_physics_process(true)

func animaciones():
	if is_on_floor():
		if velocity.x != 0:
			$animacionesJP.play("run")
		else:
			$animacionesJP.play("idle")
	
	else:
		if velocity.y <0:
			$animacionesJP.play("jump")

func hit():
	hitplayer = true
	velocity = Vector2.ZERO
	if !$animacionesJP.flip_h:
		velocity = Vector2 (-100,-100)
	
	else:
		velocity = Vector2 (100,-100)
		
	$animacionesJP.play("hurt")
	await $animacionesJP.animation_finished
	velocity = Vector2.ZERO
	hitplayer= false


func _on_area_2d_body_entered(body):
	if body.is_in_group("enemie"):
		body.death()


