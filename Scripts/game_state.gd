extends RefCounted
class_name GameState

var levels:Dictionary

func _init() -> void:
	return

func save_levels()->Dictionary:
	var raw_levels={}
	for key in self.levels:
		var level:LevelState=self.levels[key]
		var raw_level=level.save_state()
		raw_levels[key]=raw_level
	return raw_levels

func load_levels(data:Dictionary):
	self.levels={}
	for key in data:
		var raw_level=data[key]
		var level=LevelState.new(data)
		self.levels[key]=level

func save_state()->Dictionary:
	var res={
		"levels":save_levels()
	}
	return res

func load_state(data:Dictionary):
	load_levels(data.get("levels",{}))
	return
