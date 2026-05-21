extends RigidBody2D

const LIGHTNING = preload("res://scenes/lightning.tscn")

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
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
	remove_from_group("Balloons")
	var balloons = get_tree().get_nodes_in_group("Balloons")
	for balloon in balloons:
		if Balloon != self:
			get_parent().spawn_lightning(global_position, balloon.position)
			balloon.remove_from_group("Balloons")
	await animated_sprite_2d.animation_finished
	queue_free()

#func spawn_lightning(pos):
	#var new_lightning = LIGHTNING.instantiate()
	#new_lightning.position = global_position
	#new_lightning.target_pos = pos
	#get_parent().add_child(new_lightning)

func _on_hitbox_mouse_entered() -> void:
	has_mouse = true

func _on_hitbox_mouse_exited() -> void:
	has_mouse = false
