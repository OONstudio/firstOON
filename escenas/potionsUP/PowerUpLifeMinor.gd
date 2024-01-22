extends Area2D

var extralife: int =20



func _on_body_entered(body):
	if body.is_in_group("player"):
		get_tree().get_nodes_in_group("barravida")[0].value += extralife
		
	queue_free()
	$PotionMinor.play()
