extends Control
class_name UI_mainframe

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
@export var completed=0

@export var node_main:Control
@export var node_quick:QuickMenu
@export var node_thanks:Control

@onready var screens:Array[Control]=[
	node_main,
	node_quick,
	node_thanks
]
@export var extra_screens:Array[Control]
@export var node_levels:Control
@export var cur_ind:int=0

signal StartLevel(level:LevelClass)
signal EndLevel
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for screen in extra_screens:
		screens.append(screen)
	for screen in screens:
		screen.hide()
	screens[0].show()
	for i in range(completed+1):
		add_level(i)

func swap_to(new_ind:int):
	screens[self.cur_ind].hide()
	self.cur_ind=new_ind
	screens[self.cur_ind].show()

func add_level(cur):
	if cur>=len(levels):
		return
	var button = Button.new()
	button.text = "Level " + str(cur + 1)
	var bufn=func():
		start_level(cur)
	button.connect("pressed", bufn)
	node_levels.add_child(button)

func start_level(lvnum):
	var lepack:PackedScene=levels[lvnum]
	level=lepack.instantiate()
	StartLevel.emit(level)
	self.levnum=lvnum
	level.connect("win",win)
	node_quick.configure(levnum!=completed)
	swap_to(1)

func win():
	print("A winner is who?")
	if completed==levnum:
		completed+=1
		add_level(completed)
	node_quick.configure(true)

func next_level():
	EndLevel.emit()
	var newlev=levnum+1
	if newlev==levels.size():
		swap_to(2)
	else:
		start_level(levnum+1)

func close_level():
	EndLevel.emit()
	swap_to(0)
