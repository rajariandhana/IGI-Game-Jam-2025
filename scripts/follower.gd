class_name Follower
extends CharacterBody2D

var sprite: Sprite2D
var collision: CollisionShape2D

var speed:=150
var direction:=Vector2.ZERO
var target_position:=Vector2.ZERO

func _ready() -> void:
	sprite = $Sprite2D
	collision=$CollisionShape2D
	
	#set_default_properties()
	
	target_position=Vector2.ZERO
	direction = (target_position - global_position).normalized()
	
func set_props(type:int, vc:Vector2):
	position=vc
	match type:
		0:
			sprite.texture = preload("res://follower-sail.png")
		1:
			sprite.texture = preload("res://follower-steam.png")
		2:
			sprite.texture = preload("res://follower-pirate.png")
			
func _process(delta):
	var direction = target_position-position
	var movement = direction.normalized()*speed*delta
	position+=movement
	if position.x<-1920/2 || position.y<-1080/2 || position.x>1920/2 || position.y>1080/2:
		print("CLEARED")
		queue_free()
	if target_position.x > position.x:
		sprite.flip_h = false
	elif target_position.x < position.x:
		sprite.flip_h = true

func set_target(target:Vector2):
	#print("going to "+str(target))
	target_position=target
