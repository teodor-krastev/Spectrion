unit DelphiDeclarations;

(*
  These declarations facilitate the use of netCDF.dll with Delphi v 5.0
  To use it, all you need is this file and netCDF.dll.  Put both of these
  files into the same directory as your project and compile.  In any of your
  units that call these functions add 'DelphiDeclarations' to your uses
  clause.
  After that, you should be able to call the routines in the straightforward
  manner.

  I created this file by taking the information in Appendix C - Summary of
  C Interface of the NetCDF User's Guide for C, Version 3, June 1997, and
  converting all the C function calls to pascal calls.

  I have done very little testing.  The only functions I have tested are
  nc_open, nc_strerror, nc_inq_libvers, nc_inq, nc_inq_dimid, nc_inq_varid,
  nc_get_var_float and nc_close which are basically the ones you need to read
  a netCDF file.  I have not tried to write a file using these calls.  I make
  no
  guarantees that any of this will work properly.

  Good luck, hope it works for you.
  Sandy Ballard
  Sandia National Laboratories
  Albuquerque, New Mexico, USA
  sballar@sandia.gov
  2/8/2001
*)

interface

type
  size_t = cardinal;
  ptrdiff_t = integer;
  nc_type = (NC_NAT, { NAT = 'Not A Type' (c.f. NaN) }
    NC_BYTE, { signed 1 byte integer }
    NC_CHAR, { ISO/ASCII character }
    NC_SHORT, { signed 2 byte integer }
    NC_INT, { signed 4 byte integer }
    NC_FLOAT, { single precision floating point number }
    NC_DOUBLE); { double precision floating point number }

function nc_inq_libvers: pAnsiChar; cdecl; external 'netcdf.DLL';
function nc_strerror(ncerr: integer): pAnsiChar; cdecl; external 'netcdf.DLL';
function nc_create(path: PAnsiChar; cmode: integer; var ncidp: integer): integer;
  cdecl; external 'netcdf.DLL';
function nc_open(path: pAnsiChar; mode: integer; var ncidp: integer): integer;
  cdecl; external 'netcdf.DLL';
function nc_set_fill(ncid: integer; fillmode: integer; var old_modep: integer)
  : integer; cdecl; external 'netcdf.DLL';
function nc_redef(ncid: integer): integer; cdecl; external 'netcdf.DLL';
function nc_enddef(ncid: integer): integer; cdecl; external 'netcdf.DLL';
function nc_sync(ncid: integer): integer; cdecl; external 'netcdf.DLL';
function nc_abort(ncid: integer): integer; cdecl; external 'netcdf.DLL';
function nc_close(ncid: integer): integer; cdecl; external 'netcdf.DLL';
function nc_inq(ncid: integer; var ndimsp: integer; var nvarsp: integer;
  var ngattsp: integer; var unlimdimidp: integer): integer; cdecl;
  external 'netcdf.DLL';
function nc_inq_ndims(ncid: integer; var ndimsp: integer): integer; cdecl;
  external 'netcdf.DLL';
function nc_inq_nvars(ncid: integer; var nvarsp: integer): integer; cdecl;
  external 'netcdf.DLL';
function nc_inq_natts(ncid: integer; var ngattsp: integer): integer; cdecl;
  external 'netcdf.DLL';
function nc_inq_unlimdim(ncid: integer; var unlimdimidp: integer): integer;
  cdecl; external 'netcdf.DLL';
function nc_def_dim(ncid: integer; name: PAnsiChar; len: size_t; var idp: integer)
  : integer; cdecl; external 'netcdf.DLL';
function nc_inq_dimid(ncid: integer; name: PAnsiChar; var idp: integer): integer;
  cdecl; external 'netcdf.DLL';
function nc_inq_dim(ncid: integer; dimid: integer; name: PAnsiChar;
  var lenp: size_t): integer; cdecl; external 'netcdf.DLL';
function nc_inq_dimname(ncid: integer; dimid: integer; name: PAnsiChar): integer;
  cdecl; external 'netcdf.DLL';
function nc_inq_dimlen(ncid: integer; dimid: integer; var lenp: size_t)
  : integer; cdecl; external 'netcdf.DLL';
function nc_rename_dim(ncid: integer; dimid: integer; name: PAnsiChar): integer;
  cdecl; external 'netcdf.DLL';
function nc_def_var(ncid: integer; name: PAnsiChar; xtype: nc_type; ndims: integer;
  var dimidsp: integer; var varidp: integer): integer; cdecl;
  external 'netcdf.DLL';
function nc_inq_var(ncid: integer; varid: integer; name: PAnsiChar;
  var xtypep: nc_type; var ndimsp: integer; var dimidsp: integer;
  var nattsp: integer): integer; cdecl; external 'netcdf.DLL';
function nc_inq_varid(ncid: integer; name: PAnsiChar; var varidp: integer): integer;
  cdecl; external 'netcdf.DLL';
function nc_inq_varname(ncid: integer; varid: integer; name: PAnsiChar): integer;
  cdecl; external 'netcdf.DLL';
function nc_inq_vartype(ncid: integer; varid: integer; var xtypep: nc_type)
  : integer; cdecl; external 'netcdf.DLL';
function nc_inq_varndims(ncid: integer; varid: integer; var ndimsp: integer)
  : integer; cdecl; external 'netcdf.DLL';
function nc_inq_vardimid(ncid: integer; varid: integer; var dimidsp: integer)
  : integer; cdecl; external 'netcdf.DLL';
function nc_inq_varnatts(ncid: integer; varid: integer; var nattsp: integer)
  : integer; cdecl; external 'netcdf.DLL';
function nc_rename_var(ncid: integer; varid: integer; name: PAnsiChar): integer;
  cdecl; external 'netcdf.DLL';
function nc_put_var_text(ncid: integer; varid: integer; op: PAnsiChar): integer;
  cdecl; external 'netcdf.DLL';
function nc_get_var_text(ncid: integer; varid: integer; ip: PAnsiChar): integer;
  cdecl; external 'netcdf.DLL';
function nc_put_var_uchar(ncid: integer; varid: integer; op: pointer): integer;
  cdecl; external 'netcdf.DLL';
function nc_get_var_uchar(ncid: integer; varid: integer; ip: pointer): integer;
  cdecl; external 'netcdf.DLL';
function nc_put_var_schar(ncid: integer; varid: integer; op: pointer): integer;
  cdecl; external 'netcdf.DLL';
function nc_get_var_schar(ncid: integer; varid: integer; ip: pointer): integer;
  cdecl; external 'netcdf.DLL';
function nc_put_var_short(ncid: integer; varid: integer; op: pointer): integer;
  cdecl; external 'netcdf.DLL';
function nc_get_var_short(ncid: integer; varid: integer; ip: pointer): integer;
  cdecl; external 'netcdf.DLL';
function nc_put_var_int(ncid: integer; varid: integer; op: pointer): integer;
  cdecl; external 'netcdf.DLL';
function nc_get_var_int(ncid: integer; varid: integer; ip: pointer): integer;
  cdecl; external 'netcdf.DLL';
function nc_put_var_long(ncid: integer; varid: integer; op: pointer): integer;
  cdecl; external 'netcdf.DLL';
function nc_get_var_long(ncid: integer; varid: integer; ip: pointer): integer;
  cdecl; external 'netcdf.DLL';
function nc_put_var_float(ncid: integer; varid: integer; op: pointer): integer;
  cdecl; external 'netcdf.DLL';
function nc_get_var_float(ncid: integer; varid: integer; ip: pointer): integer;
  cdecl; external 'netcdf.DLL';
function nc_put_var_double(ncid: integer; varid: integer; op: pointer): integer;
  cdecl; external 'netcdf.DLL';
function nc_get_var_double(ncid: integer; varid: integer; ip: pointer): integer;
  cdecl; external 'netcdf.DLL';
function nc_put_var1_text(ncid: integer; varid: integer; var indexp: size_t;
  op: PAnsiChar): integer; cdecl; external 'netcdf.DLL';
function nc_get_var1_text(ncid: integer; varid: integer; var indexp: size_t;
  ip: PAnsiChar): integer; cdecl; external 'netcdf.DLL';
function nc_put_var1_uchar(ncid: integer; varid: integer; var indexp: size_t;
  op: pointer): integer; cdecl; external 'netcdf.DLL';
function nc_get_var1_uchar(ncid: integer; varid: integer; var indexp: size_t;
  ip: pointer): integer; cdecl; external 'netcdf.DLL';
function nc_put_var1_schar(ncid: integer; varid: integer; var indexp: size_t;
  op: pointer): integer; cdecl; external 'netcdf.DLL';
function nc_get_var1_schar(ncid: integer; varid: integer; var indexp: size_t;
  ip: pointer): integer; cdecl; external 'netcdf.DLL';
function nc_put_var1_short(ncid: integer; varid: integer; var indexp: size_t;
  op: pointer): integer; cdecl; external 'netcdf.DLL';
function nc_get_var1_short(ncid: integer; varid: integer; var indexp: size_t;
  ip: pointer): integer; cdecl; external 'netcdf.DLL';
function nc_put_var1_int(ncid: integer; varid: integer; var indexp: size_t;
  op: pointer): integer; cdecl; external 'netcdf.DLL';
function nc_get_var1_int(ncid: integer; varid: integer; var indexp: size_t;
  ip: pointer): integer; cdecl; external 'netcdf.DLL';
function nc_put_var1_long(ncid: integer; varid: integer; var indexp: size_t;
  op: pointer): integer; cdecl; external 'netcdf.DLL';
function nc_get_var1_long(ncid: integer; varid: integer; var indexp: size_t;
  ip: pointer): integer; cdecl; external 'netcdf.DLL';
function nc_put_var1_float(ncid: integer; varid: integer; var indexp: size_t;
  op: pointer): integer; cdecl; external 'netcdf.DLL';
function nc_get_var1_float(ncid: integer; varid: integer; var indexp: size_t;
  ip: pointer): integer; cdecl; external 'netcdf.DLL';
function nc_put_var1_double(ncid: integer; varid: integer; var indexp: size_t;
  op: pointer): integer; cdecl; external 'netcdf.DLL';
function nc_get_var1_double(ncid: integer; varid: integer; var indexp: size_t;
  ip: pointer): integer; cdecl; external 'netcdf.DLL';
function nc_put_vara_text(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; op: PAnsiChar): integer; cdecl; external 'netcdf.DLL';
function nc_get_vara_text(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; ip: PAnsiChar): integer; cdecl; external 'netcdf.DLL';
function nc_put_vara_uchar(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; op: pointer): integer; cdecl; external 'netcdf.DLL';
function nc_get_vara_uchar(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; ip: pointer): integer; cdecl; external 'netcdf.DLL';
function nc_put_vara_schar(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; op: pointer): integer; cdecl; external 'netcdf.DLL';
function nc_get_vara_schar(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; ip: pointer): integer; cdecl; external 'netcdf.DLL';
function nc_put_vara_short(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; op: pointer): integer; cdecl; external 'netcdf.DLL';
function nc_get_vara_short(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; ip: pointer): integer; cdecl; external 'netcdf.DLL';
function nc_put_vara_int(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; op: pointer): integer; cdecl; external 'netcdf.DLL';
function nc_get_vara_int(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; ip: pointer): integer; cdecl; external 'netcdf.DLL';
function nc_put_vara_long(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; op: pointer): integer; cdecl; external 'netcdf.DLL';
function nc_get_vara_long(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; ip: pointer): integer; cdecl; external 'netcdf.DLL';
function nc_put_vara_float(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; op: pointer): integer; cdecl; external 'netcdf.DLL';
function nc_get_vara_float(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; ip: pointer): integer; cdecl; external 'netcdf.DLL';
function nc_put_vara_double(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; op: pointer): integer; cdecl; external 'netcdf.DLL';
function nc_get_vara_double(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; ip: pointer): integer; cdecl; external 'netcdf.DLL';
function nc_put_vars_text(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; var stridep: ptrdiff_t; op: PAnsiChar): integer; cdecl;
  external 'netcdf.DLL';
function nc_get_vars_text(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; var stridep: ptrdiff_t; ip: PAnsiChar): integer; cdecl;
  external 'netcdf.DLL';
function nc_put_vars_uchar(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; var stridep: ptrdiff_t; op: pointer): integer; cdecl;
  external 'netcdf.DLL';
function nc_get_vars_uchar(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; var stridep: ptrdiff_t; ip: pointer): integer; cdecl;
  external 'netcdf.DLL';
function nc_put_vars_schar(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; var stridep: ptrdiff_t; op: pointer): integer; cdecl;
  external 'netcdf.DLL';
function nc_get_vars_schar(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; var stridep: ptrdiff_t; ip: pointer): integer; cdecl;
  external 'netcdf.DLL';
function nc_put_vars_short(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; var stridep: ptrdiff_t; op: pointer): integer; cdecl;
  external 'netcdf.DLL';
function nc_get_vars_short(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; var stridep: ptrdiff_t; ip: pointer): integer; cdecl;
  external 'netcdf.DLL';
function nc_put_vars_int(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; var stridep: ptrdiff_t; op: pointer): integer; cdecl;
  external 'netcdf.DLL';
function nc_get_vars_int(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; var stridep: ptrdiff_t; ip: pointer): integer; cdecl;
  external 'netcdf.DLL';
function nc_put_vars_long(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; var stridep: ptrdiff_t; op: pointer): integer; cdecl;
  external 'netcdf.DLL';
function nc_get_vars_long(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; var stridep: ptrdiff_t; ip: pointer): integer; cdecl;
  external 'netcdf.DLL';
function nc_put_vars_float(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; var stridep: ptrdiff_t; op: pointer): integer; cdecl;
  external 'netcdf.DLL';
function nc_get_vars_float(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; var stridep: ptrdiff_t; ip: pointer): integer; cdecl;
  external 'netcdf.DLL';
function nc_put_vars_double(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; var stridep: ptrdiff_t; op: pointer): integer; cdecl;
  external 'netcdf.DLL';
function nc_get_vars_double(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; var stridep: ptrdiff_t; ip: pointer): integer; cdecl;
  external 'netcdf.DLL';
function nc_put_varm_text(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; var stridep: ptrdiff_t; var imapp: ptrdiff_t; op: PAnsiChar)
  : integer; cdecl; external 'netcdf.DLL';
function nc_get_varm_text(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; var stridep: ptrdiff_t; var imapp: ptrdiff_t; ip: PAnsiChar)
  : integer; cdecl; external 'netcdf.DLL';
function nc_put_varm_uchar(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; var stridep: ptrdiff_t; var imapp: ptrdiff_t; op: pointer)
  : integer; cdecl; external 'netcdf.DLL';
function nc_get_varm_uchar(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; var stridep: ptrdiff_t; var imapp: ptrdiff_t; ip: pointer)
  : integer; cdecl; external 'netcdf.DLL';
function nc_put_varm_schar(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; var stridep: ptrdiff_t; var imapp: ptrdiff_t; op: pointer)
  : integer; cdecl; external 'netcdf.DLL';
function nc_get_varm_schar(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; var stridep: ptrdiff_t; var imapp: ptrdiff_t; ip: pointer)
  : integer; cdecl; external 'netcdf.DLL';
function nc_put_varm_short(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; var stridep: ptrdiff_t; var imapp: ptrdiff_t; op: pointer)
  : integer; cdecl; external 'netcdf.DLL';
function nc_get_varm_short(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; var stridep: ptrdiff_t; var imapp: ptrdiff_t; ip: pointer)
  : integer; cdecl; external 'netcdf.DLL';
function nc_put_varm_int(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; var stridep: ptrdiff_t; var imapp: ptrdiff_t; op: pointer)
  : integer; cdecl; external 'netcdf.DLL';
function nc_get_varm_int(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; var stridep: ptrdiff_t; var imapp: ptrdiff_t; ip: pointer)
  : integer; cdecl; external 'netcdf.DLL';
function nc_put_varm_long(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; var stridep: ptrdiff_t; var imapp: ptrdiff_t; op: pointer)
  : integer; cdecl; external 'netcdf.DLL';
function nc_get_varm_long(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; var stridep: ptrdiff_t; var imapp: ptrdiff_t; ip: pointer)
  : integer; cdecl; external 'netcdf.DLL';
function nc_put_varm_float(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; var stridep: ptrdiff_t; var imapp: ptrdiff_t; op: pointer)
  : integer; cdecl; external 'netcdf.DLL';
function nc_get_varm_float(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; var stridep: ptrdiff_t; var imapp: ptrdiff_t; ip: pointer)
  : integer; cdecl; external 'netcdf.DLL';
function nc_put_varm_double(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; var stridep: ptrdiff_t; var imapp: ptrdiff_t; op: pointer)
  : integer; cdecl; external 'netcdf.DLL';
function nc_get_varm_double(ncid: integer; varid: integer; var startp: size_t;
  var countp: size_t; var stridep: ptrdiff_t; var imapp: ptrdiff_t; ip: pointer)
  : integer; cdecl; external 'netcdf.DLL';
function nc_inq_att(ncid: integer; varid: integer; name: PAnsiChar;
  var xtypep: nc_type; var lenp: size_t): integer; cdecl; external 'netcdf.DLL';
function nc_inq_attid(ncid: integer; varid: integer; name: PAnsiChar;
  var idp: integer): integer; cdecl; external 'netcdf.DLL';
function nc_inq_atttype(ncid: integer; varid: integer; name: PAnsiChar;
  var xtypep: nc_type): integer; cdecl; external 'netcdf.DLL';
function nc_inq_attlen(ncid: integer; varid: integer; name: PAnsiChar;
  var lenp: size_t): integer; cdecl; external 'netcdf.DLL';
function nc_inq_attname(ncid: integer; varid: integer; attnum: integer;
  name: PAnsiChar): integer; cdecl; external 'netcdf.DLL';
function nc_copy_att(ncid_in: integer; varid_in: integer; name: PAnsiChar;
  ncid_out: integer; varid_out: integer): integer; cdecl; external 'netcdf.DLL';
function nc_rename_att(ncid: integer; varid: integer; name: PAnsiChar;
  newname: PAnsiChar): integer; cdecl; external 'netcdf.DLL';
function nc_del_att(ncid: integer; varid: integer; name: PAnsiChar): integer; cdecl;
  external 'netcdf.DLL';
function nc_put_att_text(ncid: integer; varid: integer; name: PAnsiChar;
  len: size_t; op: PAnsiChar): integer; cdecl; external 'netcdf.DLL';
function nc_get_att_text(ncid: integer; varid: integer; name: PAnsiChar; ip: PAnsiChar)
  : integer; cdecl; external 'netcdf.DLL';
function nc_put_att_uchar(ncid: integer; varid: integer; name: PAnsiChar;
  xtype: nc_type; len: size_t; var op: byte): integer; cdecl;
  external 'netcdf.DLL';
function nc_get_att_uchar(ncid: integer; varid: integer; name: PAnsiChar;
  var ip: byte): integer; cdecl; external 'netcdf.DLL';
function nc_put_att_schar(ncid: integer; varid: integer; name: PAnsiChar;
  xtype: nc_type; len: size_t; var op: shortint): integer; cdecl;
  external 'netcdf.DLL';
function nc_get_att_schar(ncid: integer; varid: integer; name: PAnsiChar;
  var ip: shortint): integer; cdecl; external 'netcdf.DLL';
function nc_put_att_short(ncid: integer; varid: integer; name: PAnsiChar;
  xtype: nc_type; len: size_t; var op: smallint): integer; cdecl;
  external 'netcdf.DLL';
function nc_get_att_short(ncid: integer; varid: integer; name: PAnsiChar;
  var ip: smallint): integer; cdecl; external 'netcdf.DLL';
function nc_put_att_int(ncid: integer; varid: integer; name: PAnsiChar;
  xtype: nc_type; len: size_t; var op: integer): integer; cdecl;
  external 'netcdf.DLL';
function nc_get_att_int(ncid: integer; varid: integer; name: PAnsiChar;
  var ip: integer): integer; cdecl; external 'netcdf.DLL';
function nc_put_att_long(ncid: integer; varid: integer; name: PAnsiChar;
  xtype: nc_type; len: size_t; var op: integer): integer; cdecl;
  external 'netcdf.DLL';
function nc_get_att_long(ncid: integer; varid: integer; name: PAnsiChar;
  var ip: integer): integer; cdecl; external 'netcdf.DLL';
function nc_put_att_float(ncid: integer; varid: integer; name: PAnsiChar;
  xtype: nc_type; len: size_t; var op: single): integer; cdecl;
  external 'netcdf.DLL';
function nc_get_att_float(ncid: integer; varid: integer; name: PAnsiChar;
  var ip: single): integer; cdecl; external 'netcdf.DLL';
function nc_put_att_double(ncid: integer; varid: integer; name: PAnsiChar;
  xtype: nc_type; len: size_t; var op: double): integer; cdecl;
  external 'netcdf.DLL';
function nc_get_att_double(ncid: integer; varid: integer; name: PAnsiChar;
  var ip: double): integer; cdecl; external 'netcdf.DLL';

function str2pac(stringVar : string) : PAnsiChar;  //String2PAnsiChar

implementation
uses SysUtils;

function str2pac(stringVar : string) : PAnsiChar;
Var
  AnsString : AnsiString;
  InternalError : Boolean;
begin
  InternalError := false;
  Result := '';
  try
    if stringVar <> '' Then
    begin
       AnsString := AnsiString(StringVar);
       Result := PAnsiChar(PAnsiString(AnsString));
    end;
  Except
    InternalError := true;
  end;
  if InternalError or (String(Result) <> stringVar) then
  begin
    Raise Exception.Create('Conversion from string to PAnsiChar failed!');
  end;
end;

end.
