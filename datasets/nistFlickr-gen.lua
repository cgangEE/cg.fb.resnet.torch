local sys = require 'sys'
local ffi = require 'ffi'

local M = {}

local function readGt(gtName)
    local tattooSet = {}

    for line in io.lines(gtName) do
        if string.sub(line,1,1)=='t' then
            imgName = string.sub(line, string.find(line, '|') + 1, -1)
            tattooSet[imgName] = true
        end
    end
    return tattooSet
end

local function getImagePath(imageList, tattooSet)
    local imagePaths = {}
    local imageClasses = {}
    local maxLength = -1

    for i, imagesName in pairs(imageList) do
        for line in io.lines(imagesName) do
            table.insert(imagePaths, line)
            table.insert(imageClasses, tattooSet[line] and 2 or 1)
            maxLength = math.max(maxLength, #line + 1)
        end
    end
    local nImages = #imagePaths
    local imagePath = torch.CharTensor(nImages, maxLength):zero()

    for i, path in pairs(imagePaths) do
        ffi.copy(imagePath[i]:data(), path)
    end
    local imageClass = torch.LongTensor(imageClasses)

    return imagePath, imageClass
end

function  M.exec(opt, cacheFile)
    local imageInfo = {}
    local nistGtName = paths.concat('nist', 'ground_truth.txt')
    local flickrGtName = paths.concat('flickr', 'ground_truth.txt')

    assert(paths.filep(nistGtName, 'gt file not found:' .. nistGtName))
    assert(paths.filep(flickrGtName, 'gt file not found:' .. flickrGtName))

    local nistSet = readGt(nistGtName)
    local flickrSet = readGt(flickrGtName)

    local trainImageList = {}
    local valImageList = {}
    for fold = 1,5 do
        if fold == opt.fold + 0 then
            local imagesName = paths.concat('flickr', 
                'flickr2349_group' .. fold .. '.txt')
            assert(paths.filep(imagesName, 'file not found:' .. imagesName))
            table.insert(valImageList, imagesName)
        else
            local imagesName = paths.concat('nist', 
                'probes' .. fold .. '.txt')
            assert(paths.filep(imagesName, 'file not found:' .. imagesName))
            table.insert(trainImageList, imagesName)
        end
    end

    local valImagePath, valImageClass = getImagePath(valImageList, flickrSet)
    local trainImagePath, trainImageClass = getImagePath(trainImageList, nistSet)

    local info = {
        basedir = opt.data,
        tattooSet = tattooSet,
        train = {
            imagePath = trainImagePath,
            imageClass = trainImageClass,
        },
        val = {
            imagePath = valImagePath,
            imageClass = valImageClass,
        },
    }
    print(" | saving list of images to " .. cacheFile)
    torch.save(cacheFile, info)
    return info
end

return M
