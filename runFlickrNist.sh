for i in {1..5} 
do
    th main.lua -batchSize 16 -dataset flickrNist -fold $i -retrain resnet-34.t7 -data flickrNist -resetClassifier true -nClasses 2 -LR 0.0001 -nEpochs 40 -save checkpointFlickrNist$i &> log$i &
done
