# MD-11 Electrical System
# Joshua Davidson (it0uchpods)

##############################################
# Copyright (c) Joshua Davidson (it0uchpods) #
##############################################

#############
# Init Vars #
#############

var ac_volt_std = 115;
var ac_volt_min = 110;
var dc_volt_std = 28;
var dc_volt_min = 25;
var dc_amps_std = 150;
var batt_amps = 2;
var ac_hz_std = 400;
var src_ac1 = "XX";
var src_ac2 = "XX";
var src_ac3 = "XX";
var src_dc1 = "XX";
var src_dc2 = "XX";
var src_dc3 = "XX";

var system = 1;
var batt_sw = 0;
var emer_pw_sw = 0; # 0 = OFF, 1 = ARM, 2 = ON
var dc_tie_1_sw = 0;
var dc_tie_3_sw = 0;
var ac_tie_1_sw = 0;
var ac_tie_2_sw = 0;
var ac_tie_3_sw = 0;
var adg_elec_sw = 0;
var cab_bus_sw = 0;
var extg_pwr_sw = 0;
var ext_pwr_sw = 0;
var apu_pwr_sw = 0;
var gen1_sw = 0;
var gen_drive_1_sw = 0;
var gen2_sw = 0;
var gen_drive_2_sw = 0;
var gen3_sw = 0;
var gen_drive_3_sw = 0;
var smoke_elecair_sw = 0;
var battery1_volts = 0;
var battery2_volts = 0;
var battery1_amps = 0;
var battery2_amps = 0;
var battery1_percent = 0;
var battery2_percent = 0;
var battery1_percent_calc = 0;
var battery2_percent_calc = 0;
var dcbat = 0;
var ac1 = 0;
var ac2 = 0;
var ac3 = 0;
var dc1 = 0;
var dc2 = 0;
var dc3 = 0;
var ac_gndsvc = 0;
var dc_gndsvc = 0;
var l_emer_ac = 0;
var l_emer_dc = 0;
var r_emer_ac = 0;
var r_emer_dc = 0;
var replay = 0;
var extpwr_on = 0;
var rpmapu = 0;
var state1 = 0;
var state2 = 0;
var state3 = 0;
var xtie1 = 0;
var xtie2 = 0;
var xtie3 = 0;
var manl = 0;

var ELEC = {
	init: func() {
		setprop("/controls/switches/annun-test", 0);
		setprop("/controls/electrical/switches/battery", 0);
		setprop("/controls/electrical/switches/emer-pw-sw", 0); # 0 = OFF, 1 = ARM, 2 = ON
		setprop("/controls/electrical/switches/dc-tie-1", 1);
		setprop("/controls/electrical/switches/dc-tie-3", 1);
		setprop("/controls/electrical/switches/ac-tie-1", 1);
		setprop("/controls/electrical/switches/ac-tie-2", 1);
		setprop("/controls/electrical/switches/ac-tie-3", 1);
		setprop("/controls/electrical/switches/adg-elec", 0);
		setprop("/controls/electrical/switches/cab-bus", 1);
		setprop("/controls/electrical/switches/extg-pwr", 0);
		setprop("/controls/electrical/switches/ext-pwr", 0);
		setprop("/controls/electrical/switches/apu-pwr", 0);
		setprop("/controls/electrical/switches/gen1", 1);
		setprop("/controls/electrical/switches/gen-drive-1", 1);
		setprop("/controls/electrical/switches/gen2", 1);
		setprop("/controls/electrical/switches/gen-drive-2", 1);
		setprop("/controls/electrical/switches/gen3", 1);
		setprop("/controls/electrical/switches/gen-drive-3", 1);
		setprop("/controls/electrical/switches/smoke-elecair", 0);
		setprop("/controls/electrical/switches/manual-lt", 0);
		setprop("/controls/electrical/switches/manual-flash", 0);
		setprop("/systems/electrical/system", 1); # Automatic
		setprop("/systems/electrical/battery1-volts", 26.5);
		setprop("/systems/electrical/battery2-volts", 26.5);
		setprop("/systems/electrical/battery1-amps", 0);
		setprop("/systems/electrical/battery2-amps", 0);
		setprop("/systems/electrical/battery1-percent", 68);
		setprop("/systems/electrical/battery2-percent", 68);
		setprop("/systems/electrical/bus/dcbat", 0);
		setprop("/systems/electrical/bus/ac1", 0);
		setprop("/systems/electrical/bus/ac2", 0);
		setprop("/systems/electrical/bus/ac3", 0);
		setprop("/systems/electrical/bus/dc1", 0);
		setprop("/systems/electrical/bus/dc2", 0);
		setprop("/systems/electrical/bus/dc3", 0);
		setprop("/systems/electrical/bus/ac-gndsvc", 0);
		setprop("/systems/electrical/bus/dc-gndsvc", 0);
		setprop("/systems/electrical/bus/l-emer-ac", 0);
		setprop("/systems/electrical/bus/l-emer-dc", 0);
		setprop("/systems/electrical/bus/r-emer-ac", 0);
		setprop("/systems/electrical/bus/r-emer-dc", 0);
		setprop("/systems/electrical/light/bat-bus", 0);
		setprop("/systems/electrical/light/emer-pw-off", 0);
		setprop("/systems/electrical/light/emer-pw-on", 0);
		setprop("/systems/electrical/light/l-emer-ac", 0);
		setprop("/systems/electrical/light/l-emer-dc", 0);
		setprop("/systems/electrical/light/ac1", 0);
		setprop("/systems/electrical/light/ac2", 0);
		setprop("/systems/electrical/light/ac3", 0);
		setprop("/systems/electrical/light/dc1", 0);
		setprop("/systems/electrical/light/dc2", 0);
		setprop("/systems/electrical/light/dc3", 0);
		setprop("/systems/electrical/light/ac-gnd", 0);
		setprop("/systems/electrical/light/dc-gnd", 0);
		setprop("/systems/electrical/light/r-emer-ac", 0);
		setprop("/systems/electrical/light/r-emer-dc", 0);
		setprop("/systems/electrical/light/select-manual", 0);
		setprop("/controls/electrical/xtie/xtie1", 0);
		setprop("/controls/electrical/xtie/xtie2", 0);
		setprop("/controls/electrical/xtie/xtie3", 0);
		manualElecLightt.stop();
		# Below are standard FG Electrical stuff to keep things working when the plane is powered
		setprop("/systems/electrical/outputs/adf", 0);
		setprop("/systems/electrical/outputs/audio-panel", 0);
		setprop("/systems/electrical/outputs/audio-panel[1]", 0);
		setprop("/systems/electrical/outputs/autopilot", 0);
		setprop("/systems/electrical/outputs/avionics", 0);
		setprop("/systems/electrical/outputs/avionics-fan", 0);
		setprop("/systems/electrical/outputs/beacon", 0);
		setprop("/systems/electrical/outputs/bus", 0);
		setprop("/systems/electrical/outputs/cabin-lights", 0);
		setprop("/systems/electrical/outputs/dme", 0);
		setprop("/systems/electrical/outputs/efis", 0);
		setprop("/systems/electrical/outputs/flaps", 0);
		setprop("/systems/electrical/outputs/fuel-pump", 0);
		setprop("/systems/electrical/outputs/fuel-pump[1]", 0);
		setprop("/systems/electrical/outputs/gps", 0);
		setprop("/systems/electrical/outputs/gps-mfd", 0);
		setprop("/systems/electrical/outputs/hsi", 0);
		setprop("/systems/electrical/outputs/instr-ignition-switch", 0);
		setprop("/systems/electrical/outputs/instrument-lights", 0);
		setprop("/systems/electrical/outputs/landing-lights", 0);
		setprop("/systems/electrical/outputs/map-lights", 0);
		setprop("/systems/electrical/outputs/mk-viii", 0);
		setprop("/systems/electrical/outputs/nav", 0);
		setprop("/systems/electrical/outputs/nav[1]", 0);
		setprop("/systems/electrical/outputs/nav[2]", 0);
		setprop("/systems/electrical/outputs/nav[3]", 0);
		setprop("/systems/electrical/outputs/pitot-head", 0);
		setprop("/systems/electrical/outputs/stobe-lights", 0);
		setprop("/systems/electrical/outputs/tacan", 0);
		setprop("/systems/electrical/outputs/taxi-lights", 0);
		setprop("/systems/electrical/outputs/transponder", 0);
		setprop("/systems/electrical/outputs/turn-coordinator", 0);
	},
	loop: func() {
		system = getprop("/systems/electrical/system");
		battery1_volts = getprop("/systems/electrical/battery1-volts");
		battery2_volts = getprop("/systems/electrical/battery2-volts");
		battery1_percent = getprop("/systems/electrical/battery1-percent");
		battery2_percent = getprop("/systems/electrical/battery2-percent");
		replay = getprop("/sim/replay/replay-state");
		extpwr_on = getprop("/controls/switches/cart");
		rpmapu = getprop("/systems/apu/n2");
		state1 = getprop("/engines/engine[0]/state");
		state2 = getprop("/engines/engine[1]/state");
		state3 = getprop("/engines/engine[2]/state");
		
		# ESC
		if (system) {
			setprop("/controls/electrical/switches/dc-tie-1", 1);
			setprop("/controls/electrical/switches/dc-tie-3", 1);
			setprop("/controls/electrical/switches/ac-tie-1", 1);
			setprop("/controls/electrical/switches/ac-tie-2", 1);
			setprop("/controls/electrical/switches/ac-tie-3", 1);
			setprop("/controls/electrical/switches/gen1", 1);
			setprop("/controls/electrical/switches/gen2", 1);
			setprop("/controls/electrical/switches/gen3", 1);
		}
		
		batt_sw = getprop("/controls/electrical/switches/battery");
		emer_pw_sw = getprop("/controls/electrical/switches/emer-pw-sw"); # 0 = OFF, 1 = ARM, 2 = ON
		dc_tie_1_sw = getprop("/controls/electrical/switches/dc-tie-1");
		dc_tie_3_sw = getprop("/controls/electrical/switches/dc-tie-3");
		ac_tie_1_sw = getprop("/controls/electrical/switches/ac-tie-1");
		ac_tie_2_sw = getprop("/controls/electrical/switches/ac-tie-2");
		ac_tie_3_sw = getprop("/controls/electrical/switches/ac-tie-3");
		adg_elec_sw = getprop("/controls/electrical/switches/adg-elec");
		cab_bus_sw = getprop("/controls/electrical/switches/cab-bus");
		extg_pwr_sw = getprop("/controls/electrical/switches/extg-pwr");
		ext_pwr_sw = getprop("/controls/electrical/switches/ext-pwr");
		apu_pwr_sw = getprop("/controls/electrical/switches/apu-pwr");
		gen1_sw = getprop("/controls/electrical/switches/gen1");
		gen_drive_1_sw = getprop("/controls/electrical/switches/gen-drive-1");
		gen2_sw = getprop("/controls/electrical/switches/gen2");
		gen_drive_2_sw = getprop("/controls/electrical/switches/gen-drive-2");
		gen3_sw = getprop("/controls/electrical/switches/gen3");
		gen_drive_3_sw = getprop("/controls/electrical/switches/gen-drive-3");
		smoke_elecair_sw = getprop("/controls/electrical/switches/smoke-elecair");
		
		# Bus Tie logic for AC Bus 1
		if (state2 == 3 and gen2_sw and ac_tie_2_sw) {
			setprop("/controls/electrical/xtie/xtie1", 1);
		} else if (state3 == 3 and gen3_sw and ac_tie_3_sw) {
			setprop("/controls/electrical/xtie/xtie1", 1);
		} else if (extpwr_on and ext_pwr_sw) {
			setprop("/controls/electrical/xtie/xtie1", 1);
		} else if (rpmapu >= 94.9 and apu_pwr_sw and (ac_tie_2_sw or ac_tie_3_sw)) {
			setprop("/controls/electrical/xtie/xtie1", 1);
		} else {
			setprop("/controls/electrical/xtie/xtie1", 0);
		}
		
		# Bus Tie logic for AC Bus 2
		if (state1 == 3 and gen1_sw and ac_tie_1_sw) {
			setprop("/controls/electrical/xtie/xtie2", 1);
		} else if (state3 == 3 and gen3_sw and ac_tie_3_sw) {
			setprop("/controls/electrical/xtie/xtie2", 1);
		} else if (extpwr_on and ext_pwr_sw) {
			setprop("/controls/electrical/xtie/xtie2", 1);
		} else if (rpmapu >= 94.9 and apu_pwr_sw and (ac_tie_1_sw or ac_tie_3_sw)) {
			setprop("/controls/electrical/xtie/xtie2", 1);
		} else {
			setprop("/controls/electrical/xtie/xtie2", 0);
		}
		
		# Bus Tie logic for AC Bus 3
		if (state1 == 3 and gen1_sw and ac_tie_1_sw) {
			setprop("/controls/electrical/xtie/xtie3", 1);
		} else if (state2 == 3 and gen2_sw and ac_tie_2_sw) {
			setprop("/controls/electrical/xtie/xtie3", 1);
		} else if (extpwr_on and ext_pwr_sw) {
			setprop("/controls/electrical/xtie/xtie3", 1);
		} else if (rpmapu >= 94.9 and apu_pwr_sw and (ac_tie_1_sw or ac_tie_2_sw)) {
			setprop("/controls/electrical/xtie/xtie3", 1);
		} else {
			setprop("/controls/electrical/xtie/xtie3", 0);
		}
		
		xtie1 = getprop("/controls/electrical/xtie/xtie1");
		xtie2 = getprop("/controls/electrical/xtie/xtie2");
		xtie3 = getprop("/controls/electrical/xtie/xtie3");
		
		# AC Bus 1
		if (state1 == 3 and gen1_sw) {
			src_ac1 = "ENG";
			setprop("/systems/electrical/bus/ac1", ac_volt_std);
		} else if (rpmapu >= 94.9 and apu_pwr_sw) {
			src_ac1 = "APU";
			setprop("/systems/electrical/bus/ac1", ac_volt_std);
		} else if (ac_tie_1_sw == 1 and xtie1) {
			src_ac1 = "XTIE";
			setprop("/systems/electrical/bus/ac1", ac_volt_std);
		} else {
			src_ac1 = "XX";
			setprop("/systems/electrical/bus/ac1", 0);
		}
		
		# AC Bus 2
		if (state2 == 3 and gen2_sw) {
			src_ac2 = "ENG";
			setprop("/systems/electrical/bus/ac2", ac_volt_std);
		} else if (rpmapu >= 94.9 and apu_pwr_sw) {
			src_ac2 = "APU";
			setprop("/systems/electrical/bus/ac2", ac_volt_std);
		} else if (ac_tie_2_sw == 1 and xtie2) {
			src_ac2 = "XTIE";
			setprop("/systems/electrical/bus/ac2", ac_volt_std);
		} else {
			src_ac2 = "XX";
			setprop("/systems/electrical/bus/ac2", 0);
		}
		
		# AC Bus 3
		if (state3 == 3 and gen3_sw) {
			src_ac3 = "ENG";
			setprop("/systems/electrical/bus/ac3", ac_volt_std);
		} else if (rpmapu >= 94.9 and apu_pwr_sw) {
			src_ac3 = "APU";
			setprop("/systems/electrical/bus/ac3", ac_volt_std);
		} else if (ac_tie_3_sw == 1 and xtie3) {
			src_ac3 = "XTIE";
			setprop("/systems/electrical/bus/ac3", ac_volt_std);
		} else {
			src_ac3 = "XX";
			setprop("/systems/electrical/bus/ac3", 0);
		}
		
		ac1 = getprop("/systems/electrical/bus/ac1");
		ac2 = getprop("/systems/electrical/bus/ac2");
		ac3 = getprop("/systems/electrical/bus/ac3");
		dc2 = getprop("/systems/electrical/bus/dc2");
		dc3 = getprop("/systems/electrical/bus/dc3");
		
		# Emergency Power and Emergency Buses
		if (emer_pw_sw == 1 and batt_sw) { # ARM
			setprop("/systems/electrical/bus/l-emer-ac", ac_volt_std);
			setprop("/systems/electrical/bus/l-emer-dc", dc_volt_std);
			if (ac3 >= 110) {
				setprop("/systems/electrical/bus/r-emer-ac", ac_volt_std);
				setprop("/systems/electrical/bus/r-emer-dc", dc_volt_std);
			} else {
				setprop("/systems/electrical/bus/r-emer-ac", 0);
				setprop("/systems/electrical/bus/r-emer-dc", 0);
			}
		} else if (emer_pw_sw == 2 and batt_sw) { # ON
			setprop("/systems/electrical/bus/l-emer-ac", ac_volt_std);
			setprop("/systems/electrical/bus/l-emer-dc", dc_volt_std);
			if (ac3 >= 110) {
				setprop("/systems/electrical/bus/r-emer-ac", ac_volt_std);
				setprop("/systems/electrical/bus/r-emer-dc", dc_volt_std);
			} else {
				setprop("/systems/electrical/bus/r-emer-ac", 0);
				setprop("/systems/electrical/bus/r-emer-dc", 0);
			}
		} else {
			if (ac1 >= 110) {
				setprop("/systems/electrical/bus/l-emer-ac", ac_volt_std);
				setprop("/systems/electrical/bus/l-emer-dc", dc_volt_std);
			} else {
				setprop("/systems/electrical/bus/l-emer-ac", 0);
				setprop("/systems/electrical/bus/l-emer-dc", 0);
			}
			if (ac3 >= 110) {
				setprop("/systems/electrical/bus/r-emer-ac", ac_volt_std);
				setprop("/systems/electrical/bus/r-emer-dc", dc_volt_std);
			} else {
				setprop("/systems/electrical/bus/r-emer-ac", 0);
				setprop("/systems/electrical/bus/r-emer-dc", 0);
			}
		}
		
		l_emer_ac = getprop("/systems/electrical/bus/l-emer-ac");
		l_emer_dc = getprop("/systems/electrical/bus/l-emer-dc");
		r_emer_ac = getprop("/systems/electrical/bus/r-emer-ac");
		r_emer_dc = getprop("/systems/electrical/bus/r-emer-dc");
		
		# Cabin/Ground Service Buses
		if (ac2 >= 110 and cab_bus_sw) {
			setprop("/systems/electrical/bus/ac-gndsvc", ac_volt_std);
			setprop("/systems/electrical/bus/dc-gndsvc", dc_volt_std);
		} else {
			setprop("/systems/electrical/bus/ac-gndsvc", 0);
			setprop("/systems/electrical/bus/dc-gndsvc", 0);
		}
		
		ac_gndsvc = getprop("/systems/electrical/bus/ac-gndsvc");
		dc_gndsvc = getprop("/systems/electrical/bus/dc-gndsvc");
		
		# DC Bus 1
		if (ac1 >= 110) {
			src_dc1 = "AC";
			setprop("/systems/electrical/bus/dc1", dc_volt_std);
		} else if (dc2 >= 25 and src_dc2 != "XTIE") {
			src_dc1 = "XTIE";
			setprop("/systems/electrical/bus/dc1", dc_volt_std);
		} else if (dc3 >= 25 and dc_tie_3_sw and src_dc3 != "XTIE") {
			src_dc1 = "XTIE";
			setprop("/systems/electrical/bus/dc1", dc_volt_std);
		} else {
			src_dc1 = "XX";
			setprop("/systems/electrical/bus/dc1", 0);
		}
		
		dc1 = getprop("/systems/electrical/bus/dc1");
		
		# DC Bus 2
		if (ac2 >= 110) {
			src_dc2 = "AC";
			setprop("/systems/electrical/bus/dc2", dc_volt_std);
		} else if (dc1 >= 25 and dc_tie_1_sw and src_dc1 != "XTIE") {
			src_dc2 = "XTIE";
			setprop("/systems/electrical/bus/dc2", dc_volt_std);
		} else if (dc3 >= 25 and dc_tie_3_sw and src_dc3 != "XTIE") {
			src_dc2 = "XTIE";
			setprop("/systems/electrical/bus/dc2", dc_volt_std);
		} else {
			src_dc2 = "XX";
			setprop("/systems/electrical/bus/dc2", 0);
		}
		
		dc2 = getprop("/systems/electrical/bus/dc2");
		
		# DC Bus 3
		if (ac3 >= 110) {
			src_dc3 = "AC";
			setprop("/systems/electrical/bus/dc3", dc_volt_std);
		} else if (dc2 >= 25 and src_dc2 != "XTIE") {
			src_dc3 = "XTIE";
			setprop("/systems/electrical/bus/dc3", dc_volt_std);
		} else if (dc1 >= 25 and dc_tie_1_sw and src_dc1 != "XTIE") {
			src_dc3 = "XTIE";
			setprop("/systems/electrical/bus/dc3", dc_volt_std);
		} else {
			src_dc3 = "XX";
			setprop("/systems/electrical/bus/dc3", 0);
		}
		
		dc3 = getprop("/systems/electrical/bus/dc3");
		
		# Battery Amps
		if (battery1_volts >= 20 and batt_sw) {
			setprop("/systems/electrical/battery1-amps", batt_amps);
		} else {
			setprop("/systems/electrical/battery1-amps", 0);
		}
		
		if (battery2_volts >= 20 and batt_sw) {
			setprop("/systems/electrical/battery2-amps", batt_amps);
		} else {
			setprop("/systems/electrical/battery2-amps", 0);
		}
		
		battery1_amps = getprop("/systems/electrical/battery1-amps");
		battery2_amps = getprop("/systems/electrical/battery2-amps");
		
		# Battery Bus
		if (battery1_amps > 0 or battery2_amps > 0) {
			setprop("/systems/electrical/bus/dcbat", dc_volt_std);
		} else if (dc_gndsvc >= 25) {
			setprop("/systems/electrical/bus/dcbat", dc_volt_std);
		} else {
			setprop("/systems/electrical/bus/dcbat", 0);
		}
		
		dcbat = getprop("/systems/electrical/bus/dcbat");
		
		# Battery Charging/Decharging
		if (battery1_percent < 100 and (ac_gndsvc >= 110 or r_emer_ac >= 110) and batt_sw) {
			if (getprop("/systems/electrical/battery1-time") + 5 < getprop("/sim/time/elapsed-sec")) {
				battery1_percent_calc = battery1_percent + 0.75; # Roughly 90 percent every 10 mins
				if (battery1_percent_calc > 100) {
					battery1_percent_calc = 100;
				}
				setprop("/systems/electrical/battery1-percent", battery1_percent_calc);
				setprop("/systems/electrical/battery1-time", getprop("/sim/time/elapsed-sec"));
			}
		} else if (battery1_percent == 100 and (ac_gndsvc >= 110 or r_emer_ac >= 110) and batt_sw) {
			setprop("/systems/electrical/battery1-time", getprop("/sim/time/elapsed-sec"));
		} else if (battery1_amps > 0 and batt_sw) {
			if (getprop("/systems/electrical/battery1-time") + 5 < getprop("/sim/time/elapsed-sec")) {
				battery1_percent_calc = battery1_percent - 0.25; # Roughly 90 percent every 30 mins
				if (battery1_percent_calc < 0) {
					battery1_percent_calc = 0;
				}
				setprop("/systems/electrical/battery1-percent", battery1_percent_calc);
				setprop("/systems/electrical/battery1-time", getprop("/sim/time/elapsed-sec"));
			}
		} else {
			setprop("/systems/electrical/battery1-time", getprop("/sim/time/elapsed-sec"));
		}
		
		if (battery2_percent < 100 and (ac_gndsvc >= 110 or r_emer_ac >= 110) and batt_sw) {
			if (getprop("/systems/electrical/battery2-time") + 5 < getprop("/sim/time/elapsed-sec")) {
				battery2_percent_calc = battery2_percent + 0.75; # Roughly 90 percent every 10 mins
				if (battery2_percent_calc > 100) {
					battery2_percent_calc = 100;
				}
				setprop("/systems/electrical/battery2-percent", battery2_percent_calc);
				setprop("/systems/electrical/battery2-time", getprop("/sim/time/elapsed-sec"));
			}
		} else if (battery2_percent == 100 and (ac_gndsvc >= 110 or r_emer_ac >= 110) and batt_sw) {
			setprop("/systems/electrical/battery2-time", getprop("/sim/time/elapsed-sec"));
		} else if (battery2_amps > 0 and batt_sw) {
			if (getprop("/systems/electrical/battery2-time") + 5 < getprop("/sim/time/elapsed-sec")) {
				battery2_percent_calc = battery2_percent - 0.25; # Roughly 90 percent every 30 mins
				if (battery2_percent_calc < 0) {
					battery2_percent_calc = 0;
				}
				setprop("/systems/electrical/battery2-percent", battery2_percent_calc);
				setprop("/systems/electrical/battery2-time", getprop("/sim/time/elapsed-sec"));
			}
		} else {
			setprop("/systems/electrical/battery2-time", getprop("/sim/time/elapsed-sec"));
		}
		
		battery1_percent = getprop("/systems/electrical/battery1-percent");
		battery2_percent = getprop("/systems/electrical/battery2-percent");
		
		if (battery1_percent >= 10) {
			setprop("/systems/electrical/battery1-volts", math.clamp(24 + (battery1_percent - 10) * (27.9 - 24) / (100 - 10), 24, 27.9));
		} else {
			setprop("/systems/electrical/battery1-volts", math.clamp(battery1_percent * (24) / (10), 0, 24));
		}
		
		if (battery2_percent >= 10) {
			setprop("/systems/electrical/battery2-volts", math.clamp(24 + (battery2_percent - 10) * (27.9 - 24) / (100 - 10), 24, 30));
		} else {
			setprop("/systems/electrical/battery2-volts", math.clamp(battery2_percent * (24) / (10), 0, 24));
		}
		
		# Generic FG Electrical Properties
		if (dc1 < 25 and dc2 < 25 and dc3 < 25) {
			if (getprop("/it-autoflight/output/ap1") == 1) {
				setprop("/it-autoflight/input/ap1", 0);
			}
			if (getprop("/it-autoflight/output/ap2") == 1) {
				setprop("/it-autoflight/input/ap2", 0);
			}
			setprop("/systems/electrical/outputs/adf", 0);
			setprop("/systems/electrical/outputs/audio-panel", 0);
			setprop("/systems/electrical/outputs/audio-panel[1]", 0);
			setprop("/systems/electrical/outputs/autopilot", 0);
			setprop("/systems/electrical/outputs/avionics", 0);
			setprop("/systems/electrical/outputs/avionics-fan", 0);
			setprop("/systems/electrical/outputs/beacon", 0);
			setprop("/systems/electrical/outputs/bus", 0);
			setprop("/systems/electrical/outputs/cabin-lights", 0);
			setprop("/systems/electrical/outputs/dme", 0);
			setprop("/systems/electrical/outputs/efis", 0);
			setprop("/systems/electrical/outputs/flaps", 0);
			setprop("/systems/electrical/outputs/fuel-pump", 0);
			setprop("/systems/electrical/outputs/fuel-pump[1]", 0);
			setprop("/systems/electrical/outputs/gps", 0);
			setprop("/systems/electrical/outputs/gps-mfd", 0);
			setprop("/systems/electrical/outputs/hsi", 0);
			setprop("/systems/electrical/outputs/instr-ignition-switch", 0);
			setprop("/systems/electrical/outputs/instrument-lights", 0);
			setprop("/systems/electrical/outputs/landing-lights", 0);
			setprop("/systems/electrical/outputs/map-lights", 0);
			setprop("/systems/electrical/outputs/mk-viii", 0);
			setprop("/systems/electrical/outputs/nav", 0);
			setprop("/systems/electrical/outputs/nav[1]", 0);
			setprop("/systems/electrical/outputs/nav[2]", 0);
			setprop("/systems/electrical/outputs/nav[3]", 0);
			setprop("/systems/electrical/outputs/pitot-head", 0);
			setprop("/systems/electrical/outputs/stobe-lights", 0);
			setprop("/systems/electrical/outputs/tacan", 0);
			setprop("/systems/electrical/outputs/taxi-lights", 0);
			setprop("/systems/electrical/outputs/transponder", 0);
			setprop("/systems/electrical/outputs/turn-coordinator", 0);
		} else {
			setprop("/systems/electrical/outputs/adf", dc_volt_std);
			setprop("/systems/electrical/outputs/audio-panel", dc_volt_std);
			setprop("/systems/electrical/outputs/audio-panel[1]", dc_volt_std);
			setprop("/systems/electrical/outputs/autopilot", dc_volt_std);
			setprop("/systems/electrical/outputs/avionics", dc_volt_std);
			setprop("/systems/electrical/outputs/avionics-fan", dc_volt_std);
			setprop("/systems/electrical/outputs/beacon", dc_volt_std);
			setprop("/systems/electrical/outputs/bus", dc_volt_std);
			setprop("/systems/electrical/outputs/cabin-lights", dc_volt_std);
			setprop("/systems/electrical/outputs/dme", dc_volt_std);
			setprop("/systems/electrical/outputs/efis", dc_volt_std);
			setprop("/systems/electrical/outputs/flaps", dc_volt_std);
			setprop("/systems/electrical/outputs/fuel-pump", dc_volt_std);
			setprop("/systems/electrical/outputs/fuel-pump[1]", dc_volt_std);
			setprop("/systems/electrical/outputs/gps", dc_volt_std);
			setprop("/systems/electrical/outputs/gps-mfd", dc_volt_std);
			setprop("/systems/electrical/outputs/hsi", dc_volt_std);
			setprop("/systems/electrical/outputs/instr-ignition-switch", dc_volt_std);
			setprop("/systems/electrical/outputs/instrument-lights", dc_volt_std);
			setprop("/systems/electrical/outputs/landing-lights", dc_volt_std);
			setprop("/systems/electrical/outputs/map-lights", dc_volt_std);
			setprop("/systems/electrical/outputs/mk-viii", dc_volt_std);
			setprop("/systems/electrical/outputs/nav", dc_volt_std);
			setprop("/systems/electrical/outputs/nav[1]", dc_volt_std);
			setprop("/systems/electrical/outputs/nav[2]", dc_volt_std);
			setprop("/systems/electrical/outputs/nav[3]", dc_volt_std);
			setprop("/systems/electrical/outputs/pitot-head", dc_volt_std);
			setprop("/systems/electrical/outputs/stobe-lights", dc_volt_std);
			setprop("/systems/electrical/outputs/tacan", dc_volt_std);
			setprop("/systems/electrical/outputs/taxi-lights", dc_volt_std);
			setprop("/systems/electrical/outputs/transponder", dc_volt_std);
			setprop("/systems/electrical/outputs/turn-coordinator", dc_volt_std);
		}
		
		# Lights
		if (emer_pw_sw == 0) {
			setprop("/systems/electrical/light/emer-pw-off", 1);
		} else {
			setprop("/systems/electrical/light/emer-pw-off", 0);
		}
		
		if (emer_pw_sw == 1 and (ac1 < 110 or dc1 < 25)) {
			setprop("/systems/electrical/light/emer-pw-on", 1);
		} else if (emer_pw_sw == 2) {
			setprop("/systems/electrical/light/emer-pw-on", 1);
		} else {
			setprop("/systems/electrical/light/emer-pw-on", 0);
		}
		
		if (dcbat < 25) {
			setprop("/systems/electrical/light/bat-bus", 1);
		} else {
			setprop("/systems/electrical/light/bat-bus", 0);
		}
		
		if (l_emer_dc < 25) {
			setprop("/systems/electrical/light/l-emer-dc", 1);
		} else {
			setprop("/systems/electrical/light/l-emer-dc", 0);
		}
		
		if (dc1 < 25) {
			setprop("/systems/electrical/light/dc1", 1);
		} else {
			setprop("/systems/electrical/light/dc1", 0);
		}
		
		if (dc2 < 25) {
			setprop("/systems/electrical/light/dc2", 1);
		} else {
			setprop("/systems/electrical/light/dc2", 0);
		}
		
		if (dc_gndsvc < 25) {
			setprop("/systems/electrical/light/dc-gnd", 1);
		} else {
			setprop("/systems/electrical/light/dc-gnd", 0);
		}
		
		if (dc3 < 25) {
			setprop("/systems/electrical/light/dc3", 1);
		} else {
			setprop("/systems/electrical/light/dc3", 0);
		}
		
		if (r_emer_dc < 25) {
			setprop("/systems/electrical/light/r-emer-dc", 1);
		} else {
			setprop("/systems/electrical/light/r-emer-dc", 0);
		}
		
		if (l_emer_ac < 110) {
			setprop("/systems/electrical/light/l-emer-ac", 1);
		} else {
			setprop("/systems/electrical/light/l-emer-ac", 0);
		}
		
		if (ac1 < 110) {
			setprop("/systems/electrical/light/ac1", 1);
		} else {
			setprop("/systems/electrical/light/ac1", 0);
		}
		
		if (ac2 < 110) {
			setprop("/systems/electrical/light/ac2", 1);
		} else {
			setprop("/systems/electrical/light/ac2", 0);
		}
		
		if (ac_gndsvc < 110) {
			setprop("/systems/electrical/light/ac-gnd", 1);
		} else {
			setprop("/systems/electrical/light/ac-gnd", 0);
		}
		
		if (ac3 < 110) {
			setprop("/systems/electrical/light/ac3", 1);
		} else {
			setprop("/systems/electrical/light/ac3", 0);
		}
		
		if (r_emer_ac < 110) {
			setprop("/systems/electrical/light/r-emer-ac", 1);
		} else {
			setprop("/systems/electrical/light/r-emer-ac", 0);
		}
	},
	systemMode: func() {
		system = getprop("/systems/electrical/system");
		if (system) {
			setprop("/systems/electrical/system", 0);
			setprop("/controls/electrical/switches/manual-lt", 1);
		} else {
			setprop("/systems/electrical/system", 1);
			setprop("/controls/electrical/switches/manual-lt", 0);
		}
	},
	manualLight: func() {
		manl = getprop("/controls/electrical/switches/manual-flash");
		system = getprop("/systems/electrical/system");
		if (manl >= 5 or !system) {
			manualElecLightt.stop();
			setprop("/controls/electrical/switches/manual-flash", 0);
		} else {
			setprop("/controls/electrical/switches/manual-flash", manl + 1);
		}
	},
};

var manualElecLightt = maketimer(0.4, ELEC.manualLight);
