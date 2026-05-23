extends Node

var use_bogo_sort = false

func bogo_sort(arr : Array, hash : Dictionary):
	use_bogo_sort = true
	var sorted = range(1, len(arr) + 1)
	while use_bogo_sort:
		await owner.owner.gen_array(true, true, false)
		
		if owner.owner.array == sorted:
			owner.owner.finish_sorting()
			break
		
	owner.owner.finish_sorting(false)
	
func _on_stop_bogo_sort():
	use_bogo_sort = false
		
		
		
