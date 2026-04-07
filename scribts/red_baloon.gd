extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var has_mouse: bool = false
var in_anim: bool = false

func  _process(delta: float) -> void:
	if get_global_mouse_position() == global_position:
		has_mouse = true
	
	if has_mouse == true and Input.is_action_just_pressed("leftclick"):
		pop()

func pop():
	Event.popped.emit()
	animated_sprite_2d.play("pop")
	in_anim = true

func _physics_process(delta: float) -> void:
	position.y -= 1

func _on_hitbox_mouse_entered() -> void:
	has_mouse = true

func _on_hitbox_mouse_exited() -> void:
	has_mouse = false
