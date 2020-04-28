# N3DPS-stack
A stack generator for the N3DPS disposable mask

OpenSCAD script that stacks the masks and generate viable supports for the upper masks.

Might have issues on older versions of openSCAD. The STL size means it can have issues. It was developed on the Developmental Build down the page here:

https://www.openscad.org/downloads.html

You might also need to up the CCAL cache size (Edit-preferences-advanced) at least for larger stacks 

Should be fairly self documenting. More supports improve final finish and print reliability at the cost of more cleanup of them.

Be aware, this takes quite a while to run, particularly on larger stacks. OpenSCAD is useful, but naive in its compiling. An 8 stack took 15 minutes and 4.1Gb of ram on an i7 processor. Pre-compiled STLs included to avoid that.

There is a script to generate a bunch of stacks also included

the pre-rendered files are too big for github. They are available on google drive however:
https://drive.google.com/open?id=13PGq6HcaBZCiX6BIzr4QoWKSDfrXC8Jf
