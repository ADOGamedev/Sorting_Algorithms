extends Node

var acumulated_delay = 0

func shuffle(arr : Array, hash : Dictionary, bars_cont : HBoxContainer):
	for i in range(len(arr) - 1, -1, -1):
		owner.play_pop(hash[arr[i]].num)
		var r = randi_range(0, i)
		await swap(i, r, arr, hash, bars_cont)

func swap(i : int, j : int, arr : Array, hash : Dictionary, bars_cont : HBoxContainer):
	hash[arr[i]].select()
			
	var tmp = arr[i]
				
	bars_cont.move_child(hash[arr[j]], i)
	hash[arr[j]].select()
	arr[i] = arr[j]
				
	bars_cont.move_child(hash[tmp], j)
	hash[tmp].select()
	arr[j] = tmp
	
	await delay()
	
	hash[arr[i]].unselect()
	hash[arr[j]].unselect()

func delay():
	acumulated_delay += owner.delay / 1000.0
	if acumulated_delay > (1.0 / Engine.get_frames_per_second()):
		await get_tree().create_timer(acumulated_delay).timeout
		acumulated_delay = 0
