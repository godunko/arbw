------------------------------------------------------------------------------
--                                                                          --
--                                AdaWebPack                                --
--                                                                          --
------------------------------------------------------------------------------
--  Copyright © 2020, Vadim Godunko                                         --
--  All rights reserved.                                                    --
--                                                                          --
--  Redistribution and use in source and binary forms, with or without      --
--  modification, are permitted provided that the following conditions are  --
--  met:                                                                    --
--                                                                          --
--  1. Redistributions of source code must retain the above copyright       --
--     notice, this list of conditions and the following disclaimer.        --
--                                                                          --
--  2. Redistributions in binary form must reproduce the above copyright    --
--     notice, this list of conditions and the following disclaimer in the  --
--     documentation and/or other materials provided with the distribution. --
--                                                                          --
--  3. Neither the name of the copyright holder nor the names of its        --
--     contributors may be used to endorse or promote products derived      --
--     from this software without specific prior written permission.        --
--                                                                          --
--  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS     --
--  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT       --
--  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR   --
--  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT    --
--  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,  --
--  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT        --
--  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,   --
--  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY   --
--  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT     --
--  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE   --
--  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.    --
------------------------------------------------------------------------------

with Ada.Unchecked_Conversion;
with System.Storage_Elements;

package body Web.Strings.WASM_Helpers is

   function To_Data is
     new Ada.Unchecked_Conversion (System.Address, String_Data_Access);

   function Allocate_String
    (Size : Interfaces.Unsigned_32) return System.Address
       with Export     => True,
            Convention => C,
            Link_Name  => "__adawebpack__core__allocate_string";

   Dummy : String_Data (1);

   ---------------------
   -- Allocate_String --
   ---------------------

   function Allocate_String
    (Size : Interfaces.Unsigned_32) return System.Address
   is
      Aux : constant String_Data_Access := new String_Data (Size);

   begin
      Aux.Size   := Size;
      Aux.Length := Integer (Size);

      return Aux.all.Data'Address;
   end Allocate_String;

   ------------
   -- To_Ada --
   ------------

   function To_Ada (Item : System.Address) return Web.Strings.Web_String is
      use type System.Address;
      use type System.Storage_Elements.Storage_Offset;

      Aux : String_Data_Access := null;

   begin
      if Item /= System.Null_Address then
         Aux := To_Data (Item - Dummy.Data'Position);

         --  XXX Validation and length recomputation are not implemented.

         Aux.Length := Integer (Aux.Size);
      end if;

      return (Ada.Finalization.Controlled with Data => Aux);
   end To_Ada;

   -----------
   -- To_JS --
   -----------

   procedure To_JS
    (Item    : Web_String;
     Address : out System.Address;
     Size    : out Interfaces.Unsigned_32) is
   begin
      if Item.Data = null then
         Address := System.Null_Address;
         Size    := 0;

      else
         Address := Item.Data.Data (Item.Data.Data'First)'Address;
         Size    := Item.Data.Size;
      end if;
   end To_JS;

end Web.Strings.WASM_Helpers;
