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
@export var completed=0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MainMenu/levels
	for i in range(completed+1):
		add_level(i)

func add_level(cur):
	if cur>=len(levels):
		return
	var button = Button.new()
	button.text = "Level " + str(cur + 1)
	var bufn=func():
		start_level(cur)
	button.connect("pressed", bufn)
	$MainMenu/levels.add_child(button)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_level(lvnum):
	$MainMenu.hide()
	var lepack:PackedScene=levels[lvnum]
	level=lepack.instantiate()
	levnum=lvnum
	$Loader.add_child(level)
	level.connect("win",win)
	$QuickMenu.show()
	$QuickMenu/Next.show()
	if levnum==completed:
		$QuickMenu/Next.hide()

func win():
	print("A winner is who?")
	if completed==levnum:
		completed+=1
		add_level(completed)
	$QuickMenu/Next.show()

func remove_level():
	$Loader.remove_child(level)
	level.queue_free()
	level=null

func next_level():
	remove_level()
	var newlev=levnum+1
	if newlev==levels.size():
		$QuickMenu.hide()
		$thanksmenu.show()
	else:
		start_level(levnum+1)

func close_level():
	remove_level()
	$QuickMenu.hide()
	$MainMenu.show()

func backtomain():
	$thanksmenu.hide()
	$MainMenu.show()
