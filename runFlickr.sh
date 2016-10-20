for i in {1..5} 
do
    th main.lua -batchSize 30 -dataset flickr -fold $i -retrain resnet-18.t7 -data flickr -resetClassifier true -nClasses 2 -LR 0.0001 -nEpochs 30 -save checkpointFlickr$i &> log$i &
done
