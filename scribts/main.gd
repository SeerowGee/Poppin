extends Node2D
const RED_BALOON = preload("res://scenes/red_baloon.tscn")
const GREEN_BALLOON = preload("res://scenes/green_baloon.tscn")
const YELLOW_BALLOON = preload("res://scenes/yellow_baloon.tscn")
const METAL_BALLOON = preload("res://scenes/metal_baloon.tscn")

const LIGHTNING = preload("res://scenes/lightning.tscn")

@onready var spawn_path_location: PathFollow2D = $SpawnPath/SpawnPathLocation
@onready var balloon_pop: AudioStreamPlayer2D = $BalloonPop
@onready var max_rand_up: Timer = $MaxRandUp

var min_rand: int = 2
var max_rand: int = 3

func _ready() -> void:
	Event.popped.connect(pop_sound)

func pop_sound():
	balloon_pop.play()

func _on_balloon_spawn_timer_timeout() -> void:
	var decider = randi_range(min_rand, max_rand)
	var balloon
	match decider:
		1,2,3:
			balloon = RED_BALOON
		4:
			balloon = GREEN_BALLOON
		5: 
			balloon = METAL_BALLOON
	var new_balloon = balloon.instantiate()
	var spawn_loc = spawn_path_location
	spawn_loc.progress_ratio = randf()
	new_balloon.position = spawn_loc.position
	add_child(new_balloon)
	#print(get_tree().get_nodes_in_group("Balloons"))
	print(decider)

func spawn_lightning(spawn_pos, traget_pos):
	var new_lightning = LIGHTNING.instantiate()
	new_lightning.global_position = spawn_pos
	add_child(new_lightning)

func _on_max_rand_up_timeout() -> void:
	max_rand += 1
	if max_rand == 5:
		max_rand_up.stop()


func _on_killzone_body_entered(body: Node2D) -> void:
	if body.has_method("pop"):
		body.queue_free()
