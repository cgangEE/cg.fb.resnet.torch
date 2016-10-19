#!/home/cgangee/code/torch/install/bin/th

require 'torch'
require 'paths'
require 'cudnn'
require 'cunn'
require 'image'
require 'socket'

function Test(tattooSet, i)

    model = torch.load('flickrCheckpoint34_1'  .. '/model_best.t7'):cuda()
    softMaxLayer = cudnn.SoftMax():cuda()
    model:add(softMaxLayer)
    model:evaluate()

    meanstd = {
        mean = { 0.485, 0.456, 0.406 },
        std = { 0.229, 0.224, 0.225 },
    }

    t = require './datasets/transforms'

    transform = t.Compose{
        t.Scale(256),
        t.ColorNormalize(meanstd),
        t.CenterCrop(224),
    }

    for line in io.lines('./tattoo/probes'..i..'.txt') do

        img = image.load('./tattoo/images/'..line, 3, 'float')
        img = transform(img)

        t1 = socket.gettime() * 1000
        output = model:forward(img:cuda()):squeeze()
        t2 = socket.gettime() * 1000
        if output[1] > output[2] then 
            if tattooSet[line] then
                print(i, line)
            end
        else
            if not tattooSet[line] then
                print(i, line)
            end
        end
    end
end

function readGt()
    local tattooSet = {}
    for line in io.lines('./tattoo/ground_truth.txt') do
        if string.sub(line,1,1)=='t' then
            imgName = string.sub(line, string.find(line, '|') + 1, -1)
            tattooSet[imgName] = true
        end
    end
    return tattooSet
end

tattooSet = readGt()
for i=1,5 do
    Test(tattooSet, i)
end
