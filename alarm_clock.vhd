--Wade Fortney 2/1/2024
--this is an alarm clock
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity alarm_clock is
    Port (    
              clk : in std_logic;
              rst : in std_logic;
              sw1 : in std_logic;
              sw2 : in std_logic;
              sw3 : in std_logic;
              sw4 : in std_logic;
			  hex_1out : out std_logic_vector(6 downto 0);
			  hex_2out : out std_logic_vector(6 downto 0);
			  hex_3out : out std_logic_vector(6 downto 0);
			  hex_4out : out std_logic_vector(6 downto 0);
			  bell : out std_logic
			  );
           
end alarm_clock;



architecture Behavioral of alarm_clock is

    type state_t is (TIM3, SET_TIME, SET_ALARM);
    signal state_r: state_t;

	signal data_hrs_s, data_min_s : std_logic_vector(6 downto 0);
	signal alarm_val_hrs_s, alarm_val_min_s, time_hrs_s, time_min_s : unsigned(6 downto 0);

    signal counter_s : unsigned(31 downto 0);
    signal clk_div_s, alarm_active_s, alarm_sel_s : std_logic;
begin


    U_HRS : entity work.top
    Port map( 
            data_in => data_hrs_s,
			hex_1out => hex_3out,
			hex_2out => hex_4out
			  );



    U_MIN : entity work.top
    Port map( 
            data_in => data_min_s,
			hex_1out => hex_1out,
			hex_2out => hex_2out
			  );

	--U_CLK_DIV : entity work...
	--implement your own clock divider


    sync_proc: process(clk_div_s, rst)
    
    begin
        
        if(rst = '1') then
            state_r <= TIM3;
            bell <= '0';
            alarm_active_s <= '0';
            alarm_sel_s <= '0';
            alarm_val_hrs_s <= (others => '0');
            alarm_val_min_s <= (others => '0');
            time_hrs_s <= (others => '0');
            time_min_s <= (others => '0');
        elsif(rising_edge(clk_div_s)) then
                  
            case(state_r) is

              when TIM3 =>
                
                --check to see if we have hit the alarm              
                if((alarm_val_hrs_s = time_hrs_s or alarm_val_hrs_s = 0 or alarm_val_hrs_s = time_hrs_s + 1) and alarm_active_s = '1') then
                    if((alarm_val_min_s = 0 and time_min_s = 59) or (alarm_val_min_s = time_min_s + 1)) then
                        bell <= '1';
                    end if;
                end if;               
                
                
                --run time increment checks
                if(time_hrs_s = 23 and time_min_s = 59) then
                               
                    time_hrs_s <= (others => '0');
                    time_min_s <= (others => '0');
                    
                elsif(time_min_s = 59) then
                
                    time_hrs_s <= time_hrs_s + 1;
                    time_min_s <= (others => '0');
                    
                else
                    time_min_s <= time_min_s + 1;
                end if;
                
                
                --run button checks
                if(sw1 = '1' and sw2 = '0') then
                    state_r <= SET_TIME;
                elsif(sw2 = '1' and sw1 = '0') then
                    alarm_sel_s <= '1';
                    state_r <= SET_ALARM;
                else
                    state_r <= TIM3;
                end if;
                
                

              when SET_TIME =>
                
		--return to time state         
                if(sw1 = '0') then
                    state_r <= TIM3;
                else
		    --increment minutes
                    if(sw3 = '1') then
			--add code here
                    --increment hrs    
                    elsif(sw4 = '1') then
			--add code here                     
                    end if;
                    
                    state_r <= SET_TIME;
                end if;               
                
                
                
              when SET_ALARM =>

                if(sw2 = '0') then
                    alarm_active_s <= '1';
                    alarm_sel_s <= '0';
                    state_r <= TIM3;
                else

                    --add code here

                    state_r <= SET_ALARM;
                end if;
                
            end case; --end state "'case'"

        end if; --end clock edge "'if'"

    end process; --end state process


    
    data_hrs_s <= std_logic_vector(time_hrs_s) when (alarm_sel_s = '0') else std_logic_vector(alarm_val_hrs_s);
    data_min_s <= std_logic_vector(time_min_s) when (alarm_sel_s = '0') else std_logic_vector(alarm_val_min_s);

end architecture;






