extends PathFollow2D

var speed = 100
var possessed = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.possessing.connect(_on_mob_possessed)
	loop = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if possessed == false:
		set_progress(get_progress() + speed * delta)
	pass

func _on_mob_possessed(in_body: bool, body_id: int, pos: Vector2):
	if in_body == true and body_id == $CharacterBody2D.get_instance_id():
		possessed = false
		pass
	else:
		possessed = false
	pass
