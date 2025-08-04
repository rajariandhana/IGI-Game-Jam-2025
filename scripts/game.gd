extends Node2D

var follower = load("res://follower.tscn")

var spawn_interval_min = 5.0
var spawn_interval_max = 15.0
var spawn_radius = 100
var spawn_area_min = Vector2(-1920/2,-1080/2)
var spawn_area_max = Vector2(1920/2,1080/2)

@onready var spawn_timer: Timer = $SpawnTimer
@onready var followers: Node2D = $Followers

func _ready() -> void:
	spawn_timer = Timer.new()
	spawn_timer.wait_time = randf_range(spawn_interval_min, spawn_interval_max)
	add_child(spawn_timer)
	#var f1:Follower = follower.instantiate()
	#followers.add_child(f1)
	#f1.set_props(0, Vector2(-1920/2,0))

func _on_spawn_timer_timeout() -> void:
	spawn_follower()
	spawn_timer.wait_time = randf_range(spawn_interval_min, spawn_interval_max)
	
func spawn_follower():
	var chance = randi_range(0,10)
	var f:Follower = follower.instantiate()
	followers.add_child(f)
	var v = get_random_spawn_position()
	var type=0
	if 5<=chance && chance<=7:
		type=1
	elif 8<=chance && chance<=10:
		type=2
	f.set_props(type,v)
		
func get_random_spawn_position() -> Vector2:
	var v = Vector2(
		randf_range(spawn_area_min.x, spawn_area_max.x),
		randf_range(spawn_area_min.y, spawn_area_max.y)
	)
	if v.distance_to(Vector2.ZERO) < 500:
		return get_random_spawn_position()
	for follower in followers.get_children():
		if v.distance_to(follower.position) < spawn_radius:
			return get_random_spawn_position()
	return v
	
