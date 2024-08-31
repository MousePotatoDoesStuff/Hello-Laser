extends Sprite2D


var grabbed=false
var mousediff:Vector2=Vector2.ZERO
@onready var parent=$"../.."

func _ready() -> void:
	return

func _process(delta: float) -> void:
	var children=parent.get_children()
	for child in children:
		if child!=$"..":
			parent.remove_child(child)
			$"..".add_child(child)
	if not grabbed:
		return
	var curpos=mousediff+get_global_mouse_position()
	var localpos=$"../..".to_local(curpos)
	var points=$"../..".points
	var start=points[0]
	var end=points[1]
	$"..".position=Geometry2D.get_closest_point_to_segment(localpos,start,end)
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		grabbed=false

func _input(event: InputEvent) -> void:
	if not event is InputEventMouseButton:
		return
	if not event.is_pressed():
		return
	if not get_rect().has_point(to_local(event.position)):
		return
	grabbed=true
	mousediff=global_position-get_global_mouse_position()
	return
