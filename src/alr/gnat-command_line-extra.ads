package GNAT.Command_Line.Extra is

   function Verify_No_Duplicates (Config : Command_Line_Configuration)
                                  return Boolean;
   --  Returns True if there are no duplicates.
   --  Check that no switch is given twice in Config. This is used to ensure
   --  that command switches are not stepping on global switches, which would
   --  lead to some undefined behavior. This manual check is necessary because
   --  the GNAT library does not perform it.

end GNAT.Command_Line.Extra;
