# Development guide

## Development
+ Make your changes
+ Add releasenotes to Changes.md file
+ Increase 'Version' in file VERSION
+ Compile new UmoX_Installer_[Version].exe using the _Compilation_ instructions
+ Test and validate new features
+ Startup release procedure

## Compilation
The UmoX-Installer script can be compiled using the free tool: 'Ps2Exe':

+ Select UmoX_Installer_[version].ps1 as Source file.
+ Copy the Source filepath and change extension into 'exe', instead of 'ps1'.
+ Select the containing 'ico' file as EXE icon file
  + Version: [version]
  + Product Name: UmoX Installer
  + Copyright: UMO Enovation (C)
+ From the checkboxes, only tick 'Require Administrator rights at runtime'
+ Prese 'Compile' in order to generate the EXE file

> [Link to PS2Exe project page](https://gallery.technet.microsoft.com/scriptcenter/PS2EXE-GUI-Convert-e7cb69d5 "PS2Exe")