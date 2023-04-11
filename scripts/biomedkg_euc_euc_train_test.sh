#python ./run/training_model.py --method "transe" --bridge "CMP-linear" --kg1f "../dgs_input/kg1f_instances_train.txt" --kg2f "../dgs_input/kg2f_ontologies_train.txt" --alignf "../dgs_input/alignf_bridges.txt" --modelname "epoch-tuning/type_biomedkg_epoch-100_EUC_EUC-exp-optim-original-param" --AM_loss_metric "L2" --vertical_links_A "euclidean" --horizontal_links_A "euclidean" --vertical_links_B "euclidean" --horizontal_links_B "euclidean" --vertical_links_AM "euclidean" --GPU "0" --dim1 300 --dim2 50 --batch_K1 256 --batch_K2 64  --batch_A 128 --m1 0.5 --fold 2 --total_epochs 100 --lr_A_vert 0.01 --lr_A_horiz 0.001 --lr_B_vert 0.001 --lr_B_horiz 0.001 --lr_AM 0.0005 --GPU 1,4

# FULL EVAL KG2F
#python ./run/test_triples.py --modelname "epoch-tuning/type_biomedkg_epoch-100_EUC_EUC-exp-optim-original-param" --model transe_CMP-linear --testfile "../dgs_input/kg2f_ontologies_test.txt" --method "transe" --resultfolder ./results/test_triples --bridge "CMP-linear" --graphtype "ontology"

# FULL EVAL KG1F
#python ./run/test_triples.py --modelname "epoch-tuning/type_biomedkg_epoch-100_EUC_EUC-exp-optim-original-param" --model transe_CMP-linear --testfile "../dgs_input/kg1f_instances_test.txt" --method "transe" --resultfolder ./results/test_triples --bridge "CMP-linear" --graphtype "ontology"

# Drug-protein eval
python ./run/test_triples.py --modelname "epoch-tuning/type_biomedkg_epoch-100_EUC_EUC-exp-optim-original-param" --model transe_CMP-linear --testfile "../dgs_input/subset_eval/drug_targets_protein_kg1f_instances_test.txt" --method "transe" --resultfolder ./results/test_triples --bridge "CMP-linear" --graphtype "instance"
