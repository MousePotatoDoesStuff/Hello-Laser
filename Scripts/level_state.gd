extends RefCounted
class_name LevelState

var path:String
var map_position:Vector2
var completed:bool=false
var unlocks:Array[int]
var other_data

func _init(data:Dictionary) -> void:
	self.load_state(data)

func save_state()->Dictionary:
	var res={}
	res["path"]=self.path
	res["completed"]=self.completed
	res["unlocks"]=self.unlocks
	res["other"]=self.other_data
	return res

func load_state(data:Dictionary):
	self.path=data.get("path","res://Scenes/sandbox.tscn")
	self.completed=data.get("completed",false)
	self.unlocks=data.get("unlocks",[])
	self.other_data=data.get("other",{})
	return

func load_level():
	var packed=load(self.path)
	if not packed:
		return null
	var instance=packed.instantiate()
	return instance
