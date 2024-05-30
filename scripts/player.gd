extends CharacterBody2D
var tileInstance
var numby : int
var playerInAction : bool = true
@export var values = {"healthM" : 100, "healthC" : 100, "move" : 4,}
@export var stats = {"atk" : 100, "mag": 2, "def" : 5, "res" : 2, "spd" : 7}
@export var items = {"weapon" : 
					{"Type" : "Halberd",
					"damage": 10,
					"Range" : 1, 
					}}
func _ready():
	print(items["weapon"]["damage"])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("cheatbutton1"):
		ReturnAction()
	
	
func TakeDamage(damage):
	values["healthC"] -= damage

func ReturnAction():
	playerInAction = true
	print("actionReturned")

func Die():
	queue_free()
