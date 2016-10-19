datasets = require 'datasets/init'
Threads = require 'threads'
Threads.serialization('threads.sharedserialize')

opt = {}
opt.dataset = 'flickr'
opt.gen = 'gen'
opt.data = 'flickr'
opt.fold = '1'

split = 'val'
dataset = datasets.create(opt, split)

function init()
    require('datasets/flickr')
end

function main(idx)
    torch.setnumthreads(1)
    _G.dataset = dataset
    _G.preprocess = dataset:preprocess()
    return dataset:size()
end

for i = 1,dataset:size() do
end
