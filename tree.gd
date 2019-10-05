extends Node2D

onready var initial_y
export var MAX_Y_DISTANCE = 24

var top
var shadow

func _ready():
	top = get_node("tree-top")
	initial_y = top.position.y
	shadow = get_node("tree-shadow")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var x_scale = abs(initial_y / top.position.y)
	var scale = Vector2(x_scale, x_scale)

	if top.position.y < initial_y and x_scale <= 1:
		shadow.set_scale(scale)

	shadow.position.x = top.position.x
	if top.position.y > initial_y + MAX_Y_DISTANCE:
		top.gravity_scale = 0
		top.linear_velocity = Vector2(0,0)
		top.angular_velocity = 0
		top.get_node("CollisionShape2D").disabled = true
		top.get_node("CollisionShape2D2").disabled = true
	else:
		print(scale)


