# BATSYNTHESIS-Automation-tool
This tool takes RTL netlist and SDC file to auto-generate the synthesized netlist along with pre-layout timing report.
---
BATSYNTHESIS lets you synthesize and get timing information for a netlist. It takes a csv file containing the input file paths, like the one below, generates the output files and saves them to the specified output directory.
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

If all the files are found, the output is as below.
![image](https://github.com/apurvaaddula/BATSYNTHESIS-Automation-tool/assets/66956207/757db436-78d0-4ecd-8f6d-c05315fefe28)

### Converting timing constraints in CSV file to SDC format
Synopsys Design Constraints (SDC) is the standard format for timing constraints for many tools used in the industry.
BATSYNTHESIS converts the clock constraints which are given to it in a CSV file into SDC format.
The input CSV file for timing constraints can be similar to the one below :
![image](https://github.com/apurvaaddula/BATSYNTHESIS-Automation-tool/assets/66956207/401dcc37-c8b9-41bd-b417-0679cf34f237)
These are converted to SDC format. The SDC file which will be created is saved in the output directory with .sdc file extension.
![image](https://github.com/apurvaaddula/BATSYNTHESIS-Automation-tool/assets/66956207/a7f95de8-831c-4169-8465-1c7ddd252a42)

![image](https://github.com/apurvaaddula/BATSYNTHESIS-Automation-tool/assets/66956207/19383f92-3493-42cf-8255-66e59c1205e4)

SDC File:
1. Clock Constraints

   ![image](https://github.com/apurvaaddula/BATSYNTHESIS-Automation-tool/assets/66956207/53e6e3ea-8b9d-488f-b3f9-02410d20ce6c)

2. Input Constraints
![image](https://github.com/apurvaaddula/BATSYNTHESIS-Automation-tool/assets/66956207/7540435f-7be1-4351-adf8-b11decc7194f)

3. Output Constraints
![image](https://github.com/apurvaaddula/BATSYNTHESIS-Automation-tool/assets/66956207/079f9bba-3532-4102-a431-bbcd75841721)

### Hierarchy Check
Hierarchy check ensures that all the hierarchies in the design are properly connected.
First the script for hierarchy check for yosys tool is created. 
![image](https://github.com/apurvaaddula/BATSYNTHESIS-Automation-tool/assets/66956207/8db3e7fa-20d6-4776-a197-1850f413fa68)
It is saved in the defined output directory with the extension ".hier.ys".
![image](https://github.com/apurvaaddula/BATSYNTHESIS-Automation-tool/assets/66956207/8fc54a52-a0a0-4b08-9a78-e7bcee1db136)
![image](https://github.com/apurvaaddula/BATSYNTHESIS-Automation-tool/assets/66956207/f84012bd-bd76-4dbe-8917-91c5fcd03c65)


Then the tool checks if all the modules are part of the design. If all modules are correct the hierarchy check is passed. Else, the tool prints an error. Error details can also be viewed in the log file having .hierarchy_check.log which is saved to output directory.

1. If there are no errors :
![image](https://github.com/apurvaaddula/BATSYNTHESIS-Automation-tool/assets/66956207/38281408-d9cb-42e9-8e29-838c4a6b7dfc)

2. If there are errors :
   ![image](https://github.com/apurvaaddula/BATSYNTHESIS-Automation-tool/assets/66956207/7d465ff3-d335-4aad-9041-5a5e91cc19b6)
   Error message in log file,
   ![image](https://github.com/apurvaaddula/BATSYNTHESIS-Automation-tool/assets/66956207/82d0c4cd-193c-46b5-a0b6-b60b304d99b3)

### Generation of Synthesized Gate Level Netlist
The Yosys tool generates a synthesized gate level netlist. batsynthesis.tcl script converts this to a final GLN that can be given to opentimer tool to generate timing information.
![image](https://github.com/apurvaaddula/BATSYNTHESIS-Automation-tool/assets/66956207/b92cf9ec-80b8-4dcb-a2e6-8a53781d18cd)
Final Synthesized gate level netlist

![image](https://github.com/apurvaaddula/BATSYNTHESIS-Automation-tool/assets/66956207/9f194fdf-04ef-4bde-9d9d-f8a5e610253a)


### Generation of QOR Report
The tool gives the synthesized gate level netlist along with SDC and library file to Opentimer to perform pre-layout STA and generate the QOR pre-layout timing report. Timing constraints are converted from SDC format to a format accepted by Opentimer. The QOR is generated as follows.
![image](https://github.com/apurvaaddula/BATSYNTHESIS-Automation-tool/assets/66956207/caf73345-faa3-4527-8d7b-319c154567bd)

### Conclusion
Throughout this project the process of converting CSV files to a format accepted by the tool and generating the required output files has been successfully automated. 

### Acknowledgements
*Mr. Kunal Ghosh, VLSI System Design*




















