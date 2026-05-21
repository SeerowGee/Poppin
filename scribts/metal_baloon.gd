extends RigidBody2D

const ANVIL = preload("res://scenes/anvil.tscn")

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var drop_point: Marker2D = $Drop_Point
var has_mouse: bool = false
var in_anim: bool = false
var is_ballon: bool = true

func _ready() -> void:
	add_to_group("Balloons")

func  _process(delta: float) -> void:
	if get_global_mouse_position() == global_position:
		has_mouse = true
	
	if has_mouse == true and Input.is_action_just_pressed("leftclick"):
		pop()

func pop():
	Event.popped.emit()
	animated_sprite_2d.play("pop")
	in_anim = true
	drop_anvil()
	await animated_sprite_2d.animation_finished
	remove_from_group("Balloons")
	queue_free()

func drop_anvil():
	var anvil = ANVIL.instantiate()
	anvil.global_position = drop_point.global_position
	get_parent().add_child(anvil)

func _on_hitbox_mouse_entered() -> void:
	has_mouse = true

func _on_hitbox_mouse_exited() -> void:
	has_mouse = false
