import os

# paths used
root = '/Users/forrest/Documents/fdt workspace/strat/res'
assetPath = '/Users/forrest/Documents/fdt workspace/strat/src/com/monarch/strat/Assets.as'
relRoot = '../../../../res'

# open Assets.as for writing, and start the class
out = open(assetPath, 'w')
out.write('package com.monarch.strat {\n\n\tpublic class Assets {\n\n')

# for each directory in resources
for dir in filter(lambda x: os.path.isdir('%s/%s' % (root, x)), os.listdir(root)):
	# start a new section
	out.write('\t\t/***** embed %s *****/\n' % dir)

	# get the resources in the section
	resources = os.listdir('%s/%s' % (root, dir))
	DIR = dir.upper()
	
	# embed each resource in Assets.as
	for res in resources:
		out.write('\t\t[Embed(source="%s/%s/%s"' % (relRoot, dir, res))
		if res[-3:].upper() == 'XML':
			out.write(', mimeType="application/octet-stream"')
		out.write(')]\n\t\tprivate static const %s_%s:Class;\n\n' % (DIR, res[:-4].upper()))
	
	# create an object to reference each resource
	out.write('\t\tpublic static const %s:Object = {\n' % dir)
	for res in resources:
		out.write('\t\t\t%s: %s_%s,\n' % (res[:-4], DIR, res[:-4].upper()))
	out.seek(-2, 2)
	out.write('\n\t\t};\n\n')

# close up the class
out.write('\t}\n\n}\n')
out.close()
