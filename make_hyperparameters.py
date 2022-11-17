
# fixed
fold=3
a1 = 2.5
a2 = 1.0
 
# variable
d = [50, 100, 200, 300]
lr = [5e-4, 1e-3, 1e-2, 1e-1]
m = [0.5, 1]

# order: dim1 dim2 a1 a2 m1 m2 fold lr_A_vert lr_A_horiz lr_B_vert lr_B_horiz lr_AM
# 12 total

# enumerate
#for d1 in d:
#	for d2 in d:
for i in range(len(d)):
	for j in range(len(d)):
		if i == j-1:
			d1 = d[i]
			d2 = d[j]
		#if d1 > d2:
	
			for lr_ in lr:

				for m_ in m:

					arr = [d1,d2,a1,a2,m_,m_,fold,lr_,lr_,lr_,lr_,lr_]
					arr = [str(x) for x in arr]
					print(','.join(arr))
