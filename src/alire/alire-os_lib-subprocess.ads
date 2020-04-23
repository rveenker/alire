with Alire.Utils;

package Alire.OS_Lib.Subprocess is

   --  Separate from Alire.OS_Lib because not preelaborable

   function Locate_In_Path (Name : String) return String;
   --  Returns full path to Name command or "" if not found

   procedure Checked_Spawn
     (Command             : String;
      Arguments           : Utils.String_Vector;
      Understands_Verbose : Boolean := False);
   --  Either suceeds or raises Checked_Error with the code and output as info.

   type Code_Array is array (Positive range <>) of Integer;
   --  An array of exit codes that won't cause the following calls to raise

   function Checked_Spawn_And_Capture
     (Command             : String;
      Arguments           : Utils.String_Vector;
      Understands_Verbose : Boolean := False;
      Err_To_Out          : Boolean := False;
      Valid_Exit_Codes    : Code_Array := (1 => 0)) return Utils.String_Vector;
   --  Either suceeds or raises Checked_Error with the code and output as info.
   --  Output is captured and returned on success. The exit code is checked
   --  against the Valid_Exit_Codes.

   function Unchecked_Spawn_And_Capture
     (Command             : String;
      Arguments           : Utils.String_Vector;
      Output              : in out Utils.String_Vector;
      Understands_Verbose : Boolean := False;
      Err_To_Out          : Boolean := False) return Integer;
   --  Returns the output and exit code of the spawned command

end Alire.OS_Lib.Subprocess;
