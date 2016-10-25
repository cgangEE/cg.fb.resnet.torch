#!/usr/bin/python

import os

def getNum(fileName):
    ret = 0
    fileName = fileName.split('.')[0]
    fileLen = len(fileName)
    for i in range(fileLen):
        if fileName[i].isdigit():
            ret = ret * 10 + int(fileName[i])
    return ret


def getMaxModel(modelList):
    maxModel = ''
    maxNum = -1
    for fileName in modelList:
        num = getNum(fileName)
        if num > maxNum:
            maxNum = num
            maxModel = fileName

    return maxModel


def clean(folder):
    modelList = []
    for fileName in os.listdir(folder):
        fullFileName = os.path.join(folder, fileName)
        if os.path.isfile(fullFileName):
            if fileName.find('model') == 0:
                modelList.append(fileName)
            else:
                os.remove(fullFileName)

    maxModel = getMaxModel(modelList)
    print(maxModel)

    for fileName in modelList:
        if fileName != maxModel:
            os.remove(os.path.join(folder, fileName))


if __name__ == '__main__':
    for f in os.listdir('./'):   
        if f.find('checkpoint') == 0:
            if os.path.isdir(f):
                print(f)
                clean(f);


