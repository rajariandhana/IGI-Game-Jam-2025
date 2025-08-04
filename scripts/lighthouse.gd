class_name Lighthouse
extends Area2D

@onready var polygon_2d: Polygon2D = $Polygon2D
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D

var zero: Vector2 = Vector2(0,0)
var target: Vector2

func _process(delta: float) -> void:
	var mouse: Vector2 = get_global_mouse_position()
	var direction = mouse - global_position
	var angle_to_mouse = direction.angle()
	collision_polygon_2d.rotation = angle_to_mouse
	polygon_2d.polygon = collision_polygon_2d.polygon
	polygon_2d.rotation = angle_to_mouse
	collision_polygon_2d.position=Vector2.ZERO
	
	target = mouse*500

func _on_body_entered(body: Node2D) -> void:
	if body is Follower:
		body.set_target(target)

func _on_body_exited(body: Node2D) -> void:
	if body is Follower:
		body.set_target(global_position)


#path_2d.curve.clear_points()
	#path_2d.curve.add_point(zero)
	#path_2d.curve.add_point(zero)
	#path_2d.curve.add_point(zero)
	#path_2d.curve.add_point(zero)
	#path_2d.curve.set_point_position(0, zero)

	#var radius = (mouse - zero).length()
	#var end: Vector2 = 1.2 * mouse
	#var sd: Vector2 = 0.2 * mouse
	#var s1 = mouse+Vector2(-sd.y, sd.x)
	#var s2 = mouse+Vector2(sd.y, -sd.x)
	#
	#path_2d.curve.set_point_position(1, s1)
	#path_2d.curve.set_point_position(2, end)
	#path_2d.curve.set_point_position(3, s2)
	#
	#var baked = path_2d.curve.get_baked_points()
	#polygon_2d.polygon = baked
	#var new_shape = polygon_2d.polygon.duplicate()
	#if collision_polygon_2d.polygon!=new_shape:
		#collision_polygon_2d.polygon= new_shape
	 #= get_global_mouse_position() - global_position
