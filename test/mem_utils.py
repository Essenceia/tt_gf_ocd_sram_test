# Copyright Julia Desmazes 2026 (soon to be 2027) 
# all rights reserved
# Permission is explicitly not granted to use this code for any form of AI training

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

SRAM_N = 128

# mem is the golden model, sram is the macro
mem = bytearray(SRAM_N) 
mem_v = bytearray(SRAM_N) 

def rd_mem(addr: byte) -> tuple(byte, bool): 
	assert(addr < SRAM_N) 
	return (mem[addr], bool(mem_v[addr]))

def wr_mem(addr: byte, data: byte) -> tuple(byte, bool): 
	assert(addr < SRAM_N)
	old = mem[addr]
	old_v = bool(mem_v[addr]) 
	mem[addr] = data
	mem_v[addr] = 1

async def wr_sram(dut, addr : byte, data : byte): 
	assert(addr < SRAM_N)
	dut.addr_i.value = addr
	dut.data_i.value = data
	dut.nwen_i.value = 0 
	await ClockCycles(dut.clk, 1) 
	wr_mem(addr, data) 
	dut.nwen_i.value = 1 

async def rd_sram(dut, addr:byte):
	assert(addr < SRAM_N) 
	dut.addr_i.value = addr
	dut.nwen_i.value = 1
	dut.data_i.value = 8*"X"
	await ClockCycles(dut.clk, 1)
	dut.addr_i.value = 7*"X"
	await ClockCycles(dut.clk, 2)
	exp_data, exp_v = rd_mem(addr)
	await ClockCycles(dut.clk, 1)
	if exp_v: 
		assert dut.data_o.value == exp_data, f"Expected {exp_data} got {dut.data_o.value} at addr {addr}"
	


