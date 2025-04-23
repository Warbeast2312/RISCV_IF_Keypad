module ID_EX(
	// Input
	input logic i_clk, i_rst_n,
		// Data
	input logic [31:0] instr_i,
	input logic [31:0] pc_i,
	input logic [31:0] rs1_data_i, rs2_data_i,
	input logic [31:0] imm_i,
	
	input logic [31:0] rs1_f_i, rs2_f_i,	
		// Hazard
	input logic [1:0] sel_i,
		// Control Unit
			// EX
	input logic [4:0] alu_op_i,
	input logic op_a_i, op_b_i,
	input logic br_sel_i, br_unsigned_i,
			// MEM
	input logic mem_wren_i,
	input logic [2:0] func_i,
	
	input logic lsu_sel_i,
			// WB
	input logic [4:0] rd_addr_i,
	input logic rd_wren_I_i, rd_wren_F_i,
	input logic [2:0] wb_sel_i,
	
	input logic Reg_sel_i,
	
	// Output
		// Data
	output logic [31:0] instr_o,
	output logic [31:0] pc_o,
	output logic [31:0] rs1_data_o, rs2_data_o,
	output logic [31:0] imm_o,
	
	output logic [31:0] rs1_f_o, rs2_f_o,	
		// Control Unit
			// EX
	output logic [4:0] alu_op_o,
	output logic op_a_o, op_b_o,
	output logic br_sel_o, br_unsigned_o,
			// MEM
	output logic mem_wren_o,
	output logic [2:0] func_o,
	
	output logic lsu_sel_o,	
			// WB
	output logic [4:0] rd_addr_o,
	output logic rd_wren_I_o, rd_wren_F_o,
	output logic [2:0] wb_sel_o,
	
	output logic Reg_sel_o
);

// EX:
logic [8:0] EX_i, EX_o;
assign EX_i = {alu_op_i, op_a_i, op_b_i, br_sel_i, br_unsigned_i};
assign {alu_op_o, op_a_o, op_b_o, br_sel_o, br_unsigned_o} = EX_o; 

// MEM
logic [4:0] M_i, M_o;
assign M_i = {mem_wren_i, func_i, lsu_sel_i};
assign {mem_wren_o, func_o, lsu_sel_o} = M_o;

// WB
logic [10:0] WB_i, WB_o;
assign WB_i = {rd_addr_i, rd_wren_I_i, rd_wren_F_i, wb_sel_i, Reg_sel_i};
assign {rd_addr_o, rd_wren_I_o, rd_wren_F_o, wb_sel_o, Reg_sel_o} = WB_o;

always_ff @(posedge i_clk) begin
	if (!i_rst_n) begin							// Negative reset
		instr_o <= 0;
		pc_o <= 0;
		rs1_data_o <= 0;
		rs2_data_o <= 0;
		imm_o <= 0;
		
		rs1_f_o <= 0;
		rs2_f_o <= 0;
		
		EX_o <= 0;
		M_o <= 0;
		WB_o <= 0;
	end
	else if (sel_i == 2'b11) begin			// Hazard: Clear
		instr_o <= 0;
		pc_o <= 0;
		rs1_data_o <= 0;
		rs2_data_o <= 0;
		imm_o <= 0;
		
		rs1_f_o <= 0;
		rs2_f_o <= 0;		
		
		EX_o <= 0;
		M_o <= 0;
		WB_o <= 0;
	end 
	else if (sel_i == 2'b00) begin				// Normal - Not stall
		instr_o <= instr_i;
		pc_o <= pc_i;
		rs1_data_o <= rs1_data_i;
		rs2_data_o <= rs2_data_i;
		imm_o <= imm_i;
		
		rs1_f_o <= rs1_f_i;
		rs2_f_o <= rs1_f_i;		
		
		EX_o <= EX_i;
		M_o <= M_i;
		WB_o <= WB_i;
	end												// Final case: Stall
end

endmodule: ID_EX