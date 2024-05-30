extends AnimatedSprite2D

var heldnode : Node # holds the node underneath it, mainly just want player nodes
var heldposx # holds players x
var heldposy # holds players y
var parent # holds parent node AKA gamescene
var moveenable = true
var ui
# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right") or Input.is_action_just_pressed("up") or Input.is_action_just_pressed("down"):
		MoveCursor()
	if Input.is_action_just_pressed("enter"):
		pass  
		#EnterButton(true)
	if Input.is_action_just_pressed("Nenter") :
		EnterButton(false)


func EnterButton(input):	
	parent.SendEnterSignal(heldnode, self, heldposx, heldposy, input)


func MoveCursor():
	if moveenable:
		var directionH = Input.get_axis("left","right")
		var directionV = Input.get_axis("up", "down")
		heldposx = position.x
		heldposy = position.y
		position.x += directionH * 16
		position.y += directionV * 16

func _on_area_2d_body_exited(body):
	heldnode = null

func _on_area_2d_body_entered(body):
	heldnode = body



