#! /bin/env tclsh

# Checks whether batsynthesis usage is correct or not.

set enable_prelayout_timing 1
set working_dir [exec pwd]
set vsd_array_length [llength [split [lindex $argv 0] .]]
set input [lindex [split [lindex $argv 0] .] $vsd_array_length-1]

if {![regexp {^csv} $input] || $argc!=1 } {
	puts "Error in usage"
	puts "Usage: ./batsynthesis <.csv>"
	puts "where <.csv> file has below inputs"
	exit
} else {
	#Converts .csv to matrix and creates initial variables.

	set filename [lindex $argv 0]

	package require csv
	package require struct::matrix
	struct::matrix m

	set f [open $filename]
	csv::read2matrix $f m , auto
	close $f

	set columns [m columns]
	#m add columns $columns
	m link my_arr

	set num_of_rows [m rows]
	set i 0
	while {$i < $num_of_rows} {
		puts "\nInfo: Setting $my_arr(0,$i) as $my_arr(1,$i)"

		if {![file isdirectory $my_arr(1,$i)]} {
			set [string map {" " ""} $my_arr(0,$i)] $my_arr(1,$i)
		} else {
			set [string map {" " ""} $my_arr(0,$i)] [file normalize $my_arr(1,$i)]
		}
		set i [expr {$i+1}]
	}
}

puts "\nInfo: Below are the list of initial variables and their values:"
puts "DesignName = $DesignName"
puts "OutputDirectory = $OutputDirectory"
puts "NetlistDirectory = $NetlistDirectory"
puts "EarlyLibraryPath = $EarlyLibraryPath"
puts "LateLibraryPath = $LateLibraryPath"
puts "ConstraintsFile = $ConstraintsFile"

#return
#
#Check if the directories and files mentioned in the csv file exist or not
#

if {![file isdirectory $OutputDirectory]} {
	puts "\nInfo: Cannot find output directory $OutputDirectory."
	file mkdir $OutputDirectory
	
} else {
	puts "\nInfo: Output Directory found in path $OutputDirectory"
}

if {![file isdirectory $NetlistDirectory]} {
	puts "\nError: Cannot find RTL netlist directory in path $NetlistDirectory. Exiting..."
	exit
} else {
	puts "\nInfo: RTL netlist directory found in path $NetlistDirectory"
}


if {![file exists $EarlyLibraryPath]} {
	puts "\nError: Cannot find early cell library in path $EarlyLibraryPath. Exiting..."
	exit
} else {
	puts "\nInfo: Early cell library found in path $EarlyLibraryPath"
}

if {![file exists $LateLibraryPath]} {
	puts "\nError: Cannot find late cell library in path $LateLibraryPath. Exiting..."
	exit
} else {
	puts "\nInfo: Late cell library found in path $LateLibraryPath"
}

if {![file exists $ConstraintsFile]} {
	puts "\nError: Cannot find constraints file in path $ConstraintsFile. Exiting..."
	exit
} else {
	puts "\nInfo: Constraints file found in path $ConstraintsFile"
}
#return


#Creation of SDC Constraints File

puts "\nInfo : Dumping SDC constraints for $DesignName"
::struct::matrix constraints
set chan [open $ConstraintsFile]
csv::read2matrix $chan constraints , auto
close $chan

set no_of_rows [constraints rows]
#puts "Number of rows = $no_of_rows"

set no_of_columns [constraints columns]
#puts "Number of columns = $no_of_columns"

#Check row number for clocks
set clock_start [lindex [lindex [constraints search all CLOCKS] 0] 1]
#Check column number for "IO delays and slew" section in constraints.csv
set clock_start_column [lindex [lindex [constraints search all CLOCKS] 0] 0]
#puts "Clock start = $clock_start"
#puts "Clock start column = $clock_start_column"

#Check row number for inputs
set input_ports_start [lindex [lindex [constraints search all INPUTS] 0] 1]
#puts "Input ports start = $input_ports_start"

#Check row number for outputs
set output_ports_start [lindex [lindex [constraints search all OUTPUTS] 0] 1]
#puts "Output ports start = $output_ports_start"
#return
#
#Clock Constraints
#Clock Latency Constraints

set clock_early_rise_delay_start [lindex [lindex [constraints search rect $clock_start_column $clock_start [expr {$no_of_columns-1}] [expr {$input_ports_start-1}] early_rise_delay] 0] 0]

set clock_early_fall_delay_start [lindex [lindex [constraints search rect $clock_start_column $clock_start [expr {$no_of_columns-1}] [expr {$input_ports_start-1}] early_fall_delay] 0] 0]

set clock_late_rise_delay_start [lindex [lindex [constraints search rect $clock_start_column $clock_start [expr {$no_of_columns-1}] [expr {$input_ports_start-1}] late_rise_delay] 0] 0]

set clock_late_fall_delay_start [lindex [lindex [constraints search rect $clock_start_column $clock_start [expr {$no_of_columns-1}] [expr {$input_ports_start-1}] late_fall_delay] 0] 0]

#Clock Transition Constraints

set clock_early_rise_slew_start [lindex [lindex [constraints search rect $clock_start_column $clock_start [expr {$no_of_columns-1}] [expr {$input_ports_start-1}] early_rise_slew] 0] 0]

set clock_early_fall_slew_start [lindex [lindex [constraints search rect $clock_start_column $clock_start [expr {$no_of_columns-1}] [expr {$input_ports_start-1}] early_fall_slew] 0] 0]

set clock_late_rise_slew_start [lindex [lindex [constraints search rect $clock_start_column $clock_start [expr {$no_of_columns-1}] [expr {$input_ports_start-1}] late_rise_slew] 0] 0]

set clock_late_fall_slew_start [lindex [lindex [constraints search rect $clock_start_column $clock_start [expr {$no_of_columns-1}] [expr {$input_ports_start-1}] late_fall_slew] 0] 0]

set sdc_file [open $OutputDirectory/$DesignName.sdc "w"]
set i [expr {$clock_start+1}]
set end_of_ports [expr {$input_ports_start-1}]
puts "\nInfo-SDC : Working on clock constraints....."
while {$i < $end_of_ports} {
	puts "Working on clock [constraints get cell 0 $i]"
	puts -nonewline $sdc_file "\ncreate_clock -name [constraints get cell 0 $i] -period [constraints get cell 1 $i] -waveform \{0 [expr {[constraints get cell 1 $i]*[constraints get cell 2 $i]/100}]\} \[get_ports [constraints get cell 0 $i]\]"

	puts -nonewline $sdc_file "\nset_clock_transition -rise -min [constraints get cell $clock_early_rise_slew_start $i] \[get_clocks [constraints get cell 0 $i]\]"
	puts -nonewline $sdc_file "\nset_clock_transition -fall -min [constraints get cell $clock_early_fall_slew_start $i] \[get_clocks [constraints get cell 0 $i]\]"
	puts -nonewline $sdc_file "\nset_clock_transition -rise -max [constraints get cell $clock_late_rise_slew_start $i] \[get_clocks [constraints get cell 0 $i]\]"
	puts -nonewline $sdc_file "\nset_clock_transition -fall -max [constraints get cell $clock_late_fall_slew_start $i] \[get_clocks [constraints get cell 0 $i]\]"

	puts -nonewline $sdc_file "\nset_clock_latency -source -early -rise [constraints get cell $clock_early_rise_delay_start $i] \[get_clocks [constraints get cell 0 $i]\]"
	puts -nonewline $sdc_file "\nset_clock_latency -source -early -fall [constraints get cell $clock_early_fall_delay_start $i] \[get_clocks [constraints get cell 0 $i]\]"
	puts -nonewline $sdc_file "\nset_clock_latency -source -late -rise [constraints get cell $clock_late_rise_delay_start $i] \[get_clocks [constraints get cell 0 $i]\]"
	puts -nonewline $sdc_file "\nset_clock_latency -source -late -fall [constraints get cell $clock_late_fall_delay_start $i] \[get_clocks [constraints get cell 0 $i]\]"

	set i [expr {$i+1}]
}
#return
#
#Input and slew constraints
#
set input_early_rise_delay_start [lindex [lindex [constraints search rect $clock_start_column $input_ports_start [expr {$no_of_columns-1}] [expr {$output_ports_start-1}] early_rise_delay] 0] 0]

set input_early_fall_delay_start [lindex [lindex [constraints search rect $clock_start_column $input_ports_start [expr {$no_of_columns-1}] [expr {$output_ports_start-1}] early_fall_delay] 0] 0]

set input_late_rise_delay_start [lindex [lindex [constraints search rect $clock_start_column $input_ports_start [expr {$no_of_columns-1}] [expr {$output_ports_start-1}] late_rise_delay] 0] 0]

set input_late_fall_delay_start [lindex [lindex [constraints search rect $clock_start_column $input_ports_start [expr {$no_of_columns-1}] [expr {$output_ports_start-1}] late_fall_delay] 0] 0]

set input_early_rise_slew_start [lindex [lindex [constraints search rect $clock_start_column $input_ports_start [expr {$no_of_columns-1}] [expr {$output_ports_start-1}] early_rise_slew] 0] 0]

set input_early_fall_slew_start [lindex [lindex [constraints search rect $clock_start_column $input_ports_start [expr {$no_of_columns-1}] [expr {$output_ports_start-1}] early_fall_slew] 0] 0]

set input_late_rise_slew_start [lindex [lindex [constraints search rect $clock_start_column $input_ports_start [expr {$no_of_columns-1}] [expr {$output_ports_start-1}] late_rise_slew] 0] 0]

set input_late_fall_slew_start [lindex [lindex [constraints search rect $clock_start_column $input_ports_start [expr {$no_of_columns-1}] [expr {$output_ports_start-1}] late_fall_slew] 0] 0]


set related_clock [lindex [lindex [constraints search rect $clock_start_column $input_ports_start [expr {$no_of_columns-1}] [expr {$output_ports_start-1}] clocks] 0] 0]
set i [expr {$input_ports_start+1}]
set end_of_ports [expr {$output_ports_start-1}]
puts "\nInfo-SDC : Working on Input constraints....."
puts "\nInfo-SDC : Categorizing input ports as single-bit and multi-bit bus....."

while {$i < $end_of_ports} {
	#Categorizing single and multi bit busses (optional)
	set netlist [glob -dir $NetlistDirectory *.v]
	set tmp_file [open /tmp/1 w]
	foreach f $netlist {
		set fd [open $f]
		#puts "Reading File $f"
		while {[gets $fd line] != -1} {
			set pattern1 " [constraints get cell 0 $i];"
			if {[regexp -all -- $pattern1 $line]} {
				#puts "Pattern1 \"$pattern1\" found and matching line in verilog file \"$f\" is \"$line\""
				set pattern2 [lindex [split $line ";"] 0]
				#puts "Creating pattern2 by splitting pattern1 using \";\" as de-limiter => \"pattern2\""
				if {[regexp -all {input} [lindex [split $pattern2 "\S+"] 0]]} {
					#puts "Out of all patterns, \"$pattern2\" has matching string \"input\". So preserving this line and ignoring others"
					set s1 "[lindex [split $pattern2 "\S+"] 0] [lindex [split $pattern2 "\S+"] 1] [lindex [split $pattern2 "\S+"] 2]"
					#puts "Printing frst 3 elements of pattern2 as \"$s1\" using space as de-limiter"
					puts -nonewline $tmp_file "\n[regsub -all {\s+} $s1 " "]"
					#puts "Replace multiple spaces in s1 by single space and re-format as \"[regsub -all {\s+} $s1 " "]\""
				}
			}
		}
		close $fd 
	}
	close $tmp_file
	set tmp_file [open /tmp/1 r]
	#puts "Reading [read $tmp_file]..."
	#puts "Reading /tmp/1 file as [split [read $tmp_file] \n]"
	#puts "Sorting /tmp/1 contents as [lsort -unique [split [read $tmp_file] \n]]"
	#puts "Joining /tmp/1 as [join [lsort -unique [split [read $tmp_file] \n]] \n]"

	set tmp2_file [open /tmp/2 w]
	puts -nonewline $tmp2_file "[join [lsort -unique [split [read $tmp_file] \n]] \n]"
	close $tmp_file
	close $tmp2_file

	set tmp2_file [open /tmp/2 r]
	#puts "Count is [llength [read $tmp2_file]]"
	set count [llength [read $tmp2_file]]
	#puts "Splitting content of tmp_2 using space and counting number of elements as $count."
	
	if {$count > 2} {
		set inp_ports [concat [constraints get cell 0 $i]\*]
		#puts "Multi-bit Bus"
	} else {
		set inp_ports [constraints get cell 0 $i]
		#puts "Single-bit"
	}

	#puts "Input port name is $inp_ports since count is $count\n"
	puts -nonewline $sdc_file "\nset_input_delay -clock \[get_clocks [constraints get cell $related_clock $i]\] -min -rise -source_latency_included [constraints get cell $input_early_rise_delay_start $i] \[get_ports $inp_ports\]"
	puts -nonewline $sdc_file "\nset_input_delay -clock \[get_clocks [constraints get cell $related_clock $i]\] -min -fall -source_latency_included [constraints get cell $input_early_fall_delay_start $i] \[get_ports $inp_ports\]"
	puts -nonewline $sdc_file "\nset_input_delay -clock \[get_clocks [constraints get cell $related_clock $i]\] -max -rise -source_latency_included [constraints get cell $input_late_rise_delay_start $i] \[get_ports $inp_ports\]"
	puts -nonewline $sdc_file "\nset_input_delay -clock \[get_clocks [constraints get cell $related_clock $i]\] -max -fall -source_latency_included [constraints get cell $input_late_fall_delay_start $i] \[get_ports $inp_ports\]"

	set i [expr {$i+1}]
}

close $tmp2_file

#Create Output Delay and Load Constraints

set output_early_rise_delay_start [lindex [lindex [constraints search rect $clock_start_column $output_ports_start [expr {$no_of_columns-1}] [expr {$no_of_rows-1}] early_rise_delay] 0] 0]

set output_early_fall_delay_start [lindex [lindex [constraints search rect $clock_start_column $output_ports_start [expr {$no_of_columns-1}] [expr {$no_of_rows-1}] early_fall_delay] 0] 0]

set output_late_rise_delay_start [lindex [lindex [constraints search rect $clock_start_column $output_ports_start [expr {$no_of_columns-1}] [expr {$no_of_rows-1}] late_rise_delay] 0] 0]

set output_late_fall_delay_start [lindex [lindex [constraints search rect $clock_start_column $output_ports_start [expr {$no_of_columns-1}] [expr {$no_of_rows-1}] late_fall_delay] 0] 0]

set output_load_start [lindex [lindex [constraints search rect $clock_start_column $output_ports_start [expr {$no_of_columns-1}] [expr {$no_of_rows-1}] load] 0] 0]

set related_clock [lindex [lindex [constraints search rect $clock_start_column $output_ports_start [expr {$no_of_columns-1}] [expr {$no_of_rows-1}] clocks] 0] 0]

set i [expr {$output_ports_start+1}]
set end_of_ports [expr {$no_of_rows}]

puts "\nInfo-SDC : Working on Output constraints....."
puts "\nInfo-SDC : Categorizing output ports as single-bit and multi-bit bus....."

while {$i < $end_of_ports} {
	#Categorizing single and multi bit busses (optional)
	set netlist [glob -dir $NetlistDirectory *.v]
	set tmp_file [open /tmp/1 w]
	foreach f $netlist {
		set fd [open $f]
		#puts "Reading File $f"
		while {[gets $fd line] != -1} {
			set pattern1 " [constraints get cell 0 $i];"
			if {[regexp -all -- $pattern1 $line]} {
				#puts "Pattern1 \"$pattern1\" found and matching line in verilog file \"$f\" is \"$line\""
				set pattern2 [lindex [split $line ";"] 0]
				#puts "Creating pattern2 by splitting pattern1 using \";\" as de-limiter => \"pattern2\""
				if {[regexp -all {input} [lindex [split $pattern2 "\S+"] 0]]} {
					#puts "Out of all patterns, \"$pattern2\" has matching string \"input\". So preserving this line and ignoring others"
					set s1 "[lindex [split $pattern2 "\S+"] 0] [lindex [split $pattern2 "\S+"] 1] [lindex [split $pattern2 "\S+"] 2]"
					#puts "Printing frst 3 elements of pattern2 as \"$s1\" using space as de-limiter"
					puts -nonewline $tmp_file "\n[regsub -all {\s+} $s1 " "]"
					#puts "Replace multiple spaces in s1 by single space and re-format as \"[regsub -all {\s+} $s1 " "]\""
				}
			}
		}
		close $fd 
	}
	close $tmp_file
	set tmp_file [open /tmp/1 r]
	#puts "Reading [read $tmp_file]..."
	#puts "Reading /tmp/1 file as [split [read $tmp_file] \n]"
	#puts "Sorting /tmp/1 contents as [lsort -unique [split [read $tmp_file] \n]]"
	#puts "Joining /tmp/1 as [join [lsort -unique [split [read $tmp_file] \n]] \n]"

	set tmp2_file [open /tmp/2 w]
	puts -nonewline $tmp2_file "[join [lsort -unique [split [read $tmp_file] \n]] \n]"
	close $tmp_file
	close $tmp2_file

	set tmp2_file [open /tmp/2 r]
	#puts "Count is [llength [read $tmp2_file]]"
	set count [llength [read $tmp2_file]]
	#puts "Splitting content of tmp_2 using space and counting number of elements as $count."
	
	if {$count > 2} {
		set op_ports [concat [constraints get cell 0 $i]\*]
		#puts "Multi-bit Bus"
	} else {
		set op_ports [constraints get cell 0 $i]
		#puts "Single-bit"
	}
	puts -nonewline $sdc_file "\nset_output_delay -clock \[get_clocks [constraints get cell $related_clock $i]\] -min -rise -source_latency_included [constraints get cell $output_early_rise_delay_start $i] \[get_ports $op_ports\]"

	puts -nonewline $sdc_file "\nset_output_delay -clock \[get_clocks [constraints get cell $related_clock $i]\] -min -fall -source_latency_included [constraints get cell $output_early_fall_delay_start $i] \[get_ports $op_ports\]"

	puts -nonewline $sdc_file "\nset_output_delay -clock \[get_clocks [constraints get cell $related_clock $i]\] -max -rise -source_latency_included [constraints get cell $output_late_rise_delay_start $i] \[get_ports $op_ports\]"

	puts -nonewline $sdc_file "\nset_output_delay -clock \[get_clocks [constraints get cell $related_clock $i]\] -max -fall -source_latency_included [constraints get cell $output_late_fall_delay_start $i] \[get_ports $op_ports\]"

	set i [expr {$i+1}]
}

close $tmp2_file
close $sdc_file

puts "\nInfo : SDC created. Please use constraints in path $OutputDirectory/$DesignName.sdc"
#return
#
#Hierarchy Check
puts "\nInfo : Creating hierarchy check script to be used by Yosys"
#Yosys cmd
set data "\nread_liberty -lib -ignore_miss_dir -setattr blackbox ${LateLibraryPath}" 
puts "\nData is \"$data\""
set filename "$DesignName.hier.ys"
puts "\nFile name is \"$filename\""
set fileId [open $OutputDirectory/$filename "w"]
puts "\nOpen \"$OutputDirectory/$filename\" in write mode"
puts -nonewline $fileId $data
set netlist [glob -dir $NetlistDirectory *.v]
puts "\nNetlist is \"$netlist\""
foreach f $netlist {
	set data $f
	#puts "Data is \"$f\""
	puts "\n read_verilog $f"
	puts -nonewline $fileId "\nread_verilog $f"
}
puts -nonewline $fileId "\nhierarchy -check"
close $fileId
#return
#
#Error Handling
puts "\nClose \"$OutputDirectory/$filename\"\n"
puts "\nChecking Hierarchy..."
set my_err [catch { exec yosys -s $OutputDirectory/$DesignName.hier.ys >& $OutputDirectory/$DesignName.hierarchy_check.log} msg]
puts "Error flag is $my_err"

if {$my_err} {
	set filename "$OutputDirectory/$DesignName.hierarchy_check.log"
	puts "Log file name is $filename"
	set pattern {referenced in module}
#	puts "Pattern is $pattern"
	set count 0
	set fid [open $filename r]
	while {[gets $fid line] != -1} {
		incr count [regexp -all -- $pattern $line]
		if {[regexp -all -- $pattern $line]} {
			puts "\nError : Module [lindex $line 2] is not part of design $DesignName. Please correct RTL in the path '$NetlistDirectory'"
			puts "\nInfo : Hierarchy check FAIL"
		}
	}
	close $fid
} else {
	puts "\nInfo : Hierarchy check PASS"
}
puts "\nInfo : Please find hierarchy check details in [file normalize $OutputDirectory/$DesignName.hierarchy_check.log] for more info"
cd $working_dir

#Main Synthesis Script
puts "\nInfo : Creating main synthesis script to be used by Yosys"
set data "read_liberty -lib -ignore_miss_dir -setattr blackbox ${LateLibraryPath}"
set filename "$DesignName.ys"
set fileId [open $OutputDirectory/$filename "w"]
puts -nonewline $fileId $data

set netlist [glob -dir $NetlistDirectory *.v]
foreach f $netlist {
	set data $f
	puts -nonewline $fileId "\nread_verilog $f"
}

puts -nonewline $fileId "\nhierarchy -top $DesignName"
puts -nonewline $fileId "\nsynth -top $DesignName"
puts -nonewline $fileId "\nsplitnets -ports -format ___ \ndfflibmap -liberty ${LateLibraryPath}\nopt"
puts -nonewline $fileId "\nabc -liberty ${LateLibraryPath}"
puts -nonewline $fileId "\nflatten"
puts -nonewline $fileId "\nclean -purge\niopadmap -outpad BUFX2 A:Y -bits\nopt\nclean"
puts -nonewline $fileId "\nwrite_verilog $OutputDirectory/$DesignName.synth.v"
close $fileId
puts "\nInfo : Synthesis script created and can be accessed from path $OutputDirectory/$DesignName.ys"

puts "\nInfo : Running synthesis..."

#Run synthesis script using yosys
if {[catch {exec yosys -s $OutputDirectory/$DesignName.ys >& $OutputDirectory/$DesignName.synthesis.log} msg]} {
	puts "\nError : Synthesis failed due to errors. Please refer to log $OutputDirectory/$DesignName.synthesis.log for errors"
	exit
} else {
	puts "\nInfo : Synthesis finished successfully"
}
puts "\nInfo : Please refer to log $OutputDirectory/$DesignName.synthesis.log"
#return
#Edit synth.v to be usable by Opentimer

set fileId [open /tmp/1 "w"]
puts -nonewline $fileId [exec grep -v -w "*" $OutputDirectory/$DesignName.synth.v]
close $fileId

set output [open $OutputDirectory/$DesignName.final.synth.v "w"]

set filename "/tmp/1"
set fid [open $filename r]

while {[gets $fid line] != -1} {
	puts -nonewline $output [string map {"\\" ""} $line]
	puts -nonewline $output "\n"
}

close $fid
close $output

puts "\nInfo : Please find the synthesized netlist for $DesignName at below path. You can use this netlist for STA or PNR"
puts "\n$OutputDirectory/$DesignName.final.synth.v"
#return
#STA Using Opentimer
#
puts "\nInfo : Timing Analysis Started..."
puts "\nInfo : Initializing Number of threads, libraries, sdc, verilog netlist path..."
source /home/vsduser/vsdsynth/procs/reopenStdout.proc
source /home/vsduser/vsdsynth/procs/set_num_threads.proc 
reopenStdout $OutputDirectory/$DesignName.conf
set_multi_cpu_usage -localCpu 4


source /home/vsduser/vsdsynth/procs/read_lib.proc
read_lib -early /home/vsduser/vsdsynth/osu018_stdcells.lib
read_lib -late /home/vsduser/vsdsynth/osu018_stdcells.lib

source /home/vsduser/vsdsynth/procs/read_verilog.proc
read_verilog $OutputDirectory/$DesignName.final.synth.v

source /home/vsduser/vsdsynth/procs/read_sdc.proc
read_sdc $OutputDirectory/$DesignName.sdc
reopenStdout /dev/tty

if {$enable_prelayout_timing == 1} {
	puts "\nInfo : enable_prelayout_timing is $enable_prelayout_timing. Enabling zero-wire load parasitics"
	set spef_file [open $OutputDirectory/$DesignName.spef w]
	puts $spef_file "*SPEF \"IEEE 1481-1998\""
	puts $spef_file "*DESIGN \"$DesignName\""
	puts $spef_file "*DATE \"clock -format {%a %b %d %I:%M:%S %Y}\""
	puts $spef_file "*VENDOR \"TAU 2015 Contest\""
	puts $spef_file "*PROGRAM \"Benchmark Parasitic Generator\""
	puts $spef_file "*VERSION \"0.0\""
	puts $spef_file "*DESIGN_FLOW \"NETLIST_TYPE_VERILOG\""
	puts $spef_file "*DIVIDER /"
	puts $spef_file "*DELIMITER : "
	puts $spef_file "*BUS DELIMITER [ ]"
	puts $spef_file "*T_UNIT 1 PS "
	puts $spef_file "*C_UNIT 1 FF "
	puts $spef_file "*R_UNIT 1 KOHM "
	puts $spef_file "*L_UNIT 1 UH "
}
close $spef_file

set conf_file [open $OutputDirectory/$DesignName.conf a]
puts $conf_file "set_spef_fpath $OutputDirectory/$DesignName.spef"
puts $conf_file "init_timer "
puts $conf_file "report_timer "
puts $conf_file "report_wns "
puts $conf_file "report_worst_paths -numPaths 10000 "
close $conf_file

set tcl_precision 3
set time_elapsed [time {exec /home/vsduser/OpenTimer-1.0.5/bin/OpenTimer < $OutputDirectory/$DesignName.conf >& $OutputDirectory/$DesignName.results} 1]
puts "Time elapsed is $time_elapsed"
set time_elapsed_in_sec "[expr {[lindex $time_elapsed 0]/100000}]sec"
puts "Time elapsed in seconds is $time_elapsed_in_sec"
puts "\nInfo : STA finished in $time_elapsed_in_sec seconds"
puts "\nInfo : Refer to $OutputDirectory/$DesignName.results for warnings and errors"

#Find worst output violation

set worst_RAT_slack "_"
set report_file [open $OutputDirectory/$DesignName.results r]
puts "Report file is $OutputDirectory.results"
set pattern {RAT}
#puts "Pattern is $pattern"
while {[gets $report_file line] != -1} {
	if {[regexp $pattern $line]} {
		puts "Pattern \"$pattern\" found in \"$line\""
		puts "Old Worst RAT Slack is $worst_RAT_slack"
		set worst_RAT_slack "[expr {[lindex $line 3]/1000}]ns"
		puts "part1 is [lindex $line 3]"
		puts "New worst RAT slack is $worst_RAT_slack"
		break
	} else {
		continue
	}
}
close $report_file

#Find the number of output violations
set report_file [open $OutputDirectory/$DesignName.results r]
set count 0
while {[gets $report_file line] != -1} {
	incr count [regexp -all -- $pattern $line]
}
set Number_output_violations $count
puts "Number of output violations is $Number_output_violations"
close $report_file

#Find worst setup violation
set worst_negative_setup_slack "-"
set report_file [open $OutputDirectory/$DesignName.results r]
set pattern {Setup}
while {[gets $report_file line] != -1} {
	if {[regexp $pattern $line]} {
		set worst_negative_setup_slack "[expr {[lindex $line 3]/1000}]ns"
		break
	} else {
		continue
	}
}
close $report_file

#Find number of setup violations
set report_file [open $OutputDirectory/$DesignName.results r]
set count 0
while {[gets $report_file line] != -1} {
	incr count [regexp -all -- $pattern $line]
}
set Number_of_setup_violations $count
close $report_file

#Find worst hold violation
set worst_negative_hold_slack "-"
set report_file [open $OutputDirectory/$DesignName.results r]
set pattern {Hold}
while {[gets $report_file line] != -1} {
	if {[regexp $pattern $line]} {
		set worst_negative_hold_slack "[expr {[lindex $line 3]/1000}]ns"
		break
	} else {
		continue
	}
}
close $report_file

#Find number of hold violations
set report_file [open $OutputDirectory/$DesignName.results r]
set count 0
while {[gets $report_file line] != -1} {
	incr count [regexp -all -- $pattern $line]
}
set Number_of_hold_violations $count
close $report_file

#Find number of instances

set pattern {Num of gates}
set report_file [open $OutputDirectory/$DesignName.results r]
while {[gets $report_file line] != -1} {
	if {[regexp $pattern $line]} {
		set instance_count "[lindex [join $line " "] 4 ]"
		break
	} else {
		continue
	}
}
close $report_file

puts "\n"
puts " 					PRELAYOUT TIMING RESULTS "
set formatStr {%10s %10s %10s %10s %10s %10s %10s %10s %10s}

puts [format $formatStr "----------" "-------" "--------------" "---------" "---------" "--------" "--------" "-------" "-------"]
puts [format $formatStr "DesignName" "Runtime" "Instance Count" "WNS Setup" "FEP Setup" "WNS Hold" "FEP Hold" "WNS RAT" "FEP RAT"]
puts [format $formatStr "----------" "-------" "--------------" "---------" "---------" "--------" "--------" "-------" "-------"]
foreach design_name $DesignName runtime $time_elapsed_in_sec instance_count $instance_count wns_setup $worst_negative_setup_slack fep_setup $Number_of_setup_violations wns_hold $worst_negative_hold_slack fep_hold $Number_of_hold_violations wns_rat $worst_RAT_slack fep_rat $Number_output_violations {
puts [format $formatStr $design_name $runtime $instance_count $wns_setup $fep_setup $wns_hold $fep_hold $wns_rat $fep_rat]
}

puts [format $formatStr "----------" "-------" "--------------" "---------" "---------" "--------" "--------" "-------" "-------"]
puts "\n"























