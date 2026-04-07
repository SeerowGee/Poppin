extends Node2D
const RED_BALOON = preload("uid://fx6brrwvixsb")

@onready var spawn_path_location: PathFollow2D = $SpawnPath/SpawnPathLocation
@onready var balloon_pop: AudioStreamPlayer2D = $BalloonPop

func _ready() -> void:
	Event.popped.connect(pop_sound)

func pop_sound():
	print("popped")
	balloon_pop.play()

func _on_balloon_spawn_timer_timeout() -> void:
	var ballooon = RED_BALOON.instantiate()
	
	var spawn_loc = spawn_path_location
	spawn_loc.progress_ratio = randf()
	
	ballooon.position = spawn_loc.position
	
	add_child(ballooon)
