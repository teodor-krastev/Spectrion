unit HDIndexU;

interface

uses Classes, Dialogs, Sysutils, Forms, Controls, StdCtrls, HKProgressBr;

type
  rCalibrationStructureOldFloat=record                            // Size=2560
    mass:array[0..15, 0..1, 0..1, 0..1, 0..1]of Single;
    intensity:array[0..15, 0..1, 0..1, 0..1, 0..1]of Single;
    Valid:array[0..15, 0..1, 0..1, 0..1, 0..1]of Word;
  end;

  rRun_Stats=record                                               //Size=9294
    magic:Word;
    software_version_number:array[0..3]of Char;
    machine_type:Word;
    creation_date:Cardinal;
    old_default_calibration:rCalibrationStructureOldFloat;
    old_created_calibration:rCalibrationStructureOldFloat;
    old_current_calibration:rCalibrationStructureOldFloat;
    number_of_scans:Word;
    comment_fields:array[0..1593]of Char;
    theos_zero_flag:array[0..1]of Char; theos_zero: single;
  end;

  rScan_stats=Record                                              //Size=80
    scan_number:Word;
    stored_mode:Word;
    number_of_shots_per_scan:Cardinal;
    number_of_scans_per_second:Single;
    tagged:Word;
    scan_time:Cardinal;
    max_peak_height_per_single_scan:Integer;
    max_mv_per_single_shot:Integer;
    max_peak_height:Integer;
    total_peak_area:Integer;
    scan_record_length:Cardinal;
    positive_ion:Word;
    high_mass_range:Word;
    reflectron:Word;
    raster_x_on:Word;
    raster_y_on:Word;
    x_position:Word;
    y_position:Word;
    laser_power:Word;
    laser_2_power:Word;
    parent_mass:Single;
    laser_2_time:Word;
    scan_x_then_y:Word;
    data_source:Word;
    sample_number:Word;
    m_tdc_length:Word;
    m_tdc_rate:Word;
    m_trans_rec_length:Word;
    m_trans_rec_rate:Word;
    ions_per_adc_bit:Single;
  end;

  Mass_Table=record                                   // Size=14
    mass:Real;
    intensity:Integer;
    flags:Word;
  end;

  THDIndex=Class
  private
    i_ActivePlot:Integer;
    s_FileName:string;
    ProgressBr: THKProgressBar;
    ErrorFlag: boolean;
    procedure RealIndexFile;
    function IsIndexed(sFileName:string):boolean;
    function GetIndexFileName(sFileName:string):string;
  public
    aIndexTable:array of Cardinal;
    aTIC, aRetTime:array of Single;
    function IndexFile(sFileName:string):boolean;
    destructor Destroy; override;
    property GetActivePlot:Integer read i_ActivePlot;
  end;

implementation

{$Q-}

uses SpecU, AboutU, Math;

destructor THDIndex.Destroy;
begin
  FreeAndNil(ProgressBr);
  Finalize(aIndexTable);
  Finalize(aTIC);
  Finalize(aRetTime);
  inherited;
end;

//----------------------------------------------------------------------------//
// Funciton: GetIndexFileName                                                 //
//                                                                            //
// Purpose: Returns the corresponding Index file name to the HD file.         //
//                                                                            //
// Parameters : sFileName:string, the complete path to the file               //
//                                                                            //
// Return Value: string : Complete path and name of the index file.           //
//----------------------------------------------------------------------------//
function THDIndex.GetIndexFileName(sFileName:string):string;
var
  ss:string;
begin
  ss:= ExtractFileExt(sFilename);
  if UpperCase(ss[2])<>'R' then ShowMessage('Error in HD file name');
  Result:= ChangeFileExt(sFileName,'.x'+copy(ss,3,2));
end;

//----------------------------------------------------------------------------//
// Funciton: IsIndexed                                                        //
//                                                                            //
// Purpose: Checks if the file has a valid index file associated to it.       //
//                                                                            //
// Parameters : sFileName:string, the complete path to the file               //
//                                                                            //
// Retrun Value : True, if the file has an index file,                        //
//                False otherwise.                                            //
//----------------------------------------------------------------------------//
function THDIndex.IsIndexed(sFileName:string):boolean;
var
  fHDFile, fIndexFile:File;
  nFileSize, nFileCreationTime, iFileSize, iFileCreationTime:Cardinal;
  rFileHeader:rRun_Stats;
  AmtTransferred:Integer;
  sIndexFileName:string;
begin Result:=False;
  sIndexFileName:=GetIndexFileName(sFileName);
  if not FileExists(sIndexFileName) then exit;
  // Open HD file
  AssignFile(fHDFile, sFileName);
  Reset(fHDFile, 1024);           // Get Filesize in KB
  nFileSize:=FileSize(fHDFile);
  Reset(fHDFile, 1);
  BlockRead(fHDFile, rFileHeader, 9294, AmtTransferred);  // Read HD file header
  if 9294<>AmtTransferred then
    raise Exception.Create('Error while reading HD run stats');
  nFileCreationTime:=rFileHeader.creation_date;

  // Find index File
  if FileExists(sIndexFileName) then
  begin
    AssignFile(fIndexFile, sIndexFileName);
    Reset(fIndexFile, 1);
    // authentify index file
    BlockRead(fIndexFile, iFileCreationTime, sizeOf(iFileCreationTime));
    BlockRead(fIndexFile, iFileSize, sizeOf(iFileSize));
    if(iFileCreationTime=nFileCreationTime)and(iFileSize=nFileSize)then
      Result:=True;
    CloseFile(fIndexFile);
  end;
  CloseFile(fHDFile);
end;


function THDIndex.IndexFile(sFileName:string):boolean;
var
  i: integer;
  fIndexFile:File;
  sIndexFileName: string;
  nScans: word;
begin Result:=False;
  s_FileName:= sFileName; 
	try
	  if not Assigned(ProgressBr) then
		begin
      ProgressBr:= THKProgressBar.Create(Application.MainForm);
		  ProgressBr.OnProcessItem:= RealIndexFile;
		  ProgressBr.Caption:= 'Indexing the file...';
		end;
	  if IsIndexed(sFileName) then
    begin
      sIndexFileName:= GetIndexFileName(sFileName);
		  AssignFile(fIndexFile, sIndexFileName);
		  Reset(fIndexFile, 1);

		  Seek(fIndexFile, 8);
		  BlockRead(fIndexFile, nScans, SizeOf(nScans));
		  SetLength(aTIC, nScans);
		  SetLength(aRetTime, nScans);
		  SetLength(aIndexTable,  nScans);
		  for i:=0 to nScans-1 do
			  BlockRead(fIndexFile, aTIC[i], SizeOf(aTIC[i]));
		  for i:=0 to nScans-1 do
			  BlockRead(fIndexFile, aRetTime[i], SizeOf(aRetTime[i]));
		  for i:=0 to nScans-1 do
			  BlockRead(fIndexFile, aIndexTable[i], sizeOf(aIndexTable[i]));
		  CloseFile(fIndexFile);
    end
    else ProgressBr.StartProgress(true);
	  if ErrorFlag then exit;
	  Result:=True;
	finally
  end;
end;

//----------------------------------------------------------------------------//
// Funciton: RealIndexFile                                                        //
//                                                                            //
// Purpose: Opens an HD formatted file, indexes it, loads the chorm and first //
//          spectrum information into memory and displays them into a         //
//          spectrum plot.                                                    //
//                                                                            //
// Parameters : sFileName:string, the complete path to the file               //
//                                                                            //
// Return Value: boolean : True if the file is opened and displayed,          //
//                         False otherwise                                    //
//----------------------------------------------------------------------------//
Procedure THDIndex.RealIndexFile;
var
  rScanStats:rScan_stats;
  rFileHeader:rRun_Stats;
  MI:Mass_Table;
  rMassTmp:tXYArray;
  fHDFile, fIndexFile:File;
  sIndexFileName: string;
  AmtTransferred, i, nScanStyle:Integer;
  bDone:Boolean;
  nScans:Word;
  nPeaks, nFileCreationTime, nFileSize:Cardinal;
begin  ErrorFlag:= true;
	try
		// Open HD file
		AssignFile(fHDFile, s_FileName);
		Reset(fHDFile, 1024);
		if FileSize(fHDFile)<24 then
		raise Exception.Create('The HD file is too small.');
		nFileSize:= FileSize(fHDFile);
		Reset(fHDFile, 1);
	
		// Read file header
		BlockRead(fHDFile, rFileHeader, 9294, AmtTransferred);
		if 9294<>AmtTransferred then
		raise Exception.Create('Error while reading HD run stats');
		nScans:= rFileHeader.number_of_scans;
		if nScans=0 then
		begin ShowMessage('Error while reading HD file');
			DeleteFile('Cashe.Dat');
			exit;
		end;
		nFileCreationTime:= rFileHeader.creation_date;
	
		// Mem allocation
		SetLength(aTIC, nScans);
		SetLength(aRetTime, nScans);
		SetLength(rMassTmp, 100000);
		SetLength(aIndexTable, nScans);
	
		// Positionning in file
		Seek(fHDFile, 14016+9294);
	
		// Start with first scan
		BlockRead(fHDFile, rScanStats, 80);
		nScanStyle:= rScanStats.stored_mode;
		if(nScanStyle=0)or(nScanStyle=1)then
		begin
			//IndexProfileFile(sFileName);
			Finalize(aRetTime);
			Finalize(aTIC);
			//CloseFile(fHDFile);
			//DeleteFile('Cashe.Dat');
			raise Exception.Create('RAW HD file format not supported.');
		end;
		if (nScanStyle<>0) and (nScanStyle<>1) and (nScanStyle<>2) and
			 (nScanStyle<>3) and (nScanStyle<>4) and (nScanStyle<>6) then
		  raise Exception.Create('Unexpected HD file format.');
		aIndexTable[0]:=FilePos(fHdFile);
		// Parameter initialization
		if rScanStats.number_of_scans_per_second= 0 then                     
		begin
      ShowMessage('Problem in R file (number_of_scans_per_second=0)');
      rScanStats.number_of_scans_per_second:= 1000;
		end;
		if isNAN(rFileHeader.theos_zero) or (rFileHeader.theos_zero>1E30) or
			 (rFileHeader.theos_zero_flag<>'TZ') then
      rFileHeader.theos_zero:= 0;
		aRetTime[0]:= rFileHeader.theos_zero + 1/rScanStats.number_of_scans_per_second;
		aTIC[0]:= 0.0;
		nPeaks:= 0;

		// Load only the first spectrum into memory
		repeat
			bDone:=False;
			BlockRead(fHDFile, MI, 14);
			if MI.mass<>0.0 then
			begin
				aTIC[0]:=aTIC[0]+MI.intensity;
				rMassTmp[nPeaks][X]:=MI.mass;
				rMassTmp[nPeaks][Y]:=MI.intensity;
				nPeaks:=nPeaks+1;
			end
			else    // Last mass so stop reading Mass_Table
				bDone:=True;
			if nPeaks>100000 then
			begin
				ShowMessage('Too many peaks have been read without a zero');
//				CloseFile(fHDFile);
//	      DeleteFile('Cashe.Dat');
				Finalize(aRetTime);
				Finalize(aTIC);
				exit;
			end;
		until bDone;
		{if nPeaks=0 then begin ErrorMsg('Zero number of masses is not allowed.'); exit;
										 end; }
	  Finalize(rMassTmp);        // Free Mem

		// Continue with the rest, but only index, not load
		for i:=1 to nScans-1 do
		begin                        // 4100 = max number of peaks
			if ProgressBr.UserCanceled then exit;
      ProgressBr.SetPosition(i,nScans);
      if((nScanStyle=2) OR (nScanStyle=3)) and (rFileHeader.magic<>$1235)then
        BlockRead(fHDFile, rScanStats, 80);
	
			// Index the cashe file
			aIndexTable[i]:=FilePos(fHdFile);

			// Parameter initialization
			if rScanStats.number_of_scans_per_second= 0 then
			begin
        ShowMessage('Problem in R file (number_of_scans_per_second=0)');
        rScanStats.number_of_scans_per_second:= 1000;
			end;
			if isNAN(rFileHeader.theos_zero) or (rFileHeader.theos_zero>1E30) or
				 (rFileHeader.theos_zero_flag<>'TZ')  then rFileHeader.theos_zero:= 0;
			aRetTime[i]:= rFileHeader.theos_zero + (i+1)/rScanStats.number_of_scans_per_second;
			aTIC[i]:=0.0;
			nPeaks:=0;

			repeat
				bDone:=False;
				BlockRead(fHDFile, MI, 14);
				if MI.mass<>0.0 then
				begin
					aTIC[i]:=aTIC[i]+MI.intensity;
					nPeaks:=nPeaks+1;
				end
				else
					bDone:=True;
				if nPeaks>100000 then
				begin
					ShowMessage('Too many peaks have been read without a zero');
//					CloseFile(fHDFile);
//	        DeleteFile('Cashe.Dat');
					Finalize(aRetTime);
					Finalize(aTIC);
					exit;
				end;
			until bDone;
    end;

    // Open Index File and write
    sIndexFileName:=GetIndexFileName(s_FileName);
    AssignFile(fIndexFile, sIndexFileName);
    {$I-}
    Rewrite(fIndexFile, 1);
    {$I+}
    if IOResult=19 then
    begin
      sIndexFileName:= RootPath+TempPath+ExtractFileName(sIndexFileName);
      AssignFile(fIndexFile, sIndexFileName);
      Rewrite(fIndexFile, 1);
    end;
		BlockWrite(fIndexFile, nFileCreationtime, sizeOf(nFileCreationTime));    // For UID
		BlockWrite(fIndexFile, nFileSize, sizeOf(nFileSize));                    // For UID
		BlockWrite(fIndexFile, nScans, sizeOf(nScans));
		for i:=0 to nScans-1 do
		  BlockWrite(fIndexFile, aTIC[i], sizeOf(aTIC[i]));
		for i:=0 to nScans-1 do
		  BlockWrite(fIndexFile, aRetTime[i], sizeOf(aRetTime[i]));
		for i:=0 to nScans-1 do
		  BlockWrite(fIndexFile, aIndexTable[i], sizeOf(aindexTable[i]));
    CloseFile(fIndexFile);
    
    ErrorFlag:= false;
	finally
		Finalize(rMassTmp);
//	  DeleteFile('Cashe.Dat');
		CloseFile(fHDFile);
	end;
end;

end.
