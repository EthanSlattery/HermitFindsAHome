extends "res://actors/states/state.gd"

export(float) var MAX_WALK_SPEED = 150
var speed = 0.0
var velocity = Vector2()
var player_origin = Vector2()
var target_angle = Vector2()

func enter():
	speed = 0.0
	velocity = Vector2()

func update(delta):
	speed = MAX_WALK_SPEED
	move_toward_target(player_origin, delta)

func move(speed, direction):
	velocity = direction.normalized() * speed
	owner.move_and_slide(velocity, Vector2(), 5, 2)
	if owner.get_slide_count() == 0:
		return
	return owner.get_slide_collision(0)
	
func move_toward_target(target_origin, delta):
	var enemy_origin = owner.get_global_transform().origin
	# direction from enemy to player
	var offset = target_origin - enemy_origin
	# normalize offset to make it a Vector with length of 1
	move(speed, offset.normalized() * speed * delta)