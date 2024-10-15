unit Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Vcl.StdCtrls, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,
  FireDAC.Phys.MSAccDef, FireDAC.Phys.MSAcc;

type
  TMainForm = class(TForm)
    FDConnection: TFDConnection;

    ConnectionStringEdit: TLabeledEdit;
    ConnectButton: TButton;
    ReportMemo: TMemo;
    LoginPromptCheckBox: TCheckBox;
    UserNameEdit: TLabeledEdit;
    PasswordEdit: TLabeledEdit;
    ParamsMemo: TMemo;
    ParamsLabel: TLabel;
    ReportLabel: TLabel;
    StatusBar: TStatusBar;
    DriverComboBox: TComboBox;
    FDPhysMSSQLDriverLink: TFDPhysMSSQLDriverLink;
    Label1: TLabel;
    procedure ConnectButtonClick(Sender: TObject);
    procedure LoginPromptCheckBoxClick(Sender: TObject);
    procedure ConnectionStringEditChange(Sender: TObject);
    procedure UserNameEditChange(Sender: TObject);
    procedure PasswordEditChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ParamsMemoChange(Sender: TObject);
  private
    procedure UpdateParamsList;
    procedure InitValuesFromIniFile;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  System.IniFiles
  ;

{$R *.dfm}

procedure TMainForm.ConnectButtonClick(Sender: TObject);
var
  LCustomDriver: string;
begin
  FDConnection.Connected := False;
  StatusBar.SimpleText := 'Not Connected';
  if not FDConnection.LoginPrompt then
  begin
    FDConnection.Params.Values['User_Name'] := 'sa';
    FDConnection.Params.Values['Password'] := '12345';
  end;

  LCustomDriver := DriverComboBox.Text;

  if LCustomDriver <> '' then
    FDPhysMSSQLDriverLink.ODBCDriver := LCustomDriver;
  try
    if Assigned(FDConnection.ConnectionIntf) then
      FDConnection.ConnectionIntf.ForceDisconnect;
    FDConnection.Connected := True;
    if FDConnection.Connected then
      StatusBar.SimpleText := 'Connected'
    else
      StatusBar.SimpleText := 'Connection Error';
    FDConnection.GetInfoReport(ReportMemo.Lines);
  except
    StatusBar.SimpleText := 'Connection Error';
    FDConnection.GetInfoReport(ReportMemo.Lines);
    raise;
  end;
end;

procedure TMainForm.ConnectionStringEditChange(Sender: TObject);
begin
  if ConnectionStringEdit.Text <> '' then
  begin
    FDConnection.ConnectionString := ConnectionStringEdit.Text;
    UpdateParamsList;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Caption := Application.Title;
  FDPhysMSSQLDriverLink.GetDrivers(DriverComboBox.Items);
  InitValuesFromIniFile;
end;

procedure TMainForm.InitValuesFromIniFile;
var
  LIniFile: TIniFile;
  LDriver: string;
begin
  LIniFile := TIniFile.create(ExtractFilePath(Application.ExeName)+
    'MSSQL_FireDAC_TestConnection.ini');
  try
    ConnectionStringEdit.Text := LIniFile.ReadString('Connection', 'ConnectionString', '');
    UpdateParamsList;
    LIniFile.ReadSectionValues('ConnectionParams', ParamsMemo.Lines);
    UserNameEdit.Text := LIniFile.ReadString('LoginParams', 'User_Name', '');
    PasswordEdit.Text := LIniFile.ReadString('LoginParams', 'Password', '');
    LoginPromptCheckBox.Checked := LIniFile.ReadBool('LoginParams', 'LoginPrompt', False);
    LDriver := LIniFile.ReadString('DriverLink', 'ODBCDriver', '');
    if LDriver <> '' then
      DriverComboBox.ItemIndex := DriverComboBox.Items.IndexOf(LDriver);
  finally
    LIniFile.Free;
  end;
end;

procedure TMainForm.LoginPromptCheckBoxClick(Sender: TObject);
begin
  FDConnection.LoginPrompt := LoginPromptCheckBox.Checked;
  UpdateParamsList;
end;

procedure TMainForm.ParamsMemoChange(Sender: TObject);
begin
  if Trim(ParamsMemo.Text) <> '' then
  begin
    FDConnection.Params.Text := Trim(ParamsMemo.Text);
    UpdateParamsList;
  end;
end;

procedure TMainForm.PasswordEditChange(Sender: TObject);
begin
  FDConnection.Params.Values['Password'] := PasswordEdit.Text;
  UpdateParamsList;
end;

procedure TMainForm.UpdateParamsList;
begin
  ParamsMemo.Lines.Text := FDConnection.Params.Text;
  PasswordEdit.Text := FDConnection.Params.Values['Password'];
  UserNameEdit.Text := FDConnection.Params.Values['User_Name'];
  ConnectionStringEdit.Text := FDConnection.ConnectionString;
end;

procedure TMainForm.UserNameEditChange(Sender: TObject);
begin
  FDConnection.Params.Values['User_Name'] := UserNameEdit.Text;
  UpdateParamsList;
end;

end.
