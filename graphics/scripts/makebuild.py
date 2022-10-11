# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		makebuild.py
#		Purpose :	Build the build file from asm/inc (Graphics version)
#		Date :		11th October 2022
#		Author : 	Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************
# *******************************************************************************************

import os,sys

sourceFiles = []																			# source files in order

for root,dirs,files in os.walk("."): 														# scan for directories
	for f in files: 																		# look for files that are .asm
		if f != "_graphics.asm":
			fName = root + os.sep + f
			if fName.endswith(".asm"):
				sourceFiles.append(fName)
sourceFiles.sort()

#
#		Create the composite file to build the whole thing.
#
h = open("_graphics.asm","w") 																# create the build file.
h.write(";\n;\tThis file is automatically generated\n;\n")  								# output the build file
h.write("\ngraphicsIntegrated = {0}\n\n".format(sys.argv[1]))
for f in sourceFiles:
	h.write('\t.include\t"{0}"\n'.format(f.replace(os.sep,"/")))
h.close()