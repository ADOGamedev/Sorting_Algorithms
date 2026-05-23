extends Node

var acumulated_delay = 0

func tim_sort(arr : Array, hash : Dictionary, bars_cont : HBoxContainer):
	var r = get_run_size(arr)
	var runs = []
	for i in range(0, len(arr), r):
		var start = i
		var end = min(i + r, len(arr))
		runs.append([start, end])
		for j in range(start, end):
			var k = j
			while k > start and arr[k] < arr[k - 1]:
				
				owner.owner.comparisons += 1
				owner.owner.array_accesses += 2
				
				swap(k, k - 1, arr, hash, bars_cont)
				await delay()
				
				hash[arr[k]].unselect()
				hash[arr[k - 1]].unselect()
				k -= 1

	await merge_sort(arr, hash, bars_cont, runs)
	owner.owner.finish_sorting()

func merge_sort(arr : Array, hash : Dictionary, bars_cont : HBoxContainer, runs : Array):
	if len(runs) == 1:
		return
		
	var new_runs = []
	var new_arr = []
	for i in range(0, len(runs) - 1, 2):
		var start1 = runs[i][0]
		var end1 = runs[i][1]
		var end2 = runs[i + 1][1]
		var left = arr.slice(start1, end1)
		var right = arr.slice(end1, end2)
		new_runs.append([start1, end2])
		new_arr.append_array(await merge(left, right, start1, hash, bars_cont))
	
	await merge_sort(new_arr, hash, bars_cont, new_runs)

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
	
func get_run_size(arr : Array):
	var n = len(arr)
	var r = 0
	while n >= 64:
		r |= n % 2
		n /= int(2)
	return n + r

func delay():
	acumulated_delay += owner.owner.delay / 2000.0
	if acumulated_delay > (1.0 / Engine.get_frames_per_second()):
		await get_tree().create_timer(acumulated_delay).timeout
		acumulated_delay = 0
	
func swap(i : int, j : int, arr : Array, hash : Dictionary, bars_cont : HBoxContainer):
	hash[arr[i]].select()
	
	owner.owner.play_pop(hash[arr[i]].num)
	owner.owner.play_pop(hash[arr[j]].num)
	owner.owner.array_accesses += 4
			
	var tmp = arr[i]
				
	bars_cont.move_child(hash[arr[j]], i)
	hash[arr[j]].select()
	arr[i] = arr[j]
				
	bars_cont.move_child(hash[tmp], j)
	hash[tmp].select()
	arr[j] = tmp
