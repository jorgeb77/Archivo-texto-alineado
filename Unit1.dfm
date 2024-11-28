object Form1: TForm1
  Left = 0
  Top = 0
  ActiveControl = EdCant
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Creaci'#243'n de archivo de texto'
  ClientHeight = 812
  ClientWidth = 1331
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -21
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  StyleName = 'Windows'
  OnCreate = FormCreate
  PixelsPerInch = 168
  TextHeight = 30
  object Gauge1: TGauge
    Left = 10
    Top = 762
    Width = 1321
    Height = 43
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Progress = 0
  end
  object Button1: TButton
    Left = 976
    Top = 16
    Width = 131
    Height = 44
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Estilo 1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 10
    Top = 70
    Width = 1321
    Height = 684
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -26
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object EdCant: TLabeledEdit
    Left = 294
    Top = 10
    Width = 121
    Height = 38
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    EditLabel.Width = 263
    EditLabel.Height = 38
    EditLabel.Margins.Left = 5
    EditLabel.Margins.Top = 5
    EditLabel.Margins.Right = 5
    EditLabel.Margins.Bottom = 5
    EditLabel.Caption = 'Cantidad de Registros :'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -26
    EditLabel.Font.Name = 'Segoe UI'
    EditLabel.Font.Style = []
    EditLabel.ParentFont = False
    LabelPosition = lpLeft
    NumbersOnly = True
    TabOrder = 2
    Text = '10'
  end
  object Button2: TButton
    Left = 1148
    Top = 16
    Width = 131
    Height = 44
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Estilo 2'
    TabOrder = 3
    OnClick = Button2Click
  end
end
