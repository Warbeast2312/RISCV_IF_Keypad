module final_select_fpu (
    input logic [31:0]  fpu_add_result, fpu_mul_result, 
	//input logic [31:0]  fpu_div_result,
    input logic [1:0] op_sel_F,
    output logic [31:0] result_fpu



);


always_comb begin
    case (op_sel_F)
        2'b00: result_fpu = fpu_add_result; //add
        2'b01: result_fpu = fpu_add_result; //sub
        2'b10: result_fpu = fpu_mul_result; //mul
        //2'b11: result_fpu = fpu_div_result; //div

    default: result_fpu = 32'b0;

    endcase


end

endmodule