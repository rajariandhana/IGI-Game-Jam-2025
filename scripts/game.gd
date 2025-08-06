extends Node2D

var follower = load("res://scenes/follower.tscn")

var SPAWN_INTERVAL={
	MIN_INIT = 4.0,
	MAX_INIT = 10.0,
	MIN = 0,
	MAX = 0
}

var spawn_radius = 100

var SPAWN_AREA={
	MIN=Vector2(-1920/2,-1080/2),
	MAX=Vector2(1920/2,1080/2)
}

var level=0
var saved=0

enum STATES {
	END, PLAYING, PAUSING
}

var GAME_STATE:= STATES.END

@onready var spawn_timer: Timer = $SpawnTimer
@onready var level_timer: Timer = $LevelTimer
@onready var followers: Node2D = $Followers
@onready var ui_manager: Control = $UIManager

func reset():
	print("RESETTING GAME")
	level=0
	saved=0
	for follower in followers.get_children():
		follower.queue_free()
	#spawn_timer = Timer.new()
	var wait=randf_range(SPAWN_INTERVAL["MIN"], SPAWN_INTERVAL["MAX"])
	SPAWN_INTERVAL["MIN"]=SPAWN_INTERVAL["MIN_INIT"]
	SPAWN_INTERVAL["MAX"]=SPAWN_INTERVAL["MAX_INIT"]
	ui_manager.update_score(saved)

func start():
	spawn_timer.start()
	level_timer.start()
	ui_manager.panel_playing()
	get_tree().paused=false
	GAME_STATE=STATES.PLAYING
	print("GAME STARTED")

func _on_spawn_timer_timeout() -> void:
	spawn_follower()
	var wait=randf_range(SPAWN_INTERVAL["MIN"], SPAWN_INTERVAL["MAX"])
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
		randf_range(SPAWN_AREA["MIN"].x, SPAWN_AREA["MAX"].x),
		randf_range(SPAWN_AREA["MIN"].y, SPAWN_AREA["MAX"].y)
	)
	if v.distance_to(Vector2.ZERO) < 500:
		return get_random_spawn_position()
	for follower in followers.get_children():
		if v.distance_to(follower.position) < spawn_radius:
			return get_random_spawn_position()
	return v
	
func _on_level_timer_timeout() -> void:
	level+=1
	print("LVL: "+str(level)+" | SAVED: "+str(level))
	SPAWN_INTERVAL["MIN"] = max(SPAWN_INTERVAL["MIN"]-1,0, 0.0)
	SPAWN_INTERVAL["MAX"] = max(SPAWN_INTERVAL["MAX"]-0.5, 2.5)
	#print("Min: "+str(SPAWN_INTERVAL["MIN)+" | Max: "+str(SPAWN_INTERVAL["MAX))

func _on_lh_area_entered(area: Area2D) -> void:
	pass
	
func _on_follower_saved(follower:Follower):
	saved+=1
	ui_manager.update_score(saved)

func _on_follower_crash(follower:Follower):
	print("CRASH")
	ui_manager.panel_end(saved)
	level_timer.stop()
	spawn_timer.stop()
	get_tree().paused=true
	GAME_STATE=STATES.END

func _on_btn_pause_pressed() -> void:
	#print("_on_btn_pause_pressed")
	ui_manager.panel_pause()
	get_tree().paused=true
	GAME_STATE=STATES.PAUSING

func _on_btn_play_pressed() -> void:
	#print("_on_btn_play_pressed")
	reset()
	start()
	GAME_STATE=STATES.PLAYING

func _on_btn_tutorial_pressed() -> void:
	pass
	#print("_on_btn_tutorial_pressed")


func _on_btn_resume_pressed() -> void:
	#print("_on_btn_resume_pressed")
	ui_manager.panel_playing()
	get_tree().paused=false
	GAME_STATE=STATES.PLAYING

#NO NEED SINCE WONT BE DETECTED IF PAUSED, NEED TO FIND A WAY
#func _input(event: InputEvent) -> void:
	#if event is InputEventKey and event.pressed and not event.echo:
		#if event.keycode == KEY_ESCAPE:
			#if GAME_STATE == STATES.PAUSING:
				#_on_btn_pause_pressed()
