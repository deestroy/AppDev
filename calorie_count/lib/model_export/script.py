import sys
import urllib.request
from os.path import realpath
#from urllib import request

#from os import read
firstarg=sys.argv[1]
print(firstarg)
urllib.request.urlretrieve(firstarg, "local-filename.jpg")
#urllib.request.urlretrieve("https://firebasestorage.googleapis.com/v0/b/caloriesignin.appspot.com/o/2019-06-12%2011%3A47%3A12.665535.png?alt=media&token=125aa137-f286-4436-b5fc-19e48ca93a1d", "local-filename.jpg")
"""resource = url.read()
    output = open("file01.jpg","wb")

    output.write(resource.read())

    output.close()

import urllib.request

with urllib.request.urlopen("http://www.python.org") as url:
    s = url.read()
    # I'm guessing this would output the html source code ?
    print(s)
    
    
dataX = urllib.request.urlopen(url).read()""" 