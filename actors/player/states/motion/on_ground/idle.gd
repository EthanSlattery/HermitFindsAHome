extends "res://actors/player/states/motion/on_ground/on_ground.gd"

var stateMachine

func enter():
	stateMachine = owner.get_node("AnimationTree").get("parameters/playback")

func handle_input(event):
	return .handle_input(event)

func update(delta):
	var input_direction = get_input_direction()
	if input_direction:
		emit_signal("finished", "move")
	else:
		stateMachine.travel("idle")
