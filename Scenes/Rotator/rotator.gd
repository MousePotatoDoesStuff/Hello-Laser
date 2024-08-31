extends Sprite2D


var grabbed=false
var mousediff:float=0.0
func _process(delta: float) -> void:
	if not grabbed:
		return
	var rotat=mouseangle()
	rotation=mousediff+rotat
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		grabbed=false

func mouseangle():
	var mouse=get_global_mouse_position()
	mouse-=global_position
	return mouse.angle()

func _input(event: InputEvent) -> void:
	if grabbed:
		return
	if not event is InputEventMouseButton:
		return
	if not event.is_pressed():
		return
	if not get_rect().has_point(to_local(event.position)):
		return
	grabbed=true
	mousediff=mouseangle()
	return
