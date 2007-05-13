object SenhaForm: TSenhaForm
  Left = 355
  Top = 241
  ActiveControl = edtSenha
  BorderStyle = bsDialog
  Caption = 'Digitar Senha...'
  ClientHeight = 145
  ClientWidth = 244
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LabelSenha: TLabel
    Left = 16
    Top = 7
    Width = 30
    Height = 13
    Caption = 'Senha'
  end
  object LabelConfirma: TLabel
    Left = 16
    Top = 51
    Width = 30
    Height = 13
    Caption = 'Senha'
  end
  object edtSenha: TEdit
    Left = 16
    Top = 23
    Width = 217
    Height = 21
    Ctl3D = True
    ParentCtl3D = False
    PasswordChar = '*'
    TabOrder = 0
  end
  object edtConfirmaSenha: TEdit
    Left = 16
    Top = 67
    Width = 217
    Height = 21
    Ctl3D = True
    ParentCtl3D = False
    PasswordChar = '*'
    TabOrder = 1
  end
  object btnOK: TBitBtn
    Left = 44
    Top = 108
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkOK
  end
  object BtCancel: TBitBtn
    Left = 124
    Top = 108
    Width = 75
    Height = 25
    TabOrder = 3
    Kind = bkCancel
  end
end
