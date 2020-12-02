extends RigidBody2D


# Declare member variables here. Examples:

export var speedup = 100
export var maxspeed = 1200
var bounce_count = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	var bodies = get_colliding_bodies()
	
	for body in bodies:
		if body.is_in_group("Bricks"):
			#Bricks that die in 2 hits
			if body.get_name() == "Brick52" or body.get_name() == "Brick49" or body.get_name() == "Brick48" or \
			body.get_name() == "Brick60" or body.get_name() == "Brick59" or body.get_name() == "Brick54" or \
			body.get_name() == "Brick56" or body.get_name() == "Brick58" or body.get_name() == "Brick10" or \
			body.get_name() == "Brick7" or body.get_name() == "Brick6" or body.get_name() == "Brick5" or \
			body.get_name() == "Brick4" or body.get_name() == "Brick11" or body.get_name() == "Brick13" or\
			body.get_name() == "Brick15": 
				bounce_count += 1
				if bounce_count == 2:
					body.queue_free() #destroy the brick
					bounce_count = 0; #reset count variable
			#Bricks that die in 3 hits
			elif body.get_name() == "Brick36" or body.get_name() == "Brick35" or body.get_name() == "Brick32" or \
			body.get_name() == "Brick31" or body.get_name() == "Brick38" or body.get_name() == "Brick40" or \
			body.get_name() == "Brick42" or body.get_name() == "Brick21" or body.get_name() == "Brick20" or \
			body.get_name() == "Brick17" or body.get_name() == "Brick16" or body.get_name() == "Brick23" or\
			body.get_name() == "Brick25" or body.get_name() == "Brick27" : 
				bounce_count += 1
				if bounce_count == 3:
					body.queue_free() #destroy the brick
					bounce_count = 0; #reset count variable		
			else: 
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
	
