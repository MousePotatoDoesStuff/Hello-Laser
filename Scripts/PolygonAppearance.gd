@tool
extends Polygon2D

var refpoly:CollisionPolygon2D=null
func _process(delta: float) -> void:
	if refpoly == null:
		var parent=get_parent()
		for child in parent.get_children():
			if child is CollisionPolygon2D:
				refpoly=child
	if refpoly == null:
		return
	var nexpolygon=refpoly.polygon if refpoly != null else $"../Collision".polygon
	if polygon != nexpolygon:
		polygon=nexpolygon
