extends Area2D

func _on_mist_duration_timeout() -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.has_method("pop") and area.in_anim == false:
		area.pop()
