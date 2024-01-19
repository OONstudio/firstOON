extends CharacterBody2D

@export var trapShoot : PackedScene
var canshoot :  bool = true

func _ready():
	pass

func _process(delta):
	if $RayCast2D.is_colliding():
		var obj= $RayCast2D.get_collider()
		if obj.is_in_group("player") and canshoot:
			canshoot = false
			$Timer.start()
			shoot()

func shoot():
	var newbullet = trapShoot.instantiate()
	newbullet.global_position = $Marker2D.global_position
	get_parent().add_child(newbullet)
	


func _on_timer_timeout():
	canshoot = true
