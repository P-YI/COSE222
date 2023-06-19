module RegisterFile(
	input clk, 
	input reset, 
	/*TODO: Declare input and output parameters in order to write & read register*/
	input we,
	input[1:0] RegSrc,
	input[3:0] addr1,
	input[3:0] addr2,
	input[3:0] addr3,
	input[3:0] waddr,
	input[31:0] wdata,
	input[31:0] pcin,
	output reg[31:0] data1,
	output reg[31:0] data2,
	output reg[31:0] data3,
	output[31:0] pcout
	);
	
	reg[31:0] registers[15:0];
	integer idx;
	assign pcout = registers[15];
	
	//Write to register file
	always @ (negedge clk)
	begin
		if (reset)
		begin
			/*TODO: Write actions when reset button is clicked*/
			for(idx=0; idx<=15; idx=idx+1) begin
				registers[idx] = 'h00000000;
			end
		end
		
		else //When reset button isn't clicked,
		begin
			if(/*TODO: Condition 1*/ we)
			begin
				if(RegSrc[0] != 1'b1)
					registers[waddr] = wdata;
				else
					registers[14] = registers[15] + 'd4;
				//TODO: Write actions to run when the Condition 1 is met
			end
			
			if(/*TODO: Condition 2*/ waddr != 4'b1111 || RegSrc[0] == 1'b1)
				registers[15] = pcin;
				//TODO: Write action to run when the Condition 2 is met
		end
	end
	
	//Read from register file
	always @ (posedge clk)
	begin
		if (reset)
		begin
			data1 <= 'h00000000;
			data2 <= 'h00000000;
			//TODO: Write actions when reset button is clicked
		end
		
		else 
		begin
			if(/*TODO: Condition 3*/ addr1 == 15)
			begin
				data1 = registers[15] + 32'd8;
				//TODO: Write actions to run when the Condition 3 is met
			end
			else
			begin
				data1 = registers[addr1];
				//TODO: Write actions to run when the Condition 3 is NOT met
			end
			
			if(/*TODO: Condition 4*/ addr2 == 15)
			begin
				data2 = registers[15] + 32'd8;
				//TODO: Write actions to run when the Condition 4 is met
			end
			else
			begin
				//TODO: Write actions to run when the Condition 4 is NOT met
				if (/*TODO: Condition 5*/ RegSrc[1] == 1'b0)
					data2 = registers[addr2];
					//TODO: Write actions to run when the Condition 5 is met
				else
					data2 = registers[waddr];
					//TODO: Write actions to run when the Condition 5 is NOT met
			end
			if(/*Condition 6*/ addr3 == 15)
			begin
				data3 = registers[15] + 32'd8;
				//TODO: Write actions to run when the Condition 6 is met
			end
			else
			begin
				data3 = registers[addr3];
				//TODO: Write actions to run when the Condition 6 is NOT met
			end
		end
	end
			
endmodule
