class_name Follower
extends CharacterBody2D

#@onready var camera = get_viewport().get_camera()

var speed:=200
var direction:=Vector2.ZERO
var target_position:=Vector2.ZERO
var last_direction:=Vector2.ZERO
var to_lighthouse:bool=true

var frame_counter:=0
var process_interval:= 0

func _ready() -> void:
	target_position=Vector2.ZERO
	direction = (target_position - global_position).normalized()

func _process(delta):
	#direction = target_position-global_position
	#global_position+=direction.normalized() * speed *delta
	var direction = target_position-position
	var movement = direction.normalized()*speed*delta
	position+=movement
	if position.x<-1920/2 || position.y<-1080/2 || position.x>1920/2 || position.y>1080/2:
		print("CLEARED")
		queue_free()
	#if target_position!=Vector2.ZERO:
		#direction = (target_position-global_position).normalized()
		#global_position+=direction*speed*delta

func set_target(target:Vector2):
	print("going to "+str(target))
	target_position=target
