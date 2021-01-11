# hvp-copy-scripts
How to use the script:

- copy or clone the script and open in your favorite editor
- set the project pathname (PROJ_NAME)
- set the path to the source and target workspaces (SRC_WS and TGT_WS)
  - target workspace will be created
- add any additional guest OSes, libraries or DKMs that exist in your project
- run the script
```
$ sh hvp-copy-mip-project.sh
```

You can now check the project into git (or other code management).

--------
NOTE: Before importing the project into workbench and building it, you must edit the file `_defs.mos.mk` located in the MIP project folder. Replace 'CHANGEME' with the path to the top of your project workspace.
--------
