extends Node2D

var follower = load("res://follower.tscn")

var spawn_interval_min = 4.0
var spawn_interval_max = 10.0
var spawn_radius = 100

var spawn_area_min = Vector2(-1920/2,-1080/2)
var spawn_area_max = Vector2(1920/2,1080/2)

@onready var canvas_layer: CanvasLayer = $CanvasLayer

var level=0

var score=0

@onready var spawn_timer: Timer = $SpawnTimer
@onready var followers: Node2D = $Followers

func _ready() -> void:
	setup_ui()

func play():
	print("GAME START")
	spawn_timer = Timer.new()
	var wait=randf_range(spawn_interval_min, spawn_interval_max)
	level=0
	score=0
	#score_label.text = "Ship saved: "+str(score)
	print("wait time: "+str(wait))


func _on_spawn_timer_timeout() -> void:
	spawn_follower()
	var wait=randf_range(spawn_interval_min, spawn_interval_max)
	print("wait time: "+str(wait))
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
	
func saved():
	score+=1
	#score_label.text = "Ship saved: "+str(score)
	#canvas_layer.update_score()
	
func _on_level_timer_timeout() -> void:
	level+=1
	print("LVL: "+str(level))
	spawn_interval_min = max(spawn_interval_min-1,0, 0.0)
	spawn_interval_max = max(spawn_interval_max-0.5, 2.5)
	print("Min: "+str(spawn_interval_min)+" | Max: "+str(spawn_interval_max))


func _on_lh_area_entered(area: Area2D) -> void:
	pass
	#if area is Follower:
		#print("dead")

@onready var btn_pause: TextureButton = $CanvasLayer/BtnPause
@onready var panel: Panel = $CanvasLayer/Panel
@onready var btn_play: TextureButton = $CanvasLayer/Panel/BtnPlay
#@onready var btn_tutorial: TextureButton = $CanvasLayer/Panel/BtnTutorial
@onready var btn_resume: TextureButton = $CanvasLayer/Panel/BtnResume
@onready var click: AudioStreamPlayer2D = $CanvasLayer/Click
@onready var score_label: Label = $CanvasLayer/ScoreLabel

func setup_ui() -> void:
	#await get_tree().create_timer(0.5).timeout  # Waits for 0.5 seconds
	#print("0.5 seconds have passed!")
	#btn_pause.visible=false
	#btn_play.visible=true
	#btn_resume.visible=false
	##btn_tutorial.visible=true
	#panel.visible=true
	get_tree().paused = true
	#update_score()
	
func pause():
	btn_pause.visible=false
	btn_play.visible=false
	btn_resume.visible=true
	#btn_tutorial.visible=true
	panel.visible=true
	get_tree().paused = true
	print("GAME PAUSED")

func resume():
	btn_pause.visible=true
	btn_play.visible=false
	btn_resume.visible=true
	#btn_tutorial.visible=true
	panel.visible=false
	get_tree().paused = false
	print("GAME RESUMED")

func _on_btn_play_pressed() -> void:
	click.play()
	Game.play()
	resume()

func _on_btn_tutorial_pressed() -> void:
	click.play()
	print("TUTORBOSS")

func _on_btn_resume_pressed() -> void:
	click.play()
	resume()

func _on_btn_pause_pressed() -> void:
	click.play()
	pause()

	
func die():
	panel.visible=true
	btn_play.visible=true
	btn_resume.visible=false
	#btn_tutorial.visible=true
	get_tree().paused = true
