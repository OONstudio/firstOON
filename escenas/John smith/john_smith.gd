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
			$CollisionJS.position.x = 1
			$Area2D.position.x = 0
			velocity.x = velocidad
			$animacionesjs.flip_h = false
				
		elif Input.is_action_pressed("ui_left"):
			$animacionesjs.position.x = -1
			$Area2D.position.x = -60
			velocity.x = -velocidad
			$animacionesjs.flip_h = true
				
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
		$animacionesjs.play("attack")
		$Area2D/CollisionShape2D.disabled= false
		await $animacionesjs.animation_finished
		$Area2D/CollisionShape2D.disabled= true
		set_physics_process(true)
		
	elif Input.is_action_just_pressed("atacar2") and !hitplayer:
		set_physics_process(false)
		$animacionesjs.play("shoot")
		$Area2D/CollisionShape2D.disabled= false
		await $animacionesjs.animation_finished
		$Area2D/CollisionShape2D.disabled= true
		set_physics_process(true)

func animaciones():
	if is_on_floor():
		if velocity.x != 0:
			$animacionesjs.play("run")
		else:
			$animacionesjs.play("idle")
	
	else:
		if velocity.y <0:
			$animacionesjs.play("jump")

func hit():
	hitplayer = true
	velocity = Vector2.ZERO
	if !$animacionesjs.flip_h:
		velocity = Vector2 (-100,-100)
	
	else:
		velocity = Vector2 (100,-100)
		
	$animacionesjs.play("hurt")
	await $animacionesjs.animation_finished
	velocity = Vector2.ZERO
	hitplayer= false

	get_tree().get_nodes_in_group("barravida")[0].DisminuirVida(25)

func _on_area_2d_body_entered(body):
	if body.is_in_group("enemie"):
		body.death()



