with Alire.Utils;

package Alr.Spawn is

   --  Encapsulates all external spawns
   --  Any of those may raise Command_Failed or GNAT.OS_Lib exceptions

   procedure Command
     (Cmd                 : String;
      Args                : Alire.Utils.String_Vector;
      Understands_Verbose : Boolean := False;
      Force_Quiet         : Boolean := False);
   --  Adds -v if understands in Debug log level
   --  Summary is shown after process successful end, if Log_Level = Info

   procedure Gprbuild
     (Project_File  : String;
      Extra_Args    : Alire.Utils.String_Vector);
   --  Launches gprbuild for the building of a crate.
   --  Extra args can be -Xblah detected from command-line.
   --  Out-of-tree build takes place in
   --    $crate / Alire.Paths.Build_Folder ($crate/alire/build).

end Alr.Spawn;
