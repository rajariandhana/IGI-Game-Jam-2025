extends Node2D

var follower = load("res://follower.tscn")

var spawn_interval_min = 4.0
var spawn_interval_max = 10.0
var spawn_radius = 100

var spawn_area_min = Vector2(-1920/2,-1080/2)
var spawn_area_max = Vector2(1920/2,1080/2)

var level=0
var score=0

@onready var spawn_timer: Timer = $SpawnTimer
@onready var level_timer: Timer = $LevelTimer
@onready var followers: Node2D = $Followers
@onready var ui_manager: Control = $UIManager

func reset():
	print("RESETTING GAME")
	level=0
	score=0
	for follower in followers.get_children():
		follower.queue_free()
	#spawn_timer = Timer.new()
	var wait=randf_range(spawn_interval_min, spawn_interval_max)

func start():
	reset()
	spawn_timer.start()
	level_timer.start()
	print("GAME STARTED")
	ui_manager.update_score(score)

func _on_spawn_timer_timeout() -> void:
	spawn_follower()
	var wait=randf_range(spawn_interval_min, spawn_interval_max)
	#print("wait time: "+str(wait))
	spawn_timer.wait_time = wait
	
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
	f.saved.connect(_on_follower_saved)
	f.crash.connect(_on_follower_crash)
	
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
	
func _on_level_timer_timeout() -> void:
	level+=1
	print("LVL: "+str(level))
	spawn_interval_min = max(spawn_interval_min-1,0, 0.0)
	spawn_interval_max = max(spawn_interval_max-0.5, 2.5)
	#print("Min: "+str(spawn_interval_min)+" | Max: "+str(spawn_interval_max))


func _on_lh_area_entered(area: Area2D) -> void:
	pass
	
func _on_follower_saved(follower:Follower):
	score+=1
	ui_manager.update_score(score)

func _on_follower_crash(follower:Follower):
	print("CRASH")
	ui_manager.panel_end(score)
	level_timer.stop()
	spawn_timer.stop()
	get_tree().paused=true

func _on_btn_pause_pressed() -> void:
	#print("_on_btn_pause_pressed")
	ui_manager.panel_pause()
	get_tree().paused=true

func _on_btn_play_pressed() -> void:
	#print("_on_btn_play_pressed")
	ui_manager.panel_playing()
	ui_manager.update_score(score)
	for f in followers.get_children():
		f.queue_free()
	get_tree().paused=false
	start()

func _on_btn_tutorial_pressed() -> void:
	pass
	#print("_on_btn_tutorial_pressed")


func _on_btn_resume_pressed() -> void:
	#print("_on_btn_resume_pressed")
	ui_manager.panel_playing()
	get_tree().paused=false
