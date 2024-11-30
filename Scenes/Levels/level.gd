extends Node2D
class_name LevelClass
signal win

var objectives:int
var complete:int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_objective():
	objectives+=1
	print("Added to ",objectives)

func complete_objective():
	complete+=1
	print("Done to ",complete)
	if complete==objectives:
		win.emit()
		print("Win")
