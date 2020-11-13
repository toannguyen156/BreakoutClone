extends RigidBody2D


# Declare member variables here. Examples:
export var speedup = 100
export var maxspeed = 2000
var bounce_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	var bodies = get_colliding_bodies()
	
	for body in bodies:
		if body.is_in_group("Bricks"):
			if body.get_name() == "Brick7" or body.get_name() == "Brick4" or body.get_name() == "Brick33" or \
			body.get_name() == "Brick80" or body.get_name() == "Brick75" or body.get_name() == "Brick90" or \
			body.get_name() == "Brick24" or body.get_name() == "Brick41": #Bricks that die in 2 hits
				bounce_count += 1
				if bounce_count == 2:
					body.queue_free() #destroy the brick
					bounce_count = 0;
					
			else: #not the double-life-bricks
				get_node("/root/World").score += 100
				body.queue_free() #destroy the brick
			
		if body.get_name() == "Paddle":
			var speed = get_linear_velocity().length()
			var direction = get_position() - body.get_node("Anchor").get_global_position()
			var velocity = direction.normalized() * min(speed + speedup, maxspeed)
			set_linear_velocity(velocity)
			print(str(speed+speedup))
			
	if get_position().y > get_viewport_rect().end.y: 
		print("ball died")
		queue_free()
