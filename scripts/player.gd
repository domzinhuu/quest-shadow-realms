extends CharacterBody2D


const SPEED = 250.0
@onready var animation: AnimatedSprite2D = $Animation


func _physics_process(_delta: float) -> void:
	var input_vector := Vector2.ZERO
	
	input_vector.x = Input.get_axis('move_left','move_right')
	input_vector.y = Input.get_axis('move_up','move_down')
	
	
	input_vector = input_vector.normalized()
	velocity = input_vector * SPEED

	var is_moving = input_vector.length() > 0
	
	if input_vector.x != 0:
		animation.flip_h = input_vector.x > 0
	
	if Input.is_action_pressed('damage'):
		animation.play('damage')
	elif Input.is_action_pressed('death'):
		animation.play('death')
	elif is_moving:
		animation.play('walk')
	else:
		animation.play('idle')
	
	
		

			
	move_and_slide()
	_limit_player_area()
	_apply_scaling()


func _apply_scaling():
	const MIN_Y: float = 0.0
	const MAX_Y: float = 1080.0
	
	const MIN_SCALE: float = 1.5
	const MAX_SCALE: float = 3.5
	
	var t: float = clamp((global_position.y - MIN_Y) / (MAX_Y - MIN_Y),0.0,1.0)
	var new_scale: float = lerp(MIN_SCALE,MAX_SCALE,t)
	
	scale = Vector2(new_scale,new_scale)


func _limit_player_area():
	var min_x := 80.0
	var max_x := 1800.0
	var min_y := 50.0
	var max_y := 800.0

	global_position.x = clamp(global_position.x, min_x, max_x)
	global_position.y = clamp(global_position.y, min_y, max_y)
