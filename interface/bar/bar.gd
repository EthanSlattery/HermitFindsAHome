extends HBoxContainer

signal maximum_changed(maximum)

var maximum = 100
var current_health = 0

func initialize(max_value):
	print("Bar initialize %s" %max_value)
	maximum = max_value
	emit_signal("maximum_changed", maximum)

func _on_Interface_health_updated(new_health):
	print("_on_Interface_health_updated: %s" %new_health)
	animate_value(current_health, new_health)
	current_health = new_health

func animate_value(start, end):
	$Tween.interpolate_property($TextureProgress, "value", start, end, 0.5, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Tween.start()
	if end < start:
		$AnimationPlayer.play("shake")
