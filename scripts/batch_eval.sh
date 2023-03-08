tag="2022-10-24"
model_folder="./model/"
for f in $model_folder*
do 
	# Only include those with the tag
	if [[ $f == *$tag* ]]; then
		model_name=$(basename $f)
		echo python ./run/test_triples.py --modelname $model_name --model murp_CMP-linear --method murp --resultfolder ./results --graphtype instance --testfile ./data/yago/yago_insnet_test.txt
	fi
	
done

