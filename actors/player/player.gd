extends "../character.gd"

signal direction_changed(new_direction)
signal dead()

const Enemy = preload("res://actors/enemy/enemy.gd")
var look_direction = Vector2(1, 0) setget set_look_direction

func _ready():
	$DetectArea.connect("area_entered", self, "hit")

func take_damage(attacker, amount, effect=null):
	if self.is_a_parent_of(attacker):
		return
	$StateMachine/Stagger.knockback_direction = (attacker.global_position - global_position).normalized()
	$StateMachine._change_state("stagger")
	$Health.take_damage(2)

func set_dead(value):
	set_process_input(not value)
	set_physics_process(not value)
	$CollisionShape2D.disabled = value
	#TODO: Replace with Dead state
	emit_signal("dead")

func set_look_direction(value):
	look_direction = value
	emit_signal("direction_changed", value)

func _on_Health_health_depleted():
	set_dead(true)
	
func hit(object):
	if object.owner.is_in_group("enemies"):
		take_damage(object, 2)
