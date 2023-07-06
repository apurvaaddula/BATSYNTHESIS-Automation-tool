# BATSYNTHESIS-Automation-tool
This tool takes RTL netlist and SDC file to auto-generate the synthesized netlist along with pre-layout timing report.
---
BATSYNTHESIS lets you synthesize and get timing information for a netlist at once. It takes a csv file containing the input file paths, like the one below, generates the output files and saves them to the specified output directory.
![image](https://github.com/apurvaaddula/BATSYNTHESIS-Automation-tool/assets/66956207/c8e93925-2538-4251-b910-2119ec74c438)

The tool is developed using shell and TCL scripting languages.

### Passing the input CSV file from Linux shell to the main script
#### 1. When the correct file in correct format is given as input in the command line
![image](https://github.com/apurvaaddula/BATSYNTHESIS-Automation-tool/assets/66956207/de18caa2-1421-4d1b-88cb-c14b43a85ce8)
#### 2. When no file is given as input or more than one files are given as input arguments
![image](https://github.com/apurvaaddula/BATSYNTHESIS-Automation-tool/assets/66956207/a6ecb553-1ba6-4dfb-b775-09cb8ae1d920)
![image](https://github.com/apurvaaddula/BATSYNTHESIS-Automation-tool/assets/66956207/302693a3-b026-44a4-89ed-b689f724fb20)
#### 3. If file does not exist
![image](https://github.com/apurvaaddula/BATSYNTHESIS-Automation-tool/assets/66956207/1fa21bd9-590c-4b06-89f0-f8a5a72868fb)
#### 4. If the input argument is -help 
![image](https://github.com/apurvaaddula/BATSYNTHESIS-Automation-tool/assets/66956207/6ba77318-7452-418f-9ef8-e2772e822b83)

### Auto-creating variables:
These variables store the file paths of the input files. 
![image](https://github.com/apurvaaddula/BATSYNTHESIS-Automation-tool/assets/66956207/58d00c2a-7db5-49ac-80a8-0dc125772806)
### Check if the directories and files exist
In this step, the tool checks if the directories and files specified in the .csv file exist.
If output directory does not exist, tool gives a warning and creates an output directory.
If any of the other files or directories do not exist, tool throws an error.
![image](https://github.com/apurvaaddula/BATSYNTHESIS-Automation-tool/assets/66956207/ae872131-87e8-4973-91dd-f7eddeea381c)
If everything all the files are found, the output is as below.
![image](https://github.com/apurvaaddula/BATSYNTHESIS-Automation-tool/assets/66956207/757db436-78d0-4ecd-8f6d-c05315fefe28)













