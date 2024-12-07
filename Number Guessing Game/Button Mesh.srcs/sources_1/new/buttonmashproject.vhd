library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity guess_the_number is
    Port (
        clk : in STD_LOGIC;                
        sw : in STD_LOGIC_VECTOR(9 downto 0); -- Switch inputs (0-9 for guessing)
        reset : in STD_LOGIC;              -- Reset button
        led : out STD_LOGIC;               -- LED lights up for correct guess
        seg : out STD_LOGIC_VECTOR(6 downto 0); -- 7-segment display segments
        an : out STD_LOGIC_VECTOR(3 downto 0)   -- 7-segment display enable
    );
end guess_the_number;

architecture Behavioral of guess_the_number is
    signal counter : INTEGER := 0;  
    signal random_number : INTEGER range 0 to 9 := 6; 
    signal guess : INTEGER range -1 to 9 := -1;         -- User's guess based on switches
    signal led_status : STD_LOGIC := '0';             -- LED status for correct guess
    signal reset_state : STD_LOGIC := '0';            -- Tracks whether reset is active
    signal display_number : INTEGER range -1 to 9 := -1; -- Number to display (-1 means no display)
    signal compare_output : STD_LOGIC;                -- Output from comparator component
    component guess_compare is
        Port (
            guess : in INTEGER range 0 to 9;
            random_number : in INTEGER range 0 to 9;
            match_status : out STD_LOGIC
        );
    end component;
begin

    -- Comparator Component Call
    guess_compare_call : guess_compare
        port map (
            guess => guess,
            random_number => random_number,
            match_status => compare_output
        );
-- Counter for random
    process(clk)
        begin
            if rising_edge(clk) then
                counter <= counter + 1; -- Free-running counter
            end if;
        end process;



    -- Map switch inputs to the user's guess
    process(sw)
    begin
        case sw is
            when "0000000001" => guess <= 0; -- Switch 0
            when "0000000010" => guess <= 1; -- Switch 1
            when "0000000100" => guess <= 2; -- Switch 2
            when "0000001000" => guess <= 3; -- Switch 3
            when "0000010000" => guess <= 4; -- Switch 4
            when "0000100000" => guess <= 5; -- Switch 5
            when "0001000000" => guess <= 6; -- Switch 6
            when "0010000000" => guess <= 7; -- Switch 7
            when "0100000000" => guess <= 8; -- Switch 8
            when "1000000000" => guess <= 9; -- Switch 9
            when others => guess <= -1;       -- Invalid guess
        end case;
    end process;

    -- Game Logic: 
    process(clk)
    begin
        if rising_edge(clk) then
            -- Handle reset
            if reset = '1' and reset_state = '0' then
                random_number <= counter mod 10; -- Generate new random number
                led_status <= '0';       -- Turn off LED
                display_number <= -1;   
                reset_state <= '1';     -- Mark reset as active
            elsif reset = '0' then
                reset_state <= '0';     -- reset to trigger again on the next press
            end if;

            -- Handle guess comparison
            if compare_output = '1' then
                led_status <= '1';             
                display_number <= random_number; -- Show the number on 7-segment display
            else
                led_status <= '0';           
            end if;
        end if;
    end process;

    -- 7-Segment Display Logic
    process(display_number)
    begin
        if display_number >= 0 then
            case display_number is
                when 0 => seg <= "1000000"; -- 0
                when 1 => seg <= "1111001"; -- 1
                when 2 => seg <= "0100100"; -- 2
                when 3 => seg <= "0110000"; -- 3
                when 4 => seg <= "0011001"; -- 4
                when 5 => seg <= "0010010"; -- 5
                when 6 => seg <= "0000010"; -- 6
                when 7 => seg <= "1111000"; -- 7
                when 8 => seg <= "0000000"; -- 8
                when 9 => seg <= "0010000"; -- 9
                when others => seg <= "1111111"; -- Blank
            end case;
            an <= "1110"; -- Enable one digit
        else
            seg <= "1111111"; -- Blank display
            an <= "1111"; -- Turn off all digits
        end if;
    end process;
    


    -- Output LED assignment
    led <= led_status; -- Light up LED only if the guess is correct

end Behavioral;
