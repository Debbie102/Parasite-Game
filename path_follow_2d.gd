extends PathFollow2D

var speed = 100
var possessed = false
var walk_direction = "forward"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.possessing.connect(_on_mob_possessed)
	loop = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_child_count() == 0:
		queue_free()
	if possessed == false and $CharacterBody2D/AnimatedSprite2D != null :
		$CharacterBody2D/AnimatedSprite2D.play("walk")

		if walk_direction == "forward":
			set_progress(get_progress() + speed * delta)
		else:
			set_progress(get_progress() - speed * delta)
	pass
	if progress_ratio == 1.0:
		walk_direction = "backward"
		$CharacterBody2D/AnimatedSprite2D.flip_h = true
	if progress_ratio == 0.0:
		walk_direction = "forward"
		$CharacterBody2D/AnimatedSprite2D.flip_h = false

func _on_mob_possessed(in_body: bool, body_id: int, pos: Vector2):
	if in_body == true and body_id == $CharacterBody2D.get_instance_id():
		possessed = true
		pass
	else:
		possessed = false
	pass
