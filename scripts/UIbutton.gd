extends Button

### This button script has the capacity to create a scene or influence a node
### the influenced node must have a script with "prompted" on it
### the created scene can be placed anywhere, but since it is a child object keep in mind it will be influenced by other nodes coordinates

@export var focusing = false # the focus when the buttons are created
@export var create = false # determines how the button responds || True = creates | False = communicates 
@export var coords : Vector2 # the coordinates for where the created scene will be
@export var nodePrompted : Node # the object the button interacts with
@export var heldScene : PackedScene # stores the scene that will be created
var heldSceneNode # stores the node of the instantiated held scene
@export var addChild : Node

@export_enum("attack", "items", "stay") var output

 
# Called when the node enters the scene tree for the first time.


func _ready():
	print(output)
	if focusing:
		SetFocus()

func _on_pressed():
	if create:
		if heldScene != null and addChild != null:
			heldSceneNode = heldScene.instantiate()
			heldSceneNode.position = coords
			addChild.add_child(heldSceneNode)
			print("generated")
			
	elif !create and nodePrompted != null:
		nodePrompted.Prompt()
	
	
	else:
		if output == 0:
			nodePrompted.Attack()
			print("you are attacking")
		elif output == 1:
			nodePrompted.Items()
			print("you want to look at items")
		elif output == 2:
			nodePrompted.Wait()
			print("you want to stay at this position")
		else:
			print("can't do this")


func SetFocus():
	grab_focus()
	
func Prompt():
	visible = true
	pass

