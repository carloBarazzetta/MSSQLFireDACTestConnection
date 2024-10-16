object MainForm: TMainForm
  Left = 0
  Top = 0
  ClientHeight = 415
  ClientWidth = 854
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    854
    415)
  PixelsPerInch = 96
  TextHeight = 13
  object ParamsLabel: TLabel
    Left = 8
    Top = 51
    Width = 99
    Height = 13
    Caption = 'Connection Params'
  end
  object ReportLabel: TLabel
    Left = 262
    Top = 51
    Width = 98
    Height = 13
    Caption = 'Connection Report'
  end
  object Label1: TLabel
    Left = 8
    Top = 271
    Width = 117
    Height = 13
    Caption = 'Available ODBC Drivers'
  end
  object ConnectionStringEdit: TLabeledEdit
    Left = 8
    Top = 24
    Width = 838
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 91
    EditLabel.Height = 13
    EditLabel.Caption = 'ConnectionString'
    TabOrder = 0
    OnChange = ConnectionStringEditChange
  end
  object ConnectButton: TButton
    Left = 135
    Top = 362
    Width = 121
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Connect...'
    TabOrder = 7
    OnClick = ConnectButtonClick
  end
  object ReportMemo: TMemo
    Left = 262
    Top = 67
    Width = 584
    Height = 320
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object LoginPromptCheckBox: TCheckBox
    Left = 8
    Top = 364
    Width = 97
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = 'Login Prompt'
    TabOrder = 6
    OnClick = LoginPromptCheckBoxClick
  end
  object UserNameEdit: TLabeledEdit
    Left = 8
    Top = 335
    Width = 121
    Height = 21
    Anchors = [akLeft, akBottom]
    EditLabel.Width = 55
    EditLabel.Height = 13
    EditLabel.Caption = 'User Name'
    TabOrder = 4
    OnChange = UserNameEditChange
  end
  object PasswordEdit: TLabeledEdit
    Left = 135
    Top = 335
    Width = 121
    Height = 21
    Anchors = [akLeft, akBottom]
    EditLabel.Width = 49
    EditLabel.Height = 13
    EditLabel.Caption = 'Password'
    TabOrder = 5
    OnChange = PasswordEditChange
  end
  object ParamsMemo: TMemo
    Left = 8
    Top = 67
    Width = 248
    Height = 198
    Anchors = [akLeft, akTop, akBottom]
    Lines.Strings = (
      'ParamsMemo')
    TabOrder = 1
    OnChange = ParamsMemoChange
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 396
    Width = 854
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object DriverComboBox: TComboBox
    Left = 8
    Top = 288
    Width = 248
    Height = 21
    Anchors = [akLeft, akBottom]
    DropDownCount = 10
    TabOrder = 3
    Items.Strings = (
      '')
  end
  object FDConnection: TFDConnection
    LoginPrompt = False
    Left = 312
    Top = 208
  end
  object FDPhysMSSQLDriverLink: TFDPhysMSSQLDriverLink
    Left = 424
    Top = 216
  end
end
