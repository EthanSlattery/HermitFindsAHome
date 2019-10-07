extends Node2D

onready var time_label = get_node("InterfaceLayer/Interface/TimeLabel")
onready var game_over_label = get_node("GameOverLabel")
onready var game_timer = get_node("GameTimer")
var timer_not_started = true
const game_time = 45

# Called when the node enters the scene tree for the first time.
func _ready():
	game_timer.set_wait_time(float(game_time))

func _process(delta):
	var time_left = int(game_timer.get_time_left())
	if timer_not_started:
		time_label.set_text(str(game_time))
	else:
		time_label.set_text(str(time_left))

func _on_GameTimer_timeout():
	remove_child(get_node("Enemy"))
	get_node("InterfaceLayer/Interface/TimeLabel").hide()
	game_over_label.show()
	game_over_label.set_text("You survived!")


func _on_Player_dead():
	remove_child(get_node("Player"))
	remove_child(get_node("Enemy"))
	get_node("InterfaceLayer/Interface/TimeLabel").hide()
	game_over_label.show()
	var message = "GAME OVER. You survived %s seconds." % str(int(game_timer.get_wait_time() - game_timer.get_time_left()))
	game_over_label.set_text(message)


func _on_Move_player_moved(new_origin):
	if timer_not_started:
		game_timer.start()
		timer_not_started = false
		
