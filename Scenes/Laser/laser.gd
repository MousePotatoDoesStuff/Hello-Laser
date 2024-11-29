extends Node2D

@export var follow_mouse=false
@onready var sender=get_parent()
var bounces:int=10
const INF_LEN:float=10000000
var max_cast_to:Vector2
var rot:float=0.0

var lasers=[]

@export var lineobject:Line2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lasers.append($Ray)
	for i in range(bounces):
		var raycast:RayCast2D=$Ray.duplicate()
		raycast.enabled=false
		#raycast.add_exception(sender)
		add_child(raycast)
		lasers.append(raycast)
	max_cast_to=Vector2(INF_LEN,0).rotated(rot)
	lineobject.top_level=true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if follow_mouse:
		rot=get_local_mouse_position().angle()
	lineobject.clear_points()
	lineobject.add_point(global_position)
	max_cast_to=Vector2(INF_LEN,0).rotated(rot)
	var idx=0
	for raycast:RayCast2D in lasers:
		idx+=1
		raycast.target_position=max_cast_to
		if not raycast.is_colliding():
			return end_ray(idx, raycast)
		var rcol=raycast.get_collision_point()
		var collider=raycast.get_collider()
		var is_bounceable=true
		if collider.has_method("laser_hit"):
			is_bounceable=collider.call("laser_hit")
		max_cast_to+=raycast.position-rcol
		lineobject.add_point(rcol)
		var maxnorm=max_cast_to.normalized()
		var normal=raycast.get_collision_normal().rotated(-global_rotation).normalized()
		var norm=maxnorm.bounce(normal).normalized()
		max_cast_to=norm*INF_LEN
		if is_bounceable and idx<lasers.size():
			lasers[idx].enabled=true
			lasers[idx].global_position=rcol+norm
		else:
			$Particles.global_position=rcol
			return

func end_ray(idx, raycast):
	lineobject.add_point(global_position+max_cast_to)
	if idx==1:
		raycast.target_position=max_cast_to
		$Particles.global_position=global_position+max_cast_to
	else:
		$Particles.global_position=raycast.global_position+max_cast_to
