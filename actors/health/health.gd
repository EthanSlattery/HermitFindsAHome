extends Node

signal health_changed(health)
signal health_depleted

var health = 0
export(int) var max_health = 6

func _ready():
	health = max_health
	emit_signal("health_changed", health)

func take_damage(amount):
	health -= amount
	health = max(0, health)
	emit_signal("health_changed", health)
	if (health <= 0):
		emit_signal("health_depleted")

func heal(amount):
	health += amount
	health = max(health, max_health)
	emit_signal("health_changed", health)
