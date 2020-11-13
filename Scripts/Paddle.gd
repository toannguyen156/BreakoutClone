extends KinematicBody2D


# Declare member variables here. Examples:

const ball_scene = preload("res://MiniScenes/Ball.tscn")
var lifecount = 0;
# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)
	set_process_input(true)
	
func _physics_process(delta):
	var y = get_position().y
	var mouse_x = get_viewport().get_mouse_position().x
	set_position(Vector2(mouse_x, y))

func _input(event):
	if event is InputEventMouseButton:
		
		
			if event.button_index == BUTTON_LEFT and event.pressed and  lifecount < 5:
				var ball = ball_scene.instance()
				lifecount+=1
				ball.set_position(get_position() - Vector2(0, 16))
				get_tree().get_root().add_child(ball)
			
