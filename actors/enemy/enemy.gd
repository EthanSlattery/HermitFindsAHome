extends "res://actors/character.gd"

signal direction_changed(new_direction)

var look_direction = Vector2(1, 0) setget set_look_direction

func take_damage(attacker, amount, effect=null):
	if self.is_a_parent_of(attacker):
		return
	$States/Stagger.knockback_direction = (attacker.global_position - global_position).normalized()
	$Health.take_damage(amount, effect)

func set_dead(value):
	set_process_input(not value)
	set_physics_process(not value)
	$CollisionShape2D.disabled = value
	#TODO: Replace with Dead state
	$BodyPivot/Body.visible = false

func set_look_direction(value):
	look_direction = value
	emit_signal("direction_changed", value)
	
func increase_speed():
	$StateMachine/Chase.MAX_WALK_SPEED += 30

func _on_Health_health_depleted():
	set_dead(true)

func _on_Player_Move_player_moved(new_origin):
	$StateMachine/Chase.player_origin = new_origin