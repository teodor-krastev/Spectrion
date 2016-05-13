unit MassLynxReadU;

interface

uses Classes, Dialogs, Sysutils, Forms, Controls, StdCtrls, clipbrd, Math,
  Windows, SpecU;

type

  TMassLynx = class
  private
    OpenMassLynxData: procedure(pwError, psRAWDirectory, paMass, paIntensity,
      paTIC, paRetTime, paPeakNumberByScan: Pointer); stdcall;
    GetFileParameters: procedure(pwError, psRAWDirectory, pTotPeakNumber,
      pnScans, pwAcquisitionType: Pointer); stdcall;
    function CallOpenMassLynxData(sRAWDirectory: string;
      var aMass, aIntensity, aTIC, aRetTime: array of single;
      var aPeakNumberByScan: array of integer): boolean;
    function CallGetFileParameters(sRAWDirectory: string;
      var TotPeakNumber, nScans: integer; var wAcquisitionType: Word): boolean;
  public
    Spec: TSpec;
    function Open(sRAWDirectory: string): boolean;
    function ReadSpectrum(sRAWDirectory: string; iIndex: integer): tXYarray;
  end;

implementation
uses DelphiDeclarations, SpOptU, SpMathU, AboutU;

function TMassLynx.Open(sRAWDirectory: string): Boolean;
var
  aMass, aIntensity, aTIC, aRetTime: array of Single;
  aPeakNumberByScan: array of Integer;
  nTotPeakNumber, nScans: Integer;
  wAcquisitionType: Word; i, j: Integer; wMass: tXYArray;
begin
  Result := False;
  Spec.AutoRefresh := False;
  // Get the RAW parameters
  if CallGetFileParameters(sRAWDirectory, nTotPeakNumber, nScans,
    wAcquisitionType) then
  begin
    // Set array sizes
    SetLength(aMass, nTotPeakNumber);
    SetLength(aIntensity, nTotPeakNumber);
    SetLength(aTIC, nScans);
    SetLength(aRetTime, nScans);
    SetLength(aPeakNumberByScan, nScans);

    // Get the Scan Data
    if CallOpenMassLynxData(sRAWDirectory, aMass, aIntensity, aTIC, aRetTime,
      aPeakNumberByScan) then
    begin
      j := 0;
      for i := 0 to nTotPeakNumber - 1 do
      begin
        if i = 0 then
        begin
          if aIntensity[i] <> 0 then
          begin
            SetLength(wMass, Length(wMass) + 1);
            wMass[Length(wMass) - 1][X] := aMass[i];
            wMass[Length(wMass) - 1][Y] := aIntensity[i];
          end;
        end
        else if (aMass[i] > aMass[i - 1]) and (aIntensity[i] <> 0) then
        // In Peak
        begin
          SetLength(wMass, Length(wMass) + 1);
          wMass[Length(wMass) - 1][X] := aMass[i];
          wMass[Length(wMass) - 1][Y] := aIntensity[i];
        end
        else if (aMass[i] < aMass[i - 1]) then // New Peak
        begin
          Spec.AddSSpec(aRetTime[j] * 60, aTIC[j], wMass); // Add Spec
          Inc(j);
          SetLength(wMass, 0);
          if aIntensity[i] <> 0 then
          begin
            SetLength(wMass, 1);
            wMass[0][X] := aMass[i];
            wMass[0][Y] := aIntensity[i];
          end;
        end;
      end;
      Result := True;
    end;
  end;
  Spec.AutoRefresh := True;
end; { TMassLynx.Open }

function TMassLynx.ReadSpectrum(sRAWDirectory: string; iIndex: Integer): tXYArray;
var
  aMass, aIntensity, aTIC, aRetTime: array of Single;
  aPeakNumberByScan: array of Integer;  nTotPeakNumber, nScans: Integer;
  wAcquisitionType: Word; i, nScanIndex: Integer;  wMass: tXYArray;
begin
  Result := wMass;
  // Get the RAW parameters
  if CallGetFileParameters(sRAWDirectory, nTotPeakNumber, nScans,
    wAcquisitionType) then
  begin
    if iIndex >= nScans then
      exit;
    // Set array sizes
    SetLength(aMass, nTotPeakNumber);
    SetLength(aIntensity, nTotPeakNumber);
    SetLength(aTIC, nScans);
    SetLength(aRetTime, nScans);
    SetLength(aPeakNumberByScan, nScans);

    // Get the Scan Data
    if CallOpenMassLynxData(sRAWDirectory, aMass, aIntensity, aTIC, aRetTime,
      aPeakNumberByScan) then
    begin
      SetLength(wMass, aPeakNumberByScan[iIndex]);
      nScanIndex := 0;
      for i := 0 to iIndex - 1 do
        nScanIndex := nScanIndex + aPeakNumberByScan[i];
      for i := 0 to aPeakNumberByScan[iIndex] - 1 do
      begin
        wMass[i][X] := aMass[nScanIndex + i];
        wMass[i][Y] := aIntensity[nScanIndex + i];
      end;
      Result := wMass;
    end;
  end;
end; { TMassLynx.ReadSpectrum }

function TMassLynx.CallGetFileParameters(sRAWDirectory: string;
  var TotPeakNumber, nScans: Integer; var wAcquisitionType: Word): Boolean;
var
  wError: Word;  dllPath: string;  dllHandle: Integer;
begin
  Result := False;
  // Call Spectrion
  wError := 1;
  dllPath := ExePath;
  if not FileExists(dllPath + 'GETRUNPA.DLL') then
  begin
    ShowMessage(dllPath + 'GETRUNPA.DLL not found');
    exit;
  end;
  dllHandle := LoadLibrary(Pchar(dllPath + 'GETRUNPA.DLL'));
  if dllHandle <> 0 then
  begin
    @GetFileParameters := GetProcAddress(dllHandle, 'GetFileParameters');
    if @GetFileParameters <> nil then
      GetFileParameters(@wError, @sRAWDirectory, @TotPeakNumber, @nScans,
        @wAcquisitionType)
    else
    begin
      Application.MessageBox('Unable to call function in GETRUNPA',
        'Spectrion Error');
      exit;
    end;
    FreeLibrary(dllHandle);
  end
  else
  begin
    Application.MessageBox('Cannot load VGOpenIO.dll', 'Spectrion Error');
    exit;
  end;
  if wError <> 0 then
  begin
    case wError of
      5:
        Application.MessageBox('Unknow data format', 'Spectrion Error');
      7:
        Application.MessageBox('Out of memory', 'Spectrion Error');
      9:
        Application.MessageBox('Subscript/Pointer out of range',
          'Spectrion Error');
      24:
        Application.MessageBox('Device Time-Out', 'Spectrion Error');
      51:
        Application.MessageBox('Internal error', 'Spectrion Error');
      52:
        Application.MessageBox('Bad file name or number', 'Spectrion Error');
      53:
        Application.MessageBox('File not found', 'Spectrion Error');
      54:
        Application.MessageBox('Bad file mode', 'Spectrion Error');
      55:
        Application.MessageBox('File is already open', 'Spectrion Error');
      57:
        Application.MessageBox('Device I/O error', 'Spectrion Error');
      58:
        Application.MessageBox('File already exists', 'Spectrion Error');
      61:
        Application.MessageBox('Disk full', 'Spectrion Error');
      62:
        Application.MessageBox('Input past end', 'Spectrion Error');
      63:
        Application.MessageBox('Bad record number', 'Spectrion Error');
      64:
        Application.MessageBox('Bad file name', 'Spectrion Error');
      67:
        Application.MessageBox('Too many files', 'Spectrion Error');
      68:
        Application.MessageBox('Device unavailable', 'Spectrion Error');
      70:
        Application.MessageBox('Permission denied', 'Spectrion Error');
      71:
        Application.MessageBox('Disk not ready', 'Spectrion Error');
      72:
        Application.MessageBox('Disk media error', 'Spectrion Error');
      74:
        Application.MessageBox('Rename across disks', 'Spectrion Error');
      75:
        Application.MessageBox('Path/file access error', 'Spectrion Error');
      76:
        Application.MessageBox('Path not found', 'Spectrion Error');
    else
      Application.MessageBox('Filter Error', 'Spectrion Error');
    end;
  end
  else
    Result := True;
end; { TMassLynx.CallGetFileParameters }

function TMassLynx.CallOpenMassLynxData(sRAWDirectory: string;
  var aMass, aIntensity, aTIC, aRetTime: array of Single;
  var aPeakNumberByScan: array of Integer): Boolean;
var
  wError: Word;  dllPath: string;  dllHandle: Integer;
begin
  Result := False;
  try
    wError := 1;
    dllPath := ExePath;
    if not FileExists(dllPath + 'VGOpenIO.DLL') then
    begin
      ShowMessage(dllPath + 'VGOpenIO.DLL not found');
      exit;
    end;
    dllHandle := LoadLibrary(Pchar(dllPath + 'VGOpenIO.dll'));
    if dllHandle <> 0 then
    begin
      @OpenMassLynxData := GetProcAddress(dllHandle, 'OpenMassLynxData');
      if @OpenMassLynxData <> nil then
        OpenMassLynxData(@wError, @sRAWDirectory, @aMass[0], @aIntensity[0],
          @aTIC[0], @aRetTime[0], @aPeakNumberByScan[0])
      else
      begin
        Application.MessageBox('Unable to call function in VGOpenIO',
          'Spectrion Error');
        exit;
      end;
      FreeLibrary(dllHandle);
    end
    else
    begin
      Application.MessageBox('Cannot load VGOpenIO.dll', 'Spectrion Error');
      exit;
    end;
    // Show error (if any)
  finally
    if wError <> 0 then
    begin
      case wError of
        5:
          Application.MessageBox('Unknow data format', 'Spectrion Error');
        7:
          Application.MessageBox('Out of memory', 'Spectrion Error');
        9:
          Application.MessageBox('Subscript/Pointer out of range',
            'Spectrion Error');
        24:
          Application.MessageBox('Device Time-Out', 'Spectrion Error');
        51:
          Application.MessageBox('Internal error', 'Spectrion Error');
        52:
          Application.MessageBox('Bad file name or number', 'Spectrion Error');
        53:
          Application.MessageBox('File not found', 'Spectrion Error');
        54:
          Application.MessageBox('Bad file mode', 'Spectrion Error');
        55:
          Application.MessageBox('File is already open', 'Spectrion Error');
        57:
          Application.MessageBox('Device I/O error', 'Spectrion Error');
        58:
          Application.MessageBox('File already exists', 'Spectrion Error');
        61:
          Application.MessageBox('Disk full', 'Spectrion Error');
        62:
          Application.MessageBox('Input past end', 'Spectrion Error');
        63:
          Application.MessageBox('Bad record number', 'Spectrion Error');
        64:
          Application.MessageBox('Bad file name', 'Spectrion Error');
        67:
          Application.MessageBox('Too many files', 'Spectrion Error');
        68:
          Application.MessageBox('Device unavailable', 'Spectrion Error');
        70:
          Application.MessageBox('Permission denied', 'Spectrion Error');
        71:
          Application.MessageBox('Disk not ready', 'Spectrion Error');
        72:
          Application.MessageBox('Disk media error', 'Spectrion Error');
        74:
          Application.MessageBox('Rename across disks', 'Spectrion Error');
        75:
          Application.MessageBox('Path/file access error', 'Spectrion Error');
        76:
          Application.MessageBox('Path not found', 'Spectrion Error');
      else
        Application.MessageBox('Filter Error', 'Spectrion Error');
      end;
    end
    else
      Result := True;
  end;
end; { TMassLynx.CallOpenMassLynxData }

end.
