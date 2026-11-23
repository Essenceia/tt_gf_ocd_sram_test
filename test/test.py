# Copyright Julia Desmazes 2026 (soon 2027) 
# SPDX-License-Identifier: Apache-2.0

import os
import time 
import random 

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

CLK_UNIT="ns"
CLK_PERIOD=20

def set_random_seed():
	if "SEED" in os.environ:
		seed = int(os.environ["SEED"].lower().strip())
	else:
		seed = time.time_ns()
	cocotb.log.info(f"random seed {seed}")
	random.seed(seed)

def start_clk(dut):
	clock = Clock(dut.clk, CLK_PERIOD, CLK_UNIT)
	clk_task = cocotb.start_soon(clock.start()) #runs the clock "in the background" 
	return clk_task

# Reset sequence
async def rst(dut, ena=1 ):
	dut.rst_n.value = 0
	clk_task = start_clk(dut)
	await ClockCycles(dut.clk, 5)
	dut.rst_n.value = 1
	dut.ena.value = 0
	await ClockCycles(dut.clk, 1)
	dut.ena.value = 1
	await ClockCycles(dut.clk, 5)

# Simple test 
@cocotb.test()
async def simple_rst_test(dut):
	set_random_seed()
	await rst(dut) 
	await ClockCycles(dut.clk, 10)
