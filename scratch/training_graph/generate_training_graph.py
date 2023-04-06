'''
This script generates the training graph from the log output
'''
import pandas as pd

def parse_line(line):

	# KG AM -> AM
	if "KG AM" in line:
		line = line.replace("KG AM","AM")
	
	split = line.split(" ")
	ret_dict = {}
	ret_dict['kg'] = split[1][:-1]
	ret_dict['batch'] = " ".join(split[2:5])
	ret_dict['epoch'] = int(split[6][:-1])
	ret_dict['loss'] = float(split[8])
	ret_dict['c_loss'] = float(split[9][1:-1])
	
	return ret_dict

def generate_training_graph(input_file, out_file = "training_stats.csv"):

	lines = [l.strip("\n") for l in open(input_file,'r').readlines()]

	data = []	
	for l in lines:
		if "process" in l:
			d = parse_line(l)
			data += [d]

	df = pd.DataFrame(data)
	print(df)
	
	df.to_csv(out_file,index=False)
	print("Written to %s"%out_file)


generate_training_graph('TRAINING_LOG.txt')


