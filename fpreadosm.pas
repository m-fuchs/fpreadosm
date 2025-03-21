unit FpReadOsm;

interface



    const
      External_library='kernel32'; {Setup as you need}

    { Pointers to basic pascal types, inserted by h2pas conversion program.}
    Type
      PLongint  = ^Longint;
      PSmallInt = ^SmallInt;
      PByte     = ^Byte;
      PWord     = ^Word;
      PDWord    = ^DWord;
      PDouble   = ^Double;

    Type
    Pchar  = ^char;
    Pint64  = ^int64;
    Preadosm_member  = ^readosm_member;
    Preadosm_member_struct  = ^readosm_member_struct;
    Preadosm_node_struct  = ^readosm_node_struct;
    Preadosm_relation_struct  = ^readosm_relation_struct;
    Preadosm_tag  = ^readosm_tag;
    Preadosm_tag_struct  = ^readosm_tag_struct;
    Preadosm_way_struct  = ^readosm_way_struct;
{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


  { 
  / readosm.h
  /
  / public declarations
  /
  / version  1.1.0, 2017 September 25
  /
  / Author: Sandro Furieri a.furieri@lqt.it
  /
  / ------------------------------------------------------------------------------
  / 
  / Version: MPL 1.1/GPL 2.0/LGPL 2.1
  / 
  / The contents of this file are subject to the Mozilla Public License Version
  / 1.1 (the "License"); you may not use this file except in compliance with
  / the License. You may obtain a copy of the License at
  / http://www.mozilla.org/MPL/
  / 
  / Software distributed under the License is distributed on an "AS IS" basis,
  / WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  / for the specific language governing rights and limitations under the
  / License.
  /
  / The Original Code is the ReadOSM library
  /
  / The Initial Developer of the Original Code is Alessandro Furieri
  / 
  / Portions created by the Initial Developer are Copyright (C) 2012-2017
  / the Initial Developer. All Rights Reserved.
  / 
  / Contributor(s):
  /
  / Alternatively, the contents of this file may be used under the terms of
  / either the GNU General Public License Version 2 or later (the "GPL"), or
  / the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  / in which case the provisions of the GPL or the LGPL are applicable instead
  / of those above. If you wish to allow use of your version of this file only
  / under the terms of either the GPL or the LGPL, and not to allow others to
  / use your version of this file under the terms of the MPL, indicate your
  / decision by deleting the provisions above and replace them with the notice
  / and other provisions required by the GPL or the LGPL. If you do not delete
  / the provisions above, a recipient may use your version of this file under
  / the terms of any one of the MPL, the GPL or the LGPL.
  / 
   }
  {*
   \file readosm.h 
   
   Function declarations and constants for ReadOSM library
    }
{$ifndef DOXYGEN_SHOULD_SKIP_THIS}
{$ifdef _WIN32}
{$ifdef DLL_EXPORT}

  { was #define dname def_expr }
  function READOSM_DECLARE : longint; { return type might be wrong }

{$define READOSM_PRIVATE}  
{$else}
(* error 
#define READOSM_DECLARE extern
in define line 58 *)
{$define READOSM_PRIVATE}    
{$endif}
{$else}

    { was #define dname def_expr }
    function READOSM_DECLARE : longint; { return type might be wrong }

  { was #define dname def_expr }
  function READOSM_PRIVATE : longint; { return type might be wrong }

{$endif}
{$endif}
{$ifndef _READOSM_H}
{$ifndef DOXYGEN_SHOULD_SKIP_THIS}
{$define _READOSM_H}  
{$endif}
  { constants  }
  {* information is not available  }

  const
    READOSM_UNDEFINED = -(1234567890);    
  {* MemberType: NODE  }
    READOSM_MEMBER_NODE = 7361;    
  {* MemberType: WAY  }
    READOSM_MEMBER_WAY = 6731;    
  {* MemberType: RELATION  }
    READOSM_MEMBER_RELATION = 3671;    
  { Error codes  }
  {*< No error, success  }
    READOSM_OK = 0;    
  {*< not .osm or .pbf suffix  }
    READOSM_INVALID_SUFFIX = -(1);    
  {*< .osm or .pbf file does not exist or is
  						not accessible for reading  }
    READOSM_FILE_NOT_FOUND = -(2);    
  {*< Null OSM_handle argument  }
    READOSM_NULL_HANDLE = -(3);    
  {*< Invalid OSM_handle argument  }
    READOSM_INVALID_HANDLE = -(4);    
  {*< some kind of memory allocation
                                                  failure  }
    READOSM_INSUFFICIENT_MEMORY = -(5);    
  {*< cannot create the XML Parser  }
    READOSM_CREATE_XML_PARSER_ERROR = -(6);    
  {*< read error  }
    READOSM_READ_ERROR = -(7);    
  {*< XML parser error  }
    READOSM_XML_ERROR = -(8);    
  {*< invalid PBF header  }
    READOSM_INVALID_PBF_HEADER = -(9);    
  {*< unZip error  }
    READOSM_UNZIP_ERROR = -(10);    
  {*< user-required parser abort  }
    READOSM_ABORT = -(11);    
  {*
  	 a struct representing a <b>key:value</b> pair, and wrapping an XML fragment like the following:
  	\verbatim
  <tag key="key-value" value="some-value" />
  	\endverbatim
  	  }
(* Const before type ignored *)
  {*< the KEY  }
(* Const before type ignored *)
  {*< the VALUE  }

  type
    Preadosm_tag_struct = ^readosm_tag_struct;
    readosm_tag_struct = record
        key : Pchar;
        value : Pchar;
      end;

  {*
       Typedef for TAG structure.
       
       \sa readosm_tag_struct
        }
    readosm_tag_struct = readosm_tag;
  {*
  	 a struct representing a NODE object, and wrapping a complex XML fragment like the following:
  	\verbatim
  <node id="12345" lat="6.66666" lon="7.77777" version="1" changeset="54321" user="some-user" uid="66" timestamp="2005-02-28T17:45:15Z">
  	<tag key="created_by" value="JOSM" />
  	<tag key="tourism" value="camp_site" />
  </node>
  	\endverbatim
  	  }
(* Const before type ignored *)
  {*< NODE-ID (expected to be a unique value)  }
(* Const before type ignored *)
  {*< geographic latitude  }
(* Const before type ignored *)
  {*< geographic longitude  }
(* Const before type ignored *)
  {*< object version  }
(* Const before type ignored *)
  {*< ChangeSet ID  }
(* Const before type ignored *)
  {*< name of the User defining this NODE  }
(* Const before type ignored *)
  {*< corresponding numeric UserID  }
(* Const before type ignored *)
  {*< when this NODE was defined  }
(* Const before type ignored *)
  {*< number of associated TAGs (may be zero)  }
(* Const before type ignored *)
  {*< array of TAG objects (may be NULL)  }
    Preadosm_node_struct = ^readosm_node_struct;
    readosm_node_struct = record
        id : int64;
        latitude : double;
        longitude : double;
        version : longint;
        changeset : int64;
        user : Pchar;
        uid : longint;
        timestamp : Pchar;
        tag_count : longint;
        tags : Preadosm_tag;
      end;

  {*
       Typedef for NODE structure.
       
       \sa readosm_node_struct
        }
    readosm_node_struct = readosm_node;
  {*
  	 a struct representing a WAY object, and wrapping a complex XML fragment like the following:
  	\verbatim
  <way id="12345" version="1" changeset="54321" user="some-user" uid="66" timestamp="2005-02-28T17:45:15Z">
  	<nd ref="12345" />
  	<nd ref="12346" />
  	<nd ref="12347" />
  	<tag key="created_by" value="JOSM" />
  	<tag key="tourism" value="camp_site" />
  </way>
  	\endverbatim
  	  }
(* Const before type ignored *)
  {*< WAY-ID (expected to be a unique value)  }
(* Const before type ignored *)
  {*< object version  }
(* Const before type ignored *)
  {*< ChangeSet ID  }
(* Const before type ignored *)
  {*< name of the User defining this WAY  }
(* Const before type ignored *)
  {*< corresponding numeric UserID  }
(* Const before type ignored *)
  {*< when this WAY was defined  }
(* Const before type ignored *)
  {*< number of referenced NODE-IDs (may be zero)  }
(* Const before type ignored *)
  {*< array of NODE-IDs (may be NULL)  }
(* Const before type ignored *)
  {*< number of associated TAGs (may be zero)  }
(* Const before type ignored *)
  {*< array of TAG objects (may be NULL)  }
    Preadosm_way_struct = ^readosm_way_struct;
    readosm_way_struct = record
        id : int64;
        version : longint;
        changeset : int64;
        user : Pchar;
        uid : longint;
        timestamp : Pchar;
        node_ref_count : longint;
        node_refs : Pint64;
        tag_count : longint;
        tags : Preadosm_tag;
      end;

  {*
       Typedef for WAY structure.
       
       \sa readosm_way_struct
        }
    readosm_way_struct = readosm_way;
  {*
  	 a struct representing a RELATION-MEMBER, and wrapping an XML fragment like the following:
  	\verbatim
  <member type="some-type" ref="12345" role="some-role" />
  	\endverbatim
  	  }
(* Const before type ignored *)
  {*< can be one of: READOSM_MEMBER_NODE, READOSM_MEMBER_WAY or READOSM_MEMBER_RELATION  }
(* Const before type ignored *)
  {*< ID-value identifying the referenced object  }
(* Const before type ignored *)
  {*< intended role for this reference  }
    Preadosm_member_struct = ^readosm_member_struct;
    readosm_member_struct = record
        member_type : longint;
        id : int64;
        role : Pchar;
      end;

  {*
       Typedef for MEMBER structure.
       
       \sa readosm_member_struct
        }
    readosm_member_struct = readosm_member;
  {*
  	 a struct representing a RELATION object, and wrapping a complex XML fragment like the following:
  	\verbatim
  <relation id="12345" version="1" changeset="54321" user="some-user" uid="66" timestamp="2005-02-28T17:45:15Z">
  	<member type="way" ref="12345" role="outer" />
  	<member type="way" ref="12346" role="inner" />
  	<tag key="created_by" value="JOSM" />
  	<tag key="tourism" value="camp_site" />
  </relation>
  	\endverbatim
  	  }
(* Const before type ignored *)
  {*< RELATION-ID (expected to be a unique value)  }
(* Const before type ignored *)
  {*< object version  }
(* Const before type ignored *)
  {*< ChangeSet ID  }
(* Const before type ignored *)
  {*< name of the User defining this RELATION  }
(* Const before type ignored *)
  {*< corresponding numeric UserID  }
(* Const before type ignored *)
  {*< when this RELATION was defined  }
(* Const before type ignored *)
  {*< number of associated MEMBERs (may be zero)  }
(* Const before type ignored *)
  {*< array of MEMBER objects (may be NULL)  }
(* Const before type ignored *)
  {*< number of associated TAGs (may be zero)  }
(* Const before type ignored *)
  {*< array of TAG objects (may be NULL)  }
    Preadosm_relation_struct = ^readosm_relation_struct;
    readosm_relation_struct = record
        id : int64;
        version : longint;
        changeset : int64;
        user : Pchar;
        uid : longint;
        timestamp : Pchar;
        member_count : longint;
        members : Preadosm_member;
        tag_count : longint;
        tags : Preadosm_tag;
      end;

  {*
       Typedef for RELATION structure.
       
       \sa readosm_relation_struct
        }
    readosm_relation_struct = readosm_relation;
  {* callback function handling NODE objects  }
(* Const before type ignored *)
(* Const before type ignored *)

    readosm_node_callback = function (user_data:pointer; var node:readosm_node):longint;cdecl;
  {* callback function handling WAY objects  }
(* Const before type ignored *)
(* Const before type ignored *)

    readosm_way_callback = function (user_data:pointer; var way:readosm_way):longint;cdecl;
  {* callback function handling RELATION objects  }
(* Const before type ignored *)
(* Const before type ignored *)

    readosm_relation_callback = function (user_data:pointer; var relation:readosm_relation):longint;cdecl;
  {*
       Open the .osm or .pbf file, preparing for future functions
       
       \param path full or relative pathname of the input file.
       \param osm_handle an opaque reference (handle) to be used in each
       subsequent function (return value).
  
       \return READOSM_OK will be returned on success, otherwise any appropriate
       error code on failure.
  
       \note You are expected to readosm_close() even on failure, so as to
       correctly release any dynamic memory allocation.
        }
(* error 
    READOSM_DECLARE int readosm_open (const char *path,
in declaration at line 267 *)
    {* 
         Close the .osm or .pbf file and release any allocated resource
    
        \param osm_handle the handle previously returned by readosm_open()
    
        \return READOSM_OK will be returned on success, otherwise any appropriate
         error code on failure.
        
        \note After calling readosm_close() any related resource will be released,
        and the handle will no longer be valid.
         }
(* error 
    READOSM_DECLARE int readosm_close (const void *osm_handle);
in declaration at line 280 *)
    {* 
         Close the .osm or .pbf file and release any allocated resource
    
        \param osm_handle the handle previously returned by readosm_open()
    	\param user_data pointer to some user-supplied data struct
    	\param node_fnct pointer to callback function intended to consume NODE objects 
    	(may be NULL if processing NODEs is not an interesting option)
    	\param way_fnct pointer to callback function intended to consume WAY objects 
    	(may be NULL if processing WAYs is not an interesting option)
    	\param relation_fnct pointer to callback function intended to consume RELATION objects 
    	(may be NULL if processing RELATIONs is not an interesting option)
    
        \return READOSM_OK will be returned on success, otherwise any appropriate
         error code on failure.
        
        \note After calling readosm_close() any related resource will be released,
        and the handle will no longer be valid.
         }
(* error 
    READOSM_DECLARE int readosm_parse (const void *osm_handle,
in declaration at line 304 *)
    {*
         Return the current ReadOSM version
         
         \return a text string corresponding the current ReadOSM version
    	 }
(* error 
    READOSM_DECLARE const char * readosm_version (void);
 in declarator_list *)
    {*
         Return the current libexpat version used by ReadOSM
         
         \return a text string corresponding the current Expat version
    	 }
(* error 
    READOSM_DECLARE const char * readosm_expat_version (void);
 in declarator_list *)
    {*
         Return the current zlib version used by ReadOSM
         
         \return a text string corresponding the current zlib version
    	 }
(* error 
    READOSM_DECLARE const char * readosm_zlib_version (void);
 in declarator_list *)
{ C++ end of extern C conditionnal removed }
{$endif}
    { _READOSM_H  }

implementation

  { was #define dname def_expr }
  function READOSM_DECLARE : longint; { return type might be wrong }
    begin
      READOSM_DECLARE:=__declspec(dllexport);
    end;

    { was #define dname def_expr }
    function READOSM_DECLARE : longint; { return type might be wrong }
      begin
        READOSM_DECLARE:=__attribute__(visibility('default'));
      end;

  { was #define dname def_expr }
  function READOSM_PRIVATE : longint; { return type might be wrong }
    begin
      READOSM_PRIVATE:=__attribute__(visibility('hidden'));
    end;


end.
