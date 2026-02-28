extends CharacterBody2D


const SPEED = 100.0
var hit_target = false

signal possession(pin: int)

var target = position

func _ready() -> void:
	$AnimatedSprite2D.play("default")
	target = null
	SignalBus.possessing.connect(_on_possession)

func _input(event):
	# Use is_action_pressed to only accept single taps as input instead of mouse drags.
	if event.is_action_pressed(&"click") and $Line2D.points[0].distance_to($Line2D.points[1]) < 200.0:
		print(target)
		print(position)
		target = get_global_mouse_position()
		hit_target = false


func _on_possession(is_in_body: bool, body_id: int, pos: Vector2):
	if is_in_body == false:
		visible = true
		$Area2D/CollisionShape2D.set_deferred("disabled",false)
		$CollisionShape2D.set_deferred("disabled",false)
		position = pos
	else:
		visible = false
		$Area2D/CollisionShape2D.set_deferred("disabled",true)
		$CollisionShape2D.set_deferred("disabled",true)
		
		
func _physics_process(delta):
	
	if target != null:
		velocity = position.direction_to(target) * SPEED 
		pass
	#elif hit_target or target == null:
		#if not is_on_floor():
			#velocity += get_gravity() * delta
		pass
			# look_at(target)

	$Line2D.points[1] = get_local_mouse_position()
	if $Line2D.points[0].distance_to($Line2D.points[1]) > 200.0:
	
		$Line2D.default_color = Color(0,0,0)
	elif(target != null):
		
		$Line2D.default_color = Color(0.776,0.675,0.914)
		if position.distance_to(target) > 10:
			move_and_slide()
	else:
		$Line2D.default_color = Color(0.776,0.675,0.914)
		pass
	if target != null and position.distance_to(target) < 20:
		hit_target = true
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("mob"):
		visible = false
		print(body.get_instance_id())
		SignalBus.possessing.emit(true, body.get_instance_id(), global_position)
		
		
