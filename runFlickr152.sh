i=1
th main.lua -batchSize 20 -dataset flickr -fold $i -retrain resnet-152.t7 -data flickr -resetClassifier true -nClasses 2 -LR 0.0001 -nEpochs 40 -save checkpointFlickr152_$i &> log152_$i 
i=1
th main.lua -batchSize 16 -dataset flickr -fold $i -retrain resnet-200.t7 -data flickr -resetClassifier true -nClasses 2 -LR 0.0001 -nEpochs 40 -save checkpointFlickr200_$i &> log200_$i 
