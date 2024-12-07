----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2024 10:31:28 PM
-- Design Name: 
-- Module Name: guess_comapre - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity guess_compare is
    Port ( guess : in INTEGER range 0 to 9;
           random_number : in INTEGER range 0 to 9;
           match_status : out STD_LOGIC);
end guess_compare;

architecture Behavioral of guess_compare is

begin
    process(guess, random_number)
    begin
        if guess = random_number then
            match_status <= '1';
        else
            match_status <= '0';
        end if;
    end process;
end Behavioral;
