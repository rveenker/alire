with Alire.Os_Lib;

with Ada.Directories; use Ada.Directories;
with GNAT.OS_Lib; use GNAT.OS_Lib;

package body Alr.OS is

   function Getenv (Var : String; Default : String := "") return String;

   ------------------
   -- Cache_Folder --
   ------------------

   function Cache_Folder return String is
   begin
      return Getenv ("XDG_CACHE_HOME",
                     Default => Compose (Compose (Getenv ("HOME"), ".cache"), "alire"));
   end Cache_Folder;

   -------------------
   -- Config_Folder --
   -------------------

   function Config_Folder return String is
   begin
      return Getenv ("XDG_CONFIG_HOME",
                     Default => Compose (Compose (Getenv ("HOME"), ".config"), "alire"));
   end Config_Folder;

   ---------------------
   -- Projects_Folder --
   ---------------------

   function Projects_Folder return String is
   begin
      return Compose (Cache_Folder, "projects");
   end Projects_Folder;

   --------------------------
   -- Create_Config_Folder --
   --------------------------

   procedure Create_Folder (Path : String) is
   begin
      Alire.OS_Lib.Spawn ("mkdir", "-p " & Path);
   end Create_Folder;

   ------------
   -- Getenv --
   ------------

   function Getenv (Var : String; Default : String := "") return String is
      Env_Access : String_Access := GNAT.OS_Lib.Getenv (Var);
      Env        : constant String := Env_Access.all;
   begin
      Free (Env_Access);
      if Env = "" then
         return Default;
      else
         return Env;
      end if;
   end Getenv;

end Alr.OS;