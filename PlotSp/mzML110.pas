
{***************************************************}
{                                                   }
{                 XML Data Binding                  }
{                                                   }
{         Generated on: 10/03/2015 02:44:28         }
{       Generated from: G:\Programs\mzML1.1.0.xsd   }
{   Settings stored in: G:\Programs\mzML1.1.0.xdb   }
{                                                   }
{***************************************************}

unit mzML110;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLMzMLType = interface;
  IXMLCVListType = interface;
  IXMLCVType = interface;
  IXMLFileDescriptionType = interface;
  IXMLParamGroupType = interface;
  IXMLParamGroupTypeList = interface;
  IXMLReferenceableParamGroupRefType = interface;
  IXMLReferenceableParamGroupRefTypeList = interface;
  IXMLCVParamType = interface;
  IXMLCVParamTypeList = interface;
  IXMLUserParamType = interface;
  IXMLUserParamTypeList = interface;
  IXMLSourceFileListType = interface;
  IXMLSourceFileType = interface;
  IXMLReferenceableParamGroupListType = interface;
  IXMLReferenceableParamGroupType = interface;
  IXMLSampleListType = interface;
  IXMLSampleType = interface;
  IXMLSoftwareListType = interface;
  IXMLSoftwareType = interface;
  IXMLScanSettingsListType = interface;
  IXMLScanSettingsType = interface;
  IXMLSourceFileRefListType = interface;
  IXMLSourceFileRefType = interface;
  IXMLTargetListType = interface;
  IXMLInstrumentConfigurationListType = interface;
  IXMLInstrumentConfigurationType = interface;
  IXMLComponentListType = interface;
  IXMLComponentType = interface;
  IXMLSourceComponentType = interface;
  IXMLSourceComponentTypeList = interface;
  IXMLAnalyzerComponentType = interface;
  IXMLAnalyzerComponentTypeList = interface;
  IXMLDetectorComponentType = interface;
  IXMLDetectorComponentTypeList = interface;
  IXMLSoftwareRefType = interface;
  IXMLDataProcessingListType = interface;
  IXMLDataProcessingType = interface;
  IXMLProcessingMethodType = interface;
  IXMLRunType = interface;
  IXMLSpectrumListType = interface;
  IXMLSpectrumType = interface;
  IXMLScanListType = interface;
  IXMLScanType = interface;
  IXMLScanTypeList = interface;
  IXMLScanWindowListType = interface;
  IXMLPrecursorListType = interface;
  IXMLPrecursorType = interface;
  IXMLSelectedIonListType = interface;
  IXMLProductListType = interface;
  IXMLProductType = interface;
  IXMLBinaryDataArrayListType = interface;
  IXMLBinaryDataArrayType = interface;
  IXMLChromatogramListType = interface;
  IXMLChromatogramType = interface;

{ IXMLMzMLType }

  IXMLMzMLType = interface(IXMLNode)
    ['{E08F81D3-7254-4D31-9A5C-8476C19B1E69}']
    { Property Accessors }
    function Get_Accession: UnicodeString;
    function Get_Version: UnicodeString;
    function Get_Id: UnicodeString;
    function Get_CvList: IXMLCVListType;
    function Get_FileDescription: IXMLFileDescriptionType;
    function Get_ReferenceableParamGroupList: IXMLReferenceableParamGroupListType;
    function Get_SampleList: IXMLSampleListType;
    function Get_SoftwareList: IXMLSoftwareListType;
    function Get_ScanSettingsList: IXMLScanSettingsListType;
    function Get_InstrumentConfigurationList: IXMLInstrumentConfigurationListType;
    function Get_DataProcessingList: IXMLDataProcessingListType;
    function Get_Run: IXMLRunType;
    procedure Set_Accession(Value: UnicodeString);
    procedure Set_Version(Value: UnicodeString);
    procedure Set_Id(Value: UnicodeString);
    { Methods & Properties }
    property Accession: UnicodeString read Get_Accession write Set_Accession;
    property Version: UnicodeString read Get_Version write Set_Version;
    property Id: UnicodeString read Get_Id write Set_Id;
    property CvList: IXMLCVListType read Get_CvList;
    property FileDescription: IXMLFileDescriptionType read Get_FileDescription;
    property ReferenceableParamGroupList: IXMLReferenceableParamGroupListType read Get_ReferenceableParamGroupList;
    property SampleList: IXMLSampleListType read Get_SampleList;
    property SoftwareList: IXMLSoftwareListType read Get_SoftwareList;
    property ScanSettingsList: IXMLScanSettingsListType read Get_ScanSettingsList;
    property InstrumentConfigurationList: IXMLInstrumentConfigurationListType read Get_InstrumentConfigurationList;
    property DataProcessingList: IXMLDataProcessingListType read Get_DataProcessingList;
    property Run: IXMLRunType read Get_Run;
  end;

{ IXMLCVListType }

  IXMLCVListType = interface(IXMLNodeCollection)
    ['{B4B39C3B-E11A-47E7-AEB2-E299BC5E89E7}']
    { Property Accessors }
    function Get_Count: LongWord;
    function Get_Cv(Index: Integer): IXMLCVType;
    procedure Set_Count(Value: LongWord);
    { Methods & Properties }
    function Add: IXMLCVType;
    function Insert(const Index: Integer): IXMLCVType;
    property Count: LongWord read Get_Count write Set_Count;
    property Cv[Index: Integer]: IXMLCVType read Get_Cv; default;
  end;

{ IXMLCVType }

  IXMLCVType = interface(IXMLNode)
    ['{238E935F-4173-4080-A8CA-EE9E94D61BE3}']
    { Property Accessors }
    function Get_Id: UnicodeString;
    function Get_FullName: UnicodeString;
    function Get_Version: UnicodeString;
    function Get_URI: UnicodeString;
    procedure Set_Id(Value: UnicodeString);
    procedure Set_FullName(Value: UnicodeString);
    procedure Set_Version(Value: UnicodeString);
    procedure Set_URI(Value: UnicodeString);
    { Methods & Properties }
    property Id: UnicodeString read Get_Id write Set_Id;
    property FullName: UnicodeString read Get_FullName write Set_FullName;
    property Version: UnicodeString read Get_Version write Set_Version;
    property URI: UnicodeString read Get_URI write Set_URI;
  end;

{ IXMLFileDescriptionType }

  IXMLFileDescriptionType = interface(IXMLNode)
    ['{B7AFEC45-4D73-4509-88FB-32F7A96BC918}']
    { Property Accessors }
    function Get_FileContent: IXMLParamGroupType;
    function Get_SourceFileList: IXMLSourceFileListType;
    function Get_Contact: IXMLParamGroupTypeList;
    { Methods & Properties }
    property FileContent: IXMLParamGroupType read Get_FileContent;
    property SourceFileList: IXMLSourceFileListType read Get_SourceFileList;
    property Contact: IXMLParamGroupTypeList read Get_Contact;
  end;

{ IXMLParamGroupType }

  IXMLParamGroupType = interface(IXMLNode)
    ['{AF29373E-7ED2-493E-8ADA-8117AD23468B}']
    { Property Accessors }
    function Get_ReferenceableParamGroupRef: IXMLReferenceableParamGroupRefTypeList;
    function Get_CvParam: IXMLCVParamTypeList;
    function Get_UserParam: IXMLUserParamTypeList;
    { Methods & Properties }
    property ReferenceableParamGroupRef: IXMLReferenceableParamGroupRefTypeList read Get_ReferenceableParamGroupRef;
    property CvParam: IXMLCVParamTypeList read Get_CvParam;
    property UserParam: IXMLUserParamTypeList read Get_UserParam;
  end;

{ IXMLParamGroupTypeList }

  IXMLParamGroupTypeList = interface(IXMLNodeCollection)
    ['{8B79F9A0-14BB-4E18-A6E6-CEBA4AC88BF3}']
    { Methods & Properties }
    function Add: IXMLParamGroupType;
    function Insert(const Index: Integer): IXMLParamGroupType;

    function Get_Item(Index: Integer): IXMLParamGroupType;
    property Items[Index: Integer]: IXMLParamGroupType read Get_Item; default;
  end;

{ IXMLReferenceableParamGroupRefType }

  IXMLReferenceableParamGroupRefType = interface(IXMLNode)
    ['{010CE4B1-7DB2-4B2A-AB35-8E38627C5249}']
    { Property Accessors }
    function Get_Ref: UnicodeString;
    procedure Set_Ref(Value: UnicodeString);
    { Methods & Properties }
    property Ref: UnicodeString read Get_Ref write Set_Ref;
  end;

{ IXMLReferenceableParamGroupRefTypeList }

  IXMLReferenceableParamGroupRefTypeList = interface(IXMLNodeCollection)
    ['{382E843B-D3FE-431D-99DA-918F28963B1C}']
    { Methods & Properties }
    function Add: IXMLReferenceableParamGroupRefType;
    function Insert(const Index: Integer): IXMLReferenceableParamGroupRefType;

    function Get_Item(Index: Integer): IXMLReferenceableParamGroupRefType;
    property Items[Index: Integer]: IXMLReferenceableParamGroupRefType read Get_Item; default;
  end;

{ IXMLCVParamType }

  IXMLCVParamType = interface(IXMLNode)
    ['{4398A85F-6C65-4DB4-8AD7-390DA664775B}']
    { Property Accessors }
    function Get_CvRef: UnicodeString;
    function Get_Accession: UnicodeString;
    function Get_Value: UnicodeString;
    function Get_Name: UnicodeString;
    function Get_UnitAccession: UnicodeString;
    function Get_UnitName: UnicodeString;
    function Get_UnitCvRef: UnicodeString;
    procedure Set_CvRef(Value: UnicodeString);
    procedure Set_Accession(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    procedure Set_Name(Value: UnicodeString);
    procedure Set_UnitAccession(Value: UnicodeString);
    procedure Set_UnitName(Value: UnicodeString);
    procedure Set_UnitCvRef(Value: UnicodeString);
    { Methods & Properties }
    property CvRef: UnicodeString read Get_CvRef write Set_CvRef;
    property Accession: UnicodeString read Get_Accession write Set_Accession;
    property Value: UnicodeString read Get_Value write Set_Value;
    property Name: UnicodeString read Get_Name write Set_Name;
    property UnitAccession: UnicodeString read Get_UnitAccession write Set_UnitAccession;
    property UnitName: UnicodeString read Get_UnitName write Set_UnitName;
    property UnitCvRef: UnicodeString read Get_UnitCvRef write Set_UnitCvRef;
  end;

{ IXMLCVParamTypeList }

  IXMLCVParamTypeList = interface(IXMLNodeCollection)
    ['{8860E34F-B2BB-491F-A921-8E8B96DD35C9}']
    { Methods & Properties }
    function Add: IXMLCVParamType;
    function Insert(const Index: Integer): IXMLCVParamType;

    function Get_Item(Index: Integer): IXMLCVParamType;
    property Items[Index: Integer]: IXMLCVParamType read Get_Item; default;
  end;

{ IXMLUserParamType }

  IXMLUserParamType = interface(IXMLNode)
    ['{6D7F8631-CE15-4264-A018-0FE497241BD1}']
    { Property Accessors }
    function Get_Name: UnicodeString;
    function Get_Type_: UnicodeString;
    function Get_Value: UnicodeString;
    function Get_UnitAccession: UnicodeString;
    function Get_UnitName: UnicodeString;
    function Get_UnitCvRef: UnicodeString;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Type_(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    procedure Set_UnitAccession(Value: UnicodeString);
    procedure Set_UnitName(Value: UnicodeString);
    procedure Set_UnitCvRef(Value: UnicodeString);
    { Methods & Properties }
    property Name: UnicodeString read Get_Name write Set_Name;
    property Type_: UnicodeString read Get_Type_ write Set_Type_;
    property Value: UnicodeString read Get_Value write Set_Value;
    property UnitAccession: UnicodeString read Get_UnitAccession write Set_UnitAccession;
    property UnitName: UnicodeString read Get_UnitName write Set_UnitName;
    property UnitCvRef: UnicodeString read Get_UnitCvRef write Set_UnitCvRef;
  end;

{ IXMLUserParamTypeList }

  IXMLUserParamTypeList = interface(IXMLNodeCollection)
    ['{50481136-F481-483E-AB14-884653A0D49F}']
    { Methods & Properties }
    function Add: IXMLUserParamType;
    function Insert(const Index: Integer): IXMLUserParamType;

    function Get_Item(Index: Integer): IXMLUserParamType;
    property Items[Index: Integer]: IXMLUserParamType read Get_Item; default;
  end;

{ IXMLSourceFileListType }

  IXMLSourceFileListType = interface(IXMLNodeCollection)
    ['{FF470433-97E7-4B14-AB97-B4F7D1EE5A99}']
    { Property Accessors }
    function Get_Count: LongWord;
    function Get_SourceFile(Index: Integer): IXMLSourceFileType;
    procedure Set_Count(Value: LongWord);
    { Methods & Properties }
    function Add: IXMLSourceFileType;
    function Insert(const Index: Integer): IXMLSourceFileType;
    property Count: LongWord read Get_Count write Set_Count;
    property SourceFile[Index: Integer]: IXMLSourceFileType read Get_SourceFile; default;
  end;

{ IXMLSourceFileType }

  IXMLSourceFileType = interface(IXMLParamGroupType)
    ['{C0EC5EDA-D18A-44F2-B7E0-E27D3C98C8D6}']
    { Property Accessors }
    function Get_Id: UnicodeString;
    function Get_Name: UnicodeString;
    function Get_Location: UnicodeString;
    procedure Set_Id(Value: UnicodeString);
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Location(Value: UnicodeString);
    { Methods & Properties }
    property Id: UnicodeString read Get_Id write Set_Id;
    property Name: UnicodeString read Get_Name write Set_Name;
    property Location: UnicodeString read Get_Location write Set_Location;
  end;

{ IXMLReferenceableParamGroupListType }

  IXMLReferenceableParamGroupListType = interface(IXMLNodeCollection)
    ['{674EDCE2-FDD9-4D9B-8D37-7709382109DD}']
    { Property Accessors }
    function Get_Count: LongWord;
    function Get_ReferenceableParamGroup(Index: Integer): IXMLReferenceableParamGroupType;
    procedure Set_Count(Value: LongWord);
    { Methods & Properties }
    function Add: IXMLReferenceableParamGroupType;
    function Insert(const Index: Integer): IXMLReferenceableParamGroupType;
    property Count: LongWord read Get_Count write Set_Count;
    property ReferenceableParamGroup[Index: Integer]: IXMLReferenceableParamGroupType read Get_ReferenceableParamGroup; default;
  end;

{ IXMLReferenceableParamGroupType }

  IXMLReferenceableParamGroupType = interface(IXMLNode)
    ['{66B7160A-7EEB-4FB1-A613-4274CF4B1042}']
    { Property Accessors }
    function Get_Id: UnicodeString;
    function Get_CvParam: IXMLCVParamTypeList;
    function Get_UserParam: IXMLUserParamTypeList;
    procedure Set_Id(Value: UnicodeString);
    { Methods & Properties }
    property Id: UnicodeString read Get_Id write Set_Id;
    property CvParam: IXMLCVParamTypeList read Get_CvParam;
    property UserParam: IXMLUserParamTypeList read Get_UserParam;
  end;

{ IXMLSampleListType }

  IXMLSampleListType = interface(IXMLNodeCollection)
    ['{DDA0F55E-646F-4D7B-861A-95BE667E3D1A}']
    { Property Accessors }
    function Get_Count: LongWord;
    function Get_Sample(Index: Integer): IXMLSampleType;
    procedure Set_Count(Value: LongWord);
    { Methods & Properties }
    function Add: IXMLSampleType;
    function Insert(const Index: Integer): IXMLSampleType;
    property Count: LongWord read Get_Count write Set_Count;
    property Sample[Index: Integer]: IXMLSampleType read Get_Sample; default;
  end;

{ IXMLSampleType }

  IXMLSampleType = interface(IXMLParamGroupType)
    ['{D9FAA044-9E7E-43E9-A74B-24DD68809BB8}']
    { Property Accessors }
    function Get_Id: UnicodeString;
    function Get_Name: UnicodeString;
    procedure Set_Id(Value: UnicodeString);
    procedure Set_Name(Value: UnicodeString);
    { Methods & Properties }
    property Id: UnicodeString read Get_Id write Set_Id;
    property Name: UnicodeString read Get_Name write Set_Name;
  end;

{ IXMLSoftwareListType }

  IXMLSoftwareListType = interface(IXMLNodeCollection)
    ['{C7C6F621-7F4F-4F7F-9D57-24F5FEAFA127}']
    { Property Accessors }
    function Get_Count: LongWord;
    function Get_Software(Index: Integer): IXMLSoftwareType;
    procedure Set_Count(Value: LongWord);
    { Methods & Properties }
    function Add: IXMLSoftwareType;
    function Insert(const Index: Integer): IXMLSoftwareType;
    property Count: LongWord read Get_Count write Set_Count;
    property Software[Index: Integer]: IXMLSoftwareType read Get_Software; default;
  end;

{ IXMLSoftwareType }

  IXMLSoftwareType = interface(IXMLParamGroupType)
    ['{A10434B9-8CF9-4526-8DDD-778676971927}']
    { Property Accessors }
    function Get_Id: UnicodeString;
    function Get_Version: UnicodeString;
    procedure Set_Id(Value: UnicodeString);
    procedure Set_Version(Value: UnicodeString);
    { Methods & Properties }
    property Id: UnicodeString read Get_Id write Set_Id;
    property Version: UnicodeString read Get_Version write Set_Version;
  end;

{ IXMLScanSettingsListType }

  IXMLScanSettingsListType = interface(IXMLNodeCollection)
    ['{D39C377F-A0CF-4F7C-BA8B-1A88A3A37EAF}']
    { Property Accessors }
    function Get_Count: LongWord;
    function Get_ScanSettings(Index: Integer): IXMLScanSettingsType;
    procedure Set_Count(Value: LongWord);
    { Methods & Properties }
    function Add: IXMLScanSettingsType;
    function Insert(const Index: Integer): IXMLScanSettingsType;
    property Count: LongWord read Get_Count write Set_Count;
    property ScanSettings[Index: Integer]: IXMLScanSettingsType read Get_ScanSettings; default;
  end;

{ IXMLScanSettingsType }

  IXMLScanSettingsType = interface(IXMLParamGroupType)
    ['{DC2B24E9-B635-4370-9481-E3090218F24C}']
    { Property Accessors }
    function Get_Id: UnicodeString;
    function Get_SourceFileRefList: IXMLSourceFileRefListType;
    function Get_TargetList: IXMLTargetListType;
    procedure Set_Id(Value: UnicodeString);
    { Methods & Properties }
    property Id: UnicodeString read Get_Id write Set_Id;
    property SourceFileRefList: IXMLSourceFileRefListType read Get_SourceFileRefList;
    property TargetList: IXMLTargetListType read Get_TargetList;
  end;

{ IXMLSourceFileRefListType }

  IXMLSourceFileRefListType = interface(IXMLNodeCollection)
    ['{C9494994-AC64-416D-83C9-E0F517A6F4F5}']
    { Property Accessors }
    function Get_Count: LongWord;
    function Get_SourceFileRef(Index: Integer): IXMLSourceFileRefType;
    procedure Set_Count(Value: LongWord);
    { Methods & Properties }
    function Add: IXMLSourceFileRefType;
    function Insert(const Index: Integer): IXMLSourceFileRefType;
    property Count: LongWord read Get_Count write Set_Count;
    property SourceFileRef[Index: Integer]: IXMLSourceFileRefType read Get_SourceFileRef; default;
  end;

{ IXMLSourceFileRefType }

  IXMLSourceFileRefType = interface(IXMLNode)
    ['{F0C33073-A1D1-4965-8FEB-A42A60C663EC}']
    { Property Accessors }
    function Get_Ref: UnicodeString;
    procedure Set_Ref(Value: UnicodeString);
    { Methods & Properties }
    property Ref: UnicodeString read Get_Ref write Set_Ref;
  end;

{ IXMLTargetListType }

  IXMLTargetListType = interface(IXMLNodeCollection)
    ['{4963B00F-8753-4357-9FD7-806D1E6D8B9A}']
    { Property Accessors }
    function Get_Count: LongWord;
    function Get_Target(Index: Integer): IXMLParamGroupType;
    procedure Set_Count(Value: LongWord);
    { Methods & Properties }
    function Add: IXMLParamGroupType;
    function Insert(const Index: Integer): IXMLParamGroupType;
    property Count: LongWord read Get_Count write Set_Count;
    property Target[Index: Integer]: IXMLParamGroupType read Get_Target; default;
  end;

{ IXMLInstrumentConfigurationListType }

  IXMLInstrumentConfigurationListType = interface(IXMLNodeCollection)
    ['{FB0AFB4B-F023-4484-8696-EC2431DC6E7B}']
    { Property Accessors }
    function Get_Count: LongWord;
    function Get_InstrumentConfiguration(Index: Integer): IXMLInstrumentConfigurationType;
    procedure Set_Count(Value: LongWord);
    { Methods & Properties }
    function Add: IXMLInstrumentConfigurationType;
    function Insert(const Index: Integer): IXMLInstrumentConfigurationType;
    property Count: LongWord read Get_Count write Set_Count;
    property InstrumentConfiguration[Index: Integer]: IXMLInstrumentConfigurationType read Get_InstrumentConfiguration; default;
  end;

{ IXMLInstrumentConfigurationType }

  IXMLInstrumentConfigurationType = interface(IXMLParamGroupType)
    ['{D767D443-6305-4B40-AAE4-687FC3BEA26F}']
    { Property Accessors }
    function Get_Id: UnicodeString;
    function Get_ScanSettingsRef: UnicodeString;
    function Get_ComponentList: IXMLComponentListType;
    function Get_SoftwareRef: IXMLSoftwareRefType;
    procedure Set_Id(Value: UnicodeString);
    procedure Set_ScanSettingsRef(Value: UnicodeString);
    { Methods & Properties }
    property Id: UnicodeString read Get_Id write Set_Id;
    property ScanSettingsRef: UnicodeString read Get_ScanSettingsRef write Set_ScanSettingsRef;
    property ComponentList: IXMLComponentListType read Get_ComponentList;
    property SoftwareRef: IXMLSoftwareRefType read Get_SoftwareRef;
  end;

{ IXMLComponentListType }

  IXMLComponentListType = interface(IXMLNode)
    ['{C4437467-F5AD-46DD-B4AB-3C0E950D903F}']
    { Property Accessors }
    function Get_Count: LongWord;
    function Get_Source: IXMLSourceComponentTypeList;
    function Get_Analyzer: IXMLAnalyzerComponentTypeList;
    function Get_Detector: IXMLDetectorComponentTypeList;
    procedure Set_Count(Value: LongWord);
    { Methods & Properties }
    property Count: LongWord read Get_Count write Set_Count;
    property Source: IXMLSourceComponentTypeList read Get_Source;
    property Analyzer: IXMLAnalyzerComponentTypeList read Get_Analyzer;
    property Detector: IXMLDetectorComponentTypeList read Get_Detector;
  end;

{ IXMLComponentType }

  IXMLComponentType = interface(IXMLParamGroupType)
    ['{9B05A649-FE46-4789-88FF-85EC60508655}']
    { Property Accessors }
    function Get_Order: Integer;
    procedure Set_Order(Value: Integer);
    { Methods & Properties }
    property Order: Integer read Get_Order write Set_Order;
  end;

{ IXMLSourceComponentType }

  IXMLSourceComponentType = interface(IXMLComponentType)
    ['{4846CD86-D2DC-47EE-BFF7-943898400512}']
  end;

{ IXMLSourceComponentTypeList }

  IXMLSourceComponentTypeList = interface(IXMLNodeCollection)
    ['{7EBE15F5-D349-4330-A5EA-235CC1168DDF}']
    { Methods & Properties }
    function Add: IXMLSourceComponentType;
    function Insert(const Index: Integer): IXMLSourceComponentType;

    function Get_Item(Index: Integer): IXMLSourceComponentType;
    property Items[Index: Integer]: IXMLSourceComponentType read Get_Item; default;
  end;

{ IXMLAnalyzerComponentType }

  IXMLAnalyzerComponentType = interface(IXMLComponentType)
    ['{A2B0452B-6ECC-4E2A-A49F-6D0E0F1A5262}']
  end;

{ IXMLAnalyzerComponentTypeList }

  IXMLAnalyzerComponentTypeList = interface(IXMLNodeCollection)
    ['{942151A7-B4A0-4609-9494-5B81DA3EB52F}']
    { Methods & Properties }
    function Add: IXMLAnalyzerComponentType;
    function Insert(const Index: Integer): IXMLAnalyzerComponentType;

    function Get_Item(Index: Integer): IXMLAnalyzerComponentType;
    property Items[Index: Integer]: IXMLAnalyzerComponentType read Get_Item; default;
  end;

{ IXMLDetectorComponentType }

  IXMLDetectorComponentType = interface(IXMLComponentType)
    ['{A2179C3F-5F36-4121-B129-720C3B1E3429}']
  end;

{ IXMLDetectorComponentTypeList }

  IXMLDetectorComponentTypeList = interface(IXMLNodeCollection)
    ['{1ECF0128-C75B-42F2-8C77-B2155D80C795}']
    { Methods & Properties }
    function Add: IXMLDetectorComponentType;
    function Insert(const Index: Integer): IXMLDetectorComponentType;

    function Get_Item(Index: Integer): IXMLDetectorComponentType;
    property Items[Index: Integer]: IXMLDetectorComponentType read Get_Item; default;
  end;

{ IXMLSoftwareRefType }

  IXMLSoftwareRefType = interface(IXMLNode)
    ['{56630D2F-8032-44A0-B4F4-A837F15CFA6A}']
    { Property Accessors }
    function Get_Ref: UnicodeString;
    procedure Set_Ref(Value: UnicodeString);
    { Methods & Properties }
    property Ref: UnicodeString read Get_Ref write Set_Ref;
  end;

{ IXMLDataProcessingListType }

  IXMLDataProcessingListType = interface(IXMLNodeCollection)
    ['{6EA488AF-3AFC-4AF6-AE70-56AFC0B01C53}']
    { Property Accessors }
    function Get_Count: LongWord;
    function Get_DataProcessing(Index: Integer): IXMLDataProcessingType;
    procedure Set_Count(Value: LongWord);
    { Methods & Properties }
    function Add: IXMLDataProcessingType;
    function Insert(const Index: Integer): IXMLDataProcessingType;
    property Count: LongWord read Get_Count write Set_Count;
    property DataProcessing[Index: Integer]: IXMLDataProcessingType read Get_DataProcessing; default;
  end;

{ IXMLDataProcessingType }

  IXMLDataProcessingType = interface(IXMLNodeCollection)
    ['{D1BF9137-3F0F-4CAD-AD63-2FFD1B09BEC9}']
    { Property Accessors }
    function Get_Id: UnicodeString;
    function Get_ProcessingMethod(Index: Integer): IXMLProcessingMethodType;
    procedure Set_Id(Value: UnicodeString);
    { Methods & Properties }
    function Add: IXMLProcessingMethodType;
    function Insert(const Index: Integer): IXMLProcessingMethodType;
    property Id: UnicodeString read Get_Id write Set_Id;
    property ProcessingMethod[Index: Integer]: IXMLProcessingMethodType read Get_ProcessingMethod; default;
  end;

{ IXMLProcessingMethodType }

  IXMLProcessingMethodType = interface(IXMLParamGroupType)
    ['{1BE1465C-5808-4AC5-81DC-6C523174741D}']
    { Property Accessors }
    function Get_Order: LongWord;
    function Get_SoftwareRef: UnicodeString;
    procedure Set_Order(Value: LongWord);
    procedure Set_SoftwareRef(Value: UnicodeString);
    { Methods & Properties }
    property Order: LongWord read Get_Order write Set_Order;
    property SoftwareRef: UnicodeString read Get_SoftwareRef write Set_SoftwareRef;
  end;

{ IXMLRunType }

  IXMLRunType = interface(IXMLParamGroupType)
    ['{BE40683B-6608-4CC6-B7AE-E312B850642C}']
    { Property Accessors }
    function Get_Id: UnicodeString;
    function Get_DefaultInstrumentConfigurationRef: UnicodeString;
    function Get_DefaultSourceFileRef: UnicodeString;
    function Get_SampleRef: UnicodeString;
    function Get_StartTimeStamp: UnicodeString;
    function Get_SpectrumList: IXMLSpectrumListType;
    function Get_ChromatogramList: IXMLChromatogramListType;
    procedure Set_Id(Value: UnicodeString);
    procedure Set_DefaultInstrumentConfigurationRef(Value: UnicodeString);
    procedure Set_DefaultSourceFileRef(Value: UnicodeString);
    procedure Set_SampleRef(Value: UnicodeString);
    procedure Set_StartTimeStamp(Value: UnicodeString);
    { Methods & Properties }
    property Id: UnicodeString read Get_Id write Set_Id;
    property DefaultInstrumentConfigurationRef: UnicodeString read Get_DefaultInstrumentConfigurationRef write Set_DefaultInstrumentConfigurationRef;
    property DefaultSourceFileRef: UnicodeString read Get_DefaultSourceFileRef write Set_DefaultSourceFileRef;
    property SampleRef: UnicodeString read Get_SampleRef write Set_SampleRef;
    property StartTimeStamp: UnicodeString read Get_StartTimeStamp write Set_StartTimeStamp;
    property SpectrumList: IXMLSpectrumListType read Get_SpectrumList;
    property ChromatogramList: IXMLChromatogramListType read Get_ChromatogramList;
  end;

{ IXMLSpectrumListType }

  IXMLSpectrumListType = interface(IXMLNodeCollection)
    ['{88F0A591-37AD-4A1B-B3AE-EEE28B228FFE}']
    { Property Accessors }
    function Get_Count: LongWord;
    function Get_DefaultDataProcessingRef: UnicodeString;
    function Get_Spectrum(Index: Integer): IXMLSpectrumType;
    procedure Set_Count(Value: LongWord);
    procedure Set_DefaultDataProcessingRef(Value: UnicodeString);
    { Methods & Properties }
    function Add: IXMLSpectrumType;
    function Insert(const Index: Integer): IXMLSpectrumType;
    property Count: LongWord read Get_Count write Set_Count;
    property DefaultDataProcessingRef: UnicodeString read Get_DefaultDataProcessingRef write Set_DefaultDataProcessingRef;
    property Spectrum[Index: Integer]: IXMLSpectrumType read Get_Spectrum; default;
  end;

{ IXMLSpectrumType }

  IXMLSpectrumType = interface(IXMLParamGroupType)
    ['{2C42D1D7-ACDA-4D45-B3FF-27F95A188D02}']
    { Property Accessors }
    function Get_Id: UnicodeString;
    function Get_SpotID: UnicodeString;
    function Get_Index: LongWord;
    function Get_DefaultArrayLength: Integer;
    function Get_DataProcessingRef: UnicodeString;
    function Get_SourceFileRef: UnicodeString;
    function Get_ScanList: IXMLScanListType;
    function Get_PrecursorList: IXMLPrecursorListType;
    function Get_ProductList: IXMLProductListType;
    function Get_BinaryDataArrayList: IXMLBinaryDataArrayListType;
    procedure Set_Id(Value: UnicodeString);
    procedure Set_SpotID(Value: UnicodeString);
    procedure Set_Index(Value: LongWord);
    procedure Set_DefaultArrayLength(Value: Integer);
    procedure Set_DataProcessingRef(Value: UnicodeString);
    procedure Set_SourceFileRef(Value: UnicodeString);
    { Methods & Properties }
    property Id: UnicodeString read Get_Id write Set_Id;
    property SpotID: UnicodeString read Get_SpotID write Set_SpotID;
    property Index: LongWord read Get_Index write Set_Index;
    property DefaultArrayLength: Integer read Get_DefaultArrayLength write Set_DefaultArrayLength;
    property DataProcessingRef: UnicodeString read Get_DataProcessingRef write Set_DataProcessingRef;
    property SourceFileRef: UnicodeString read Get_SourceFileRef write Set_SourceFileRef;
    property ScanList: IXMLScanListType read Get_ScanList;
    property PrecursorList: IXMLPrecursorListType read Get_PrecursorList;
    property ProductList: IXMLProductListType read Get_ProductList;
    property BinaryDataArrayList: IXMLBinaryDataArrayListType read Get_BinaryDataArrayList;
  end;

{ IXMLScanListType }

  IXMLScanListType = interface(IXMLParamGroupType)
    ['{F49E39D1-5DF9-4317-BEC2-B20A1EB12D53}']
    { Property Accessors }
    function Get_Count: LongWord;
    function Get_Scan: IXMLScanTypeList;
    procedure Set_Count(Value: LongWord);
    { Methods & Properties }
    property Count: LongWord read Get_Count write Set_Count;
    property Scan: IXMLScanTypeList read Get_Scan;
  end;

{ IXMLScanType }

  IXMLScanType = interface(IXMLParamGroupType)
    ['{6D3794A4-B88F-41C6-BF32-ADEF9B7F4EED}']
    { Property Accessors }
    function Get_SpectrumRef: UnicodeString;
    function Get_SourceFileRef: UnicodeString;
    function Get_ExternalSpectrumID: UnicodeString;
    function Get_InstrumentConfigurationRef: UnicodeString;
    function Get_ScanWindowList: IXMLScanWindowListType;
    procedure Set_SpectrumRef(Value: UnicodeString);
    procedure Set_SourceFileRef(Value: UnicodeString);
    procedure Set_ExternalSpectrumID(Value: UnicodeString);
    procedure Set_InstrumentConfigurationRef(Value: UnicodeString);
    { Methods & Properties }
    property SpectrumRef: UnicodeString read Get_SpectrumRef write Set_SpectrumRef;
    property SourceFileRef: UnicodeString read Get_SourceFileRef write Set_SourceFileRef;
    property ExternalSpectrumID: UnicodeString read Get_ExternalSpectrumID write Set_ExternalSpectrumID;
    property InstrumentConfigurationRef: UnicodeString read Get_InstrumentConfigurationRef write Set_InstrumentConfigurationRef;
    property ScanWindowList: IXMLScanWindowListType read Get_ScanWindowList;
  end;

{ IXMLScanTypeList }

  IXMLScanTypeList = interface(IXMLNodeCollection)
    ['{093E9772-3454-4AC9-887E-4F0F2C002E64}']
    { Methods & Properties }
    function Add: IXMLScanType;
    function Insert(const Index: Integer): IXMLScanType;

    function Get_Item(Index: Integer): IXMLScanType;
    property Items[Index: Integer]: IXMLScanType read Get_Item; default;
  end;

{ IXMLScanWindowListType }

  IXMLScanWindowListType = interface(IXMLNodeCollection)
    ['{EC5D57D4-040C-4B3C-8C9A-2FDCA43A38E2}']
    { Property Accessors }
    function Get_Count: Integer;
    function Get_ScanWindow(Index: Integer): IXMLParamGroupType;
    procedure Set_Count(Value: Integer);
    { Methods & Properties }
    function Add: IXMLParamGroupType;
    function Insert(const Index: Integer): IXMLParamGroupType;
    property Count: Integer read Get_Count write Set_Count;
    property ScanWindow[Index: Integer]: IXMLParamGroupType read Get_ScanWindow; default;
  end;

{ IXMLPrecursorListType }

  IXMLPrecursorListType = interface(IXMLNodeCollection)
    ['{502EEE42-40C8-4502-802C-16ED749769CF}']
    { Property Accessors }
    function Get_Count: LongWord;
    function Get_Precursor(Index: Integer): IXMLPrecursorType;
    procedure Set_Count(Value: LongWord);
    { Methods & Properties }
    function Add: IXMLPrecursorType;
    function Insert(const Index: Integer): IXMLPrecursorType;
    property Count: LongWord read Get_Count write Set_Count;
    property Precursor[Index: Integer]: IXMLPrecursorType read Get_Precursor; default;
  end;

{ IXMLPrecursorType }

  IXMLPrecursorType = interface(IXMLNode)
    ['{0122EBA9-2DAB-4ED5-BF16-5ECD46FE46A5}']
    { Property Accessors }
    function Get_SpectrumRef: UnicodeString;
    function Get_SourceFileRef: UnicodeString;
    function Get_ExternalSpectrumID: UnicodeString;
    function Get_IsolationWindow: IXMLParamGroupType;
    function Get_SelectedIonList: IXMLSelectedIonListType;
    function Get_Activation: IXMLParamGroupType;
    procedure Set_SpectrumRef(Value: UnicodeString);
    procedure Set_SourceFileRef(Value: UnicodeString);
    procedure Set_ExternalSpectrumID(Value: UnicodeString);
    { Methods & Properties }
    property SpectrumRef: UnicodeString read Get_SpectrumRef write Set_SpectrumRef;
    property SourceFileRef: UnicodeString read Get_SourceFileRef write Set_SourceFileRef;
    property ExternalSpectrumID: UnicodeString read Get_ExternalSpectrumID write Set_ExternalSpectrumID;
    property IsolationWindow: IXMLParamGroupType read Get_IsolationWindow;
    property SelectedIonList: IXMLSelectedIonListType read Get_SelectedIonList;
    property Activation: IXMLParamGroupType read Get_Activation;
  end;

{ IXMLSelectedIonListType }

  IXMLSelectedIonListType = interface(IXMLNodeCollection)
    ['{1F580BC6-217D-403C-AEC8-D3F6A32582FF}']
    { Property Accessors }
    function Get_Count: LongWord;
    function Get_SelectedIon(Index: Integer): IXMLParamGroupType;
    procedure Set_Count(Value: LongWord);
    { Methods & Properties }
    function Add: IXMLParamGroupType;
    function Insert(const Index: Integer): IXMLParamGroupType;
    property Count: LongWord read Get_Count write Set_Count;
    property SelectedIon[Index: Integer]: IXMLParamGroupType read Get_SelectedIon; default;
  end;

{ IXMLProductListType }

  IXMLProductListType = interface(IXMLNodeCollection)
    ['{8059BE93-4F35-49C7-8F17-45189638473E}']
    { Property Accessors }
    function Get_Count: LongWord;
    function Get_Product(Index: Integer): IXMLProductType;
    procedure Set_Count(Value: LongWord);
    { Methods & Properties }
    function Add: IXMLProductType;
    function Insert(const Index: Integer): IXMLProductType;
    property Count: LongWord read Get_Count write Set_Count;
    property Product[Index: Integer]: IXMLProductType read Get_Product; default;
  end;

{ IXMLProductType }

  IXMLProductType = interface(IXMLNode)
    ['{6603E243-E9A4-4746-BE9A-8DC2D1F94FCE}']
    { Property Accessors }
    function Get_IsolationWindow: IXMLParamGroupType;
    { Methods & Properties }
    property IsolationWindow: IXMLParamGroupType read Get_IsolationWindow;
  end;

{ IXMLBinaryDataArrayListType }

  IXMLBinaryDataArrayListType = interface(IXMLNodeCollection)
    ['{7FF90AED-5EED-4932-B84D-44706D272EB7}']
    { Property Accessors }
    function Get_Count: LongWord;
    function Get_BinaryDataArray(Index: Integer): IXMLBinaryDataArrayType;
    procedure Set_Count(Value: LongWord);
    { Methods & Properties }
    function Add: IXMLBinaryDataArrayType;
    function Insert(const Index: Integer): IXMLBinaryDataArrayType;
    property Count: LongWord read Get_Count write Set_Count;
    property BinaryDataArray[Index: Integer]: IXMLBinaryDataArrayType read Get_BinaryDataArray; default;
  end;

{ IXMLBinaryDataArrayType }

  IXMLBinaryDataArrayType = interface(IXMLParamGroupType)
    ['{FD7A1787-1584-4B9C-894C-1602FAEB851B}']
    { Property Accessors }
    function Get_ArrayLength: LongWord;
    function Get_DataProcessingRef: UnicodeString;
    function Get_EncodedLength: LongWord;
    function Get_Binary: UnicodeString;
    procedure Set_ArrayLength(Value: LongWord);
    procedure Set_DataProcessingRef(Value: UnicodeString);
    procedure Set_EncodedLength(Value: LongWord);
    procedure Set_Binary(Value: UnicodeString);
    { Methods & Properties }
    property ArrayLength: LongWord read Get_ArrayLength write Set_ArrayLength;
    property DataProcessingRef: UnicodeString read Get_DataProcessingRef write Set_DataProcessingRef;
    property EncodedLength: LongWord read Get_EncodedLength write Set_EncodedLength;
    property Binary: UnicodeString read Get_Binary write Set_Binary;
  end;

{ IXMLChromatogramListType }

  IXMLChromatogramListType = interface(IXMLNodeCollection)
    ['{563C4623-746C-4B2E-A08A-6D0F69506476}']
    { Property Accessors }
    function Get_Count: LongWord;
    function Get_DefaultDataProcessingRef: UnicodeString;
    function Get_Chromatogram(Index: Integer): IXMLChromatogramType;
    procedure Set_Count(Value: LongWord);
    procedure Set_DefaultDataProcessingRef(Value: UnicodeString);
    { Methods & Properties }
    function Add: IXMLChromatogramType;
    function Insert(const Index: Integer): IXMLChromatogramType;
    property Count: LongWord read Get_Count write Set_Count;
    property DefaultDataProcessingRef: UnicodeString read Get_DefaultDataProcessingRef write Set_DefaultDataProcessingRef;
    property Chromatogram[Index: Integer]: IXMLChromatogramType read Get_Chromatogram; default;
  end;

{ IXMLChromatogramType }

  IXMLChromatogramType = interface(IXMLParamGroupType)
    ['{8BC5ABA4-5677-4B1E-9CF6-747587F1F536}']
    { Property Accessors }
    function Get_Id: UnicodeString;
    function Get_Index: LongWord;
    function Get_DefaultArrayLength: Integer;
    function Get_DataProcessingRef: UnicodeString;
    function Get_Precursor: IXMLPrecursorType;
    function Get_Product: IXMLProductType;
    function Get_BinaryDataArrayList: IXMLBinaryDataArrayListType;
    procedure Set_Id(Value: UnicodeString);
    procedure Set_Index(Value: LongWord);
    procedure Set_DefaultArrayLength(Value: Integer);
    procedure Set_DataProcessingRef(Value: UnicodeString);
    { Methods & Properties }
    property Id: UnicodeString read Get_Id write Set_Id;
    property Index: LongWord read Get_Index write Set_Index;
    property DefaultArrayLength: Integer read Get_DefaultArrayLength write Set_DefaultArrayLength;
    property DataProcessingRef: UnicodeString read Get_DataProcessingRef write Set_DataProcessingRef;
    property Precursor: IXMLPrecursorType read Get_Precursor;
    property Product: IXMLProductType read Get_Product;
    property BinaryDataArrayList: IXMLBinaryDataArrayListType read Get_BinaryDataArrayList;
  end;

{ Forward Decls }

  TXMLMzMLType = class;
  TXMLCVListType = class;
  TXMLCVType = class;
  TXMLFileDescriptionType = class;
  TXMLParamGroupType = class;
  TXMLParamGroupTypeList = class;
  TXMLReferenceableParamGroupRefType = class;
  TXMLReferenceableParamGroupRefTypeList = class;
  TXMLCVParamType = class;
  TXMLCVParamTypeList = class;
  TXMLUserParamType = class;
  TXMLUserParamTypeList = class;
  TXMLSourceFileListType = class;
  TXMLSourceFileType = class;
  TXMLReferenceableParamGroupListType = class;
  TXMLReferenceableParamGroupType = class;
  TXMLSampleListType = class;
  TXMLSampleType = class;
  TXMLSoftwareListType = class;
  TXMLSoftwareType = class;
  TXMLScanSettingsListType = class;
  TXMLScanSettingsType = class;
  TXMLSourceFileRefListType = class;
  TXMLSourceFileRefType = class;
  TXMLTargetListType = class;
  TXMLInstrumentConfigurationListType = class;
  TXMLInstrumentConfigurationType = class;
  TXMLComponentListType = class;
  TXMLComponentType = class;
  TXMLSourceComponentType = class;
  TXMLSourceComponentTypeList = class;
  TXMLAnalyzerComponentType = class;
  TXMLAnalyzerComponentTypeList = class;
  TXMLDetectorComponentType = class;
  TXMLDetectorComponentTypeList = class;
  TXMLSoftwareRefType = class;
  TXMLDataProcessingListType = class;
  TXMLDataProcessingType = class;
  TXMLProcessingMethodType = class;
  TXMLRunType = class;
  TXMLSpectrumListType = class;
  TXMLSpectrumType = class;
  TXMLScanListType = class;
  TXMLScanType = class;
  TXMLScanTypeList = class;
  TXMLScanWindowListType = class;
  TXMLPrecursorListType = class;
  TXMLPrecursorType = class;
  TXMLSelectedIonListType = class;
  TXMLProductListType = class;
  TXMLProductType = class;
  TXMLBinaryDataArrayListType = class;
  TXMLBinaryDataArrayType = class;
  TXMLChromatogramListType = class;
  TXMLChromatogramType = class;

{ TXMLMzMLType }

  TXMLMzMLType = class(TXMLNode, IXMLMzMLType)
  protected
    { IXMLMzMLType }
    function Get_Accession: UnicodeString;
    function Get_Version: UnicodeString;
    function Get_Id: UnicodeString;
    function Get_CvList: IXMLCVListType;
    function Get_FileDescription: IXMLFileDescriptionType;
    function Get_ReferenceableParamGroupList: IXMLReferenceableParamGroupListType;
    function Get_SampleList: IXMLSampleListType;
    function Get_SoftwareList: IXMLSoftwareListType;
    function Get_ScanSettingsList: IXMLScanSettingsListType;
    function Get_InstrumentConfigurationList: IXMLInstrumentConfigurationListType;
    function Get_DataProcessingList: IXMLDataProcessingListType;
    function Get_Run: IXMLRunType;
    procedure Set_Accession(Value: UnicodeString);
    procedure Set_Version(Value: UnicodeString);
    procedure Set_Id(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCVListType }

  TXMLCVListType = class(TXMLNodeCollection, IXMLCVListType)
  protected
    { IXMLCVListType }
    function Get_Count: LongWord;
    function Get_Cv(Index: Integer): IXMLCVType;
    procedure Set_Count(Value: LongWord);
    function Add: IXMLCVType;
    function Insert(const Index: Integer): IXMLCVType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCVType }

  TXMLCVType = class(TXMLNode, IXMLCVType)
  protected
    { IXMLCVType }
    function Get_Id: UnicodeString;
    function Get_FullName: UnicodeString;
    function Get_Version: UnicodeString;
    function Get_URI: UnicodeString;
    procedure Set_Id(Value: UnicodeString);
    procedure Set_FullName(Value: UnicodeString);
    procedure Set_Version(Value: UnicodeString);
    procedure Set_URI(Value: UnicodeString);
  end;

{ TXMLFileDescriptionType }

  TXMLFileDescriptionType = class(TXMLNode, IXMLFileDescriptionType)
  private
    FContact: IXMLParamGroupTypeList;
  protected
    { IXMLFileDescriptionType }
    function Get_FileContent: IXMLParamGroupType;
    function Get_SourceFileList: IXMLSourceFileListType;
    function Get_Contact: IXMLParamGroupTypeList;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLParamGroupType }

  TXMLParamGroupType = class(TXMLNode, IXMLParamGroupType)
  private
    FReferenceableParamGroupRef: IXMLReferenceableParamGroupRefTypeList;
    FCvParam: IXMLCVParamTypeList;
    FUserParam: IXMLUserParamTypeList;
  protected
    { IXMLParamGroupType }
    function Get_ReferenceableParamGroupRef: IXMLReferenceableParamGroupRefTypeList;
    function Get_CvParam: IXMLCVParamTypeList;
    function Get_UserParam: IXMLUserParamTypeList;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLParamGroupTypeList }

  TXMLParamGroupTypeList = class(TXMLNodeCollection, IXMLParamGroupTypeList)
  protected
    { IXMLParamGroupTypeList }
    function Add: IXMLParamGroupType;
    function Insert(const Index: Integer): IXMLParamGroupType;

    function Get_Item(Index: Integer): IXMLParamGroupType;
  end;

{ TXMLReferenceableParamGroupRefType }

  TXMLReferenceableParamGroupRefType = class(TXMLNode, IXMLReferenceableParamGroupRefType)
  protected
    { IXMLReferenceableParamGroupRefType }
    function Get_Ref: UnicodeString;
    procedure Set_Ref(Value: UnicodeString);
  end;

{ TXMLReferenceableParamGroupRefTypeList }

  TXMLReferenceableParamGroupRefTypeList = class(TXMLNodeCollection, IXMLReferenceableParamGroupRefTypeList)
  protected
    { IXMLReferenceableParamGroupRefTypeList }
    function Add: IXMLReferenceableParamGroupRefType;
    function Insert(const Index: Integer): IXMLReferenceableParamGroupRefType;

    function Get_Item(Index: Integer): IXMLReferenceableParamGroupRefType;
  end;

{ TXMLCVParamType }

  TXMLCVParamType = class(TXMLNode, IXMLCVParamType)
  protected
    { IXMLCVParamType }
    function Get_CvRef: UnicodeString;
    function Get_Accession: UnicodeString;
    function Get_Value: UnicodeString;
    function Get_Name: UnicodeString;
    function Get_UnitAccession: UnicodeString;
    function Get_UnitName: UnicodeString;
    function Get_UnitCvRef: UnicodeString;
    procedure Set_CvRef(Value: UnicodeString);
    procedure Set_Accession(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    procedure Set_Name(Value: UnicodeString);
    procedure Set_UnitAccession(Value: UnicodeString);
    procedure Set_UnitName(Value: UnicodeString);
    procedure Set_UnitCvRef(Value: UnicodeString);
  end;

{ TXMLCVParamTypeList }

  TXMLCVParamTypeList = class(TXMLNodeCollection, IXMLCVParamTypeList)
  protected
    { IXMLCVParamTypeList }
    function Add: IXMLCVParamType;
    function Insert(const Index: Integer): IXMLCVParamType;

    function Get_Item(Index: Integer): IXMLCVParamType;
  end;

{ TXMLUserParamType }

  TXMLUserParamType = class(TXMLNode, IXMLUserParamType)
  protected
    { IXMLUserParamType }
    function Get_Name: UnicodeString;
    function Get_Type_: UnicodeString;
    function Get_Value: UnicodeString;
    function Get_UnitAccession: UnicodeString;
    function Get_UnitName: UnicodeString;
    function Get_UnitCvRef: UnicodeString;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Type_(Value: UnicodeString);
    procedure Set_Value(Value: UnicodeString);
    procedure Set_UnitAccession(Value: UnicodeString);
    procedure Set_UnitName(Value: UnicodeString);
    procedure Set_UnitCvRef(Value: UnicodeString);
  end;

{ TXMLUserParamTypeList }

  TXMLUserParamTypeList = class(TXMLNodeCollection, IXMLUserParamTypeList)
  protected
    { IXMLUserParamTypeList }
    function Add: IXMLUserParamType;
    function Insert(const Index: Integer): IXMLUserParamType;

    function Get_Item(Index: Integer): IXMLUserParamType;
  end;

{ TXMLSourceFileListType }

  TXMLSourceFileListType = class(TXMLNodeCollection, IXMLSourceFileListType)
  protected
    { IXMLSourceFileListType }
    function Get_Count: LongWord;
    function Get_SourceFile(Index: Integer): IXMLSourceFileType;
    procedure Set_Count(Value: LongWord);
    function Add: IXMLSourceFileType;
    function Insert(const Index: Integer): IXMLSourceFileType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSourceFileType }

  TXMLSourceFileType = class(TXMLParamGroupType, IXMLSourceFileType)
  protected
    { IXMLSourceFileType }
    function Get_Id: UnicodeString;
    function Get_Name: UnicodeString;
    function Get_Location: UnicodeString;
    procedure Set_Id(Value: UnicodeString);
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Location(Value: UnicodeString);
  end;

{ TXMLReferenceableParamGroupListType }

  TXMLReferenceableParamGroupListType = class(TXMLNodeCollection, IXMLReferenceableParamGroupListType)
  protected
    { IXMLReferenceableParamGroupListType }
    function Get_Count: LongWord;
    function Get_ReferenceableParamGroup(Index: Integer): IXMLReferenceableParamGroupType;
    procedure Set_Count(Value: LongWord);
    function Add: IXMLReferenceableParamGroupType;
    function Insert(const Index: Integer): IXMLReferenceableParamGroupType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLReferenceableParamGroupType }

  TXMLReferenceableParamGroupType = class(TXMLNode, IXMLReferenceableParamGroupType)
  private
    FCvParam: IXMLCVParamTypeList;
    FUserParam: IXMLUserParamTypeList;
  protected
    { IXMLReferenceableParamGroupType }
    function Get_Id: UnicodeString;
    function Get_CvParam: IXMLCVParamTypeList;
    function Get_UserParam: IXMLUserParamTypeList;
    procedure Set_Id(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSampleListType }

  TXMLSampleListType = class(TXMLNodeCollection, IXMLSampleListType)
  protected
    { IXMLSampleListType }
    function Get_Count: LongWord;
    function Get_Sample(Index: Integer): IXMLSampleType;
    procedure Set_Count(Value: LongWord);
    function Add: IXMLSampleType;
    function Insert(const Index: Integer): IXMLSampleType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSampleType }

  TXMLSampleType = class(TXMLParamGroupType, IXMLSampleType)
  protected
    { IXMLSampleType }
    function Get_Id: UnicodeString;
    function Get_Name: UnicodeString;
    procedure Set_Id(Value: UnicodeString);
    procedure Set_Name(Value: UnicodeString);
  end;

{ TXMLSoftwareListType }

  TXMLSoftwareListType = class(TXMLNodeCollection, IXMLSoftwareListType)
  protected
    { IXMLSoftwareListType }
    function Get_Count: LongWord;
    function Get_Software(Index: Integer): IXMLSoftwareType;
    procedure Set_Count(Value: LongWord);
    function Add: IXMLSoftwareType;
    function Insert(const Index: Integer): IXMLSoftwareType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSoftwareType }

  TXMLSoftwareType = class(TXMLParamGroupType, IXMLSoftwareType)
  protected
    { IXMLSoftwareType }
    function Get_Id: UnicodeString;
    function Get_Version: UnicodeString;
    procedure Set_Id(Value: UnicodeString);
    procedure Set_Version(Value: UnicodeString);
  end;

{ TXMLScanSettingsListType }

  TXMLScanSettingsListType = class(TXMLNodeCollection, IXMLScanSettingsListType)
  protected
    { IXMLScanSettingsListType }
    function Get_Count: LongWord;
    function Get_ScanSettings(Index: Integer): IXMLScanSettingsType;
    procedure Set_Count(Value: LongWord);
    function Add: IXMLScanSettingsType;
    function Insert(const Index: Integer): IXMLScanSettingsType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLScanSettingsType }

  TXMLScanSettingsType = class(TXMLParamGroupType, IXMLScanSettingsType)
  protected
    { IXMLScanSettingsType }
    function Get_Id: UnicodeString;
    function Get_SourceFileRefList: IXMLSourceFileRefListType;
    function Get_TargetList: IXMLTargetListType;
    procedure Set_Id(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSourceFileRefListType }

  TXMLSourceFileRefListType = class(TXMLNodeCollection, IXMLSourceFileRefListType)
  protected
    { IXMLSourceFileRefListType }
    function Get_Count: LongWord;
    function Get_SourceFileRef(Index: Integer): IXMLSourceFileRefType;
    procedure Set_Count(Value: LongWord);
    function Add: IXMLSourceFileRefType;
    function Insert(const Index: Integer): IXMLSourceFileRefType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSourceFileRefType }

  TXMLSourceFileRefType = class(TXMLNode, IXMLSourceFileRefType)
  protected
    { IXMLSourceFileRefType }
    function Get_Ref: UnicodeString;
    procedure Set_Ref(Value: UnicodeString);
  end;

{ TXMLTargetListType }

  TXMLTargetListType = class(TXMLNodeCollection, IXMLTargetListType)
  protected
    { IXMLTargetListType }
    function Get_Count: LongWord;
    function Get_Target(Index: Integer): IXMLParamGroupType;
    procedure Set_Count(Value: LongWord);
    function Add: IXMLParamGroupType;
    function Insert(const Index: Integer): IXMLParamGroupType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLInstrumentConfigurationListType }

  TXMLInstrumentConfigurationListType = class(TXMLNodeCollection, IXMLInstrumentConfigurationListType)
  protected
    { IXMLInstrumentConfigurationListType }
    function Get_Count: LongWord;
    function Get_InstrumentConfiguration(Index: Integer): IXMLInstrumentConfigurationType;
    procedure Set_Count(Value: LongWord);
    function Add: IXMLInstrumentConfigurationType;
    function Insert(const Index: Integer): IXMLInstrumentConfigurationType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLInstrumentConfigurationType }

  TXMLInstrumentConfigurationType = class(TXMLParamGroupType, IXMLInstrumentConfigurationType)
  protected
    { IXMLInstrumentConfigurationType }
    function Get_Id: UnicodeString;
    function Get_ScanSettingsRef: UnicodeString;
    function Get_ComponentList: IXMLComponentListType;
    function Get_SoftwareRef: IXMLSoftwareRefType;
    procedure Set_Id(Value: UnicodeString);
    procedure Set_ScanSettingsRef(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLComponentListType }

  TXMLComponentListType = class(TXMLNode, IXMLComponentListType)
  private
    FSource: IXMLSourceComponentTypeList;
    FAnalyzer: IXMLAnalyzerComponentTypeList;
    FDetector: IXMLDetectorComponentTypeList;
  protected
    { IXMLComponentListType }
    function Get_Count: LongWord;
    function Get_Source: IXMLSourceComponentTypeList;
    function Get_Analyzer: IXMLAnalyzerComponentTypeList;
    function Get_Detector: IXMLDetectorComponentTypeList;
    procedure Set_Count(Value: LongWord);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLComponentType }

  TXMLComponentType = class(TXMLParamGroupType, IXMLComponentType)
  protected
    { IXMLComponentType }
    function Get_Order: Integer;
    procedure Set_Order(Value: Integer);
  end;

{ TXMLSourceComponentType }

  TXMLSourceComponentType = class(TXMLComponentType, IXMLSourceComponentType)
  protected
    { IXMLSourceComponentType }
  end;

{ TXMLSourceComponentTypeList }

  TXMLSourceComponentTypeList = class(TXMLNodeCollection, IXMLSourceComponentTypeList)
  protected
    { IXMLSourceComponentTypeList }
    function Add: IXMLSourceComponentType;
    function Insert(const Index: Integer): IXMLSourceComponentType;

    function Get_Item(Index: Integer): IXMLSourceComponentType;
  end;

{ TXMLAnalyzerComponentType }

  TXMLAnalyzerComponentType = class(TXMLComponentType, IXMLAnalyzerComponentType)
  protected
    { IXMLAnalyzerComponentType }
  end;

{ TXMLAnalyzerComponentTypeList }

  TXMLAnalyzerComponentTypeList = class(TXMLNodeCollection, IXMLAnalyzerComponentTypeList)
  protected
    { IXMLAnalyzerComponentTypeList }
    function Add: IXMLAnalyzerComponentType;
    function Insert(const Index: Integer): IXMLAnalyzerComponentType;

    function Get_Item(Index: Integer): IXMLAnalyzerComponentType;
  end;

{ TXMLDetectorComponentType }

  TXMLDetectorComponentType = class(TXMLComponentType, IXMLDetectorComponentType)
  protected
    { IXMLDetectorComponentType }
  end;

{ TXMLDetectorComponentTypeList }

  TXMLDetectorComponentTypeList = class(TXMLNodeCollection, IXMLDetectorComponentTypeList)
  protected
    { IXMLDetectorComponentTypeList }
    function Add: IXMLDetectorComponentType;
    function Insert(const Index: Integer): IXMLDetectorComponentType;

    function Get_Item(Index: Integer): IXMLDetectorComponentType;
  end;

{ TXMLSoftwareRefType }

  TXMLSoftwareRefType = class(TXMLNode, IXMLSoftwareRefType)
  protected
    { IXMLSoftwareRefType }
    function Get_Ref: UnicodeString;
    procedure Set_Ref(Value: UnicodeString);
  end;

{ TXMLDataProcessingListType }

  TXMLDataProcessingListType = class(TXMLNodeCollection, IXMLDataProcessingListType)
  protected
    { IXMLDataProcessingListType }
    function Get_Count: LongWord;
    function Get_DataProcessing(Index: Integer): IXMLDataProcessingType;
    procedure Set_Count(Value: LongWord);
    function Add: IXMLDataProcessingType;
    function Insert(const Index: Integer): IXMLDataProcessingType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLDataProcessingType }

  TXMLDataProcessingType = class(TXMLNodeCollection, IXMLDataProcessingType)
  protected
    { IXMLDataProcessingType }
    function Get_Id: UnicodeString;
    function Get_ProcessingMethod(Index: Integer): IXMLProcessingMethodType;
    procedure Set_Id(Value: UnicodeString);
    function Add: IXMLProcessingMethodType;
    function Insert(const Index: Integer): IXMLProcessingMethodType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLProcessingMethodType }

  TXMLProcessingMethodType = class(TXMLParamGroupType, IXMLProcessingMethodType)
  protected
    { IXMLProcessingMethodType }
    function Get_Order: LongWord;
    function Get_SoftwareRef: UnicodeString;
    procedure Set_Order(Value: LongWord);
    procedure Set_SoftwareRef(Value: UnicodeString);
  end;

{ TXMLRunType }

  TXMLRunType = class(TXMLParamGroupType, IXMLRunType)
  protected
    { IXMLRunType }
    function Get_Id: UnicodeString;
    function Get_DefaultInstrumentConfigurationRef: UnicodeString;
    function Get_DefaultSourceFileRef: UnicodeString;
    function Get_SampleRef: UnicodeString;
    function Get_StartTimeStamp: UnicodeString;
    function Get_SpectrumList: IXMLSpectrumListType;
    function Get_ChromatogramList: IXMLChromatogramListType;
    procedure Set_Id(Value: UnicodeString);
    procedure Set_DefaultInstrumentConfigurationRef(Value: UnicodeString);
    procedure Set_DefaultSourceFileRef(Value: UnicodeString);
    procedure Set_SampleRef(Value: UnicodeString);
    procedure Set_StartTimeStamp(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSpectrumListType }

  TXMLSpectrumListType = class(TXMLNodeCollection, IXMLSpectrumListType)
  protected
    { IXMLSpectrumListType }
    function Get_Count: LongWord;
    function Get_DefaultDataProcessingRef: UnicodeString;
    function Get_Spectrum(Index: Integer): IXMLSpectrumType;
    procedure Set_Count(Value: LongWord);
    procedure Set_DefaultDataProcessingRef(Value: UnicodeString);
    function Add: IXMLSpectrumType;
    function Insert(const Index: Integer): IXMLSpectrumType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSpectrumType }

  TXMLSpectrumType = class(TXMLParamGroupType, IXMLSpectrumType)
  protected
    { IXMLSpectrumType }
    function Get_Id: UnicodeString;
    function Get_SpotID: UnicodeString;
    function Get_Index: LongWord;
    function Get_DefaultArrayLength: Integer;
    function Get_DataProcessingRef: UnicodeString;
    function Get_SourceFileRef: UnicodeString;
    function Get_ScanList: IXMLScanListType;
    function Get_PrecursorList: IXMLPrecursorListType;
    function Get_ProductList: IXMLProductListType;
    function Get_BinaryDataArrayList: IXMLBinaryDataArrayListType;
    procedure Set_Id(Value: UnicodeString);
    procedure Set_SpotID(Value: UnicodeString);
    procedure Set_Index(Value: LongWord);
    procedure Set_DefaultArrayLength(Value: Integer);
    procedure Set_DataProcessingRef(Value: UnicodeString);
    procedure Set_SourceFileRef(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLScanListType }

  TXMLScanListType = class(TXMLParamGroupType, IXMLScanListType)
  private
    FScan: IXMLScanTypeList;
  protected
    { IXMLScanListType }
    function Get_Count: LongWord;
    function Get_Scan: IXMLScanTypeList;
    procedure Set_Count(Value: LongWord);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLScanType }

  TXMLScanType = class(TXMLParamGroupType, IXMLScanType)
  protected
    { IXMLScanType }
    function Get_SpectrumRef: UnicodeString;
    function Get_SourceFileRef: UnicodeString;
    function Get_ExternalSpectrumID: UnicodeString;
    function Get_InstrumentConfigurationRef: UnicodeString;
    function Get_ScanWindowList: IXMLScanWindowListType;
    procedure Set_SpectrumRef(Value: UnicodeString);
    procedure Set_SourceFileRef(Value: UnicodeString);
    procedure Set_ExternalSpectrumID(Value: UnicodeString);
    procedure Set_InstrumentConfigurationRef(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLScanTypeList }

  TXMLScanTypeList = class(TXMLNodeCollection, IXMLScanTypeList)
  protected
    { IXMLScanTypeList }
    function Add: IXMLScanType;
    function Insert(const Index: Integer): IXMLScanType;

    function Get_Item(Index: Integer): IXMLScanType;
  end;

{ TXMLScanWindowListType }

  TXMLScanWindowListType = class(TXMLNodeCollection, IXMLScanWindowListType)
  protected
    { IXMLScanWindowListType }
    function Get_Count: Integer;
    function Get_ScanWindow(Index: Integer): IXMLParamGroupType;
    procedure Set_Count(Value: Integer);
    function Add: IXMLParamGroupType;
    function Insert(const Index: Integer): IXMLParamGroupType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLPrecursorListType }

  TXMLPrecursorListType = class(TXMLNodeCollection, IXMLPrecursorListType)
  protected
    { IXMLPrecursorListType }
    function Get_Count: LongWord;
    function Get_Precursor(Index: Integer): IXMLPrecursorType;
    procedure Set_Count(Value: LongWord);
    function Add: IXMLPrecursorType;
    function Insert(const Index: Integer): IXMLPrecursorType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLPrecursorType }

  TXMLPrecursorType = class(TXMLNode, IXMLPrecursorType)
  protected
    { IXMLPrecursorType }
    function Get_SpectrumRef: UnicodeString;
    function Get_SourceFileRef: UnicodeString;
    function Get_ExternalSpectrumID: UnicodeString;
    function Get_IsolationWindow: IXMLParamGroupType;
    function Get_SelectedIonList: IXMLSelectedIonListType;
    function Get_Activation: IXMLParamGroupType;
    procedure Set_SpectrumRef(Value: UnicodeString);
    procedure Set_SourceFileRef(Value: UnicodeString);
    procedure Set_ExternalSpectrumID(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSelectedIonListType }

  TXMLSelectedIonListType = class(TXMLNodeCollection, IXMLSelectedIonListType)
  protected
    { IXMLSelectedIonListType }
    function Get_Count: LongWord;
    function Get_SelectedIon(Index: Integer): IXMLParamGroupType;
    procedure Set_Count(Value: LongWord);
    function Add: IXMLParamGroupType;
    function Insert(const Index: Integer): IXMLParamGroupType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLProductListType }

  TXMLProductListType = class(TXMLNodeCollection, IXMLProductListType)
  protected
    { IXMLProductListType }
    function Get_Count: LongWord;
    function Get_Product(Index: Integer): IXMLProductType;
    procedure Set_Count(Value: LongWord);
    function Add: IXMLProductType;
    function Insert(const Index: Integer): IXMLProductType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLProductType }

  TXMLProductType = class(TXMLNode, IXMLProductType)
  protected
    { IXMLProductType }
    function Get_IsolationWindow: IXMLParamGroupType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLBinaryDataArrayListType }

  TXMLBinaryDataArrayListType = class(TXMLNodeCollection, IXMLBinaryDataArrayListType)
  protected
    { IXMLBinaryDataArrayListType }
    function Get_Count: LongWord;
    function Get_BinaryDataArray(Index: Integer): IXMLBinaryDataArrayType;
    procedure Set_Count(Value: LongWord);
    function Add: IXMLBinaryDataArrayType;
    function Insert(const Index: Integer): IXMLBinaryDataArrayType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLBinaryDataArrayType }

  TXMLBinaryDataArrayType = class(TXMLParamGroupType, IXMLBinaryDataArrayType)
  protected
    { IXMLBinaryDataArrayType }
    function Get_ArrayLength: LongWord;
    function Get_DataProcessingRef: UnicodeString;
    function Get_EncodedLength: LongWord;
    function Get_Binary: UnicodeString;
    procedure Set_ArrayLength(Value: LongWord);
    procedure Set_DataProcessingRef(Value: UnicodeString);
    procedure Set_EncodedLength(Value: LongWord);
    procedure Set_Binary(Value: UnicodeString);
  end;

{ TXMLChromatogramListType }

  TXMLChromatogramListType = class(TXMLNodeCollection, IXMLChromatogramListType)
  protected
    { IXMLChromatogramListType }
    function Get_Count: LongWord;
    function Get_DefaultDataProcessingRef: UnicodeString;
    function Get_Chromatogram(Index: Integer): IXMLChromatogramType;
    procedure Set_Count(Value: LongWord);
    procedure Set_DefaultDataProcessingRef(Value: UnicodeString);
    function Add: IXMLChromatogramType;
    function Insert(const Index: Integer): IXMLChromatogramType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLChromatogramType }

  TXMLChromatogramType = class(TXMLParamGroupType, IXMLChromatogramType)
  protected
    { IXMLChromatogramType }
    function Get_Id: UnicodeString;
    function Get_Index: LongWord;
    function Get_DefaultArrayLength: Integer;
    function Get_DataProcessingRef: UnicodeString;
    function Get_Precursor: IXMLPrecursorType;
    function Get_Product: IXMLProductType;
    function Get_BinaryDataArrayList: IXMLBinaryDataArrayListType;
    procedure Set_Id(Value: UnicodeString);
    procedure Set_Index(Value: LongWord);
    procedure Set_DefaultArrayLength(Value: Integer);
    procedure Set_DataProcessingRef(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ Global Functions }

function GetmzML(Doc: IXMLDocument): IXMLMzMLType;
function LoadmzML(const FileName: string): IXMLMzMLType;
function NewmzML: IXMLMzMLType;

const
  TargetNamespace = 'http://psi.hupo.org/ms/mzml';

implementation

{ Global Functions }

function GetmzML(Doc: IXMLDocument): IXMLMzMLType;
begin
  Result := Doc.GetDocBinding('mzML', TXMLMzMLType, TargetNamespace) as IXMLMzMLType;
end;

function LoadmzML(const FileName: string): IXMLMzMLType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('mzML', TXMLMzMLType, TargetNamespace) as IXMLMzMLType;
end;

function NewmzML: IXMLMzMLType;
begin
  Result := NewXMLDocument.GetDocBinding('mzML', TXMLMzMLType, TargetNamespace) as IXMLMzMLType;
end;

{ TXMLMzMLType }

procedure TXMLMzMLType.AfterConstruction;
begin
  RegisterChildNode('cvList', TXMLCVListType);
  RegisterChildNode('fileDescription', TXMLFileDescriptionType);
  RegisterChildNode('referenceableParamGroupList', TXMLReferenceableParamGroupListType);
  RegisterChildNode('sampleList', TXMLSampleListType);
  RegisterChildNode('softwareList', TXMLSoftwareListType);
  RegisterChildNode('scanSettingsList', TXMLScanSettingsListType);
  RegisterChildNode('instrumentConfigurationList', TXMLInstrumentConfigurationListType);
  RegisterChildNode('dataProcessingList', TXMLDataProcessingListType);
  RegisterChildNode('run', TXMLRunType);
  inherited;
end;

function TXMLMzMLType.Get_Accession: UnicodeString;
begin
  Result := AttributeNodes['accession'].Text;
end;

procedure TXMLMzMLType.Set_Accession(Value: UnicodeString);
begin
  SetAttribute('accession', Value);
end;

function TXMLMzMLType.Get_Version: UnicodeString;
begin
  Result := AttributeNodes['version'].Text;
end;

procedure TXMLMzMLType.Set_Version(Value: UnicodeString);
begin
  SetAttribute('version', Value);
end;

function TXMLMzMLType.Get_Id: UnicodeString;
begin
  Result := AttributeNodes['id'].Text;
end;

procedure TXMLMzMLType.Set_Id(Value: UnicodeString);
begin
  SetAttribute('id', Value);
end;

function TXMLMzMLType.Get_CvList: IXMLCVListType;
begin
  Result := ChildNodes['cvList'] as IXMLCVListType;
end;

function TXMLMzMLType.Get_FileDescription: IXMLFileDescriptionType;
begin
  Result := ChildNodes['fileDescription'] as IXMLFileDescriptionType;
end;

function TXMLMzMLType.Get_ReferenceableParamGroupList: IXMLReferenceableParamGroupListType;
begin
  Result := ChildNodes['referenceableParamGroupList'] as IXMLReferenceableParamGroupListType;
end;

function TXMLMzMLType.Get_SampleList: IXMLSampleListType;
begin
  Result := ChildNodes['sampleList'] as IXMLSampleListType;
end;

function TXMLMzMLType.Get_SoftwareList: IXMLSoftwareListType;
begin
  Result := ChildNodes['softwareList'] as IXMLSoftwareListType;
end;

function TXMLMzMLType.Get_ScanSettingsList: IXMLScanSettingsListType;
begin
  Result := ChildNodes['scanSettingsList'] as IXMLScanSettingsListType;
end;

function TXMLMzMLType.Get_InstrumentConfigurationList: IXMLInstrumentConfigurationListType;
begin
  Result := ChildNodes['instrumentConfigurationList'] as IXMLInstrumentConfigurationListType;
end;

function TXMLMzMLType.Get_DataProcessingList: IXMLDataProcessingListType;
begin
  Result := ChildNodes['dataProcessingList'] as IXMLDataProcessingListType;
end;

function TXMLMzMLType.Get_Run: IXMLRunType;
begin
  Result := ChildNodes['run'] as IXMLRunType;
end;

{ TXMLCVListType }

procedure TXMLCVListType.AfterConstruction;
begin
  RegisterChildNode('cv', TXMLCVType);
  ItemTag := 'cv';
  ItemInterface := IXMLCVType;
  inherited;
end;

function TXMLCVListType.Get_Count: LongWord;
begin
  Result := AttributeNodes['count'].NodeValue;
end;

procedure TXMLCVListType.Set_Count(Value: LongWord);
begin
  SetAttribute('count', Value);
end;

function TXMLCVListType.Get_Cv(Index: Integer): IXMLCVType;
begin
  Result := List[Index] as IXMLCVType;
end;

function TXMLCVListType.Add: IXMLCVType;
begin
  Result := AddItem(-1) as IXMLCVType;
end;

function TXMLCVListType.Insert(const Index: Integer): IXMLCVType;
begin
  Result := AddItem(Index) as IXMLCVType;
end;

{ TXMLCVType }

function TXMLCVType.Get_Id: UnicodeString;
begin
  Result := AttributeNodes['id'].Text;
end;

procedure TXMLCVType.Set_Id(Value: UnicodeString);
begin
  SetAttribute('id', Value);
end;

function TXMLCVType.Get_FullName: UnicodeString;
begin
  Result := AttributeNodes['fullName'].Text;
end;

procedure TXMLCVType.Set_FullName(Value: UnicodeString);
begin
  SetAttribute('fullName', Value);
end;

function TXMLCVType.Get_Version: UnicodeString;
begin
  Result := AttributeNodes['version'].Text;
end;

procedure TXMLCVType.Set_Version(Value: UnicodeString);
begin
  SetAttribute('version', Value);
end;

function TXMLCVType.Get_URI: UnicodeString;
begin
  Result := AttributeNodes['URI'].Text;
end;

procedure TXMLCVType.Set_URI(Value: UnicodeString);
begin
  SetAttribute('URI', Value);
end;

{ TXMLFileDescriptionType }

procedure TXMLFileDescriptionType.AfterConstruction;
begin
  RegisterChildNode('fileContent', TXMLParamGroupType);
  RegisterChildNode('sourceFileList', TXMLSourceFileListType);
  RegisterChildNode('contact', TXMLParamGroupType);
  FContact := CreateCollection(TXMLParamGroupTypeList, IXMLParamGroupType, 'contact') as IXMLParamGroupTypeList;
  inherited;
end;

function TXMLFileDescriptionType.Get_FileContent: IXMLParamGroupType;
begin
  Result := ChildNodes['fileContent'] as IXMLParamGroupType;
end;

function TXMLFileDescriptionType.Get_SourceFileList: IXMLSourceFileListType;
begin
  Result := ChildNodes['sourceFileList'] as IXMLSourceFileListType;
end;

function TXMLFileDescriptionType.Get_Contact: IXMLParamGroupTypeList;
begin
  Result := FContact;
end;

{ TXMLParamGroupType }

procedure TXMLParamGroupType.AfterConstruction;
begin
  RegisterChildNode('referenceableParamGroupRef', TXMLReferenceableParamGroupRefType);
  RegisterChildNode('cvParam', TXMLCVParamType);
  RegisterChildNode('userParam', TXMLUserParamType);
  FReferenceableParamGroupRef := CreateCollection(TXMLReferenceableParamGroupRefTypeList, IXMLReferenceableParamGroupRefType, 'referenceableParamGroupRef') as IXMLReferenceableParamGroupRefTypeList;
  FCvParam := CreateCollection(TXMLCVParamTypeList, IXMLCVParamType, 'cvParam') as IXMLCVParamTypeList;
  FUserParam := CreateCollection(TXMLUserParamTypeList, IXMLUserParamType, 'userParam') as IXMLUserParamTypeList;
  inherited;
end;

function TXMLParamGroupType.Get_ReferenceableParamGroupRef: IXMLReferenceableParamGroupRefTypeList;
begin
  Result := FReferenceableParamGroupRef;
end;

function TXMLParamGroupType.Get_CvParam: IXMLCVParamTypeList;
begin
  Result := FCvParam;
end;

function TXMLParamGroupType.Get_UserParam: IXMLUserParamTypeList;
begin
  Result := FUserParam;
end;

{ TXMLParamGroupTypeList }

function TXMLParamGroupTypeList.Add: IXMLParamGroupType;
begin
  Result := AddItem(-1) as IXMLParamGroupType;
end;

function TXMLParamGroupTypeList.Insert(const Index: Integer): IXMLParamGroupType;
begin
  Result := AddItem(Index) as IXMLParamGroupType;
end;

function TXMLParamGroupTypeList.Get_Item(Index: Integer): IXMLParamGroupType;
begin
  Result := List[Index] as IXMLParamGroupType;
end;

{ TXMLReferenceableParamGroupRefType }

function TXMLReferenceableParamGroupRefType.Get_Ref: UnicodeString;
begin
  Result := AttributeNodes['ref'].Text;
end;

procedure TXMLReferenceableParamGroupRefType.Set_Ref(Value: UnicodeString);
begin
  SetAttribute('ref', Value);
end;

{ TXMLReferenceableParamGroupRefTypeList }

function TXMLReferenceableParamGroupRefTypeList.Add: IXMLReferenceableParamGroupRefType;
begin
  Result := AddItem(-1) as IXMLReferenceableParamGroupRefType;
end;

function TXMLReferenceableParamGroupRefTypeList.Insert(const Index: Integer): IXMLReferenceableParamGroupRefType;
begin
  Result := AddItem(Index) as IXMLReferenceableParamGroupRefType;
end;

function TXMLReferenceableParamGroupRefTypeList.Get_Item(Index: Integer): IXMLReferenceableParamGroupRefType;
begin
  Result := List[Index] as IXMLReferenceableParamGroupRefType;
end;

{ TXMLCVParamType }

function TXMLCVParamType.Get_CvRef: UnicodeString;
begin
  Result := AttributeNodes['cvRef'].Text;
end;

procedure TXMLCVParamType.Set_CvRef(Value: UnicodeString);
begin
  SetAttribute('cvRef', Value);
end;

function TXMLCVParamType.Get_Accession: UnicodeString;
begin
  Result := AttributeNodes['accession'].Text;
end;

procedure TXMLCVParamType.Set_Accession(Value: UnicodeString);
begin
  SetAttribute('accession', Value);
end;

function TXMLCVParamType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLCVParamType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

function TXMLCVParamType.Get_Name: UnicodeString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLCVParamType.Set_Name(Value: UnicodeString);
begin
  SetAttribute('name', Value);
end;

function TXMLCVParamType.Get_UnitAccession: UnicodeString;
begin
  Result := AttributeNodes['unitAccession'].Text;
end;

procedure TXMLCVParamType.Set_UnitAccession(Value: UnicodeString);
begin
  SetAttribute('unitAccession', Value);
end;

function TXMLCVParamType.Get_UnitName: UnicodeString;
begin
  Result := AttributeNodes['unitName'].Text;
end;

procedure TXMLCVParamType.Set_UnitName(Value: UnicodeString);
begin
  SetAttribute('unitName', Value);
end;

function TXMLCVParamType.Get_UnitCvRef: UnicodeString;
begin
  Result := AttributeNodes['unitCvRef'].Text;
end;

procedure TXMLCVParamType.Set_UnitCvRef(Value: UnicodeString);
begin
  SetAttribute('unitCvRef', Value);
end;

{ TXMLCVParamTypeList }

function TXMLCVParamTypeList.Add: IXMLCVParamType;
begin
  Result := AddItem(-1) as IXMLCVParamType;
end;

function TXMLCVParamTypeList.Insert(const Index: Integer): IXMLCVParamType;
begin
  Result := AddItem(Index) as IXMLCVParamType;
end;

function TXMLCVParamTypeList.Get_Item(Index: Integer): IXMLCVParamType;
begin
  Result := List[Index] as IXMLCVParamType;
end;

{ TXMLUserParamType }

function TXMLUserParamType.Get_Name: UnicodeString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLUserParamType.Set_Name(Value: UnicodeString);
begin
  SetAttribute('name', Value);
end;

function TXMLUserParamType.Get_Type_: UnicodeString;
begin
  Result := AttributeNodes['type'].Text;
end;

procedure TXMLUserParamType.Set_Type_(Value: UnicodeString);
begin
  SetAttribute('type', Value);
end;

function TXMLUserParamType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLUserParamType.Set_Value(Value: UnicodeString);
begin
  SetAttribute('value', Value);
end;

function TXMLUserParamType.Get_UnitAccession: UnicodeString;
begin
  Result := AttributeNodes['unitAccession'].Text;
end;

procedure TXMLUserParamType.Set_UnitAccession(Value: UnicodeString);
begin
  SetAttribute('unitAccession', Value);
end;

function TXMLUserParamType.Get_UnitName: UnicodeString;
begin
  Result := AttributeNodes['unitName'].Text;
end;

procedure TXMLUserParamType.Set_UnitName(Value: UnicodeString);
begin
  SetAttribute('unitName', Value);
end;

function TXMLUserParamType.Get_UnitCvRef: UnicodeString;
begin
  Result := AttributeNodes['unitCvRef'].Text;
end;

procedure TXMLUserParamType.Set_UnitCvRef(Value: UnicodeString);
begin
  SetAttribute('unitCvRef', Value);
end;

{ TXMLUserParamTypeList }

function TXMLUserParamTypeList.Add: IXMLUserParamType;
begin
  Result := AddItem(-1) as IXMLUserParamType;
end;

function TXMLUserParamTypeList.Insert(const Index: Integer): IXMLUserParamType;
begin
  Result := AddItem(Index) as IXMLUserParamType;
end;

function TXMLUserParamTypeList.Get_Item(Index: Integer): IXMLUserParamType;
begin
  Result := List[Index] as IXMLUserParamType;
end;

{ TXMLSourceFileListType }

procedure TXMLSourceFileListType.AfterConstruction;
begin
  RegisterChildNode('sourceFile', TXMLSourceFileType);
  ItemTag := 'sourceFile';
  ItemInterface := IXMLSourceFileType;
  inherited;
end;

function TXMLSourceFileListType.Get_Count: LongWord;
begin
  Result := AttributeNodes['count'].NodeValue;
end;

procedure TXMLSourceFileListType.Set_Count(Value: LongWord);
begin
  SetAttribute('count', Value);
end;

function TXMLSourceFileListType.Get_SourceFile(Index: Integer): IXMLSourceFileType;
begin
  Result := List[Index] as IXMLSourceFileType;
end;

function TXMLSourceFileListType.Add: IXMLSourceFileType;
begin
  Result := AddItem(-1) as IXMLSourceFileType;
end;

function TXMLSourceFileListType.Insert(const Index: Integer): IXMLSourceFileType;
begin
  Result := AddItem(Index) as IXMLSourceFileType;
end;

{ TXMLSourceFileType }

function TXMLSourceFileType.Get_Id: UnicodeString;
begin
  Result := AttributeNodes['id'].Text;
end;

procedure TXMLSourceFileType.Set_Id(Value: UnicodeString);
begin
  SetAttribute('id', Value);
end;

function TXMLSourceFileType.Get_Name: UnicodeString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLSourceFileType.Set_Name(Value: UnicodeString);
begin
  SetAttribute('name', Value);
end;

function TXMLSourceFileType.Get_Location: UnicodeString;
begin
  Result := AttributeNodes['location'].Text;
end;

procedure TXMLSourceFileType.Set_Location(Value: UnicodeString);
begin
  SetAttribute('location', Value);
end;

{ TXMLReferenceableParamGroupListType }

procedure TXMLReferenceableParamGroupListType.AfterConstruction;
begin
  RegisterChildNode('referenceableParamGroup', TXMLReferenceableParamGroupType);
  ItemTag := 'referenceableParamGroup';
  ItemInterface := IXMLReferenceableParamGroupType;
  inherited;
end;

function TXMLReferenceableParamGroupListType.Get_Count: LongWord;
begin
  Result := AttributeNodes['count'].NodeValue;
end;

procedure TXMLReferenceableParamGroupListType.Set_Count(Value: LongWord);
begin
  SetAttribute('count', Value);
end;

function TXMLReferenceableParamGroupListType.Get_ReferenceableParamGroup(Index: Integer): IXMLReferenceableParamGroupType;
begin
  Result := List[Index] as IXMLReferenceableParamGroupType;
end;

function TXMLReferenceableParamGroupListType.Add: IXMLReferenceableParamGroupType;
begin
  Result := AddItem(-1) as IXMLReferenceableParamGroupType;
end;

function TXMLReferenceableParamGroupListType.Insert(const Index: Integer): IXMLReferenceableParamGroupType;
begin
  Result := AddItem(Index) as IXMLReferenceableParamGroupType;
end;

{ TXMLReferenceableParamGroupType }

procedure TXMLReferenceableParamGroupType.AfterConstruction;
begin
  RegisterChildNode('cvParam', TXMLCVParamType);
  RegisterChildNode('userParam', TXMLUserParamType);
  FCvParam := CreateCollection(TXMLCVParamTypeList, IXMLCVParamType, 'cvParam') as IXMLCVParamTypeList;
  FUserParam := CreateCollection(TXMLUserParamTypeList, IXMLUserParamType, 'userParam') as IXMLUserParamTypeList;
  inherited;
end;

function TXMLReferenceableParamGroupType.Get_Id: UnicodeString;
begin
  Result := AttributeNodes['id'].Text;
end;

procedure TXMLReferenceableParamGroupType.Set_Id(Value: UnicodeString);
begin
  SetAttribute('id', Value);
end;

function TXMLReferenceableParamGroupType.Get_CvParam: IXMLCVParamTypeList;
begin
  Result := FCvParam;
end;

function TXMLReferenceableParamGroupType.Get_UserParam: IXMLUserParamTypeList;
begin
  Result := FUserParam;
end;

{ TXMLSampleListType }

procedure TXMLSampleListType.AfterConstruction;
begin
  RegisterChildNode('sample', TXMLSampleType);
  ItemTag := 'sample';
  ItemInterface := IXMLSampleType;
  inherited;
end;

function TXMLSampleListType.Get_Count: LongWord;
begin
  Result := AttributeNodes['count'].NodeValue;
end;

procedure TXMLSampleListType.Set_Count(Value: LongWord);
begin
  SetAttribute('count', Value);
end;

function TXMLSampleListType.Get_Sample(Index: Integer): IXMLSampleType;
begin
  Result := List[Index] as IXMLSampleType;
end;

function TXMLSampleListType.Add: IXMLSampleType;
begin
  Result := AddItem(-1) as IXMLSampleType;
end;

function TXMLSampleListType.Insert(const Index: Integer): IXMLSampleType;
begin
  Result := AddItem(Index) as IXMLSampleType;
end;

{ TXMLSampleType }

function TXMLSampleType.Get_Id: UnicodeString;
begin
  Result := AttributeNodes['id'].Text;
end;

procedure TXMLSampleType.Set_Id(Value: UnicodeString);
begin
  SetAttribute('id', Value);
end;

function TXMLSampleType.Get_Name: UnicodeString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLSampleType.Set_Name(Value: UnicodeString);
begin
  SetAttribute('name', Value);
end;

{ TXMLSoftwareListType }

procedure TXMLSoftwareListType.AfterConstruction;
begin
  RegisterChildNode('software', TXMLSoftwareType);
  ItemTag := 'software';
  ItemInterface := IXMLSoftwareType;
  inherited;
end;

function TXMLSoftwareListType.Get_Count: LongWord;
begin
  Result := AttributeNodes['count'].NodeValue;
end;

procedure TXMLSoftwareListType.Set_Count(Value: LongWord);
begin
  SetAttribute('count', Value);
end;

function TXMLSoftwareListType.Get_Software(Index: Integer): IXMLSoftwareType;
begin
  Result := List[Index] as IXMLSoftwareType;
end;

function TXMLSoftwareListType.Add: IXMLSoftwareType;
begin
  Result := AddItem(-1) as IXMLSoftwareType;
end;

function TXMLSoftwareListType.Insert(const Index: Integer): IXMLSoftwareType;
begin
  Result := AddItem(Index) as IXMLSoftwareType;
end;

{ TXMLSoftwareType }

function TXMLSoftwareType.Get_Id: UnicodeString;
begin
  Result := AttributeNodes['id'].Text;
end;

procedure TXMLSoftwareType.Set_Id(Value: UnicodeString);
begin
  SetAttribute('id', Value);
end;

function TXMLSoftwareType.Get_Version: UnicodeString;
begin
  Result := AttributeNodes['version'].Text;
end;

procedure TXMLSoftwareType.Set_Version(Value: UnicodeString);
begin
  SetAttribute('version', Value);
end;

{ TXMLScanSettingsListType }

procedure TXMLScanSettingsListType.AfterConstruction;
begin
  RegisterChildNode('scanSettings', TXMLScanSettingsType);
  ItemTag := 'scanSettings';
  ItemInterface := IXMLScanSettingsType;
  inherited;
end;

function TXMLScanSettingsListType.Get_Count: LongWord;
begin
  Result := AttributeNodes['count'].NodeValue;
end;

procedure TXMLScanSettingsListType.Set_Count(Value: LongWord);
begin
  SetAttribute('count', Value);
end;

function TXMLScanSettingsListType.Get_ScanSettings(Index: Integer): IXMLScanSettingsType;
begin
  Result := List[Index] as IXMLScanSettingsType;
end;

function TXMLScanSettingsListType.Add: IXMLScanSettingsType;
begin
  Result := AddItem(-1) as IXMLScanSettingsType;
end;

function TXMLScanSettingsListType.Insert(const Index: Integer): IXMLScanSettingsType;
begin
  Result := AddItem(Index) as IXMLScanSettingsType;
end;

{ TXMLScanSettingsType }

procedure TXMLScanSettingsType.AfterConstruction;
begin
  RegisterChildNode('sourceFileRefList', TXMLSourceFileRefListType);
  RegisterChildNode('targetList', TXMLTargetListType);
  inherited;
end;

function TXMLScanSettingsType.Get_Id: UnicodeString;
begin
  Result := AttributeNodes['id'].Text;
end;

procedure TXMLScanSettingsType.Set_Id(Value: UnicodeString);
begin
  SetAttribute('id', Value);
end;

function TXMLScanSettingsType.Get_SourceFileRefList: IXMLSourceFileRefListType;
begin
  Result := ChildNodes['sourceFileRefList'] as IXMLSourceFileRefListType;
end;

function TXMLScanSettingsType.Get_TargetList: IXMLTargetListType;
begin
  Result := ChildNodes['targetList'] as IXMLTargetListType;
end;

{ TXMLSourceFileRefListType }

procedure TXMLSourceFileRefListType.AfterConstruction;
begin
  RegisterChildNode('sourceFileRef', TXMLSourceFileRefType);
  ItemTag := 'sourceFileRef';
  ItemInterface := IXMLSourceFileRefType;
  inherited;
end;

function TXMLSourceFileRefListType.Get_Count: LongWord;
begin
  Result := AttributeNodes['count'].NodeValue;
end;

procedure TXMLSourceFileRefListType.Set_Count(Value: LongWord);
begin
  SetAttribute('count', Value);
end;

function TXMLSourceFileRefListType.Get_SourceFileRef(Index: Integer): IXMLSourceFileRefType;
begin
  Result := List[Index] as IXMLSourceFileRefType;
end;

function TXMLSourceFileRefListType.Add: IXMLSourceFileRefType;
begin
  Result := AddItem(-1) as IXMLSourceFileRefType;
end;

function TXMLSourceFileRefListType.Insert(const Index: Integer): IXMLSourceFileRefType;
begin
  Result := AddItem(Index) as IXMLSourceFileRefType;
end;

{ TXMLSourceFileRefType }

function TXMLSourceFileRefType.Get_Ref: UnicodeString;
begin
  Result := AttributeNodes['ref'].Text;
end;

procedure TXMLSourceFileRefType.Set_Ref(Value: UnicodeString);
begin
  SetAttribute('ref', Value);
end;

{ TXMLTargetListType }

procedure TXMLTargetListType.AfterConstruction;
begin
  RegisterChildNode('target', TXMLParamGroupType);
  ItemTag := 'target';
  ItemInterface := IXMLParamGroupType;
  inherited;
end;

function TXMLTargetListType.Get_Count: LongWord;
begin
  Result := AttributeNodes['count'].NodeValue;
end;

procedure TXMLTargetListType.Set_Count(Value: LongWord);
begin
  SetAttribute('count', Value);
end;

function TXMLTargetListType.Get_Target(Index: Integer): IXMLParamGroupType;
begin
  Result := List[Index] as IXMLParamGroupType;
end;

function TXMLTargetListType.Add: IXMLParamGroupType;
begin
  Result := AddItem(-1) as IXMLParamGroupType;
end;

function TXMLTargetListType.Insert(const Index: Integer): IXMLParamGroupType;
begin
  Result := AddItem(Index) as IXMLParamGroupType;
end;

{ TXMLInstrumentConfigurationListType }

procedure TXMLInstrumentConfigurationListType.AfterConstruction;
begin
  RegisterChildNode('instrumentConfiguration', TXMLInstrumentConfigurationType);
  ItemTag := 'instrumentConfiguration';
  ItemInterface := IXMLInstrumentConfigurationType;
  inherited;
end;

function TXMLInstrumentConfigurationListType.Get_Count: LongWord;
begin
  Result := AttributeNodes['count'].NodeValue;
end;

procedure TXMLInstrumentConfigurationListType.Set_Count(Value: LongWord);
begin
  SetAttribute('count', Value);
end;

function TXMLInstrumentConfigurationListType.Get_InstrumentConfiguration(Index: Integer): IXMLInstrumentConfigurationType;
begin
  Result := List[Index] as IXMLInstrumentConfigurationType;
end;

function TXMLInstrumentConfigurationListType.Add: IXMLInstrumentConfigurationType;
begin
  Result := AddItem(-1) as IXMLInstrumentConfigurationType;
end;

function TXMLInstrumentConfigurationListType.Insert(const Index: Integer): IXMLInstrumentConfigurationType;
begin
  Result := AddItem(Index) as IXMLInstrumentConfigurationType;
end;

{ TXMLInstrumentConfigurationType }

procedure TXMLInstrumentConfigurationType.AfterConstruction;
begin
  RegisterChildNode('componentList', TXMLComponentListType);
  RegisterChildNode('softwareRef', TXMLSoftwareRefType);
  inherited;
end;

function TXMLInstrumentConfigurationType.Get_Id: UnicodeString;
begin
  Result := AttributeNodes['id'].Text;
end;

procedure TXMLInstrumentConfigurationType.Set_Id(Value: UnicodeString);
begin
  SetAttribute('id', Value);
end;

function TXMLInstrumentConfigurationType.Get_ScanSettingsRef: UnicodeString;
begin
  Result := AttributeNodes['scanSettingsRef'].Text;
end;

procedure TXMLInstrumentConfigurationType.Set_ScanSettingsRef(Value: UnicodeString);
begin
  SetAttribute('scanSettingsRef', Value);
end;

function TXMLInstrumentConfigurationType.Get_ComponentList: IXMLComponentListType;
begin
  Result := ChildNodes['componentList'] as IXMLComponentListType;
end;

function TXMLInstrumentConfigurationType.Get_SoftwareRef: IXMLSoftwareRefType;
begin
  Result := ChildNodes['softwareRef'] as IXMLSoftwareRefType;
end;

{ TXMLComponentListType }

procedure TXMLComponentListType.AfterConstruction;
begin
  RegisterChildNode('source', TXMLSourceComponentType);
  RegisterChildNode('analyzer', TXMLAnalyzerComponentType);
  RegisterChildNode('detector', TXMLDetectorComponentType);
  FSource := CreateCollection(TXMLSourceComponentTypeList, IXMLSourceComponentType, 'source') as IXMLSourceComponentTypeList;
  FAnalyzer := CreateCollection(TXMLAnalyzerComponentTypeList, IXMLAnalyzerComponentType, 'analyzer') as IXMLAnalyzerComponentTypeList;
  FDetector := CreateCollection(TXMLDetectorComponentTypeList, IXMLDetectorComponentType, 'detector') as IXMLDetectorComponentTypeList;
  inherited;
end;

function TXMLComponentListType.Get_Count: LongWord;
begin
  Result := AttributeNodes['count'].NodeValue;
end;

procedure TXMLComponentListType.Set_Count(Value: LongWord);
begin
  SetAttribute('count', Value);
end;

function TXMLComponentListType.Get_Source: IXMLSourceComponentTypeList;
begin
  Result := FSource;
end;

function TXMLComponentListType.Get_Analyzer: IXMLAnalyzerComponentTypeList;
begin
  Result := FAnalyzer;
end;

function TXMLComponentListType.Get_Detector: IXMLDetectorComponentTypeList;
begin
  Result := FDetector;
end;

{ TXMLComponentType }

function TXMLComponentType.Get_Order: Integer;
begin
  Result := AttributeNodes['order'].NodeValue;
end;

procedure TXMLComponentType.Set_Order(Value: Integer);
begin
  SetAttribute('order', Value);
end;

{ TXMLSourceComponentType }

{ TXMLSourceComponentTypeList }

function TXMLSourceComponentTypeList.Add: IXMLSourceComponentType;
begin
  Result := AddItem(-1) as IXMLSourceComponentType;
end;

function TXMLSourceComponentTypeList.Insert(const Index: Integer): IXMLSourceComponentType;
begin
  Result := AddItem(Index) as IXMLSourceComponentType;
end;

function TXMLSourceComponentTypeList.Get_Item(Index: Integer): IXMLSourceComponentType;
begin
  Result := List[Index] as IXMLSourceComponentType;
end;

{ TXMLAnalyzerComponentType }

{ TXMLAnalyzerComponentTypeList }

function TXMLAnalyzerComponentTypeList.Add: IXMLAnalyzerComponentType;
begin
  Result := AddItem(-1) as IXMLAnalyzerComponentType;
end;

function TXMLAnalyzerComponentTypeList.Insert(const Index: Integer): IXMLAnalyzerComponentType;
begin
  Result := AddItem(Index) as IXMLAnalyzerComponentType;
end;

function TXMLAnalyzerComponentTypeList.Get_Item(Index: Integer): IXMLAnalyzerComponentType;
begin
  Result := List[Index] as IXMLAnalyzerComponentType;
end;

{ TXMLDetectorComponentType }

{ TXMLDetectorComponentTypeList }

function TXMLDetectorComponentTypeList.Add: IXMLDetectorComponentType;
begin
  Result := AddItem(-1) as IXMLDetectorComponentType;
end;

function TXMLDetectorComponentTypeList.Insert(const Index: Integer): IXMLDetectorComponentType;
begin
  Result := AddItem(Index) as IXMLDetectorComponentType;
end;

function TXMLDetectorComponentTypeList.Get_Item(Index: Integer): IXMLDetectorComponentType;
begin
  Result := List[Index] as IXMLDetectorComponentType;
end;

{ TXMLSoftwareRefType }

function TXMLSoftwareRefType.Get_Ref: UnicodeString;
begin
  Result := AttributeNodes['ref'].Text;
end;

procedure TXMLSoftwareRefType.Set_Ref(Value: UnicodeString);
begin
  SetAttribute('ref', Value);
end;

{ TXMLDataProcessingListType }

procedure TXMLDataProcessingListType.AfterConstruction;
begin
  RegisterChildNode('dataProcessing', TXMLDataProcessingType);
  ItemTag := 'dataProcessing';
  ItemInterface := IXMLDataProcessingType;
  inherited;
end;

function TXMLDataProcessingListType.Get_Count: LongWord;
begin
  Result := AttributeNodes['count'].NodeValue;
end;

procedure TXMLDataProcessingListType.Set_Count(Value: LongWord);
begin
  SetAttribute('count', Value);
end;

function TXMLDataProcessingListType.Get_DataProcessing(Index: Integer): IXMLDataProcessingType;
begin
  Result := List[Index] as IXMLDataProcessingType;
end;

function TXMLDataProcessingListType.Add: IXMLDataProcessingType;
begin
  Result := AddItem(-1) as IXMLDataProcessingType;
end;

function TXMLDataProcessingListType.Insert(const Index: Integer): IXMLDataProcessingType;
begin
  Result := AddItem(Index) as IXMLDataProcessingType;
end;

{ TXMLDataProcessingType }

procedure TXMLDataProcessingType.AfterConstruction;
begin
  RegisterChildNode('processingMethod', TXMLProcessingMethodType);
  ItemTag := 'processingMethod';
  ItemInterface := IXMLProcessingMethodType;
  inherited;
end;

function TXMLDataProcessingType.Get_Id: UnicodeString;
begin
  Result := AttributeNodes['id'].Text;
end;

procedure TXMLDataProcessingType.Set_Id(Value: UnicodeString);
begin
  SetAttribute('id', Value);
end;

function TXMLDataProcessingType.Get_ProcessingMethod(Index: Integer): IXMLProcessingMethodType;
begin
  Result := List[Index] as IXMLProcessingMethodType;
end;

function TXMLDataProcessingType.Add: IXMLProcessingMethodType;
begin
  Result := AddItem(-1) as IXMLProcessingMethodType;
end;

function TXMLDataProcessingType.Insert(const Index: Integer): IXMLProcessingMethodType;
begin
  Result := AddItem(Index) as IXMLProcessingMethodType;
end;

{ TXMLProcessingMethodType }

function TXMLProcessingMethodType.Get_Order: LongWord;
begin
  Result := AttributeNodes['order'].NodeValue;
end;

procedure TXMLProcessingMethodType.Set_Order(Value: LongWord);
begin
  SetAttribute('order', Value);
end;

function TXMLProcessingMethodType.Get_SoftwareRef: UnicodeString;
begin
  Result := AttributeNodes['softwareRef'].Text;
end;

procedure TXMLProcessingMethodType.Set_SoftwareRef(Value: UnicodeString);
begin
  SetAttribute('softwareRef', Value);
end;

{ TXMLRunType }

procedure TXMLRunType.AfterConstruction;
begin
  RegisterChildNode('spectrumList', TXMLSpectrumListType);
  RegisterChildNode('chromatogramList', TXMLChromatogramListType);
  inherited;
end;

function TXMLRunType.Get_Id: UnicodeString;
begin
  Result := AttributeNodes['id'].Text;
end;

procedure TXMLRunType.Set_Id(Value: UnicodeString);
begin
  SetAttribute('id', Value);
end;

function TXMLRunType.Get_DefaultInstrumentConfigurationRef: UnicodeString;
begin
  Result := AttributeNodes['defaultInstrumentConfigurationRef'].Text;
end;

procedure TXMLRunType.Set_DefaultInstrumentConfigurationRef(Value: UnicodeString);
begin
  SetAttribute('defaultInstrumentConfigurationRef', Value);
end;

function TXMLRunType.Get_DefaultSourceFileRef: UnicodeString;
begin
  Result := AttributeNodes['defaultSourceFileRef'].Text;
end;

procedure TXMLRunType.Set_DefaultSourceFileRef(Value: UnicodeString);
begin
  SetAttribute('defaultSourceFileRef', Value);
end;

function TXMLRunType.Get_SampleRef: UnicodeString;
begin
  Result := AttributeNodes['sampleRef'].Text;
end;

procedure TXMLRunType.Set_SampleRef(Value: UnicodeString);
begin
  SetAttribute('sampleRef', Value);
end;

function TXMLRunType.Get_StartTimeStamp: UnicodeString;
begin
  Result := AttributeNodes['startTimeStamp'].Text;
end;

procedure TXMLRunType.Set_StartTimeStamp(Value: UnicodeString);
begin
  SetAttribute('startTimeStamp', Value);
end;

function TXMLRunType.Get_SpectrumList: IXMLSpectrumListType;
begin
  Result := ChildNodes['spectrumList'] as IXMLSpectrumListType;
end;

function TXMLRunType.Get_ChromatogramList: IXMLChromatogramListType;
begin
  Result := ChildNodes['chromatogramList'] as IXMLChromatogramListType;
end;

{ TXMLSpectrumListType }

procedure TXMLSpectrumListType.AfterConstruction;
begin
  RegisterChildNode('spectrum', TXMLSpectrumType);
  ItemTag := 'spectrum';
  ItemInterface := IXMLSpectrumType;
  inherited;
end;

function TXMLSpectrumListType.Get_Count: LongWord;
begin
  Result := AttributeNodes['count'].NodeValue;
end;

procedure TXMLSpectrumListType.Set_Count(Value: LongWord);
begin
  SetAttribute('count', Value);
end;

function TXMLSpectrumListType.Get_DefaultDataProcessingRef: UnicodeString;
begin
  Result := AttributeNodes['defaultDataProcessingRef'].Text;
end;

procedure TXMLSpectrumListType.Set_DefaultDataProcessingRef(Value: UnicodeString);
begin
  SetAttribute('defaultDataProcessingRef', Value);
end;

function TXMLSpectrumListType.Get_Spectrum(Index: Integer): IXMLSpectrumType;
begin
  Result := List[Index] as IXMLSpectrumType;
end;

function TXMLSpectrumListType.Add: IXMLSpectrumType;
begin
  Result := AddItem(-1) as IXMLSpectrumType;
end;

function TXMLSpectrumListType.Insert(const Index: Integer): IXMLSpectrumType;
begin
  Result := AddItem(Index) as IXMLSpectrumType;
end;

{ TXMLSpectrumType }

procedure TXMLSpectrumType.AfterConstruction;
begin
  RegisterChildNode('scanList', TXMLScanListType);
  RegisterChildNode('precursorList', TXMLPrecursorListType);
  RegisterChildNode('productList', TXMLProductListType);
  RegisterChildNode('binaryDataArrayList', TXMLBinaryDataArrayListType);
  inherited;
end;

function TXMLSpectrumType.Get_Id: UnicodeString;
begin
  Result := AttributeNodes['id'].Text;
end;

procedure TXMLSpectrumType.Set_Id(Value: UnicodeString);
begin
  SetAttribute('id', Value);
end;

function TXMLSpectrumType.Get_SpotID: UnicodeString;
begin
  Result := AttributeNodes['spotID'].Text;
end;

procedure TXMLSpectrumType.Set_SpotID(Value: UnicodeString);
begin
  SetAttribute('spotID', Value);
end;

function TXMLSpectrumType.Get_Index: LongWord;
begin
  Result := AttributeNodes['index'].NodeValue;
end;

procedure TXMLSpectrumType.Set_Index(Value: LongWord);
begin
  SetAttribute('index', Value);
end;

function TXMLSpectrumType.Get_DefaultArrayLength: Integer;
begin
  Result := AttributeNodes['defaultArrayLength'].NodeValue;
end;

procedure TXMLSpectrumType.Set_DefaultArrayLength(Value: Integer);
begin
  SetAttribute('defaultArrayLength', Value);
end;

function TXMLSpectrumType.Get_DataProcessingRef: UnicodeString;
begin
  Result := AttributeNodes['dataProcessingRef'].Text;
end;

procedure TXMLSpectrumType.Set_DataProcessingRef(Value: UnicodeString);
begin
  SetAttribute('dataProcessingRef', Value);
end;

function TXMLSpectrumType.Get_SourceFileRef: UnicodeString;
begin
  Result := AttributeNodes['sourceFileRef'].Text;
end;

procedure TXMLSpectrumType.Set_SourceFileRef(Value: UnicodeString);
begin
  SetAttribute('sourceFileRef', Value);
end;

function TXMLSpectrumType.Get_ScanList: IXMLScanListType;
begin
  Result := ChildNodes['scanList'] as IXMLScanListType;
end;

function TXMLSpectrumType.Get_PrecursorList: IXMLPrecursorListType;
begin
  Result := ChildNodes['precursorList'] as IXMLPrecursorListType;
end;

function TXMLSpectrumType.Get_ProductList: IXMLProductListType;
begin
  Result := ChildNodes['productList'] as IXMLProductListType;
end;

function TXMLSpectrumType.Get_BinaryDataArrayList: IXMLBinaryDataArrayListType;
begin
  Result := ChildNodes['binaryDataArrayList'] as IXMLBinaryDataArrayListType;
end;

{ TXMLScanListType }

procedure TXMLScanListType.AfterConstruction;
begin
  RegisterChildNode('scan', TXMLScanType);
  FScan := CreateCollection(TXMLScanTypeList, IXMLScanType, 'scan') as IXMLScanTypeList;
  inherited;
end;

function TXMLScanListType.Get_Count: LongWord;
begin
  Result := AttributeNodes['count'].NodeValue;
end;

procedure TXMLScanListType.Set_Count(Value: LongWord);
begin
  SetAttribute('count', Value);
end;

function TXMLScanListType.Get_Scan: IXMLScanTypeList;
begin
  Result := FScan;
end;

{ TXMLScanType }

procedure TXMLScanType.AfterConstruction;
begin
  RegisterChildNode('scanWindowList', TXMLScanWindowListType);
  inherited;
end;

function TXMLScanType.Get_SpectrumRef: UnicodeString;
begin
  Result := AttributeNodes['spectrumRef'].Text;
end;

procedure TXMLScanType.Set_SpectrumRef(Value: UnicodeString);
begin
  SetAttribute('spectrumRef', Value);
end;

function TXMLScanType.Get_SourceFileRef: UnicodeString;
begin
  Result := AttributeNodes['sourceFileRef'].Text;
end;

procedure TXMLScanType.Set_SourceFileRef(Value: UnicodeString);
begin
  SetAttribute('sourceFileRef', Value);
end;

function TXMLScanType.Get_ExternalSpectrumID: UnicodeString;
begin
  Result := AttributeNodes['externalSpectrumID'].Text;
end;

procedure TXMLScanType.Set_ExternalSpectrumID(Value: UnicodeString);
begin
  SetAttribute('externalSpectrumID', Value);
end;

function TXMLScanType.Get_InstrumentConfigurationRef: UnicodeString;
begin
  Result := AttributeNodes['instrumentConfigurationRef'].Text;
end;

procedure TXMLScanType.Set_InstrumentConfigurationRef(Value: UnicodeString);
begin
  SetAttribute('instrumentConfigurationRef', Value);
end;

function TXMLScanType.Get_ScanWindowList: IXMLScanWindowListType;
begin
  Result := ChildNodes['scanWindowList'] as IXMLScanWindowListType;
end;

{ TXMLScanTypeList }

function TXMLScanTypeList.Add: IXMLScanType;
begin
  Result := AddItem(-1) as IXMLScanType;
end;

function TXMLScanTypeList.Insert(const Index: Integer): IXMLScanType;
begin
  Result := AddItem(Index) as IXMLScanType;
end;

function TXMLScanTypeList.Get_Item(Index: Integer): IXMLScanType;
begin
  Result := List[Index] as IXMLScanType;
end;

{ TXMLScanWindowListType }

procedure TXMLScanWindowListType.AfterConstruction;
begin
  RegisterChildNode('scanWindow', TXMLParamGroupType);
  ItemTag := 'scanWindow';
  ItemInterface := IXMLParamGroupType;
  inherited;
end;

function TXMLScanWindowListType.Get_Count: Integer;
begin
  Result := AttributeNodes['count'].NodeValue;
end;

procedure TXMLScanWindowListType.Set_Count(Value: Integer);
begin
  SetAttribute('count', Value);
end;

function TXMLScanWindowListType.Get_ScanWindow(Index: Integer): IXMLParamGroupType;
begin
  Result := List[Index] as IXMLParamGroupType;
end;

function TXMLScanWindowListType.Add: IXMLParamGroupType;
begin
  Result := AddItem(-1) as IXMLParamGroupType;
end;

function TXMLScanWindowListType.Insert(const Index: Integer): IXMLParamGroupType;
begin
  Result := AddItem(Index) as IXMLParamGroupType;
end;

{ TXMLPrecursorListType }

procedure TXMLPrecursorListType.AfterConstruction;
begin
  RegisterChildNode('precursor', TXMLPrecursorType);
  ItemTag := 'precursor';
  ItemInterface := IXMLPrecursorType;
  inherited;
end;

function TXMLPrecursorListType.Get_Count: LongWord;
begin
  Result := AttributeNodes['count'].NodeValue;
end;

procedure TXMLPrecursorListType.Set_Count(Value: LongWord);
begin
  SetAttribute('count', Value);
end;

function TXMLPrecursorListType.Get_Precursor(Index: Integer): IXMLPrecursorType;
begin
  Result := List[Index] as IXMLPrecursorType;
end;

function TXMLPrecursorListType.Add: IXMLPrecursorType;
begin
  Result := AddItem(-1) as IXMLPrecursorType;
end;

function TXMLPrecursorListType.Insert(const Index: Integer): IXMLPrecursorType;
begin
  Result := AddItem(Index) as IXMLPrecursorType;
end;

{ TXMLPrecursorType }

procedure TXMLPrecursorType.AfterConstruction;
begin
  RegisterChildNode('isolationWindow', TXMLParamGroupType);
  RegisterChildNode('selectedIonList', TXMLSelectedIonListType);
  RegisterChildNode('activation', TXMLParamGroupType);
  inherited;
end;

function TXMLPrecursorType.Get_SpectrumRef: UnicodeString;
begin
  Result := AttributeNodes['spectrumRef'].Text;
end;

procedure TXMLPrecursorType.Set_SpectrumRef(Value: UnicodeString);
begin
  SetAttribute('spectrumRef', Value);
end;

function TXMLPrecursorType.Get_SourceFileRef: UnicodeString;
begin
  Result := AttributeNodes['sourceFileRef'].Text;
end;

procedure TXMLPrecursorType.Set_SourceFileRef(Value: UnicodeString);
begin
  SetAttribute('sourceFileRef', Value);
end;

function TXMLPrecursorType.Get_ExternalSpectrumID: UnicodeString;
begin
  Result := AttributeNodes['externalSpectrumID'].Text;
end;

procedure TXMLPrecursorType.Set_ExternalSpectrumID(Value: UnicodeString);
begin
  SetAttribute('externalSpectrumID', Value);
end;

function TXMLPrecursorType.Get_IsolationWindow: IXMLParamGroupType;
begin
  Result := ChildNodes['isolationWindow'] as IXMLParamGroupType;
end;

function TXMLPrecursorType.Get_SelectedIonList: IXMLSelectedIonListType;
begin
  Result := ChildNodes['selectedIonList'] as IXMLSelectedIonListType;
end;

function TXMLPrecursorType.Get_Activation: IXMLParamGroupType;
begin
  Result := ChildNodes['activation'] as IXMLParamGroupType;
end;

{ TXMLSelectedIonListType }

procedure TXMLSelectedIonListType.AfterConstruction;
begin
  RegisterChildNode('selectedIon', TXMLParamGroupType);
  ItemTag := 'selectedIon';
  ItemInterface := IXMLParamGroupType;
  inherited;
end;

function TXMLSelectedIonListType.Get_Count: LongWord;
begin
  Result := AttributeNodes['count'].NodeValue;
end;

procedure TXMLSelectedIonListType.Set_Count(Value: LongWord);
begin
  SetAttribute('count', Value);
end;

function TXMLSelectedIonListType.Get_SelectedIon(Index: Integer): IXMLParamGroupType;
begin
  Result := List[Index] as IXMLParamGroupType;
end;

function TXMLSelectedIonListType.Add: IXMLParamGroupType;
begin
  Result := AddItem(-1) as IXMLParamGroupType;
end;

function TXMLSelectedIonListType.Insert(const Index: Integer): IXMLParamGroupType;
begin
  Result := AddItem(Index) as IXMLParamGroupType;
end;

{ TXMLProductListType }

procedure TXMLProductListType.AfterConstruction;
begin
  RegisterChildNode('product', TXMLProductType);
  ItemTag := 'product';
  ItemInterface := IXMLProductType;
  inherited;
end;

function TXMLProductListType.Get_Count: LongWord;
begin
  Result := AttributeNodes['count'].NodeValue;
end;

procedure TXMLProductListType.Set_Count(Value: LongWord);
begin
  SetAttribute('count', Value);
end;

function TXMLProductListType.Get_Product(Index: Integer): IXMLProductType;
begin
  Result := List[Index] as IXMLProductType;
end;

function TXMLProductListType.Add: IXMLProductType;
begin
  Result := AddItem(-1) as IXMLProductType;
end;

function TXMLProductListType.Insert(const Index: Integer): IXMLProductType;
begin
  Result := AddItem(Index) as IXMLProductType;
end;

{ TXMLProductType }

procedure TXMLProductType.AfterConstruction;
begin
  RegisterChildNode('isolationWindow', TXMLParamGroupType);
  inherited;
end;

function TXMLProductType.Get_IsolationWindow: IXMLParamGroupType;
begin
  Result := ChildNodes['isolationWindow'] as IXMLParamGroupType;
end;

{ TXMLBinaryDataArrayListType }

procedure TXMLBinaryDataArrayListType.AfterConstruction;
begin
  RegisterChildNode('binaryDataArray', TXMLBinaryDataArrayType);
  ItemTag := 'binaryDataArray';
  ItemInterface := IXMLBinaryDataArrayType;
  inherited;
end;

function TXMLBinaryDataArrayListType.Get_Count: LongWord;
begin
  Result := AttributeNodes['count'].NodeValue;
end;

procedure TXMLBinaryDataArrayListType.Set_Count(Value: LongWord);
begin
  SetAttribute('count', Value);
end;

function TXMLBinaryDataArrayListType.Get_BinaryDataArray(Index: Integer): IXMLBinaryDataArrayType;
begin
  Result := List[Index] as IXMLBinaryDataArrayType;
end;

function TXMLBinaryDataArrayListType.Add: IXMLBinaryDataArrayType;
begin
  Result := AddItem(-1) as IXMLBinaryDataArrayType;
end;

function TXMLBinaryDataArrayListType.Insert(const Index: Integer): IXMLBinaryDataArrayType;
begin
  Result := AddItem(Index) as IXMLBinaryDataArrayType;
end;

{ TXMLBinaryDataArrayType }

function TXMLBinaryDataArrayType.Get_ArrayLength: LongWord;
begin
  Result := AttributeNodes['arrayLength'].NodeValue;
end;

procedure TXMLBinaryDataArrayType.Set_ArrayLength(Value: LongWord);
begin
  SetAttribute('arrayLength', Value);
end;

function TXMLBinaryDataArrayType.Get_DataProcessingRef: UnicodeString;
begin
  Result := AttributeNodes['dataProcessingRef'].Text;
end;

procedure TXMLBinaryDataArrayType.Set_DataProcessingRef(Value: UnicodeString);
begin
  SetAttribute('dataProcessingRef', Value);
end;

function TXMLBinaryDataArrayType.Get_EncodedLength: LongWord;
begin
  Result := AttributeNodes['encodedLength'].NodeValue;
end;

procedure TXMLBinaryDataArrayType.Set_EncodedLength(Value: LongWord);
begin
  SetAttribute('encodedLength', Value);
end;

function TXMLBinaryDataArrayType.Get_Binary: UnicodeString;
begin
  Result := ChildNodes['binary'].Text;
end;

procedure TXMLBinaryDataArrayType.Set_Binary(Value: UnicodeString);
begin
  ChildNodes['binary'].NodeValue := Value;
end;

{ TXMLChromatogramListType }

procedure TXMLChromatogramListType.AfterConstruction;
begin
  RegisterChildNode('chromatogram', TXMLChromatogramType);
  ItemTag := 'chromatogram';
  ItemInterface := IXMLChromatogramType;
  inherited;
end;

function TXMLChromatogramListType.Get_Count: LongWord;
begin
  Result := AttributeNodes['count'].NodeValue;
end;

procedure TXMLChromatogramListType.Set_Count(Value: LongWord);
begin
  SetAttribute('count', Value);
end;

function TXMLChromatogramListType.Get_DefaultDataProcessingRef: UnicodeString;
begin
  Result := AttributeNodes['defaultDataProcessingRef'].Text;
end;

procedure TXMLChromatogramListType.Set_DefaultDataProcessingRef(Value: UnicodeString);
begin
  SetAttribute('defaultDataProcessingRef', Value);
end;

function TXMLChromatogramListType.Get_Chromatogram(Index: Integer): IXMLChromatogramType;
begin
  Result := List[Index] as IXMLChromatogramType;
end;

function TXMLChromatogramListType.Add: IXMLChromatogramType;
begin
  Result := AddItem(-1) as IXMLChromatogramType;
end;

function TXMLChromatogramListType.Insert(const Index: Integer): IXMLChromatogramType;
begin
  Result := AddItem(Index) as IXMLChromatogramType;
end;

{ TXMLChromatogramType }

procedure TXMLChromatogramType.AfterConstruction;
begin
  RegisterChildNode('precursor', TXMLPrecursorType);
  RegisterChildNode('product', TXMLProductType);
  RegisterChildNode('binaryDataArrayList', TXMLBinaryDataArrayListType);
  inherited;
end;

function TXMLChromatogramType.Get_Id: UnicodeString;
begin
  Result := AttributeNodes['id'].Text;
end;

procedure TXMLChromatogramType.Set_Id(Value: UnicodeString);
begin
  SetAttribute('id', Value);
end;

function TXMLChromatogramType.Get_Index: LongWord;
begin
  Result := AttributeNodes['index'].NodeValue;
end;

procedure TXMLChromatogramType.Set_Index(Value: LongWord);
begin
  SetAttribute('index', Value);
end;

function TXMLChromatogramType.Get_DefaultArrayLength: Integer;
begin
  Result := AttributeNodes['defaultArrayLength'].NodeValue;
end;

procedure TXMLChromatogramType.Set_DefaultArrayLength(Value: Integer);
begin
  SetAttribute('defaultArrayLength', Value);
end;

function TXMLChromatogramType.Get_DataProcessingRef: UnicodeString;
begin
  Result := AttributeNodes['dataProcessingRef'].Text;
end;

procedure TXMLChromatogramType.Set_DataProcessingRef(Value: UnicodeString);
begin
  SetAttribute('dataProcessingRef', Value);
end;

function TXMLChromatogramType.Get_Precursor: IXMLPrecursorType;
begin
  Result := ChildNodes['precursor'] as IXMLPrecursorType;
end;

function TXMLChromatogramType.Get_Product: IXMLProductType;
begin
  Result := ChildNodes['product'] as IXMLProductType;
end;

function TXMLChromatogramType.Get_BinaryDataArrayList: IXMLBinaryDataArrayListType;
begin
  Result := ChildNodes['binaryDataArrayList'] as IXMLBinaryDataArrayListType;
end;

end.