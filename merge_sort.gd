extends Node

var acumulated_delay = 0

func merge_sort(arr : Array, start_i : int, hash : Dictionary, bars_cont : HBoxContainer):
	if len(arr) < 2:
		return arr
		
	var mid = len(arr) / 2
	var left = arr.slice(0, mid)
	var right = arr.slice(mid)
	
	left = await merge_sort(left, start_i, hash, bars_cont)
	await delay()
	right = await merge_sort(right, start_i + mid, hash, bars_cont)

	owner.owner.array = await merge(left, right, start_i, hash, bars_cont)
	
	return owner.owner.array
	

func merge(left : Array, right : Array, start : int, hash : Dictionary, bars_cont : HBoxContainer):
	var l = 0
	var r = 0
	var res = []
	
	while l < len(left) and r < len(right):
		owner.owner.comparisons += 1
		owner.owner.array_accesses += 3
		
		if left[l] <= right[r]:
			await add(res, left, l, start, hash, bars_cont)
			hash[res[l]].select()
			await delay()
			hash[res[l]].unselect()
			l += 1
		else:
			await add(res, right, r, start, hash, bars_cont)
			hash[res[r]].select()
			await delay()
			hash[res[r]].unselect()
			r += 1
		
	while l < len(left):
		await add(res, left, l, start, hash, bars_cont)
		hash[res[l]].select()
		await delay()
		hash[res[l]].unselect()
		l += 1
		
	while r < len(right):
		await add(res, right, r, start, hash, bars_cont)
		hash[res[r]].select()
		await delay()
		hash[res[r]].unselect()
		r += 1
	
	return res
	
func add(res : Array, arr : Array, i : int, start : int, hash : Dictionary, bars_cont : HBoxContainer):
	owner.owner.array_accesses += 1
		
	res.append(arr[i])
		
	owner.owner.play_pop(hash[arr[i]].num)
	bars_cont.move_child(hash[arr[i]], start + len(res) - 1)
		
func delay():
	acumulated_delay += owner.owner.delay / 1000.0
	if acumulated_delay > (1.0 / Engine.get_frames_per_second()):
		await get_tree().create_timer(acumulated_delay).timeout
		acumulated_delay = 0
