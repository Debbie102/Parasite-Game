extends CharacterBody2D


const SPEED = 300.0
var possessed = false
#const JUMP_VELOCITY = -400.0
var current_mob

func _ready() -> void:
	current_mob = get_instance_id()
	print(current_mob)
	SignalBus.possessing.connect(on_possessed)
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if velocity.x == 0 and possessed == false:
		$AnimatedSprite2D.play("idle")
	else:
		if velocity.x >= 0:
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("walk")
		
	if possessed == true:
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			
			velocity.x = move_toward(velocity.x, 0, SPEED)
	if $ProgressBar.value <= 0:
		$Timer.stop()
		SignalBus.possessing.emit(false, 1, global_position)
		queue_free()
		

	move_and_slide()

func on_possessed(in_body: bool, pin: int, pos: Vector2):
	if in_body == true:
		print("possessed")
		if current_mob == pin:
			possessed = true
			
		$Timer.start()
	else:
		$Timer.stop()
	pass


func _on_timer_timeout() -> void:
	$ProgressBar.value -= 10
	pass # Replace with function body.
