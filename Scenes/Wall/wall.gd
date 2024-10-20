@tool
extends StaticBody2D

@export var moss:bool=false
@export var inert=false
@export var fire:float=0.0
@export var fire_start_time:float=1.0
@export var fire_end_time:float=0.5
@export var moss_color:Color=Color.GREEN_YELLOW
@export var fire_color:Color=Color.ORANGE
@export var wall_color:Color=Color.WEB_GRAY
@export var inert_color:Color=Color.BLACK
var isHit=false
var level=self
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	while level is not LevelClass:
		level=level.get_parent()
		assert(level != null)
	if moss:
		level.add_objective()

func _process(delta: float) -> void:
	if moss:
		fire_start(delta)
	else:
		if fire>0.0:
			fire-=delta/max(fire_end_time,0.001)
			if fire<0.0:
				fire=0.0
				level.complete_objective()
	isHit=false
	var choice:Color=wall_color
	if inert:
		choice=inert_color
	if moss:
		choice=moss_color
	$Appearance.color=choice.lerp(fire_color,fire)

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
