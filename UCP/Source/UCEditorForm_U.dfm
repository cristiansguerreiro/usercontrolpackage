object UCEditorForm: TUCEditorForm
  Left = 182
  Top = 174
  BorderStyle = bsDialog
  Caption = 'User Control Editor'
  ClientHeight = 524
  ClientWidth = 594
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBotoes: TPanel
    Left = 0
    Top = 479
    Width = 594
    Height = 45
    Align = alBottom
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 0
    object btnOK: TBitBtn
      Left = 201
      Top = 9
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
    object btnClose: TBitBtn
      Left = 313
      Top = 7
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkClose
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 594
    Height = 73
    Align = alTop
    BevelOuter = bvNone
    Color = clGray
    TabOrder = 1
    object lbComponente: TLabel
      Left = 215
      Top = 27
      Width = 164
      Height = 19
      Caption = 'Configura'#231#227'o B'#225'sica'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object pnlCentro: TPanel
    Left = 0
    Top = 73
    Width = 594
    Height = 406
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object PageControl: TPageControl
      Left = 0
      Top = 0
      Width = 594
      Height = 406
      ActivePage = tabLogin
      Align = alClient
      Style = tsFlatButtons
      TabOrder = 0
      object tabPrincipal: TTabSheet
        Caption = 'Principal'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Panel5: TPanel
          Left = 0
          Top = 0
          Width = 586
          Height = 375
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object Label5: TLabel
            Left = 64
            Top = 20
            Width = 115
            Height = 13
            Caption = 'Identifica'#231#227'o Programa :'
          end
          object Label6: TLabel
            Left = 47
            Top = 304
            Width = 132
            Height = 13
            Caption = 'Tabela de Usuarios/Perfis : '
          end
          object Label7: TLabel
            Left = 69
            Top = 233
            Width = 110
            Height = 13
            Caption = 'Tabela de Permiss'#245'es :'
          end
          object Label29: TLabel
            Left = 120
            Top = 127
            Width = 59
            Height = 13
            Alignment = taRightJustify
            Caption = 'Criptografia :'
          end
          object Label30: TLabel
            Left = 116
            Top = 162
            Width = 63
            Height = 13
            Alignment = taRightJustify
            Caption = 'Encrypt Key :'
          end
          object Label32: TLabel
            Left = 117
            Top = 198
            Width = 62
            Height = 13
            Alignment = taRightJustify
            Caption = 'Login Mode :'
          end
          object edtApplicationID: TEdit
            Left = 182
            Top = 17
            Width = 220
            Height = 21
            TabOrder = 0
          end
          object edtTableUsers: TEdit
            Left = 182
            Top = 300
            Width = 220
            Height = 21
            TabOrder = 1
          end
          object edtTableRights: TEdit
            Left = 182
            Top = 229
            Width = 220
            Height = 21
            TabOrder = 2
            OnChange = edtTableRightsChange
          end
          object edtTabelaPermissoesEX: TEdit
            Left = 182
            Top = 265
            Width = 220
            Height = 21
            Enabled = False
            TabOrder = 3
            Text = 'EX'
          end
          object ckAutoStart: TCheckBox
            Left = 182
            Top = 52
            Width = 220
            Height = 21
            Caption = 'Iniciar Automaticamente'
            TabOrder = 4
          end
          object btnTabelasPadrao: TButton
            Left = 182
            Top = 336
            Width = 220
            Height = 21
            Caption = 'Tabelas Padr'#227'o'
            TabOrder = 5
            OnClick = btnTabelasPadraoClick
          end
          object ckValidationKey: TCheckBox
            Left = 182
            Top = 87
            Width = 220
            Height = 21
            Caption = 'CheckValidationKey'
            TabOrder = 6
          end
          object cbCriptografia: TComboBox
            Left = 182
            Top = 123
            Width = 220
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 7
            Items.Strings = (
              'cPadrao'
              'cMD5')
          end
          object cbLoginMode: TComboBox
            Left = 182
            Top = 194
            Width = 220
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 8
            Items.Strings = (
              'lmActive'
              'lmPassive')
          end
          object GroupBox3: TGroupBox
            Left = 425
            Top = 17
            Width = 113
            Height = 78
            Caption = 'Not Allowed Items'
            TabOrder = 9
            object ckActionVisible: TCheckBox
              Left = 12
              Top = 24
              Width = 89
              Height = 17
              Caption = 'Action Visible'
              Checked = True
              State = cbChecked
              TabOrder = 0
            end
            object ckMenuVisible: TCheckBox
              Left = 12
              Top = 47
              Width = 89
              Height = 17
              Caption = 'Menu Visible'
              Checked = True
              State = cbChecked
              TabOrder = 1
            end
          end
          object spedtEncryptKey: TSpinEdit
            Left = 182
            Top = 157
            Width = 220
            Height = 22
            MaxValue = 0
            MinValue = 0
            TabOrder = 10
            Value = 0
          end
        end
      end
      object tabControlRights: TTabSheet
        Caption = 'Control Rights'
        ImageIndex = 6
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label33: TLabel
          Left = 179
          Top = 117
          Width = 52
          Height = 13
          Alignment = taRightJustify
          Caption = 'ActionList :'
        end
        object Label34: TLabel
          Left = 129
          Top = 159
          Width = 102
          Height = 13
          Alignment = taRightJustify
          Caption = 'ActionMainMenuBar :'
        end
        object Label35: TLabel
          Left = 153
          Top = 202
          Width = 78
          Height = 13
          Alignment = taRightJustify
          Caption = 'ActionManager :'
        end
        object Label36: TLabel
          Left = 175
          Top = 245
          Width = 56
          Height = 13
          Alignment = taRightJustify
          Caption = 'MainMenu :'
        end
        object cbActionList: TComboBox
          Left = 237
          Top = 113
          Width = 220
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 0
          OnChange = ComboRightsChange
        end
        object cbActionMainMenuBar: TComboBox
          Left = 237
          Top = 155
          Width = 220
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 1
          OnChange = ComboRightsChange
          OnClick = ComboRightsChange
        end
        object cbActionManager: TComboBox
          Left = 237
          Top = 198
          Width = 220
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 2
          OnChange = ComboRightsChange
        end
        object cbMainMenu: TComboBox
          Left = 237
          Top = 241
          Width = 220
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 3
          OnChange = ComboRightsChange
        end
      end
      object tabUser: TTabSheet
        Caption = 'User'
        ImageIndex = 3
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label2: TLabel
          Left = 172
          Top = 122
          Width = 36
          Height = 13
          Caption = 'Action :'
        end
        object Label27: TLabel
          Left = 152
          Top = 161
          Width = 56
          Height = 13
          Caption = 'Menu Item :'
        end
        object cbUserAction: TComboBox
          Left = 214
          Top = 118
          Width = 220
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 0
          OnChange = ComboActionMenuItem
          OnClick = ComboActionMenuItem
        end
        object cbUserMenuItem: TComboBox
          Left = 214
          Top = 157
          Width = 220
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 1
          OnChange = ComboActionMenuItem
          OnClick = ComboActionMenuItem
        end
        object ckUserProtectAdministrator: TCheckBox
          Left = 214
          Top = 196
          Width = 220
          Height = 21
          Caption = 'User Protect Administrator'
          TabOrder = 2
        end
        object ckUserUsePrivilegedField: TCheckBox
          Left = 214
          Top = 236
          Width = 220
          Height = 21
          Caption = 'Use Privileged Field'
          TabOrder = 3
        end
      end
      object tabUserProfile: TTabSheet
        Caption = 'User Profile'
        ImageIndex = 4
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label3: TLabel
          Left = 174
          Top = 128
          Width = 36
          Height = 13
          Alignment = taRightJustify
          Caption = 'Action :'
        end
        object Label28: TLabel
          Left = 154
          Top = 181
          Width = 56
          Height = 13
          Alignment = taRightJustify
          Caption = 'Menu Item :'
        end
        object cbUserProfileAction: TComboBox
          Left = 213
          Top = 124
          Width = 220
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 0
          OnChange = ComboActionMenuItem
          OnClick = ComboActionMenuItem
        end
        object cbUserProfileMenuItem: TComboBox
          Left = 213
          Top = 177
          Width = 220
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 1
          OnChange = ComboActionMenuItem
          OnClick = ComboActionMenuItem
        end
        object ckUserProfileActive: TCheckBox
          Left = 213
          Top = 230
          Width = 220
          Height = 21
          Caption = 'Active'
          TabOrder = 2
        end
      end
      object tabUserPasswordChange: TTabSheet
        Caption = 'User Password Change'
        ImageIndex = 5
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label4: TLabel
          Left = 126
          Top = 252
          Width = 108
          Height = 13
          Alignment = taRightJustify
          Caption = 'Min Password Length :'
        end
        object Label31: TLabel
          Left = 198
          Top = 110
          Width = 36
          Height = 13
          Alignment = taRightJustify
          Caption = 'Action :'
        end
        object Label37: TLabel
          Left = 178
          Top = 157
          Width = 56
          Height = 13
          Alignment = taRightJustify
          Caption = 'Menu Item :'
        end
        object cbUserPasswordChangeAction: TComboBox
          Left = 239
          Top = 106
          Width = 220
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 0
          OnChange = ComboActionMenuItem
          OnClick = ComboActionMenuItem
        end
        object cbUserPasswordChangeMenuItem: TComboBox
          Left = 239
          Top = 153
          Width = 220
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 1
          OnChange = ComboActionMenuItem
          OnClick = ComboActionMenuItem
        end
        object ckUserPassowrdChangeForcePassword: TCheckBox
          Left = 239
          Top = 200
          Width = 220
          Height = 21
          Caption = 'Force Password'
          TabOrder = 2
        end
        object spedtUserPasswordChangeMinPasswordLength: TSpinEdit
          Left = 239
          Top = 247
          Width = 220
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 3
          Value = 0
        end
      end
      object tabLogControl: TTabSheet
        Caption = 'Log Control'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label25: TLabel
          Left = 140
          Top = 115
          Width = 80
          Height = 13
          Alignment = taRightJustify
          Caption = 'Tabela de Logs :'
        end
        object Label1: TLabel
          Left = 164
          Top = 75
          Width = 56
          Height = 13
          Alignment = taRightJustify
          Caption = 'Menu Item :'
        end
        object Label26: TLabel
          Left = 184
          Top = 35
          Width = 36
          Height = 13
          Alignment = taRightJustify
          Caption = 'Action :'
        end
        object Panel4: TPanel
          Left = 0
          Top = 205
          Width = 586
          Height = 170
          Align = alBottom
          BevelKind = bkFlat
          BevelOuter = bvNone
          Color = clWhite
          TabOrder = 0
          object Image4: TImage
            Left = 20
            Top = 28
            Width = 25
            Height = 24
            Picture.Data = {
              07544269746D617076060000424D760600000000000036040000280000001800
              000018000000010008000000000040020000C40E0000C40E0000000100000000
              00000800000008080800310010004A08180031101800391821005A1821004A18
              290063292900522131006B21310039314200843142001042420018394A001042
              4A008C524A0031395200084252006B4A5200085252005A525200845252005A5A
              5A00635A5A006B5A5A00845A5A008C5A5A00635A6300845A63005A6363008463
              6300946363008C6B6B00A56B6B00086B7300426B730094737300396B7B009C7B
              7B00A57B7B00AD848400187B9400188C9C00298C9C0029949C002994A500B5A5
              A500218CAD00089CAD0021A5AD0021ADAD009CA5B5007BB5B500089CBD00219C
              BD0021B5BD00089CC60008BDC60010A5CE0018B5CE0008BDD60000B5DE0008B5
              DE0010B5DE0008DEDE0000BDE70008BDE70000C6E70008C6E70018C6E70008CE
              E70052CEE70000D6E70000DEE70018E7E70000BDEF0000C6EF0000CEEF0000D6
              EF0018D6EF0000DEEF0008DEEF0063DEEF0000E7EF0008E7EF0010E7EF004AE7
              EF0063E7EF0000EFEF004AEFEF0000C6F70000CEF7006BDEF70000E7F70094E7
              F7009CE7F70000EFF70008F7F70010F7F700FF00FF0000D6FF0000DEFF0008DE
              FF0000E7FF0008E7FF0000EFFF0008EFFF0010EFFF0000F7FF0008F7FF0010F7
              FF0018F7FF0000FFFF0008FFFF0010FFFF0018FFFF0031FFFF0052FFFF00FFFF
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
              FF007777777777777777777777777777777777777777777777777777772F1F1A
              1D1D1D1D1D1D1D1D1D1D1D1D1D1D161B77777777483B36363636363636393636
              36363636363930081B7777483F3E42424242424D3F37404C4242424242425B26
              10777753434D655C5C5C654E0F073446655C5C5C655C5C2429777777464D6765
              656565440104093C656565656C65431377777777534467676565654F12000E47
              656565676C5C2C277777777777464E69666565665E495E666565667067451C77
              77777777775D4E6769666666662A666666666970662E2977777777777777504F
              6C666666490B4F68666670674F1977777777777777775344676966683A063D6A
              666C6C662C28777777777777777777474F6B686A310C2B6A686F694715777777
              7777777777777753496B6B61230A26616B70682D287777777777777777777777
              505E6E540F0311496F6C5418777777777777777777777777585162410102053A
              706A322277777777777777777777777777526141000204386E52177777777777
              77777777777777777757515514010D4B6D332177777777777777777777777777
              777756616E4A746E551E7777777777777777777777777777777758546E72746D
              382077777777777777777777777777777777774B627573611E77777777777777
              77777777777777777777775A5975713825777777777777777777777777777777
              77777777636E6335777777777777777777777777777777777777777753765377
              7777777777777777777777777777777777777777775377777777777777777777
              7777}
          end
          object Label19: TLabel
            Left = 60
            Top = 28
            Width = 320
            Height = 13
            Caption = 'O Componente n'#227'o grava nenhum log automaticamente!'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label20: TLabel
            Left = 60
            Top = 52
            Width = 505
            Height = 13
            Caption = 
              'Utilize o Metodo: Log(msg : String; nivel : Integer {0..3} = 0) ' +
              'para gravar registros no Log de mensagens'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label21: TLabel
            Left = 68
            Top = 76
            Width = 16
            Height = 13
            Caption = 'Ex:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label22: TLabel
            Left = 92
            Top = 76
            Width = 175
            Height = 13
            Caption = 'UserControl1.Log('#39'Exemplo de Log'#39');'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label23: TLabel
            Left = 280
            Top = 76
            Width = 285
            Height = 65
            Caption = 
              'try'#13#10'  ..'#13#10'except'#13#10'  on e : Exception do ADOUserControl1.Log(e.M' +
              'essage, 3);'#13#10'end;'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label24: TLabel
            Left = 92
            Top = 108
            Width = 162
            Height = 13
            Caption = 'UserControl1.Log('#39'Exemplo 2'#39', 1);'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
        end
        object edtLogControlTableLog: TEdit
          Left = 226
          Top = 112
          Width = 220
          Height = 21
          TabOrder = 1
        end
        object ckLogControlActive: TCheckBox
          Left = 226
          Top = 152
          Width = 220
          Height = 21
          Caption = 'Active'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
        object cbLogControlAction: TComboBox
          Left = 226
          Top = 32
          Width = 220
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 3
          OnChange = ComboActionMenuItem
          OnClick = ComboActionMenuItem
        end
        object cbLogControlMenuItem: TComboBox
          Left = 226
          Top = 72
          Width = 220
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 4
          OnChange = ComboActionMenuItem
          OnClick = ComboActionMenuItem
        end
      end
      object tabLogin: TTabSheet
        Caption = 'Login'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label14: TLabel
          Left = 115
          Top = 25
          Width = 149
          Height = 13
          Alignment = taRightJustify
          Caption = 'N'#250'mero m'#225'ximo de Tentativas :'
        end
        object Label15: TLabel
          Left = 181
          Top = 52
          Width = 83
          Height = 13
          Alignment = taRightJustify
          Caption = 'Get Login Name :'
        end
        object Label16: TLabel
          Left = 136
          Top = 350
          Width = 79
          Height = 13
          Caption = 'Imagem Superior'
        end
        object Label17: TLabel
          Left = 288
          Top = 350
          Width = 85
          Height = 13
          Caption = 'Imagem Esquerda'
        end
        object Label18: TLabel
          Left = 440
          Top = 350
          Width = 72
          Height = 13
          Caption = 'Imagem Inferior'
        end
        object SpeedButton1: TSpeedButton
          Left = 19
          Top = 288
          Width = 73
          Height = 40
          Caption = 'Visualizar'
          Flat = True
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000420B0000420B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFCC6701CC6701CC6701CC6701CC6701CC6701CC
            6701CC6701CC6701CC6701CC6701CC6701CC6701CC6701CC6701FF00FFCC6701
            FFFFFFFFFFFFFFFAF5FFF3E6FEEBD5FEE3C3FEDCB5FED7ABFED7ABFED7ABFED7
            ABFED7ABFED7ABCC6701FF00FFCC6701FFFFFFFFFFFFFFFFFFFFFAF5FFF3E6FE
            EBD5FEE3C4FEDCB500C0C000C0C000C0C000C0C0FED7ABCC6701FF00FFCC6701
            FFFFFFFFFFFFFFFFFFFFFFFFFFFAF5FFF3E6FFEBD5FEE3C4FFFFFFFFFFFFFFFF
            FF00C0C0FED7ABCC6701FF00FFCC6701FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FAF5FFF3E6FFEBD5FEE3C4FEDCB5FED7ABFED7ABFED7ABCC6701FF00FFCC6701
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAF5FFF3E6FFEBD5FEE3C4FEDC
            B5FED7ABFED7ABCC6701FF00FFCC6701FFFFFFFFFFFFFFFFFF80808080808080
            8080FFFFFF808080FFF3E6808080808080808080FED7ABCC6701FF00FFCC6701
            8080FF0000FF8080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAF5FFF3E6FFEB
            D5FEE3C4FEDCB5CC6701FF00FFCC67010000FF0000FF0000FFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFAF5FFF3E6FFEBD5FEE3C4CC6701FF00FFCC6701
            8080FF0000FF8080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA
            F5FFF3E6FFEBD5CC6701FF00FFCC6701FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAF5FFF3E6CC6701FF00FFCC6701
            CC6701CC6701CC6701CC6701CC6701CC6701CC6701CC6701CC6701CC6701CC67
            01CC6701CC6701CC6701FF00FFFF00FFCC6701CC6701CC6701CC6701CC6701CC
            6701CC6701CC6701CC6701CC6701CC6701CC6701CC6701FF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          Layout = blGlyphTop
          OnClick = SpeedButton1Click
        end
        object SpeedButton2: TSpeedButton
          Left = 211
          Top = 322
          Width = 48
          Height = 22
          Caption = 'Limpar'
          Flat = True
          OnClick = SpeedButton2Click
        end
        object SpeedButton3: TSpeedButton
          Left = 365
          Top = 322
          Width = 48
          Height = 22
          Caption = 'Limpar'
          Flat = True
          OnClick = SpeedButton3Click
        end
        object SpeedButton4: TSpeedButton
          Left = 517
          Top = 322
          Width = 48
          Height = 22
          Caption = 'Limpar'
          Flat = True
          OnClick = SpeedButton4Click
        end
        object GroupBox1: TGroupBox
          Left = 2
          Top = 88
          Width = 290
          Height = 185
          Caption = 'Login Inicial'
          TabOrder = 0
          object Label8: TLabel
            Left = 14
            Top = 24
            Width = 42
            Height = 13
            Caption = 'Usu'#225'rio :'
          end
          object Label9: TLabel
            Left = 19
            Top = 55
            Width = 37
            Height = 13
            Caption = 'Senha :'
          end
          object Label12: TLabel
            Left = 25
            Top = 87
            Width = 31
            Height = 13
            Caption = 'Email :'
          end
          object lblInitialRights: TLabel
            Left = -7
            Top = 115
            Width = 63
            Height = 13
            Alignment = taRightJustify
            Caption = 'Initial Rights :'
          end
          object edtInitialLoginUser: TEdit
            Left = 64
            Top = 20
            Width = 220
            Height = 21
            TabOrder = 0
          end
          object edtInitialLoginPassword: TEdit
            Left = 64
            Top = 51
            Width = 220
            Height = 21
            TabOrder = 1
          end
          object edtInitialLoginEmail: TEdit
            Left = 64
            Top = 83
            Width = 220
            Height = 21
            TabOrder = 2
          end
          object mmInitialRights: TMemo
            Left = 64
            Top = 115
            Width = 220
            Height = 62
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
        end
        object GroupBox2: TGroupBox
          Left = 295
          Top = 88
          Width = 290
          Height = 185
          Caption = 'Login Autom'#225'tico'
          TabOrder = 1
          object Label10: TLabel
            Left = 13
            Top = 44
            Width = 42
            Height = 13
            Alignment = taRightJustify
            Caption = 'Usu'#225'rio :'
          end
          object Label11: TLabel
            Left = 18
            Top = 81
            Width = 37
            Height = 13
            Alignment = taRightJustify
            Caption = 'Senha :'
          end
          object edtLoginAutoLoginUser: TEdit
            Left = 56
            Top = 40
            Width = 220
            Height = 21
            TabOrder = 0
          end
          object edtLoginAutoLoginPassword: TEdit
            Left = 56
            Top = 77
            Width = 220
            Height = 21
            TabOrder = 1
          end
          object ckLoginAutologinActive: TCheckBox
            Left = 56
            Top = 104
            Width = 65
            Height = 17
            Caption = 'Ativo'
            Checked = True
            State = cbChecked
            TabOrder = 2
          end
          object ckLoginAutoLoginMessageOnError: TCheckBox
            Left = 33
            Top = 127
            Width = 225
            Height = 17
            Caption = 'Exibir mensagem padr'#227'o de erro se falhar ?'
            TabOrder = 3
          end
        end
        object cbGetLoginName: TComboBox
          Left = 270
          Top = 48
          Width = 201
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 2
          Text = 'lnNone'
          Items.Strings = (
            'lnNone'
            'lnUserName'
            'lnMachineName')
        end
        object Panel6: TPanel
          Left = 143
          Top = 280
          Width = 65
          Height = 65
          BevelOuter = bvLowered
          Color = clGray
          TabOrder = 3
          object imgTop: TImage
            Left = 1
            Top = 1
            Width = 63
            Height = 63
            Cursor = crHandPoint
            Align = alClient
            Center = True
            Proportional = True
            Stretch = True
            OnClick = ActionsExecute
          end
        end
        object Panel7: TPanel
          Left = 295
          Top = 280
          Width = 65
          Height = 65
          BevelOuter = bvLowered
          Color = clGray
          TabOrder = 4
          object imgLeft: TImage
            Left = 1
            Top = 1
            Width = 63
            Height = 63
            Cursor = crHandPoint
            Align = alClient
            Center = True
            Proportional = True
            Stretch = True
            OnClick = ActionsExecute
          end
        end
        object Panel8: TPanel
          Left = 447
          Top = 280
          Width = 65
          Height = 65
          BevelOuter = bvLowered
          Color = clGray
          TabOrder = 5
          object imgBottom: TImage
            Left = 1
            Top = 1
            Width = 63
            Height = 63
            Cursor = crHandPoint
            Align = alClient
            Center = True
            Proportional = True
            Stretch = True
            OnClick = ActionsExecute
          end
        end
        object spedtMaxLoginAttempts: TSpinEdit
          Left = 270
          Top = 20
          Width = 121
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 6
          Value = 0
        end
      end
    end
  end
  object OpenPictureDialog: TOpenPictureDialog
    Left = 104
    Top = 392
  end
  object ActionList: TActionList
    Left = 137
    Top = 392
    object acCarregarFigura: TAction
      Caption = 'Carregar Figura'
      OnExecute = ActionsExecute
    end
    object acVisualizarTelaLogin: TAction
      Caption = 'acVisualizarTelaLogin'
      OnExecute = ActionsExecute
    end
  end
end
