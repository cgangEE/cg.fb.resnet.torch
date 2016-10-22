require 'gnuplot'


if arg[1] == nil then
   print('-draw\tdraw epoc - error rate graph')
   print('-print\tprint error rate for each fold, and total error rate')
   os.exit(1)
end

errSum = 0.0

M = {}
table.insert(M, 'log50_1')
table.insert(M, 'log101_1')

--for i = 1,5 do
for i, f in pairs(M) do
   errRates = {} 
   err = 0.0
--   for line in io.lines('log' .. i) do
   for line in io.lines(f) do 
      if (string.find(line, 'Finished epoch') ~= nil) then 
         b, e = string.find(line, 'top1:')
         errRate = string.sub(line, e+1, e+8)
         table.insert(errRates, tonumber(errRate))
         err = tonumber(errRate)
      end
   end
   errSum = errSum + err
   if (arg[1] == '-draw') then
      gnuplot.figure(i) 
      y = torch.DoubleTensor(errRates)
      gnuplot.plot(y)
   end

   if (arg[1] == '-print') then
      print(err)
   end
end

if (arg[1] == '-print') then
   print(errSum / 5)
end

