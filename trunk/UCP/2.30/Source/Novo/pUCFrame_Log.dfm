object UCFrame_Log: TUCFrame_Log
  Left = 0
  Top = 0
  Width = 563
  Height = 498
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  TabStop = True
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 563
    Height = 394
    Align = alClient
    Ctl3D = True
    DataSource = DataSource1
    DefaultDrawing = False
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawColumnCell = DBGrid1DrawColumnCell
    Columns = <
      item
        Expanded = False
        Visible = True
      end
      item
        Expanded = False
        Visible = True
      end
      item
        Expanded = False
        Visible = True
      end
      item
        Expanded = False
        Visible = True
      end
      item
        Expanded = False
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 394
    Width = 563
    Height = 104
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object lbUsuario: TLabel
      Left = 16
      Top = 8
      Width = 42
      Height = 13
      Caption = 'Usu'#225'rio :'
    end
    object lbData: TLabel
      Left = 176
      Top = 8
      Width = 29
      Height = 13
      Caption = 'Data :'
    end
    object lbNivel: TLabel
      Left = 376
      Top = 8
      Width = 69
      Height = 13
      Caption = 'N'#237'vel m'#237'nimo :'
    end
    object Bevel3: TBevel
      Left = 16
      Top = 63
      Width = 529
      Height = 2
      Style = bsRaised
    end
    object btfiltro: TBitBtn
      Left = 124
      Top = 71
      Width = 101
      Height = 25
      Cursor = crHandPoint
      Caption = 'Aplicar filtro'
      Enabled = False
      TabOrder = 4
      OnClick = btfiltroClick
      Glyph.Data = {
        36060000424D3606000000000000360000002800000020000000100000000100
        18000000000000060000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFA68B7A694731FF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA8A8A86C
        6C6CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFA68B7AB09888694731FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA7A7A7B1
        B1B16B6B6BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFA68B7ADCCCC286624D694731FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA7A7A7DA
        DADA8585856C6C6CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFA68B7ADECFC686624D694731FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA7A7A7DC
        DCDC8484846C6C6CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFA68B7ADFD1C886624D694731FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA7A7A7DD
        DDDD8585856B6B6BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFA68B7AE1D3CB86624D694731FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA7A7A7DF
        DFDF8585856B6B6BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFA68B7AE2D6CE86624D694731FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA7A7A7E2
        E2E28585856C6C6CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFA68B7AE4D8D086624D694731FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA8A8A8E3
        E3E38585856C6C6CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFA68B7AFFFFFFDACABFBDA69686624D694731FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA7A7A7FFFFFFD8
        D8D8BDBDBD8484846C6C6CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFA68B7AFFFFFFF0F0F0E1D4CCD1BBADB4937E86624D694731FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA7A7A7FFFFFFF5F5F5E0
        E0E0CDCDCDAEAEAE8585856C6C6CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFA68B7AFFFFFFF0F0F0ECE4E0E6DBD5DFD1C7CFB9AABE9F8A86624D6947
        31FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA7A7A7FFFFFFF5F5F5ECECECE5
        E5E5DEDEDECBCBCBB7B7B78585856B6B6BFF00FFFF00FFFF00FFFF00FFFF00FF
        A68B7AFFFFFFF0F0F0F5F0EEF1EAE7ECE3DEE6DBD5DCCDC2CFB9AAB4937E8662
        4D694731FF00FFFF00FFFF00FFFF00FFA7A7A7FFFFFFF5F5F5F5F5F5F0F0F0EC
        ECECE6E6E6DADADACBCBCBAEAEAE8585856B6B6BFF00FFFF00FFFF00FFA68B7A
        FFFFFFF0F0F0F3EEEAF0E9E5EDE6E1E5D9D1E5D9D1E2D6CEDED0C6CFB9AABE9F
        8A86624D694731FF00FFFF00FFA7A7A7FFFFFFF5F5F5F3F3F3F0F0F0EDEDEDE4
        E4E4E3E3E3E2E2E2DDDDDDCBCBCBB7B7B78585856C6C6CFF00FFFF00FFB39A89
        B39A89B39A89B39A89B39A89B39A89B39A89B39A89B39A89B39A89B39A89B39A
        89B39A89B39A89FF00FFFF00FFB4B4B4B3B3B3B3B3B3B3B3B3B4B4B4B3B3B3B3
        B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3FF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      NumGlyphs = 2
    end
    object btfecha: TBitBtn
      Left = 338
      Top = 71
      Width = 101
      Height = 25
      Cursor = crHandPoint
      Caption = 'Fechar'
      TabOrder = 5
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
    object btexclui: TBitBtn
      Left = 231
      Top = 71
      Width = 101
      Height = 25
      Cursor = crHandPoint
      Caption = 'Excluir Log'
      TabOrder = 6
      OnClick = btexcluiClick
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000220B0000220B000000010000000100000031DE000031
        E7000031EF000031F700FF00FF000031FF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00040404040404
        0404040404040404000004000004040404040404040404000004040000000404
        0404040404040000040404000000000404040404040000040404040402000000
        0404040400000404040404040404000000040000000404040404040404040400
        0101010004040404040404040404040401010204040404040404040404040400
        0201020304040404040404040404030201040403030404040404040404050203
        0404040405030404040404040303050404040404040303040404040303030404
        0404040404040403040403030304040404040404040404040404030304040404
        0404040404040404040404040404040404040404040404040404}
    end
    object ComboUsuario: TComboBox
      Left = 16
      Top = 24
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = ComboUsuarioChange
    end
    object Data1: TDateTimePicker
      Left = 176
      Top = 25
      Width = 89
      Height = 21
      Date = 37615.000000000000000000
      Time = 37615.000000000000000000
      TabOrder = 1
      OnChange = Data1Change
    end
    object Data2: TDateTimePicker
      Left = 271
      Top = 24
      Width = 89
      Height = 21
      Date = 37615.000000000000000000
      Time = 37615.000000000000000000
      TabOrder = 2
      OnChange = ComboUsuarioChange
    end
    object ComboNivel: TComboBox
      Left = 376
      Top = 24
      Width = 145
      Height = 24
      Style = csOwnerDrawFixed
      ItemHeight = 18
      TabOrder = 3
      OnChange = ComboUsuarioChange
      OnDrawItem = ComboNivelDrawItem
      Items.Strings = (
        'Faible'
        'Moyen'
        'Haut'
        'Critique')
    end
  end
  object DataSource1: TDataSource
    Left = 440
  end
  object ImageList1: TImageList
    Left = 136
    Top = 153
    Bitmap = {
      494C010104000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DEDEDE00DEDEDE00DEDEDE00D6D6D600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E7C4B300E7C4B300E7C4B300D6B9AE00000000000000
      000000000000000000000000000000000000000000000000000000A4EB000088
      C8000088C8000088C8000088C8000088C8000088C8000088C8000088C8000088
      C8000088C8000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DEDEDE00F1F1F100E0E0E000E0E0E000F1F1F100D6D6D6000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E7C4B300F2E7E100CAD0D600CAD0D600F2E7E100D6B9AE000000
      000000000000000000000000000000000000000000002DBCFF0040D6F00015C1
      E60015C1E60015C1E60013C0E2003471890011BFDE0015C1E60015C1E60015C1
      E60015C1E60000A4EB00000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000DEDEDE00F1F1F100FEFEFE00B5B5B500ACACAC00D1D1D100F1F1F100D6D6
      D600000000000000000000000000000000000000000000000000000000000000
      0000E7C4B300F2E7E100FEFEFE00D0805D00C4695200BFB9B900F2E7E100D6B9
      AE00000000000000000000000000000000000000000078CCE80066E5F8002ECB
      EC002DCAEB002CCAEB003471890031001000347189002BC8EA002BC8EA002BC8
      EA0013B9DD002DBCFF000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF0000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF0000000000000000000000000000000000DEDE
      DE00F1F1F100FEFEFE00B5B5B500ACACAC00A8A8A800ACACAC00D1D1D100F1F1
      F100D6D6D600000000000000000000000000000000000000000000000000E7C4
      B300F2E7E100FEFEFE00D0805D00C46E5200BF694C00C4695200BFB9B900F2E7
      E100D6B9AE0000000000000000000000000000000000000000002DBCFF0040D6
      F00039CEEC0038CDEB002DC8E2003471890021C4DA0036CAEA0035CAEA0035CA
      EA0000A4EB0000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF0000000000000000000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000DEDEDE00F1F1
      F100FEFEFE00B5B5B500ACACAC00F5F5F500F5F5F500EFEFEF00A8A8A800D1D1
      D100F1F1F100D6D6D60000000000000000000000000000000000E7C4B300F2E7
      E100FEFEFE00D0805D00C46E5200F8EDE700F8EDE700F8E1D600BF694C00BFB9
      B900F2E7E100D6B9AE000000000000000000000000000000000078CCE80066E5
      F8003ACEEC0039CEEC0038CDEB003471890037CBEA0036CAEA0036CAEA0013B9
      DD002DBCFF0000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF00000000000000000000000000DEDEDE00F1F1F100FEFE
      FE00B5B5B500ACACAC00ACACAC00ACACAC00F5F5F500ACACAC00ACACAC00A8A8
      A800D1D1D100F1F1F100D6D6D6000000000000000000E7C4B300F2E7E100FEFE
      FE00D0805D00C46E5200C46E5200C46E5200F8EDE700C46E5200C46E5200BF69
      4C00BFB9B900F2E7E100D6B9AE00000000000000000000000000000000002DBC
      FF0040D6F0003BCFED0017BACC003100100017BACC0037CAEA0036CAEA0000A4
      EB00000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF0000000000000000000000000000000000E5E5E500FEFEFE00B5B5
      B500B0B0B000ACACAC00ACACAC00ACACAC00F5F5F500ACACAC00ACACAC00ACAC
      AC00A8A8A800D1D1D100D6D6D6000000000000000000EDD0C400FEFEFE00D080
      5D00CA7A5700C46E5200C46E5200C46E5200F8EDE700C46E5200C46E5200C46E
      5200BF694C00BFB9B900D6B9AE000000000000000000000000000000000078CC
      E80066E5F8003CD0ED001796A700310010001796A70037CBEA0013B9DD002DBC
      FF00000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF0000000000000000000000FF000000FF000000
      FF000000FF0000000000000000000000000000000000E5E5E500FFFFFF00EBEB
      EB00C4C4C400B0B0B000ACACAC00ACACAC00F5F5F500ACACAC00ACACAC00ACAC
      AC00B5B5B500E0E0E000D6D6D6000000000000000000EDD0C400FFFFFF00F8E1
      CA00E1A27400CA7A5700C46E5200C46E5200F8EDE700C46E5200C46E5200C46E
      5200D0805D00CAD0D600D6B9AE00000000000000000000000000000000000000
      00002DBCFF0040D6F0003471890031001000286F7D0038CCEB0000A4EB000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF0000000000000000000000FF000000FF000000
      FF000000000000000000000000000000000000000000DEDEDE00F1F1F100FFFF
      FF00EBEBEB00C4C4C400B0B0B000F5F5F500F5F5F500ACACAC00ACACAC00B5B5
      B500F1F1F100F1F1F100D6D6D6000000000000000000E7C4B300F2E7E100FFFF
      FF00F8E1CA00E1A27400CA7A5700F8EDE700F8EDE700C46E5200C46E5200D080
      5D00E7EDED00F2E7E100D6B9AE00000000000000000000000000000000000000
      000078CCE80066E5F80034718900310010003471890013B9DD002DBCFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF0000000000000000000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000DEDEDE00F1F1
      F100FFFFFF00EBEBEB00C4C4C400B0B0B000CDCDCD00ACACAC00B5B5B500FEFE
      FE00F1F1F100DBDBDB0000000000000000000000000000000000E7C4B300F2E7
      E100FFFFFF00F8E1CA00E1A27400CA7A5700E7AE8500C46E5200D0805D00FEFE
      FE00F2E7E100E1C4B30000000000000000000000000000000000000000000000
      0000000000002DBCFF0030B3CA002B5768002396A70000A4EB00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF0000000000000000000000FF000000FF000000
      000000000000000000000000000000000000000000000000000000000000DEDE
      DE00F1F1F100FFFFFF00EBEBEB00C4C4C400F5F5F500B5B5B500FEFEFE00F1F1
      F100DBDBDB00000000000000000000000000000000000000000000000000E7C4
      B300F2E7E100FFFFFF00F8E1CA00E1A27400F8EDE700D0805D00FEFEFE00F2E7
      E100E1C4B3000000000000000000000000000000000000000000000000000000
      00000000000078CCE80066E5F8003ACFEC0013B9DD002DBCFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF0000000000000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000DEDEDE00F1F1F100FFFFFF00EBEBEB00B5B5B500FEFEFE00F1F1F100DBDB
      DB00000000000000000000000000000000000000000000000000000000000000
      0000E7C4B300F2E7E100FFFFFF00F8E1CA00D0805D00FEFEFE00F2E7E100E1C4
      B300000000000000000000000000000000000000000000000000000000000000
      000000000000000000002DBCFF0066E5F80000A4EB0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DEDEDE00F1F1F100FFFFFF00FEFEFE00F1F1F100DBDBDB000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E7C4B300F2E7E100FFFFFF00FEFEFE00F2E7E100E1C4B3000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000078CCE8003DD2EE002DBCFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DEDEDE00DEDEDE00DBDBDB00DBDBDB00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E7C4B300E7C4B300E1C4B300E1C4B300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000002DBCFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFFFFFFFFFFC3FFC3FC007FFFF
      F81FF81F8003C003F00FF00F80038001E007E007C007C003C003C003C007C003
      80018001E00FE00780018001E00FE00780018001F01FF00F80018001F01FF00F
      C003C003F83FF81FE007E007F83FF81FF00FF00FFC7FFC3FF81FF81FFC7FFC3F
      FC3FFC3FFEFFFE7FFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
end
