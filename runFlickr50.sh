i=1
th main.lua -batchSize 32 -dataset flickr -fold $i -retrain resnet-50.t7 -data flickr -resetClassifier true -nClasses 2 -LR 0.0001 -nEpochs 40 -save checkpointFlickr50_$i &> log50_$i 
i=1
th main.lua -batchSize 32 -dataset flickr -fold $i -retrain resnet-101.t7 -data flickr -resetClassifier true -nClasses 2 -LR 0.0001 -nEpochs 40 -save checkpointFlickr101_$i &> log101_$i 
