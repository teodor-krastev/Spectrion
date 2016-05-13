unit SPCN_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : $Revision:   1.130.1.0.1.0.1.6  $
// File generated on 26/03/2003 11:27:06 AM from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\Work\SPCN\SPCN.tlb (1)
// LIBID: {A0721783-FC10-46B0-8325-A06045BEE330}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINNT\System32\STDOLE2.TLB)
//   (2) v4.0 StdVCL, (C:\WINNT\System32\STDVCL40.DLL)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  SPCNMajorVersion = 1;
  SPCNMinorVersion = 0;

  LIBID_SPCN: TGUID = '{A0721783-FC10-46B0-8325-A06045BEE330}';

  IID_ICOM_SPCN: TGUID = '{3A71124A-ABA8-4F78-8525-45164BA25227}';
  DIID_ICOM_SPCNEvents: TGUID = '{86AD634A-17BC-40A8-B61A-808150AF3465}';
  CLASS_COM_SPCN: TGUID = '{D3419A8D-4CCD-41B6-ADDE-99B472FC6330}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ICOM_SPCN = interface;
  ICOM_SPCNDisp = dispinterface;
  ICOM_SPCNEvents = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  COM_SPCN = ICOM_SPCN;


// *********************************************************************//
// Interface: ICOM_SPCN
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3A71124A-ABA8-4F78-8525-45164BA25227}
// *********************************************************************//
  ICOM_SPCN = interface(IDispatch)
    ['{3A71124A-ABA8-4F78-8525-45164BA25227}']
    procedure Command(var InOutText: WideString; out Success: WordBool); safecall;
    procedure Procedur(const WhichProc: WideString; var PrmList: WideString; var Suc: WordBool); safecall;
    function Get_ExePath: WideString; safecall;
    procedure AbortExe; safecall;
    procedure GetSpec(Num: Integer; var SpecX: OleVariant; var SpecY: OleVariant); safecall;
    property ExePath: WideString read Get_ExePath;
  end;

// *********************************************************************//
// DispIntf:  ICOM_SPCNDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3A71124A-ABA8-4F78-8525-45164BA25227}
// *********************************************************************//
  ICOM_SPCNDisp = dispinterface
    ['{3A71124A-ABA8-4F78-8525-45164BA25227}']
    procedure Command(var InOutText: WideString; out Success: WordBool); dispid 1;
    procedure Procedur(const WhichProc: WideString; var PrmList: WideString; var Suc: WordBool); dispid 2;
    property ExePath: WideString readonly dispid 4;
    procedure AbortExe; dispid 6;
    procedure GetSpec(Num: Integer; var SpecX: OleVariant; var SpecY: OleVariant); dispid 3;
  end;

// *********************************************************************//
// DispIntf:  ICOM_SPCNEvents
// Flags:     (4096) Dispatchable
// GUID:      {86AD634A-17BC-40A8-B61A-808150AF3465}
// *********************************************************************//
  ICOM_SPCNEvents = dispinterface
    ['{86AD634A-17BC-40A8-B61A-808150AF3465}']
    procedure EventCommand(const Cmd: WideString; const Reply: WideString); dispid 1;
    procedure EventDvcState(const DvcName: WideString; OldSt: Integer; NewSt: Integer); dispid 2;
  end;

// *********************************************************************//
// The Class CoCOM_SPCN provides a Create and CreateRemote method to          
// create instances of the default interface ICOM_SPCN exposed by              
// the CoClass COM_SPCN. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCOM_SPCN = class
    class function Create: ICOM_SPCN;
    class function CreateRemote(const MachineName: string): ICOM_SPCN;
  end;

implementation

uses ComObj;

class function CoCOM_SPCN.Create: ICOM_SPCN;
begin
  Result := CreateComObject(CLASS_COM_SPCN) as ICOM_SPCN;
end;

class function CoCOM_SPCN.CreateRemote(const MachineName: string): ICOM_SPCN;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_COM_SPCN) as ICOM_SPCN;
end;

end.
