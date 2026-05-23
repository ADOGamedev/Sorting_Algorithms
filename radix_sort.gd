extends Node

var acumulated_delay = 0

func radix_sort(arr : Array, hash : Dictionary, bars_cont : HBoxContainer):
	var digit_i = -1
	
	while digit_i >= -len(str(owner.owner.array_len)):
		var buckets = [[], [], [], [], [], [], [], [], [], []]
		for n in arr:
			var digit = 0 if digit_i < -len(str(n)) else int(str(n)[digit_i])
			buckets[digit].append(n)
			owner.owner.array_accesses += 2
		
		var i = 0
		for b in buckets:
			for n in b:
				owner.owner.array_accesses += 3
				await delay()
				arr[i] = n
				owner.owner.play_pop(hash[n].num)
				bars_cont.move_child(hash[n], i)
				i += 1
		
		digit_i -= 1
			
	owner.owner.finish_sorting()

func delay():
	acumulated_delay += owner.owner.delay / 2000.0
	if acumulated_delay > (1.0 / Engine.get_frames_per_second()):
		await get_tree().create_timer(acumulated_delay).timeout
		acumulated_delay = 0
