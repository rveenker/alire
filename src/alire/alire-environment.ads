with Ada.Strings.Unbounded;

with Alire.Releases;
with Alire.Properties;
with Alire.Platforms;
limited with Alire.Roots;

private with Ada.Strings.Unbounded.Hash;
private with Ada.Containers.Vectors;
private with Ada.Containers.Hashed_Maps;
private with Alire.Properties.Environment;

package Alire.Environment is

   Config : constant String := "ALR_CONFIG";
   --  Folder where current alr will look for configuration

   Source : constant String := "ALR_SOURCE";
   --  Folder that overrides where alr sources are checked out
   --  Intended to help developers by pointing it to their sources

   type Context is tagged limited private;

   procedure Set (This : in out Context; Name, Value, Origin : String);
   --  Set a variable in the context

   procedure Append (This : in out Context; Name, Value, Origin : String);
   --  Append a value to a variable in the context

   procedure Prepend (This : in out Context; Name, Value, Origin : String);
   --  Prepend a value to a variable in the context

   procedure Load (This : in out Context;
                   Root :        Alire.Roots.Root);
   --  Load the environment variables of a releases found in the workspace
   --  Solution (GPR_PROJECT_PATH and custom variables) in the context.

   procedure Export (This : Context);
   --  Export the environment variables built from the variables previously
   --  loaded and defined in the context.

   procedure Print_Shell (This : Context; Kind : Platforms.Shells);
   --  Print the shell commands that can be used to export the environment
   --  variables.

   procedure Print_Details (This : Context);
   --  Print details about the environement context. What are the variables
   --  definitions and their origin.

private

   type Var is record
      Key : Ada.Strings.Unbounded.Unbounded_String;
      Value : Ada.Strings.Unbounded.Unbounded_String;
   end record;

   type Var_Array is array (Natural range <>) of Var;

   function Compile (This : Context) return Var_Array;
   --  Return an array of environment variable key/value built from the
   --  variables previously loaded and defined in the context.

   type Env_Action is record
      Kind   : Alire.Properties.Environment.Actions;
      Value  : Ada.Strings.Unbounded.Unbounded_String;
      Origin : Ada.Strings.Unbounded.Unbounded_String;
   end record;

   package Action_Vectors is new Ada.Containers.Vectors
     (Index_Type   => Natural,
      Element_Type => Env_Action);

   package Action_Maps is new Ada.Containers.Hashed_Maps
     (Key_Type        => Ada.Strings.Unbounded.Unbounded_String,
      Element_Type    => Action_Vectors.Vector,
      Hash            => Ada.Strings.Unbounded.Hash,
      Equivalent_Keys => Ada.Strings.Unbounded."=",
      "="             => Action_Vectors."=");

   type Context is tagged limited record
      Actions : Action_Maps.Map;
   end record;

   procedure Add (This : in out Context; Name : String; Action : Env_Action);

   procedure Load (This            : in out Context;
                   Root            : Roots.Root;
                   Crate           : Crate_Name);
   --  Load the environment variables of a release (GPR_PROJECT_PATH and custom
   --  variables) in the context.

end Alire.Environment;
