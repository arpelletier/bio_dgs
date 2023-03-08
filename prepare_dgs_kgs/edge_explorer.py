import pandas as pd
import sys

def parse_node_to_type(file_name):
	node_df = pd.read_csv(file_name,sep="\t")
	node_to_type = {node:node_type for node,node_type in zip(node_df['node'],node_df['node_type'])}
	return node_to_type

def identify_node_types(edge_type, edges_df, node_to_type, debug=False):
	sub_df = edges_df[edges_df['r'] == edge_type].copy(deep=True)
	sub_df['h_type'] = [node_to_type[n] for n in sub_df['h']]
	sub_df['t_type'] = [node_to_type[n] for n in sub_df['t']]

	type_df = sub_df[['h_type','t_type']]
	uniq_type_df = type_df.drop_duplicates()
	if debug:
		print(edge_type)
		print(type_df.shape)
		print(type_df.drop_duplicates())
		print()
	return uniq_type_df
#type_df.drop_duplicates()
	#return type_df.drop_duplicates(ignore_index=True)


### Parse arguments ###
if len(sys.argv) < 2:
	print("Incorrect usage.")
	print("python edges_explorer.py edges_to_test.txt")
	sys.exit(0)


# input files
edges_input = 'kg1f_instances_grape.txt'
node_input = 'kg1f_instances_nodes.txt'
# get file names
edges_of_interest_list = sys.argv[1]
#edges_of_interest_list = 'edges_to_test.txt'

edges_df = pd.read_csv(edges_input,sep="\t")
edges_of_interest = [l.strip("\n") for l in open(edges_of_interest_list,'r').readlines()]


node_to_type = parse_node_to_type(node_input)

for edge in edges_of_interest:
	sub_df = identify_node_types(edge,edges_df,node_to_type,debug=True)
