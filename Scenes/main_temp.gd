extends Node2D

var levels:Array[PackedScene]=[
	preload("res://Scenes/Levels/Level_01.tscn"),
	preload("res://Scenes/Levels/Level_02.tscn"),
	preload("res://Scenes/Levels/Level_03.tscn"),
	preload("res://Scenes/Levels/Level_04.tscn"),
	preload("res://Scenes/Levels/Level_05.tscn"),
	preload("res://Scenes/Levels/Level_06.tscn"),
	preload("res://Scenes/Levels/Level_07.tscn"),
	preload("res://Scenes/Levels/Level_08.tscn"),
	preload("res://Scenes/Levels/Level_09.tscn"),
	preload("res://Scenes/Levels/Level_10.tscn")
]
var level:LevelClass=null
var levnum:int=-1
@export var node_loader:Control
@export var node_UI:Control
@export var completed=20
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func start_level(level:LevelClass):
	$Loader.add_child(level)
	self.level=level

func remove_level():
	$Loader.remove_child(level)
	level.queue_free()
	level=null
