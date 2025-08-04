extends Node2D

var on: bool

func _ready() -> void:
	on = false

func _process(delta: float) -> void:
	pass

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		on=!on
		#label.text = "ON" if on else "OFF"
		#label.text = str(on)
