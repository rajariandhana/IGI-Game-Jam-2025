extends Control

@onready var btn_pause: TextureButton = $BtnPause
@onready var panel: Panel = $Panel
@onready var btn_play: TextureButton = $Panel/BtnPlay
@onready var btn_tutorial: TextureButton = $Panel/BtnTutorial
@onready var btn_resume: TextureButton = $Panel/BtnResume
@onready var click: AudioStreamPlayer2D = $Click
@onready var score_label: Label = $ScoreLabel
@onready var stats: Label = $Panel/Stats

func _ready():
	panel_end(0)
	stats.visible=false
	stats.text=""

func panel_start():
	panel.visible=true
	btn_pause.visible=false
	btn_play.visible=true
	#btn_tutorial.visible=true
	btn_resume.visible=false
	score_label.visible=true
	stats.visible=false
	stats.text=""

func panel_pause():
	panel.visible=true
	btn_pause.visible=false
	btn_play.visible=false
	#btn_tutorial.visible=true
	btn_resume.visible=true
	score_label.visible=true
	stats.visible=false

func panel_playing():
	btn_pause.visible=true
	btn_play.visible=false
	#btn_tutorial.visible=false
	btn_resume.visible=true
	panel.visible=false
	score_label.visible=true
	stats.visible=false

func panel_end(score:int):
	#print("panel_end")
	panel.visible=true
	btn_pause.visible=false
	btn_play.visible=true
	btn_tutorial.visible=false
	btn_resume.visible=false
	score_label.visible=false
	stats.visible=true
	stats.text = "Congrats\n you saved "+str(score)+" ships!"

func update_score(score:int):
	score_label.text = "Ships saved: "+str(score)
