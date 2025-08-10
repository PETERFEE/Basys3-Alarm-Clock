library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;




entity top is
    Port ( data_in : in STD_LOGIC_VECTOR (6 downto 0);
				hex_1out : out std_logic_vector(6 downto 0);
			  hex_2out : out std_logic_vector(6 downto 0)
			  );
           
end top;




architecture Behavioral of top is

	signal hex1_s, hex2_s : std_logic_vector(3 downto 0);
	signal data_s : unsigned(6 downto 0);


begin


    U_HEX0 : entity work.sevensegment
        port map(
                NUMBER => hex1_s,
				HEX0 => hex_1out
            );

    U_HEX1 : entity work.sevensegment
        port map(
                NUMBER => hex2_s,
				HEX0 => hex_2out
            );


	--combinational logic for processing hex parts
	process(data_s) is
	   --variable value1, value2 : integer := 0;
	begin
	   hex1_s <= (others => '0');
	   hex2_s <= (others => '0');
        
        --check to see if we are out of range
        if(data_s > 99) then
            hex1_s <= (others => 'U');
            hex2_s <= (others => 'U');
	
	--do math to split the 2 digit number into 2 separate digits
        else
            
	    --code here
            ...
            ...
            hex1_s <= ...
            hex2_s <= ...   
   
        end if;

	end process;
	
	
	data_s <= unsigned(data_in);

end architecture;