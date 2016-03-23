import sys

out=open(sys.argv[1]+'.shrt','w')

for i in open(sys.argv[1]):
        if '\t0/0:' in i: continue
        if '\t./.:' in i: continue
        out.write(i)

out.close()
