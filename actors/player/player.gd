extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(float, EXP, 10, 200, 1) var move_speed := 100
export (NodePath) var animation_player_path
onready var animation_player_node
export (NodePath) var sprite_path
onready var sprite_node

const ANIMATIONS := {
		"walk": "The Real Walk",
		"idle": "Darwin Idle"
	}

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player_node = get_node(animation_player_path)
	sprite_node = get_node(sprite_path)

func _physics_process(delta):
	var direction = { "x": 0, "y": 0 }

	if Input.is_action_pressed("ui_right"):
		direction.x = 1
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
	if Input.is_action_pressed("ui_down"):
		direction.y = 1
	if Input.is_action_pressed("ui_up"):
		direction.y = -1

	if direction.x != 0 || direction.y != 0:
		animation_player_node.play(ANIMATIONS.walk)
	elif animation_player_node.current_animation == ANIMATIONS.walk:
		play_idle_animation(animation_player_node)

	sprite_node.flip_h = true if direction.x < 0 else false

	var move_vector = Vector2(direction.x, direction.y)
	move_and_slide(move_vector.normalized() * move_speed)

func play_idle_animation(animation_node) -> void:
	animation_node.play(ANIMATIONS.idle)


func _on_Area2D_body_entered(body):
	print('woooooo')
	pass # Replace with function body.
