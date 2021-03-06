------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               Web Framework                              --
--                                                                          --
--                            Web API Definition                            --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2014-2021, Vadim Godunko <vgodunko@gmail.com>                --
-- All rights reserved.                                                     --
--                                                                          --
-- Redistribution and use in source and binary forms, with or without       --
-- modification, are permitted provided that the following conditions       --
-- are met:                                                                 --
--                                                                          --
--  * Redistributions of source code must retain the above copyright        --
--    notice, this list of conditions and the following disclaimer.         --
--                                                                          --
--  * Redistributions in binary form must reproduce the above copyright     --
--    notice, this list of conditions and the following disclaimer in the   --
--    documentation and/or other materials provided with the distribution.  --
--                                                                          --
--  * Neither the name of the Vadim Godunko, IE nor the names of its        --
--    contributors may be used to endorse or promote products derived from  --
--    this software without specific prior written permission.              --
--                                                                          --
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS      --
-- "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT        --
-- LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR    --
-- A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT     --
-- HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,   --
-- SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED --
-- TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR   --
-- PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF   --
-- LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING     --
-- NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS       --
-- SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.             --
--                                                                          --
------------------------------------------------------------------------------
--  $Revision: 5518 $ $Date: 2015-12-20 14:25:24 +0300 (Sun, 20 Dec 2015) $
------------------------------------------------------------------------------
--  This package provides binding to interface Node.
------------------------------------------------------------------------------

with WASM.Objects;

limited with Web.DOM.Documents;
limited with Web.DOM.Elements;
with Web.DOM.Event_Listeners;
with Web.DOM.Event_Targets;
limited with Web.HTML.Elements;
with Web.Strings;

package Web.DOM.Nodes is

   pragma Preelaborate;

   type Node is new WASM.Objects.Object_Reference
     and Web.DOM.Event_Targets.Event_Target with null record;

   type Node_Types is
    (ELEMENT_NODE,
     ATTRIBUTE_NODE,          --  historical
     TEXT_NODE,
     CDATA_SECTION_NODE,      --  historical
     ENTITY_REFERENCE_NODE,   --  historical
     ENTITY_NODE,             --  historical
     PROCESSING_INSTRUCTION_NODE,
     COMMENT_NODE,
     DOCUMENT_NODE,
     DOCUMENT_TYPE_NODE,
     DOCUMENT_FRAGMENT_NODE,
     NOTATION_NODE);          --  historical
   for Node_Types'Size use Web.DOM_Unsigned_Short'Size;
   for Node_Types use
    (ELEMENT_NODE                => 1,
     ATTRIBUTE_NODE              => 2,
     TEXT_NODE                   => 3,
     CDATA_SECTION_NODE          => 4,
     ENTITY_REFERENCE_NODE       => 5,
     ENTITY_NODE                 => 6,
     PROCESSING_INSTRUCTION_NODE => 7,
     COMMENT_NODE                => 8,
     DOCUMENT_NODE               => 9,
     DOCUMENT_TYPE_NODE          => 10,
     DOCUMENT_FRAGMENT_NODE      => 11,
     NOTATION_NODE               => 12);

--  interface Node : EventTarget {
--    readonly attribute DOMString nodeName;
--
--    readonly attribute DOMString? baseURI;
--
--    readonly attribute Node? parentNode;
--    boolean hasChildNodes();
--    [SameObject] readonly attribute NodeList childNodes;
--    readonly attribute Node? lastChild;
--    readonly attribute Node? previousSibling;
--
--             attribute DOMString? nodeValue;
--             attribute DOMString? textContent;
--    void normalize();
--
--    boolean isEqualNode(Node? node);
--
--    const unsigned short DOCUMENT_POSITION_DISCONNECTED = 0x01;
--    const unsigned short DOCUMENT_POSITION_PRECEDING = 0x02;
--    const unsigned short DOCUMENT_POSITION_FOLLOWING = 0x04;
--    const unsigned short DOCUMENT_POSITION_CONTAINS = 0x08;
--    const unsigned short DOCUMENT_POSITION_CONTAINED_BY = 0x10;
--    const unsigned short DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC = 0x20;
--    unsigned short compareDocumentPosition(Node other);
--    boolean contains(Node? other);
--
--    DOMString? lookupPrefix(DOMString? namespace);
--    DOMString? lookupNamespaceURI(DOMString? prefix);
--    boolean isDefaultNamespace(DOMString? namespace);
--
--    Node insertBefore(Node node, Node? child);
--    Node replaceChild(Node node, Node child);
--  };
--limited with WebAPI.DOM.Documents;
--limited with WebAPI.DOM.Elements;
--with WebAPI.DOM.Event_Targets;
--limited with WebAPI.DOM.Node_Lists;
--
--package WebAPI.DOM.Nodes is

   function Get_Node_Type (Self : Node'Class) return Web.DOM.Nodes.Node_Types;
   --  Returns the type of node.

--   not overriding function Get_Node_Name
--    (Self : not null access constant Node) return WebAPI.DOM_String is abstract
--       with Import     => True,
--            Convention => JavaScript_Property_Getter,
--            Link_Name  => "nodeName";
--   --  Returns a string appropriate for the type of node, as follows:
--   --
--   --    Element
--   --      Its tagName attribute value. 
--   --    Text
--   --      "#text". 
--   --    ProcessingInstruction
--   --      Its target. 
--   --    Comment
--   --      "#comment". 
--   --    Document
--   --      "#document". 
--   --    DocumentType
--   --      Its name. 
--   --    DocumentFragment
--   --      "#document-fragment". 
--
--   not overriding function Get_Base_URI
--    (Self : not null access constant Node) return WebAPI.DOM_String is abstract
--       with Import     => True,
--            Convention => JavaScript_Property_Getter,
--            Link_Name  => "baseURI";
--   --  Returns the base URL.

   function Get_Owner_Document
    (Self : Node'Class) return Web.DOM.Documents.Document;
   --  Returns the node document.
   --
   --  Returns null for documents.

--   not overriding function Get_Parent_Node
--    (Self : not null access constant Node)
--       return WebAPI.DOM.Nodes.Node_Access is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "parentNode";
--   --  Returns the parent.

   function Get_Parent_Element
     (Self : Node'Class) return Web.DOM.Elements.Element;
   --  Returns the parent element.

--   not overriding function Has_Child_Nodes
--    (Self : not null access constant Node) return Boolean is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "hasChildNodes";
--   --  Returns whether node has children.
--
--   not overriding function Get_Child_Nodes
--    (Self : not null access constant Node)
--       return WebAPI.DOM.Node_Lists.Node_List is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "childNodes";
--   --  Returns the children.

   function Get_First_Child (Self : Node'Class) return Web.DOM.Nodes.Node;
   --  Returns the first child.

--   not overriding function Get_Last_Child
--    (Self : not null access constant Node)
--       return WebAPI.DOM.Nodes.Node_Access is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "lastChild";
--   --  Returns the last child.
--
--   not overriding function Get_Previous_Sibling
--    (Self : not null access constant Node)
--       return WebAPI.DOM.Nodes.Node_Access is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "previousSibling";
--   --  Returns the previous sibling.

   function Get_Next_Sibling (Self : Node'Class) return Web.DOM.Nodes.Node;
   --  Returns the next sibling.

--   not overriding function Get_Node_Value
--    (Self : not null access constant Node) return WebAPI.DOM_String is abstract
--       with Import     => True,
--            Convention => JavaScript_Property_Getter,
--            Link_Name  => "nodeValue";
--   --  The nodeValue attribute must return the following, depending on the
--   --  context object:
--   --
--   --    Text
--   --    Comment
--   --    ProcessingInstruction
--   --
--   --      The context object's data. 
--   --
--   --    Any other node
--   --
--   --      Null.
--
--   not overriding procedure Set_Node_Value
--    (Self : not null access Node;
--     To   : WebAPI.DOM_String) is abstract
--       with Import     => True,
--            Convention => JavaScript_Property_Setter,
--            Link_Name  => "nodeValue";
--   --  The nodeValue attribute must, on setting, if the new value is null, act
--   --  as if it was the empty string instead, and then do as described below,
--   --  depending on the context object:
--   --
--   --    Text
--   --    Comment
--   --    ProcessingInstruction
--   --
--   --      Replace data with node context object, offset 0, count length
--   --      attribute value, and data new value. 
--   --
--   --    Any other node
--   --
--   --      Do nothing.
--
--   not overriding function Get_Text_Content
--    (Self : not null access constant Node) return WebAPI.DOM_String is abstract
--       with Import     => True,
--            Convention => JavaScript_Property_Getter,
--            Link_Name  => "textContent";
--   --  The textContent attribute must return the following, depending on the
--   --  context object:
--   --
--   --    DocumentFragment
--   --    Element
--   --
--   --      The concatenation of data of all the Text node descendants of the
--   --      context object, in tree order. 
--   --
--   --    Text
--   --    ProcessingInstruction
--   --    Comment
--   --
--   --      The context object's data. 
--   --
--   --    Any other node
--   --
--   --      Null.
--
--   not overriding procedure Set_Text_Content
--    (Self : not null access Node;
--     To   : WebAPI.DOM_String) is abstract
--       with Import     => True,
--            Convention => JavaScript_Property_Setter,
--            Link_Name  => "textContent";
--   --  The textContent attribute must, on setting, if the new value is null,
--   --  act as if it was the empty string instead, and then do as described
--   --  below, depending on the context object:
--   --
--   --    DocumentFragment
--   --    Element
--   --
--   --      1. Let node be null.
--   --
--   --      2. If new value is not the empty string, set node to a new Text node
--   --         whose data is new value.
--   --
--   --      3. Replace all with node within the context object. 
--   --
--   --    Text
--   --    ProcessingInstruction
--   --    Comment
--   --
--   --      Replace data with node context object, offset 0, count length
--   --      attribute value, and data new value. 
--   --
--   --    Any other node
--   --
--   --      Do nothing.
--
--   not overriding procedure Normalize (Self : not null access Node) is abstract
--     with Import     => True,
--          Convention => JavaScript_Method,
--          Link_Name  => "normalize";
--   --  Removes empty Text nodes and concatenates the data of remaining
--   --  contiguous Text nodes into the first of their nodes.

   function Clone_Node
     (Self : Node'Class; Deep : Boolean := False) return Web.DOM.Nodes.Node;
   --  Returns a copy of node. If deep is true, the copy also includes the
   --  node's descendants.

--   not overriding function Is_Equal_Node
--    (Self  : not null access constant Node;
--     Other : access Node'Class) return Boolean is abstract
--         with Import     => True,
--              Convention => JavaScript_Method,
--              Link_Name  => "isEqualNode";
--   --  Returns whether node and other have the same properties.
--
--   --  XXX Not bindied yet:
--   --    const unsigned short DOCUMENT_POSITION_DISCONNECTED = 0x01;
--   --    const unsigned short DOCUMENT_POSITION_PRECEDING = 0x02;
--   --    const unsigned short DOCUMENT_POSITION_FOLLOWING = 0x04;
--   --    const unsigned short DOCUMENT_POSITION_CONTAINS = 0x08;
--   --    const unsigned short DOCUMENT_POSITION_CONTAINED_BY = 0x10;
--   --    const unsigned short DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC = 0x20;
--   --    unsigned short compareDocumentPosition(Node other);
--
--   not overriding function Contains
--    (Self  : not null access constant Node;
--     Other : access Node'Class) return Boolean is abstract
--         with Import     => True,
--              Convention => JavaScript_Method,
--              Link_Name  => "contains";
--   --  Returns true if other is an inclusive descendant of node, and false
--   --  otherwise.
--
--   not overriding function Lookup_Prefix
--    (Self          : not null access constant Node;
--     Namespace_URI : WebAPI.DOM_String) return WebAPI.DOM_String is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "lookupPrefix";
--   --  The lookupPrefix(namespace) method must run these steps:
--   --
--   --   1. If namespace is null or the empty string, return null.
--   --
--   --   2. Otherwise it depends on the context object:
--   --
--   --      Element
--   --
--   --        Return the result of locating a namespace prefix for the node
--   --        using namespace. 
--   --
--   --      Document
--   --
--   --        Return the result of locating a namespace prefix for its document
--   --        element, if that is not null, and null otherwise. 
--   --
--   --      DocumentType
--   --      DocumentFragment
--   --
--   --        Return null. 
--   --
--   --      Any other node
--   --
--   --        Return the result of locating a namespace prefix for its parent
--   --        element, or if that is null, null. 
--
--   not overriding function Lookup_Namespace_URI
--    (Self   : not null access constant Node;
--     Prefix : WebAPI.DOM_String) return WebAPI.DOM_String is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "lookupNamespaceURI";
--   --  The lookupNamespaceURI(prefix) method must run these steps:
--   --
--   --   1. If prefix is the empty string, set it to null.
--   --
--   --   2. Return the result of running locate a namespace for the context
--   --      object using prefix.
--
--   not overriding function Is_Default_Namespace
--    (Self          : not null access constant Node;
--     Namespace_URI : WebAPI.DOM_String) return Boolean is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "isDefaultNamespace";
--   --  The isDefaultNamespace(namespace) method must run these steps:
--   --
--   --   1. If namespace is the empty string, set it to null.
--   --
--   --   2. Let defaultNamespace be the result of running locate a namespace for
--   --      the context object using null.
--   --
--   --   3. Return true if defaultNamespace is the same as namespace, and false
--   --      otherwise.
--
--   not overriding function Insert_Before
--    (Self  : not null access Node;
--     Node  : not null access WebAPI.DOM.Nodes.Node'Class;
--     Child : access WebAPI.DOM.Nodes.Node'Class)
--       return WebAPI.DOM.Nodes.Node_Access is abstract
--         with Import     => True,
--              Convention => JavaScript_Method,
--              Link_Name  => "insertBefore";
--   procedure Insert_Before
--    (Self  : not null access Node'Class;
--     Node  : not null access WebAPI.DOM.Nodes.Node'Class;
--     Child : access WebAPI.DOM.Nodes.Node'Class)
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "insertBefore";
--   --  The insertBefore(node, child) method must return the result of
--   --  pre-inserting node into the context object before child.

   function Append_Child
    (Self : in out Node'Class;
     Node : Web.DOM.Nodes.Node'Class) return Web.DOM.Nodes.Node;
   --  The appendChild(node) method must return the result of appending node to
   --  the context object.

   procedure Append_Child
    (Self : in out Node'Class;
     Node : Web.DOM.Nodes.Node'Class);

--   not overriding function Replace_Child
--    (Self  : not null access Node;
--     Node  : not null access WebAPI.DOM.Nodes.Node'Class;
--     Child : not null access WebAPI.DOM.Nodes.Node'Class)
--       return WebAPI.DOM.Nodes.Node_Access is abstract
--         with Import     => True,
--              Convention => JavaScript_Method,
--              Link_Name  => "replaceChild";
--   procedure Replace_Child
--    (Self  : not null access Node'Class;
--     Node  : not null access WebAPI.DOM.Nodes.Node'Class;
--     Child : not null access WebAPI.DOM.Nodes.Node'Class)
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "replaceChild";
--   --  The replaceChild(node, child) method must return the result of replacing
--   --  child with node within the context object.

   function Remove_Child
    (Self : in out Node'Class;
     Node : Web.DOM.Nodes.Node'Class) return Web.DOM.Nodes.Node;
   --  The removeChild(child) method must return the result of pre-removing
   --  child from the context object.

   procedure Remove_Child
    (Self : in out Node'Class;
     Node : Web.DOM.Nodes.Node'Class);

   overriding procedure Add_Event_Listener
    (Self     : in out Node;
     Name     : Web.Strings.Web_String;
     Callback : not null Web.DOM.Event_Listeners.Event_Listener_Access;
     Capture  : Boolean := False);

   --  Additional subprograms for convenience

   function As_HTML_Element
    (Self : Node'Class) return Web.HTML.Elements.HTML_Element;

end Web.DOM.Nodes;
