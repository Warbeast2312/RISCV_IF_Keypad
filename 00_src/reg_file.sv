 module reg_file
 #(
 	parameter DATA_WIDTH = 32,
 	parameter ADDR_WIDTH = 5,
 	parameter NUM_REGS = 32
 )
 (	 
 	input logic i_clk,
 	input logic i_rst_n,
 	input logic i_rd_wren,
 	input logic [ADDR_WIDTH-1:0] i_rs1_addr,
 	input logic [ADDR_WIDTH-1:0] i_rs2_addr,
 	input logic [ADDR_WIDTH-1:0] i_rd_addr,
 	input logic [DATA_WIDTH-1:0] i_rd_data,
 	output logic [DATA_WIDTH-1:0] o_rs1_data,
 	output logic [DATA_WIDTH-1:0] o_rs2_data
 );
 	logic [DATA_WIDTH-1:0] ouputdata [1:NUM_REGS-1];
 	logic [DATA_WIDTH-1:0] register_i[1:NUM_REGS-1];
 	logic [DATA_WIDTH-1:0] register_o[0:NUM_REGS-1];
	
	
 	writedata write  (.wren (i_rd_wren), 
 							.addr_i (i_rd_addr),
 							.res (register_o[1:NUM_REGS-1]),
 							.data_i (i_rd_data),
 							.data_o (ouputdata));
 	reset resett   (.rst (i_rst_n),
 						.data_i (ouputdata),
 						.data_o (register_i));
		 
 	reg32 register (.clk (i_clk),  
 						.reg_i (register_i),
 						.reg_o (register_o));	
						
 	readdata read (.addr_i1 (i_rs1_addr),
 						.addr_i2 (i_rs2_addr), 
 						.read_i (register_o), 
 						.data_o1 (o_rs1_data), 
 						.data_o2 (o_rs2_data));					
						
 endmodule


 module writedata (
 	input logic wren,
 	input logic [4:0] addr_i, 
 	input logic [31:0] res[1:31],
 	input logic [31:0] data_i,
 	output logic [31:0] data_o[1:31]
 );
 	logic [0:31] de_o;
	
 	decoder5to32 decoder (addr_i, wren, de_o); 
	
 	genvar k;
 	generate
 		for (k=1; k < 32; k=k+1) begin: mux2to1
 			mux2to1_32bit muxx (res[k] ,data_i, de_o[k], data_o[k]);
 		end
 	endgenerate	

	
 endmodule
	
	
 		module decoder5to32 (
 			 input logic [4:0] in,
 			 input logic en,
 			 output logic [0:31] out
 		);

 			 always_comb begin
 				  if (en) begin
 						case (in) 
 							5'b00000: out = 32'b10000000000000000000000000000000;
 							5'b00001: out = 32'b01000000000000000000000000000000;
 							5'b00010: out = 32'b00100000000000000000000000000000;
 							5'b00011: out = 32'b00010000000000000000000000000000;
 							5'b00100: out = 32'b00001000000000000000000000000000;
 							5'b00101: out = 32'b00000100000000000000000000000000;
 							5'b00110: out = 32'b00000010000000000000000000000000;
 							5'b00111: out = 32'b00000001000000000000000000000000;
 							5'b01000: out = 32'b00000000100000000000000000000000;
 							5'b01001: out = 32'b00000000010000000000000000000000;
 							5'b01010: out = 32'b00000000001000000000000000000000;
 							5'b01011: out = 32'b00000000000100000000000000000000;
 							5'b01100: out = 32'b00000000000010000000000000000000;
 							5'b01101: out = 32'b00000000000001000000000000000000;
 							5'b01110: out = 32'b00000000000000100000000000000000;
 							5'b01111: out = 32'b00000000000000010000000000000000;
 							5'b10000: out = 32'b00000000000000001000000000000000;
 							5'b10001: out = 32'b00000000000000000100000000000000;
 							5'b10010: out = 32'b00000000000000000010000000000000;
 							5'b10011: out = 32'b00000000000000000001000000000000;
 							5'b10100: out = 32'b00000000000000000000100000000000;
 							5'b10101: out = 32'b00000000000000000000010000000000;
 							5'b10110: out = 32'b00000000000000000000001000000000;
 							5'b10111: out = 32'b00000000000000000000000100000000;
 							5'b11000: out = 32'b00000000000000000000000010000000;
 							5'b11001: out = 32'b00000000000000000000000001000000;
 							5'b11010: out = 32'b00000000000000000000000000100000;
 							5'b11011: out = 32'b00000000000000000000000000010000;
 							5'b11100: out = 32'b00000000000000000000000000001000;
 							5'b11101: out = 32'b00000000000000000000000000000100;
 							5'b11110: out = 32'b00000000000000000000000000000010;
 							5'b11111: out = 32'b00000000000000000000000000000001;
 						endcase
 					end else begin	
 						out = 32'b0; 
 					end
 			 end
 		endmodule

 		module mux2to1_32bit (
 			input logic [31:0]in1,
 			input logic [31:0]in2,
 			input logic sel,
 			output logic [31:0]out
 		);

 			always_comb begin
 				case (sel)
 					1'b0: out = in1;
 					1'b1: out = in2;
 				endcase
 			end
			
 		endmodule	
	


 module reset (
 	input logic rst,
 	input logic [31:0] data_i[1:31],
 	output logic [31:0] data_o[1:31]
 );
 	genvar k;
 	generate
 		for (k=1; k < 32; k=k+1) begin: mux2to1_rst
 			mux2to1_rst muxx (rst ,data_i[k], data_o[k]);
 		end
 	endgenerate	
 endmodule


 		module mux2to1_rst (
 			input logic sel,
 			input logic [31:0]in,
 			output logic [31:0]out
 		);
 			always_comb begin 
 				case (sel)
 					1'b0: out = 32'b0;
 					1'b1: out = in;
 				endcase
 			end	
 		endmodule	


 module reg32 (
 	input logic clk,
 	input logic [31:0] reg_i[1:31],
 	output logic [31:0] reg_o[0:31]
 );

 	logic [31:0] register[1:31];
 	integer i;

 	always_ff @(negedge clk) begin
 		for (i = 1; i < 32; i = i + 1) begin
 			register[i] = reg_i[i];
 			reg_o[i] = register[i];
 		end
 			reg_o[0]=0;
 	end
	
 //	initial
 //		begin
 //			$writememh("../30_mem/regfile.data", register);		
 //		end
	
 endmodule




 module readdata (
 	input logic [4:0] addr_i1,
 	input logic [4:0] addr_i2,
 	input logic [31:0] read_i[0:31],
 	output logic [31:0] data_o1,
 	output logic [31:0] data_o2
 );

 	mux32to1_32bit mux1 (read_i,addr_i1,data_o1);
 	mux32to1_32bit mux2 (read_i,addr_i2,data_o2);
	
 endmodule

 		module mux32to1_32bit (
 			 input logic [31:0] in [0:31],  // Input data
 			 input logic [4:0] sel,        //  Choose input data source
 			 output logic [31:0]out              // Output data
 		);
 			 always_comb begin
 				  case (sel)
 						5'b00000: out = in[0];
 						5'b00001: out = in[1];
 						5'b00010: out = in[2];
 						5'b00011: out = in[3];
 						5'b00100: out = in[4];
 						5'b00101: out = in[5];
 						5'b00110: out = in[6];
 						5'b00111: out = in[7];
 						5'b01000: out = in[8];
 						5'b01001: out = in[9];
 						5'b01010: out = in[10];
 						5'b01011: out = in[11];
 						5'b01100: out = in[12];
 						5'b01101: out = in[13];
 						5'b01110: out = in[14];
 						5'b01111: out = in[15];
 						5'b10000: out = in[16];
 						5'b10001: out = in[17];
 						5'b10010: out = in[18];
 						5'b10011: out = in[19];
 						5'b10100: out = in[20];
 						5'b10101: out = in[21];
 						5'b10110: out = in[22];
 						5'b10111: out = in[23];
 						5'b11000: out = in[24];
 						5'b11001: out = in[25];
 						5'b11010: out = in[26];
 						5'b11011: out = in[27];
 						5'b11100: out = in[28];
 						5'b11101: out = in[29];
 						5'b11110: out = in[30];
 						5'b11111: out = in[31];
 				  endcase
 			 end
 		endmodule


//module reg_file(
//	input logic         i_clk,
//	input logic         i_rst_n,
//	input logic [31:0]  i_rd_data,  // Data to be written
//	input logic [4:0]   i_rd_addr,    // Write register selector
//	input logic [4:0]   i_rs1_addr,    // Read register 1 selector
//	input logic [4:0]   i_rs2_addr,    // Read register 2 selector
//	input logic         i_rd_wren,         // Enable for writing to register
//	output logic [31:0] o_rs1_data, // Output data from register i_rs1_addr
//	output logic [31:0] o_rs2_data  // Output data from register i_rs2_addr
//	
//);
//
//	// Define the 32 registers, but leave regfile[0] as a separate case
//	logic [31:0] regfile [31:0];  
//	//logic [31:0] temp; 
//    // Read operation (asynchronous)
//    // Always return 0 for x0, no matter the value in the regfile
//    assign o_rs1_data = (i_rs1_addr == 5'b00000) ? 32'b0 : regfile[i_rs1_addr];
//    assign o_rs2_data = (i_rs2_addr == 5'b00000) ? 32'b0 : regfile[i_rs2_addr];
//
//    // Write operation (synchronous)
//    always_ff @(posedge i_clk or negedge i_rst_n) begin
//        if (!i_rst_n) begin
//            // Reset all registers to 0 except x0, which is always 0 (even without reset)
//            for (int i = 1; i < 32; i = i + 1) begin
//                regfile[i] <= 32'b0;
//            end
//        end else if (i_rd_wren && (i_rd_addr != 5'b00000)) begin
//            // Write to the destination register only if write enable is high and not writing to x0
//            regfile[i_rd_addr] <= i_rd_data;
//        end
//    end
//endmodule