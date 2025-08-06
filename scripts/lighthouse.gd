class_name Lighthouse
extends Area2D

@onready var light_shape: Polygon2D = $LightShape
@onready var light_border: CollisionPolygon2D = $LightBorder

var on: bool
var target: Vector2

func _process(delta: float) -> void:
	var mouse: Vector2 = get_global_mouse_position()
	var direction = mouse - global_position
	var angle_to_mouse = direction.angle()
	light_border.rotation = angle_to_mouse
	light_shape.polygon = light_border.polygon
	light_shape.rotation = angle_to_mouse
	light_border.position=Vector2.ZERO
	
	target = mouse*500

func _on_body_entered(body: Node2D) -> void:
	#print("ERE")
	if body is Follower:
		body.set_target(target)
		body.speed = 400

func _on_body_exited(body: Node2D) -> void:
	if body is Follower:
		body.set_target(global_position)
		body.speed = 200

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		on=!on
