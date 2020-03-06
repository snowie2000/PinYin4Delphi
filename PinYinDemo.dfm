object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 300
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 168
    Top = 136
    Width = 16
    Height = 13
    Caption = 'lbl1'
  end
  object edt1: TEdit
    Left = 152
    Top = 64
    Width = 265
    Height = 21
    TabOrder = 1
    Text = 'edt1'
  end
  object btn1: TButton
    Left = 432
    Top = 62
    Width = 75
    Height = 25
    Caption = 'btn1'
    Default = True
    TabOrder = 0
    OnClick = btn1Click
  end
end
