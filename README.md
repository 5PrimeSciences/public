# 5 Prime Sciences Public GitHub Repository

This repository contains WDL scripts that are used by 5' Genomics pipelines. They should be mostly devoid of anything of value and any "smarts" should be either included in a (privately hosted) docker repository or in a (privately hosted) script that will be provided as input to the WDL script. 

Make sure not to include any references to:
- clients
- project names
- gene names
- other business secrets


Structure of this Repository:

scripts -- contains the wdl scripts. 
Each script should be placed in it's own subdirectory. In addition to the script itself, one can also include a .json file (the configuration) and test files. Examples of this are shown in....

.dockstore -- this file needs to be updated when a new script in added and you want the script to be visible in dockstore. 
If, after adding a wdl you do not see it in dockstore you can investigate the following:
- invalid .dockstore file
- invalid wdl (run `miniwdl check` and also `womtool validate`)
- you need to make public the workflow (newly added workflows are "hidden" by default, find the script as "unpublished" in dockstore, and publish it.)

