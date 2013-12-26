unit FProtecao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, VDOHddSerial, StdCtrls, FileCtrl, ExtCtrls, BmsXPButton,
  TFlatPanelUnit, ComCtrls, BmsXPPageControl, pngimage, Cripto;

type
  TProteger = class(TForm)
    MainMenu1: TMainMenu;
    Sobre1: TMenuItem;
    Sobre2: TMenuItem;
    VDOHddSerial1: TVDOHddSerial;
    Memo1: TMemo;
    Memo2: TMemo;
    Edit1: TEdit;
    Timer1: TTimer;
    PagerContolHD: TBmsXPPageControl;
    TabSheet1: TTabSheet;
    FlatPanel1: TFlatPanel;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    BmsXPButton1: TBmsXPButton;
    Image1: TImage;
    Label3: TLabel;
    Edit2: TEdit;
    Cripto1: TCripto;
    procedure FormCreate(Sender: TObject);
    procedure Cript;
    procedure Timer1Timer(Sender: TObject);
    procedure Sobre2Click(Sender: TObject);
    procedure BmsXPButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Proteger: TProteger;
  Erro: Boolean=False;
  iDrive: Integer=0;

implementation

uses Math, FSobre;

{$R *.dfm}
function GetIdeDiskSerialNumber( ControllerNumber, DriveNumber : Integer ) : String;
type
  TSrbIoControl = packed record
    HeaderLength : ULONG;
    Signature    : Array[0..7] of Char;
    Timeout      : ULONG;
    ControlCode  : ULONG;
    ReturnCode   : ULONG;
    Length       : ULONG;
  end;
  SRB_IO_CONTROL = TSrbIoControl;
  PSrbIoControl = ^TSrbIoControl;

  TIDERegs = packed record
    bFeaturesReg     : Byte; // Used for specifying SMART "commands".
    bSectorCountReg  : Byte; // IDE sector count register
    bSectorNumberReg : Byte; // IDE sector number register
    bCylLowReg       : Byte; // IDE low order cylinder value
    bCylHighReg      : Byte; // IDE high order cylinder value
    bDriveHeadReg    : Byte; // IDE drive/head register
    bCommandReg      : Byte; // Actual IDE command.
    bReserved        : Byte; // reserved for future use.  Must be zero.
  end;
  IDEREGS   = TIDERegs;
  PIDERegs  = ^TIDERegs;

  TSendCmdInParams = packed record
    cBufferSize  : DWORD;                // Buffer size in bytes
    irDriveRegs  : TIDERegs;             // Structure with drive register values.
    bDriveNumber : Byte;                 // Physical drive number to send command to (0,1,2,3).
    bReserved    : Array[0..2] of Byte;  // Reserved for future expansion.
    dwReserved   : Array[0..3] of DWORD; // For future use.
    bBuffer      : Array[0..0] of Byte;  // Input buffer.
  end;
  SENDCMDINPARAMS   = TSendCmdInParams;
  PSendCmdInParams  = ^TSendCmdInParams;

  TIdSector = packed record
    wGenConfig                 : Word;
    wNumCyls                   : Word;
    wReserved                  : Word;
    wNumHeads                  : Word;
    wBytesPerTrack             : Word;
    wBytesPerSector            : Word;
    wSectorsPerTrack           : Word;
    wVendorUnique              : Array[0..2] of Word;
    sSerialNumber              : Array[0..19] of Char;
    wBufferType                : Word;
    wBufferSize                : Word;
    wECCSize                   : Word;
    sFirmwareRev               : Array[0..7] of Char;
    sModelNumber               : Array[0..39] of Char;
    wMoreVendorUnique          : Word;
    wDoubleWordIO              : Word;
    wCapabilities              : Word;
    wReserved1                 : Word;
    wPIOTiming                 : Word;
    wDMATiming                 : Word;
    wBS                        : Word;
    wNumCurrentCyls            : Word;
    wNumCurrentHeads           : Word;
    wNumCurrentSectorsPerTrack : Word;
    ulCurrentSectorCapacity    : ULONG;
    wMultSectorStuff           : Word;
    ulTotalAddressableSectors  : ULONG;
    wSingleWordDMA             : Word;
    wMultiWordDMA              : Word;
    bReserved                  : Array[0..127] of Byte;
  end;
  PIdSector = ^TIdSector;

const
  IDE_ID_FUNCTION = $EC;
  IDENTIFY_BUFFER_SIZE       = 512;
  DFP_RECEIVE_DRIVE_DATA        = $0007c088;
  IOCTL_SCSI_MINIPORT           = $0004d008;
  IOCTL_SCSI_MINIPORT_IDENTIFY  = $001b0501;
  DataSize = sizeof(TSendCmdInParams)-1+IDENTIFY_BUFFER_SIZE;
  BufferSize = SizeOf(SRB_IO_CONTROL)+DataSize;
  W9xBufferSize = IDENTIFY_BUFFER_SIZE+16;
var
  hDevice : THandle;
  cbBytesReturned : DWORD;
  s : String;
  pInData : PSendCmdInParams;
  pOutData : Pointer; // PSendCmdInParams;
  Buffer : Array[0..BufferSize-1] of Byte;
  srbControl : TSrbIoControl absolute Buffer;

  procedure ChangeByteOrder( var Data; Size : Integer );
  var ptr : PChar;
      i : Integer;
      c : Char;
  begin
    ptr := @Data;
    for i := 0 to (Size shr 1)-1 do
    begin
      c := ptr^;
      ptr^ := (ptr+1)^;
      (ptr+1)^ := c;
      Inc(ptr,2);
    end;
  end;

begin
  Result := '';
  FillChar(Buffer,BufferSize,#0);
  if Win32Platform=VER_PLATFORM_WIN32_NT then
    begin // Windows NT, Windows 2000
      Str(ControllerNumber,s);
      // Get SCSI port handle
      hDevice := CreateFile(
        PChar('\\.\Scsi'+s+':'),
        GENERIC_READ or GENERIC_WRITE,
        FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0 );
      if hDevice=INVALID_HANDLE_VALUE then RaiseLastOSError;
      try
        srbControl.HeaderLength := SizeOf(SRB_IO_CONTROL);
        System.Move('SCSIDISK',srbControl.Signature,8);
        srbControl.Timeout      := 2;
        srbControl.Length       := DataSize;
        srbControl.ControlCode  := IOCTL_SCSI_MINIPORT_IDENTIFY;
        pInData := PSendCmdInParams(PChar(@Buffer)+SizeOf(SRB_IO_CONTROL));
        pOutData := pInData;
        with pInData^ do
        begin
          cBufferSize  := IDENTIFY_BUFFER_SIZE;
          bDriveNumber := DriveNumber;
          with irDriveRegs do
          begin
            bFeaturesReg     := 0;
            bSectorCountReg  := 1;
            bSectorNumberReg := 1;
            bCylLowReg       := 0;
            bCylHighReg      := 0;
            bDriveHeadReg    := $A0 or ((DriveNumber and 1) shl 4);
            bCommandReg      := IDE_ID_FUNCTION;
          end;
        end;
        if not DeviceIoControl( hDevice, IOCTL_SCSI_MINIPORT, @Buffer, BufferSize, @Buffer, BufferSize, cbBytesReturned, nil ) then RaiseLastOSError;
      finally
        CloseHandle(hDevice);
      end;
    end
  else
    begin // Windows 95 OSR2, Windows 98
      hDevice := CreateFile( '\\.\SMARTVSD', 0, 0, nil, CREATE_NEW, 0, 0 );
      if hDevice=INVALID_HANDLE_VALUE then RaiseLastOSError;
      try
        pInData := PSendCmdInParams(@Buffer);
        pOutData := PChar(@pInData^.bBuffer);
        with pInData^ do
        begin
          cBufferSize  := IDENTIFY_BUFFER_SIZE;
          bDriveNumber := DriveNumber;
          with irDriveRegs do
          begin
            bFeaturesReg     := 0;
            bSectorCountReg  := 1;
            bSectorNumberReg := 1;
            bCylLowReg       := 0;
            bCylHighReg      := 0;
            bDriveHeadReg    := $A0 or ((DriveNumber and 1) shl 4);
            bCommandReg      := IDE_ID_FUNCTION;
          end;
        end;
        if not DeviceIoControl( hDevice, DFP_RECEIVE_DRIVE_DATA, pInData, SizeOf(TSendCmdInParams)-1, pOutData, W9xBufferSize, cbBytesReturned, nil ) then RaiseLastOSError;
      finally
        CloseHandle(hDevice);
      end;
    end;

  with PIdSector(PChar(pOutData)+16)^ do
  begin
    ChangeByteOrder(sSerialNumber,SizeOf(sSerialNumber));
    SetString(Result,sSerialNumber,SizeOf(sSerialNumber));
  end;

  Result := Trim(Result);

end;






function GetIdeSN : String;
var
  iController, maxController : Integer;
begin
  Result := '';
  maxController := 15;
  if Win32Platform<>VER_PLATFORM_WIN32_NT then maxController := 0;
  for iController := 0 to maxController do
  begin
      try
        Result := GetIdeDiskSerialNumber(iController,iDrive);
        if Result<>'' then Exit;
      except
        // ignore exceptions
      end;

  end;
end;

  procedure TProteger.Cript;
    var
      pos : integer;
      shift : integer;
      Serial : String;
    begin
      begin
        Serial := Edit2.Text;
        for pos := 1 to length(Serial) do
        Serial[pos] := chr(ord(Serial[pos]) + 861);
      end;
      Memo2.Text:= Serial;
    end;

procedure TProteger.FormCreate(Sender: TObject);
begin
 { if 'S165J50S410525' <> VDOHddSerial1.SerialNumber then
    Begin
    ShowMessage('Erro I');
    Application.Terminate;
    end
    else
    begin
     Erro := True;
    end; }
end;

procedure TProteger.Timer1Timer(Sender: TObject);
begin
 if Erro = False Then
 begin
  // ShowMessage('Erro I');
 //  Application.Terminate;
  end;
end;

procedure TProteger.Sobre2Click(Sender: TObject);
begin
 Contato.ShowModal;
end;

procedure TProteger.BmsXPButton1Click(Sender: TObject);
begin
 if fileExists(ComboBox1.Text+'\WINDOWS\system32\bili.dll') = True then
 begin
  Memo1.Lines.Add(Edit2.Text);
  try
     Cript;
     memo2.Lines.SaveToFile(ComboBox1.Text+'\WINDOWS\system32\bili.dll');
     ShowMessage('Ativado Com Sucesso!');
  except
     ShowMessage('Erro ao ativar contate o desenvolvedor');
  end;
 end;
end;



procedure TProteger.FormShow(Sender: TObject);
begin
 { if 'S165J50S410525' <> VDOHddSerial1.SerialNumber then
    Begin
     ShowMessage('Erro I');
     Application.Terminate;
    end
    else
    begin
     Erro := True;
    end; }
end;

end.
