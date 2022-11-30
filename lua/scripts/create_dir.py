import sys
import os

path = sys.argv[1]
if not os.path.isdir(sys.argv[1]):
    os.makedirs(path)



