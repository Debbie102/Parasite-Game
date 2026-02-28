extends Control
@onready var player = %parasite
@onready var Camera_id 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	SignalBus.possessing.connect(_on_body_possessed)
	
	pass # Replace with function body.
func _on_body_possessed(is_body : bool, body_id: int, pos: Vector2):
	if %Camera2D != null:
		Camera_id = %Camera2D.get_instance_id()
	if !is_body or body_id == null:
		if instance_from_id(Camera_id) != null and instance_from_id(Camera_id).get_parent() != null:
			instance_from_id(Camera_id).get_parent().remove_child(instance_from_id(Camera_id))
		player.add_child(instance_from_id(Camera_id))
	elif is_body:
		if get_mob_id(self,body_id) != null:
			if instance_from_id(Camera_id) != null and instance_from_id(Camera_id).get_parent() != null:
				instance_from_id(Camera_id).get_parent().remove_child(instance_from_id(Camera_id))
			get_mob_id(self,body_id).add_child(instance_from_id(Camera_id))
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func get_mob_id(object,body_id):
	for i in range(object.get_child_count()):
		if object.get_child(i).get_instance_id() == body_id:
			print(object.get_child(i))
			return object.get_child(i)
		else:
			get_mob_id(object.get_child(i),body_id)
		pass
