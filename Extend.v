module Extend( /*TODO: Declare variables of inputs and output for multiplexer*/
	input[23:0] in,
	input[1:0] ImmSrc,
	output reg[31:0] ExtImm
	);
	integer i;
	always @ (*)
	begin
		case(ImmSrc /*TODO: Write on Variable name to distinguish various cases*/)
		/*TODO: Case 1*/ 2'b00:
		begin
			ExtImm[7:0] = in[7:0];
			for(i=8; i<32; i=i+1)
				ExtImm[i] = in[7];
			//TODO: Write actions to run when (Variable) == (Case 1).
		end
		
		/*TODO: Case 2*/ 2'b01:
		begin
			ExtImm[11:0] = in[11:0];
			for(i=12; i<32; i=i+1)
				ExtImm[i] = 'b0;
			//TODO: Write actions to run when (Variable) == (Case 2).
		end
		
		/*TODO: Case 3*/ 2'b10:
		begin
			ExtImm[1:0] = 2'b00;
			ExtImm[25:2] = in[23:0];
			for(i=26; i<32; i=i+1)
				ExtImm[i] = in[23];
			//TODO: Write actions to run when (Variable) == (Case 3).
		end
		
		default:
			//TODO: Assign the default value to output variable
			ExtImm = 'h00000000;
		endcase
	end
 
endmodule
