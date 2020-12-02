extends KinematicBody2D


# Declare member variables here. Examples:

const ball_scene = preload("res://MiniScenes/Ball.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)
	set_process_input(true)
	
func _physics_process(_delta):
	var y = get_position().y
	var mouse_x = get_viewport().get_mouse_position().x
	set_position(Vector2(mouse_x, y))

