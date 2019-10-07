extends Node2D

onready var time_label = get_node("InterfaceLayer/Interface/TimeLabel")
onready var game_over_label = get_node("GameOverLabel")
onready var game_timer = get_node("GameTimer")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	var time_left = int(game_timer.get_time_left())
	time_label.set_text(str(time_left))

func _on_GameTimer_timeout():
	remove_child(get_node("Enemy"))
	remove_child(get_node("InterfaceLayer/Interface/TimeLabel"))
	game_over_label.set_text("You survived!")


func _on_Player_dead():
	remove_child(get_node("Player"))
	remove_child(get_node("Enemy"))
	remove_child(get_node("InterfaceLayer/Interface/TimeLabel"))
	var message = "GAME OVER. You survived %s seconds." % str(int(game_timer.get_wait_time() - game_timer.get_time_left()))
	game_over_label.set_text(message)
