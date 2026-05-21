extends Area2D

const SPEED = 80

var target_pos

func _ready() -> void:
	var target = get_tree().get_first_node_in_group("Balloons")
	target_pos = target.global_position
	

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("pop"):
		body.pop()
	#queue_free()

func _physics_process(delta: float) -> void:
	#var tween = create_tween()
	#tween.tween_property(self, "global_position", target_pos, delta)
	#tween.tween_callback(kill_lightning).set_delay(0.2)
	#move_toward(global_position.y, target_pos.y,delta)
	position = position.lerp(target_pos, delta * SPEED)
	kill_lightning()


func kill_lightning():
	if position == target_pos:
		queue_free()
	#queue_free()
