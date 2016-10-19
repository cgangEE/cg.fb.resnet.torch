th main.lua -retrain resnet-18.t7 -data tattoo/fold1 -resetClassifier true -nClasses 2 -nEpochs 90 -save checkpoint1 &> log1 &
th main.lua -retrain resnet-18.t7 -data tattoo/fold2 -resetClassifier true -nClasses 2 -nEpochs 90 -save checkpoint2 &> log2 &
th main.lua -retrain resnet-18.t7 -data tattoo/fold3 -resetClassifier true -nClasses 2 -nEpochs 90 -save checkpoint3 &> log3 &
th main.lua -retrain resnet-18.t7 -data tattoo/fold4 -resetClassifier true -nClasses 2 -nEpochs 90 -save checkpoint4 &> log4 &
th main.lua -retrain resnet-18.t7 -data tattoo/fold5 -resetClassifier true -nClasses 2 -nEpochs 90 -save checkpoint5 &> log5 &
