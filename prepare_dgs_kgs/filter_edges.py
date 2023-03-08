import sys
import pandas as pd



### Parse arguments ###
if len(sys.argv) < 3:
	print("Incorrect usage.")
	print("python filter_edges.py edges_to_include.txt edge_file.tsv")
	sys.exit(0)

# get file names
edges_to_include_list = sys.argv[1]
edge_file = sys.argv[2]

# parse files
edges = [l.strip("\n") for l in open(edges_to_include_list,'r').readlines()]
df = pd.read_csv(edge_file,sep="\t",header=None)
df.columns=['h','r','t']

sub_df = df[df['r'].isin(edges)]

print(edges_to_include_list)
print(edges[:10])
print(edge_file)
print(df.head())

print("Original df shape: ",df.shape)
print("Filtered df shape: ",sub_df.shape)

out_file_name = edges_to_include_list.split(".txt")[0]+"_"+edge_file
print(out_file_name)

sub_df.to_csv(out_file_name,index=False,header=False,sep="\t")
