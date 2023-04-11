#kg1f_test=kg1f_instances_test.txt
kg1f_test=$1
#['drug_targets_protein','affects','binding','binder']
#['treats']
output_folder=$2 

test_basename="${kg1f_test##*/}"

echo $test_basename
# drug to protein
echo "grep "drug_targets_protein" $kg1f_test > $output_folder/drug_targets_protein_$test_basename"
grep "drug_targets_protein" $kg1f_test > $output_folder/drug_targets_protein_$test_basename
wc -l $output_folder/drug_targets_protein_$test_basename

# drug to disease
echo "grep "treats" $kg1f_test > $output_folder/drug_treats_disease_$test_basename"
grep "treats" $kg1f_test > $output_folder/drug_treats_disease_$test_basename
wc -l $output_folder/drug_treats_disease_$test_basename


