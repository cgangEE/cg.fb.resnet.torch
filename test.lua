#!/home/cgangee/code/torch/install/bin/th

require 'torch'
require 'paths'
require 'cudnn'
require 'cunn'
require 'image'
require 'socket'

function Test()
    model = torch.load('checkpointFlickr2/model_30.t7'):cuda()
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

    img = image.load('./2.jpg', 3, 'float')
    img = transform(img)
    print(img:size())

    output = model:forward(img:cuda())
    return output
end

Test()
