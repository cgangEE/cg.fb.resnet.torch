f = open('tmp', 'r')
ret = 0.0
cnt = 0
for line in f:
    cnt += 1
    ret += float(line)
print ret / cnt
