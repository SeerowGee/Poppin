extends Area2D

const SPEED = 5

func _physics_process(delta: float) -> void:
	position.y += SPEED

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("pop"):
		if body.in_anim == false:
			body.pop()
