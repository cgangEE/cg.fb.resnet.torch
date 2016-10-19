for i in {1..5} 
do
    th main.lua -batchSize 16 -dataset flickr -fold $i -retrain resnet-34.t7 -data flickr -resetClassifier true -nClasses 2 -LR 0.00006 -nEpochs 40 -save checkpointFlickr$i &> logFlickr$i &
done
