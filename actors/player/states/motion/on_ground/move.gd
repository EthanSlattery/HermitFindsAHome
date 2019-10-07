extends "on_ground.gd"

signal player_moved(new_origin)

export(float) var MAX_WALK_SPEED = 450
export(float) var MAX_RUN_SPEED = 700

func enter():
	speed = 0.0
	velocity = Vector2()

	var input_direction = get_input_direction()
	update_look_direction(input_direction)
	var stateMachine = owner.get_node("AnimationTree").get("parameters/playback")
	if input_direction.x > 0:
		stateMachine.travel("walk")
	elif input_direction.x < 0:
		stateMachine.travel("walk")
		
		

func handle_input(event):
	return .handle_input(event)

func update(delta):
	var input_direction = get_input_direction()
	if not input_direction:
		emit_signal("finished", "idle")
	emit_signal("player_moved", owner.get_global_transform().origin)
	update_look_direction(input_direction)

	speed = MAX_RUN_SPEED if Input.is_action_pressed("run") else MAX_WALK_SPEED
	var collision_info = move(speed, input_direction)
	if not collision_info:
		return
	if speed == MAX_RUN_SPEED and collision_info.collider.is_in_group("environment"):
		return null

func move(speed, direction):
	velocity = direction.normalized() * speed
	owner.move_and_slide(velocity, Vector2(), 5, 2)
	if owner.get_slide_count() == 0:
		return
	return owner.get_slide_collision(0)
