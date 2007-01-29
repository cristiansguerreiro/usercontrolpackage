object SenhaForm: TSenhaForm
  Left = 0
  Top = 0
  ActiveControl = edtSenha
  BorderStyle = bsDialog
  Caption = 'Digitar Senha...'
  ClientHeight = 115
  ClientWidth = 213
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object edtSenha: TEdit
    Left = 7
    Top = 15
    Width = 200
    Height = 19
    Ctl3D = False
    ParentCtl3D = False
    PasswordChar = '*'
    TabOrder = 0
    Text = 'edtSenha'
  end
  object edtConfirmaSenha: TEdit
    Left = 7
    Top = 43
    Width = 200
    Height = 19
    Ctl3D = False
    ParentCtl3D = False
    PasswordChar = '*'
    TabOrder = 1
    Text = 'edtConfirmaSenha'
  end
  object btnOK: TBitBtn
    Left = 44
    Top = 76
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkOK
  end
  object BitBtn1: TBitBtn
    Left = 132
    Top = 76
    Width = 75
    Height = 25
    TabOrder = 3
    Kind = bkCancel
  end
end
