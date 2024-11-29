@tool
extends StaticBody2D

signal ObjectiveComplete

@export var moss:bool=false
@export var inert=false
@export var fragile=false
@export var fire:float=0.0
@export var fire_start_time:float=1.0
@export var fire_end_time:float=0.5
@export var moss_color:Color=Color.GREEN_YELLOW
@export var fire_color:Color=Color.ORANGE
@export var wall_color:Color=Color.WEB_GRAY
@export var inert_color:Color=Color.BLACK
var isHit=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint():
		return
	var level=self
	while level is not LevelClass:
		level=level.get_parent()
		if level == null:
			return
	var true_level:LevelClass=level
	if moss:
		true_level.add_objective()
		ObjectiveComplete.connect(true_level.complete_objective)

func _process(delta: float) -> void:
	if not Engine.is_editor_hint():
		active_process(delta)
	always_process(delta)

func always_process(_delta: float):
	var choice:Color=wall_color
	if inert:
		choice=inert_color
	if moss:
		choice=moss_color
	$Appearance.color=choice.lerp(fire_color,fire)
	if fragile and not moss and fire>0:
		$Appearance.modulate.a=fire

func active_process(delta: float):
	if moss:
		fire_start(delta)
	else:
		if fire>0.0:
			fire-=delta/max(fire_end_time,0.001)
			if fire<0.0:
				fire=0.0
				ObjectiveComplete.emit()
				if fragile:
					destroy()
	isHit=false
	return

func fire_start(delta:float):
	if fire<=0.0:
		return
	var curdelta=delta/max(fire_start_time,0.001)
	fire+=curdelta if isHit else -curdelta
	if fire>1.0:
		fire=1.0
		moss=false
	if fire<0.0:
		fire=0.0

func laser_hit():
	isHit=true
	if moss:
		fire+=0.001
	return not (moss or inert)

func destroy():
	queue_free()
