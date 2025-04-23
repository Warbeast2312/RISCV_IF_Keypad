module fpu_top (
    input logic [31:0] i_rs1_f,
	input logic [31:0] i_rs2_f,	
	input logic [4:0]  i_alu_op,
	output logic [31:0] o_fpu_data



);

logic [1:0]  op_sel_F; //for final select
logic		 sub_sign; //sub sign for add sub float

logic [31:0] fpu_add_result; //temp result before final select
logic [31:0] fpu_mul_result; //temp result before final select
logic [31:0] fpu_div_result; //temp result before final select



always_comb begin
	case (i_alu_op) 			
		5'b01010:	op_sel_F = 2'b00; //fadd
		5'b01011:	op_sel_F = 2'b01; //fsub
		5'b01100:	op_sel_F = 2'b10; //fmul
		5'b01101:	op_sel_F = 2'b11; //fdiv
		default:    op_sel_F = 2'b00;
	endcase

	case (op_sel_F)
		2'b00:   	sub_sign = 1'b0;
		2'b01:		sub_sign = 1'b1;
		default:    sub_sign = 1'b0;
	endcase   

end

fpu_add fpu_add_block (
	.sub 	(sub_sign),
	.x		(i_rs1_f),
	.y		(i_rs2_f),
	.out	(fpu_add_result)

);




fpu_mul fpu_mul_block (
	.x		(i_rs1_f),
	.y		(i_rs2_f),
	.out	(fpu_mul_result)

);


//fpu_div fpu_div_block (
//	.x		(i_rs1_f),
//	.y		(i_rs2_f),
//	.out	(fpu_div_result)

//);


// fpu_comp fpu_comp_block (


// );


final_select_fpu	final_select_mux (
	.fpu_add_result		(fpu_add_result),
	.fpu_mul_result		(fpu_mul_result),
	//.fpu_div_result		(fpu_div_result),
	.op_sel_F			(op_sel_F),
	.result_fpu			(o_fpu_data)



);

endmodule