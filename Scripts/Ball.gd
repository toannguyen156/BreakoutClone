extends RigidBody2D


# Declare member variables here. Examples:

export var speedup = 100
export var maxspeed = 2000
var bounce_count = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	var bodies = get_colliding_bodies()
	
	for body in bodies:
		if body.is_in_group("Bricks"):			
				get_node("/root/World").score += 100
				body.queue_free() #destroy the brick
		
		if 	body.get_name() == "Walls":
			get_node("/root/World/Walls/WallHit").play()
			
		if body.get_name() == "Paddle":
			get_node("/root/World/Paddle/PaddleHit").play()
			var speed = get_linear_velocity().length()
			var direction = get_position() - body.get_node("Anchor").get_global_position()
			var velocity = direction.normalized() * min(speed + speedup, maxspeed)
			set_linear_velocity(velocity)
			print(str(speed+speedup))
		
			

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	get_node("/root/World").life -= 1
	get_node("/root/World").current_ball_count -= 1
	get_node("/root/World").game_over()
	print("ball died")
	
