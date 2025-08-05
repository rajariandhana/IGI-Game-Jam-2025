extends CanvasLayer

@onready var btn_pause: TextureButton = $BtnPause
@onready var panel: Panel = $Panel
@onready var btn_play: TextureButton = $Panel/BtnPlay
#@onready var btn_tutorial: TextureButton = $Panel/BtnTutorial
@onready var btn_resume: TextureButton = $Panel/BtnResume
@onready var click: AudioStreamPlayer2D = $Click
@onready var score_label: Label = $ScoreLabel


	
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

#func update_score():
	#score_label.text = "Ship saved: "+str(Game.score)
