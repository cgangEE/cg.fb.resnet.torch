for i in {1..5} 
do
    th main.lua -batchSize 16 -dataset nistFlickr -fold $i -retrain resnet-34.t7 -data nistFlickr -resetClassifier true -nClasses 2 -LR 0.0001 -nEpochs 30 -save checkpointNistFlickr$i &> log$i &
done
