python ./run/training_model.py \
					--method distmult \
					--bridge CMP-linear \
					--kg1f ./data/yago/yago_insnet_train.txt \
					--kg2f ./data/yago/yago_ontonet_train.txt \
					--alignf ./data/yago/yago_InsType_train.txt \
					--modelname yago_test \
					--AM_loss_metric L2 \
					--vertical_links_A euclidean \
					--vertical_links_B hyperbolic \
					--horizontal_links_A euclidean \
					--horizontal_links_B hyperbolic \
					--vertical_links_AM hyperbolic \
					--total_epochs 1000






