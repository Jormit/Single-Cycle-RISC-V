`timescale 1ns/1ps

module riscv_core_tb;
    reg clock;
    reg reset;

    wire [31:0] bus_address;
    wire [31:0] bus_write_data;
    wire [31:0] bus_read_data;
    wire bus_write;
    wire bus_read;
    wire [31:0] inst;
    wire [31:0] pc;

    riscv_core riscv_core_instance (
        .clock(clock),
        .reset(reset),
        .bus_address(bus_address),
        .bus_write_data(bus_write_data),
        .bus_read_data(bus_read_data),
        .bus_write(bus_write),
        .bus_read(bus_read),
        .inst(inst),
        .pc(pc)
    );

    ram ram_instance(
        .clock(clock),
        .write(bus_write),
        .write_data(bus_write_data),
        .address(bus_address),
        .data(bus_read_data)
    );

    rom #(
        .SIZE(10)
    ) rom_instance(
        .address(pc),
        .data(inst)
    );

    integer i;

    initial begin
        reset = 0;
        clock = 0;
        #1
        reset = 1;
        #1
        reset = 0;
        
        for (i = 0; i < 10; i = i + 1) begin
            #1
            clock = 1;
            #1
            clock = 0;
        end
    end
    
    
endmodule

