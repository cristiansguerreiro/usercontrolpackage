object EnvMsgForm: TEnvMsgForm
  Left = 304
  Top = 204
  BorderStyle = bsDialog
  Caption = 'Mensagem'
  ClientHeight = 364
  ClientWidth = 377
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 377
    Height = 35
    Align = alTop
    BevelOuter = bvLowered
    Color = clWhite
    TabOrder = 0
    object lbTitulo: TLabel
      Left = 48
      Top = 10
      Width = 205
      Height = 18
      Caption = 'Enviar Nova Mensagem'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Image1: TImage
      Left = 8
      Top = 4
      Width = 28
      Height = 28
      AutoSize = True
      Picture.Data = {
        07544269746D6170760C0000424D760C00000000000036000000280000001C00
        00001C0000000100200000000000400C00000000000000000000000000000000
        0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C7B2A300694731006947
        3100694731006947310069473100694731006947310069473100694731006947
        3100694731006947310069473100694731006947310069473100694731006947
        310069473100694731006947310069473100694731006947310069473100FFFF
        FF00FFFFFF00C7B2A300DBC9BF00B7A29300B7A29300B7A29300B7A29300B7A2
        9300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A2
        9300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A2
        9300B7A29300B7A2930069473100FFFFFF00FFFFFF00C7B2A300B7A29300DFD0
        C700DFD0C700DFD0C700DFD0C700DFD0C700DFD0C700DFD0C700DFD0C700DFD0
        C700DFD0C700DFD0C700DFD0C700DFD0C700DFD0C700DFD0C700DFD0C700DFD0
        C700DFD0C700DFD0C700DFD0C700DFD0C700DFD0C700CE99970069473100FFFF
        FF00FFFFFF00C7B2A300DBC9BF00B7A29300E4D7CF00E4D7CF00E4D7CF00E4D7
        CF00E4D7CF00E4D7CF00E4D7CF00E4D7CF00E4D7CF00E4D7CF00E4D7CF00E4D7
        CF00E4D7CF00E4D7CF00E4D7CF00E4D7CF00E4D7CF00E4D7CF00E4D7CF00E4D7
        CF00B7A29300B7A2930069473100FFFFFF00FFFFFF00C7B2A300DECEC500DECE
        C500B7A29300E9DED700E9DED700E9DED700E9DED700E9DED700E9DED700E9DE
        D700E9DED700E9DED700E9DED700E9DED700E9DED700E9DED700E9DED700E9DE
        D700E9DED700E9DED700E9DED700B7A29300DECEC500B7A2930069473100FFFF
        FF00FFFFFF00C7B2A300E2D4CC00E2D4CC00E2D4CC00B7A29300EDE4DF00EDE4
        DF00EDE4DF00EDE4DF00EDE4DF00EDE4DF00EDE4DF00EDE4DF00EDE4DF00EDE4
        DF00EDE4DF00EDE4DF00EDE4DF00EDE4DF00EDE4DF00EDE4DF00B7A29300E2D4
        CC00E2D4CC00B7A2930069473100FFFFFF00FFFFFF00C7B2A300E6D9D200E6D9
        D200E6D9D200E6D9D200B7A29300F0E9E500F0E9E500F0E9E500F0E9E500F0E9
        E500F0E9E500F0E9E500F0E9E500F0E9E500F0E9E500F0E9E500F0E9E500F0E9
        E500F0E9E500B7A29300E6D9D200E6D9D200E6D9D200B7A2930069473100FFFF
        FF00FFFFFF00C7B2A300EADFD900EADFD900EADFD900EADFD900EADFD900B7A2
        9300F4EFEC00F4EFEC00F4EFEC00F4EFEC00F4EFEC00F4EFEC00F4EFEC00F4EF
        EC00F4EFEC00F4EFEC00F4EFEC00F4EFEC00B7A29300EADFD900EADFD900EADF
        D900EADFD900B7A2930069473100FFFFFF00FFFFFF00C7B2A300EDE4DF00EDE4
        DF00EDE4DF00EDE4DF00EDE4DF00EDE4DF00B7A29300F8F4F200F8F4F200F8F4
        F200F8F4F200F8F4F200F8F4F200F8F4F200F8F4F200F8F4F200F8F4F200B7A2
        9300EDE4DF00EDE4DF00EDE4DF00EDE4DF00EDE4DF00B7A2930069473100FFFF
        FF00FFFFFF00C7B2A300F0E8E400F0E8E400F0E8E400F0E8E400F0E8E400F0E8
        E400B7A29300B7A29300FCFAF900FCFAF900FCFAF900FCFAF900FCFAF900FCFA
        F900FCFAF900FCFAF900B7A29300B7A29300F0E8E400F0E8E400F0E8E400F0E8
        E400F0E8E400B7A2930069473100FFFFFF00FFFFFF00C7B2A300F3EDE900F3ED
        E900F3EDE900F3EDE900F3EDE900B7A29300DDC5C200DDC5C200B7A29300DDC5
        C200FFFFFF00FFFFFF00FFFFFF00FFFFFF00DDC5C200B7A29300DDC5C200DDC5
        C200B7A29300F3EDE900F3EDE900F3EDE900F3EDE900B7A2930069473100FFFF
        FF00FFFFFF00C7B2A300F6F1EF00F6F1EF00F6F1EF00F6F1EF00B7A29300DDC5
        C200FBF9F700F7F4F100DDC5C200C7B2A300B7A29300B7A29300B7A29300B7A2
        9300C7B2A300DDC5C200DCCBC100DBC9BF00DDC5C200B7A29300F6F1EF00F6F1
        EF00F6F1EF00B7A2930069473100FFFFFF00FFFFFF00C7B2A300F9F6F400F9F6
        F400F9F6F400B7A29300DDC5C200FFFFFF00FEFDFC00FBF9F700F7F4F100EEE0
        E000EEE0E000EEE0E000EEE0E000EEE0E000EEE0E000E4D7CF00E1D2C900DECD
        C400DBC9BF00DDC5C200B7A29300F9F6F400F9F6F400B7A2930069473100FFFF
        FF00FFFFFF00C7B2A300FCFBFA00FCFBFA00B7A29300C8B3A400FFFFFF00FFFF
        FF00B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A2
        9300B7A29300B7A29300B7A29300B7A29300DECDC400DBC9BF00D2C0B300B7A2
        9300FCFBFA00B7A2930069473100FFFFFF00FFFFFF00C7B2A300FFFFFF00B8A3
        9400DDC5C200C8B3A400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FCFB
        F900F9F6F400F6F2EF00F3EDE900F0E8E400EDE4DF00EAE0D900E7DBD400E4D7
        CF00E1D2C900DECDC400D2BFB200DDC5C200B7A29300FFFFFF0069473100FFFF
        FF00FFFFFF00C7B2A300B7A29300DDC5C20027A5E900C8B3A400FFFFFF00FFFF
        FF00B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A2
        9300B7A29300B7A29300B7A29300B7A29300E4D7CF00E1D2C900D1BEB10027A5
        E900DDC5C200B7A2930069473100FFFFFF00FFFFFF00C7B2A300DDC5C20027A5
        E90027A5E900C8B3A400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FCFBF900F9F6F400F6F2EF00F3EDE900F0E8E400EDE4DF00EAE0
        D900E7DBD400E4D7CF00D1BEB10027A5E90027A5E900B7A2930069473100FFFF
        FF00FFFFFF00FFFFFF00C7B2A300DDC5C20047B6FF00C8B3A400FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FCFBF900F9F6
        F400F6F2EF00F3EDE900F0E8E400EDE4DF00EAE0D900E7DBD400D0BDB00047B6
        FF00B7A2930069473100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C7B2
        A300DDC5C200C8B3A400C8B3A400C8B3A400C8B3A400C8B3A400C8B3A400C9B4
        A500C9B5A600CAB6A700CBB6A800CBB7A900CCB8AA00CCB9AB00CDB9AB00CEBA
        AC00CEBBAD00CFBBAE00CFBCAF00BCA7980069473100FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C7B2A300DDC5C200DBF3FA00DBF3
        FA00DBF3FA00D4F0FA00C7EBFB00B9E5FB00ACDFFB009ED9FC0091D4FC0082CE
        FD0073C8FD0064C2FE0055BCFE0047B6FF0047B6FF0047B6FF00BBA697007353
        3E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00C7B2A300EEE0E000DBF3FA00DBF3FA00DBF3FA00D4F0FA00C7EB
        FB00B9E5FB00B2E2FB00A5DCFC0097D6FC0089D1FC007BCBFD006CC5FD005DBF
        FE004EB9FE00B7A2930069473100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C7B2A300EEE0
        E000DBF3FA00DBF3FA00DBF3FA00DBF3FA00CDEDFA00C0E8FB00B2E2FB00A5DC
        FC0097D6FC0089D1FC007BCBFD006CC5FD00B7A2930069473100FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00C7B2A300EEE0E000DBF3FA00DBF3FA00DBF3
        FA00DBF3FA00CDEDFA00C0E8FB00B2E2FB00A5DCFC0097D6FC0089D1FC00B7A2
        930069473100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00C7B2A300EEE0E000DBF3FA00DBF3FA00DBF3FA00DBF3FA00CDEDFA00C0E8
        FB00B2E2FB00A5DCFC00B7A2930069473100FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C7B2A300EEE0E000EEE0
        E000EEE0E000EEE0E000EEE0E000EEE0E000DDC5C200B7A2930069473100FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00C7B2A300C7B2A300C7B2A300C7B2A300C7B2A300C7B2
        A300C7B2A300C7B2A300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00}
    end
  end
  object gbPara: TGroupBox
    Left = 8
    Top = 40
    Width = 361
    Height = 81
    Caption = 'Para'
    TabOrder = 1
    object rbUsuario: TRadioButton
      Left = 40
      Top = 24
      Width = 80
      Height = 17
      Caption = 'Usu'#225'rio :'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rbUsuarioClick
    end
    object rbTodos: TRadioButton
      Left = 40
      Top = 56
      Width = 113
      Height = 17
      Caption = 'Todos'
      TabOrder = 1
      OnClick = rbUsuarioClick
    end
    object dbUsuario: TDBLookupComboBox
      Left = 120
      Top = 18
      Width = 217
      Height = 21
      BevelEdges = []
      BevelInner = bvNone
      BevelOuter = bvNone
      KeyField = 'IdUser'
      ListField = 'Nome'
      ListSource = DataSource1
      TabOrder = 2
      OnCloseUp = dbUsuarioCloseUp
    end
  end
  object gbMensagem: TGroupBox
    Left = 8
    Top = 128
    Width = 361
    Height = 201
    Caption = 'Mensagem'
    TabOrder = 2
    object lbAssunto: TLabel
      Left = 24
      Top = 24
      Width = 38
      Height = 13
      Caption = 'Assunto'
    end
    object lbMensagem: TLabel
      Left = 24
      Top = 72
      Width = 52
      Height = 13
      Caption = 'Mensagem'
    end
    object EditAssunto: TEdit
      Left = 24
      Top = 40
      Width = 313
      Height = 21
      MaxLength = 50
      TabOrder = 0
    end
    object MemoMsg: TMemo
      Left = 24
      Top = 88
      Width = 313
      Height = 97
      MaxLength = 255
      ScrollBars = ssBoth
      TabOrder = 1
    end
  end
  object btEnvia: TBitBtn
    Left = 93
    Top = 336
    Width = 79
    Height = 25
    Caption = '&Enviar'
    TabOrder = 3
    OnClick = btEnviaClick
    Glyph.Data = {
      42040000424D4204000000000000420000002800000020000000100000000100
      1000030000000004000000000000000000000000000000000000007C0000E003
      00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C45261F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C94521F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C4526862645261F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C9452D65A94521F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C673286268626862645261F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7CD65AD65AD65AD65A94521F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C45268626C62A862E862645261F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C9452D65AF75ED65AD65A94521F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C47328626C62A252E252EC62A8822C62A1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7CB556D65AF75EB556B556F75ED65AF75E1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C4526C62A252E1F7C1F7C252EC62A45261F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C9452F75EB5561F7C1F7CB556F75E94521F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C252E1F7C1F7C1F7C1F7C252EC62A45261F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7CB5561F7C1F7C1F7C1F7CB556F75E94521F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C252EC62AC62A1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CB556F75EF75E1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C252E86261F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CB556D65A1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C252E86261F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CB556D65A1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C252E8626
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CB556D65A
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C252E
      86261F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CB556
      D65A1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      252E86261F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      B556D65A1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C252E1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7CB5561F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C}
    NumGlyphs = 2
  end
  object btCancela: TBitBtn
    Left = 205
    Top = 336
    Width = 79
    Height = 25
    Cancel = True
    Caption = 'Cancelar'
    TabOrder = 4
    OnClick = btCancelaClick
    Glyph.Data = {
      36060000424D3606000000000000360000002800000020000000100000000100
      18000000000000060000120B0000120B00000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC066148E4019
      8E40198E40198E40198E40198E40198E40198E40198E40198E40198E40198E40
      198E40198E4019FF00FF8888886969696969696969696969696969696A6A6A69
      69696969696969696A6A6A6969696969696A6A6A696969FF00FFC06614F9F5F4
      C3B2A5C3B2A5C3B2A5C3B2A5C3B2A5C3B2A5C3B2A5C3B2A5C3B2A5C3B2A5C3B2
      A5C3B2A58E4019FF00FF888888F8F8F8C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6
      C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6696969FF00FFC06614FCFAFA
      F9F5F4F5F0EEF2EBE8EEE6E2ECE2DCE9DED7E5D9D1E2D4CCDFD0C7DFD0C7DCCB
      C1C3B2A58E4019FF00FF888888FCFCFCF8F8F8F5F5F5F1F1F1EEEEEEEAEAEAE7
      E7E7E4E4E4E0E0E0DDDDDDDDDDDDD9D9D9C6C6C6696969FF00FFC06614FFFFFF
      FCFAFAF9F5F4F5F0EEF2EBE8EEE6E2ECE2DCE9DED7E5D9D1E2D4CCE2D4CCDFD0
      C7C3B2A58E4019FF00FF888888FFFFFFFCFCFCF8F8F8F5F5F5F1F1F1EEEEEEEA
      EAEAE7E7E7E3E3E3E0E0E0E0E0E0DDDDDDC6C6C6696969FF00FFC06614FFFFFF
      FFFFFFFCFAFAF9F5F4F5F0EEF2EBE8EEE6E2ECE2DCE9DED7E5D9D1E5D9D1E2D4
      CCC3B2A58E4019FF00FF888888FFFFFFFFFFFFFCFCFCF8F8F8F5F5F5F1F1F1EE
      EEEEEAEAEAE7E7E7E3E3E3E3E3E3E0E0E0C6C6C6696969FF00FFC06614FFFFFF
      FFFFFFFFFFFFFCFAFAF9F5F4F5F0EEF2EBE8EEE6E2ECE2DCE9DED7E9DED7E5D9
      D1C3B2A58E4019FF00FF888888FFFFFFFFFFFFFFFFFFFCFCFCF8F8F8F5F5F5F1
      F1F1EEEEEEEAEAEAE7E7E7E7E7E7E3E3E3C6C6C6696969FF00FFC06614FFFFFF
      FFFFFFFFFFFFFFFFFFFEFDFDFBF8F7F7F3F1F2EBE8EEE6E2ECE2DCECE2DCE9DE
      D7C3B2A58E4019FF00FF888888FFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFBFBFBF7
      F7F7F1F1F1EEEEEEEAEAEAEAEAEAE7E7E7C6C6C6696969FF00FFC06614FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFEFDFDFBF8F7F7F3F1F4EEEBF0E9E5F0E9E5EDE4
      DFC3B2A58E4019FF00FF888888FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFB
      FBFBF7F7F7F3F3F3F0F0F0F0F0F0ECECECC6C6C66A6A6AFF00FFC06614FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFDFDFBF8F7F7F3F1F4EEEBF4EEEBF0E9
      E5C3B2A58E4019FF00FF888888FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE
      FEFEFBFBFBF7F7F7F3F3F3F3F3F3F0F0F0C6C6C66A6A6AFF00FFC06614FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFDFDFBF8F78A9DE92546CD1D3F
      C9193BC8183BC88194E1898989FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFEFEFEFAFAFAC6C6C6979797929292929292929292C0C0C0C06614FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFDFD3355DBF2F4FD4E6B
      D94A67D8F2F4FD183BC8888888FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFEFEFEA1A1A1FAFAFAAAAAAAA8A8A8F9F9F9929292C066148E4019
      8E40198E40198E40198E40198E40198E40198E40198E40193C5CDD8296E4D9DF
      F9CDD5F74C69D81A3CC88888886969696969696969696A6A6A69696969696969
      6969696969696969A5A5A5C1C1C1EDEDEDE7E7E7A8A8A8929292C06614ED9733
      ED9733ED9733ED9733ED9733ED9733ED9733F6CA9AED97334563E16980E2E4E8
      FBD8DEF9516DDA1F40C9888888ACACACACACACADADADADADADADADADACACACAD
      ADADD5D5D5ADADADA8A8A8B6B6B6F2F2F2ECECECABABAB939393F810DCC06614
      C06614C06614C06614C06614C06614C06614C06614C066144D6AE3F2F4FD667D
      E26E85E2F2F4FD2749CEEF14EF88888888888888888888888889898988888888
      8888888888898989ACACACF9F9F9B5B5B5B9B9B9F9F9F9989898FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9AABEF4D6AE34563
      E14463DF3E5EDE8FA2EBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFCFCFCFACACACA8A8A8A8A8A8A6A6A6C9C9C9}
    NumGlyphs = 2
  end
  object DataSource1: TDataSource
    Left = 144
    Top = 96
  end
end
