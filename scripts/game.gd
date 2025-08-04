extends Node2D

var on: bool

func _ready() -> void:
	var f = load("res://follower.tscn")
	var f1:Follower = f.instantiate()
	add_child(f1)
	f1.set_props(0, Vector2(-1920/2,0))
	var f2:Follower = f.instantiate()
	add_child(f2)
	f2.set_props(1, Vector2(0,-1080/2))
	var f3:Follower = f.instantiate()
	add_child(f3)
	f3.set_props(2, Vector2(1920/2,0))

func _process(delta: float) -> void:
	pass

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		on=!on
		#label.text = "ON" if on else "OFF"
		#label.text = str(on)
