extends Area2D

func _on_mist_duration_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("pop") and body.in_anim == false:
		body.pop()
