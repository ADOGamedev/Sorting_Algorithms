extends VBoxContainer
class_name Bar

@onready var selected = $bar_selected
@onready var unselected = $bar_unselected
var num = 1
var SELECTED_COLOR = Color(0xf56262ff)
var DEFAULT_COLOR = Color(0xf29363ff)

func use_border(use : bool):
	if use:
		selected = $bar_selected
		unselected = $bar_unselected
	else:
		selected = $bar_selected_borderless
		unselected = $bar_unselected_borderless
		
	
func update_num(new_num : int, len : int):
	num = new_num
	$Control.set_stretch_ratio((1.0 / (float(num) / len)) - 1.0)

func select():
	selected.visible = true
	unselected.visible = false

func unselect():
	selected.visible = false
	unselected.visible = true
