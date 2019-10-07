extends "res://actors/state_machine.gd"

func _ready():
	states_map = {
		"chase": $Chase,
		"stagger": $Stagger
	}

func _change_state(state_name):
	if not _active:
		return
	if state_name in ["stagger"]:
		states_stack.push_front(states_map[state_name])
	._change_state(state_name)

func _input(event):
	current_state.handle_input(event)

func _on_AnimationPlayer_animation_finished(anim_name):
	._on_animation_finished(anim_name)