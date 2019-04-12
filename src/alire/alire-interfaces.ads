with Alire.Utils;

with TOML;

package Alire.Interfaces with Preelaborate is

   type Codifiable is limited interface;
   
   function To_Code (This : Codifiable) return Utils.String_Vector is abstract;
   
   
   type Imaginable is limited interface;
      
   function Image (This : Imaginable) return String is abstract;

   
   type Tomifiable is limited interface;
   
   function To_TOML (This : Tomifiable) return TOML.TOML_Value is abstract;
   
end Alire.Interfaces;
