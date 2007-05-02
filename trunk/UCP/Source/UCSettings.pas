unit UCSettings;

interface

uses
  Classes,
  Forms,
  UCMessages;

type

  TUCSettings = class(TComponent)
  private
    FAddProfileFormMSG:  TUCAddProfileFormMSG;
    FAddUserFormMSG:     TUCAddUserFormMSG;
    FCadUserFormMSG:     TUCCadUserFormMSG;
    FLogControlFormMSG:  TUCLogControlFormMSG;
    FLoginFormMSG:       TUCLoginFormMSG;
    FPermissFormMSG:     TUCPermissFormMSG;
    FProfileUserFormMSG: TUCProfileUserFormMSG;
    FResetPassword:      TUCResetPassword;
    FTrocaSenhaFormMSG:  TUCTrocaSenhaFormMSG;
    FUserCommomMSG:      TUCUserCommonMSG;
    FAppMessagesMSG:     TUCAppMessagesMSG;
    FPosition:           TPosition;
    procedure SetFAddProfileFormMSG(const Value: TUCAddProfileFormMSG);
    procedure SetFAddUserFormMSG(const Value: TUCAddUserFormMSG);
    procedure SetFCadUserFormMSG(const Value: TUCCadUserFormMSG);
    procedure SetFFormLoginMsg(const Value: TUCLoginFormMSG);
    procedure SetFLogControlFormMSG(const Value: TUCLogControlFormMSG);
    procedure SetFPermissFormMSG(const Value: TUCPermissFormMSG);
    procedure SetFProfileUserFormMSG(const Value: TUCProfileUserFormMSG);
    procedure SetFResetPassword(const Value: TUCResetPassword);
    procedure SetFTrocaSenhaFormMSG(const Value: TUCTrocaSenhaFormMSG);
    procedure SetFUserCommonMSg(const Value: TUCUserCommonMSG);
    procedure SetAppMessagesMSG(const Value: TUCAppMessagesMSG);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property AppMessages: TUCAppMessagesMSG read FAppMessagesMSG write SetAppMessagesMSG;
    property CommonMessages: TUCUserCommonMSG read FUserCommomMSG write SetFUserCommonMSg;
    property Login: TUCLoginFormMSG read FLoginFormMSG write SetFFormLoginMsg;
    property Log: TUCLogControlFormMSG read FLogControlFormMSG write SetFLogControlFormMSG;
    property UsersForm: TUCCadUserFormMSG read FCadUserFormMSG write SetFCadUserFormMSG;
    property AddChangeUser: TUCAddUserFormMSG read FAddUserFormMSG write SetFAddUserFormMSG;
    property AddChangeProfile: TUCAddProfileFormMSG read FAddProfileFormMSG write SetFAddProfileFormMSG;
    property UsersProfile: TUCProfileUserFormMSG read FProfileUserFormMSG write SetFProfileUserFormMSG;
    property Rights: TUCPermissFormMSG read FPermissFormMSG write SetFPermissFormMSG;
    property ChangePassword: TUCTrocaSenhaFormMSG read FTrocaSenhaFormMSG write SetFTrocaSenhaFormMSG;
    property ResetPassword: TUCResetPassword read FResetPassword write SetFResetPassword;
    property WindowsPosition: TPosition read FPosition write FPosition default poMainFormCenter;
  end;

procedure IniSettings(DestSettings: TUCUserSettings);
procedure IniSettings2(DestSettings: TUCSettings);

implementation

uses
  Graphics,
  SysUtils,
  UCBase,
  UCConsts;

{$IFDEF DELPHI9_UP} {$REGION 'Inicializacao'} {$ENDIF}

procedure IniSettings(DestSettings: TUCUserSettings);
var
  tmp: TBitmap;
begin
  with DestSettings.CommonMessages do
  begin
    if BlankPassword = '' then
      BlankPassword := Const_Men_SenhaDesabitada;
    if PasswordChanged = '' then
      PasswordChanged := Const_Men_SenhaAlterada;
    if InitialMessage.Text = '' then
      InitialMessage.Text := Const_Men_MsgInicial;
    if MaxLoginAttemptsError = '' then
      MaxLoginAttemptsError := Const_Men_MaxTentativas;
    if InvalidLogin = '' then
      InvalidLogin := Const_Men_LoginInvalido;
    if AutoLogonError = '' then
      AutoLogonError := Const_Men_AutoLogonError;
    if UsuarioExiste = '' then
      UsuarioExiste := Const_Men_UsuarioExiste;
    if PasswordExpired  = '' then
      PasswordExpired := Const_Men_PasswordExpired; 
  end;

  with DestSettings.Login do
  begin
    if BtCancel = '' then
      BtCancel := Const_Log_BtCancelar;
    if BtOK = '' then
      BtOK := Const_Log_BtOK;
    if LabelPassword = '' then
      LabelPassword := Const_Log_LabelSenha;
    if LabelUser = '' then
      LabelUser := Const_Log_LabelUsuario;
    if WindowCaption = '' then
      WindowCaption := Const_Log_WindowCaption;

    if LabelTentativa = '' then
      LabelTentativa := Const_Log_LabelTentativa;
    if LabelTentativas = '' then
      LabelTentativas := Const_Log_LabelTentativas;


    try
      Tmp := TBitmap.Create;
      Tmp.LoadFromResourceName(HInstance, 'UCLOCKLOGIN');
      LeftImage.Assign(tmp);
    finally
      FreeAndNil(tmp);
    end;
  end;

  with DestSettings.UsersForm do
  begin
    if WindowCaption = '' then
      WindowCaption := Const_Cad_WindowCaption;
    if LabelDescription = '' then
      LabelDescription := Const_Cad_LabelDescricao;
    if ColName = '' then
      ColName := Const_Cad_ColunaNome;
    if ColLogin = '' then
      ColLogin := Const_Cad_ColunaLogin;
    if ColEmail = '' then
      ColEmail := Const_Cad_ColunaEmail;
    if BtAdd = '' then
      BtAdd := Const_Cad_BtAdicionar;
    if BtChange = '' then
      BtChange := Const_Cad_BtAlterar;
    if BtDelete = '' then
      BtDelete := Const_Cad_BtExcluir;
    if BtRights = '' then
      BtRights := Const_Cad_BtPermissoes;
    if BtPassword = '' then
      BtPassword := Const_Cad_BtSenha;
    if BtClose = '' then
      BtClose := Const_Cad_BtFechar;
    if PromptDelete = '' then
      PromptDelete := Const_Cad_ConfirmaExcluir;
    if PromptDelete_WindowCaption = '' then
      PromptDelete_WindowCaption := Const_Cad_ConfirmaDelete_WindowCaption; //added by fduenas
  end;

  with DestSettings.UsersProfile do
  begin
    if WindowCaption = '' then
      WindowCaption := Const_Prof_WindowCaption;
    if LabelDescription = '' then
      LabelDescription := Const_Prof_LabelDescricao;
    if ColProfile = '' then
      ColProfile := Const_Prof_ColunaNome;
    if BtAdd = '' then
      BtAdd := Const_Prof_BtAdicionar;
    if BtChange = '' then
      BtChange := Const_Prof_BtAlterar;
    if BtDelete = '' then
      BtDelete := Const_Prof_BtExcluir;
    if BtRights = '' then
      BtRights := Const_Prof_BtPermissoes; 
    if BtClose = '' then
      BtClose := Const_Prof_BtFechar;
    if PromptDelete = '' then
      PromptDelete := Const_Prof_ConfirmaExcluir;
    if PromptDelete_WindowCaption = '' then
      PromptDelete_WindowCaption := Const_Prof_ConfirmaDelete_WindowCaption; //added by fduenas
  end;

  with DestSettings.AddChangeUser do
  begin
    if WindowCaption = '' then
      WindowCaption := Const_Inc_WindowCaption;
    if LabelAdd = '' then
      LabelAdd := Const_Inc_LabelAdicionar;
    if LabelChange = '' then
      LabelChange := Const_Inc_LabelAlterar;
    if LabelName = '' then
      LabelName := Const_Inc_LabelNome;
    if LabelLogin = '' then
      LabelLogin := Const_Inc_LabelLogin;
    if LabelEmail = '' then
      LabelEmail := Const_Inc_LabelEmail;
    if LabelPerfil = '' then
      LabelPerfil := Const_Inc_LabelPerfil;
    if CheckPrivileged = '' then
      CheckPrivileged := Const_Inc_CheckPrivilegiado;
    if BtSave = '' then
      BtSave := Const_Inc_BtGravar;
    if BtCancel = '' then
      BtCancel := Const_Inc_BtCancelar;
  end;

  with DestSettings.AddChangeProfile do
  begin
    if WindowCaption = '' then
      WindowCaption := Const_PInc_WindowCaption;
    if LabelAdd = '' then
      LabelAdd := Const_PInc_LabelAdicionar;
    if LabelChange = '' then
      LabelChange := Const_PInc_LabelAlterar;
    if LabelName = '' then
      LabelName := Const_PInc_LabelNome;
    if BtSave = '' then
      BtSave := Const_PInc_BtGravar;
    if BtCancel = '' then
      BtCancel := Const_PInc_BtCancelar;
  end;

  with DestSettings.Rights do
  begin
    if WindowCaption = '' then
      WindowCaption := Const_Perm_WindowCaption;
    if LabelUser = '' then
      LabelUser := Const_Perm_LabelUsuario;
    if LabelProfile = '' then
      LabelProfile := Const_Perm_LabelPerfil;
    if PageMenu = '' then
      PageMenu := Const_Perm_PageMenu;
    if PageActions = '' then
      PageActions := Const_Perm_PageActions;
    If PageControls = '' then
      PageControls := Const_Perm_PageControls; // by vicente barros leonel
    if BtUnlock = '' then
      BtUnlock := Const_Perm_BtLibera;
    if BtLock = '' then
      BtLock := Const_Perm_BtBloqueia;
    if BtSave = '' then
      BtSave := Const_Perm_BtGravar;
    if BtCancel = '' then
      BtCancel := Const_Perm_BtCancelar;
  end;

  with DestSettings.ChangePassword do
  begin
    if WindowCaption = '' then
      WindowCaption := Const_Troc_WindowCaption;
    if LabelDescription = '' then
      LabelDescription := Const_Troc_LabelDescricao;
    if LabelCurrentPassword = '' then
      LabelCurrentPassword := Const_Troc_LabelSenhaAtual;
    if LabelNewPassword = '' then
      LabelNewPassword := Const_Troc_LabelNovaSenha;
    if LabelConfirm = '' then
      LabelConfirm := Const_Troc_LabelConfirma;
    if BtSave = '' then
      BtSave := Const_Troc_BtGravar;
    if BtCancel = '' then
      BtCancel := Const_Troc_BtCancelar;
  end;

  with DestSettings.CommonMessages.ChangePasswordError do
  begin
    if InvalidCurrentPassword = '' then
      InvalidCurrentPassword := Const_ErrPass_SenhaAtualInvalida;
    if NewPasswordError = '' then
      NewPasswordError := Const_ErrPass_ErroNovaSenha;
    if NewEqualCurrent = '' then
      NewEqualCurrent := Const_ErrPass_NovaIgualAtual;
    if PasswordRequired = '' then
      PasswordRequired := Const_ErrPass_SenhaObrigatoria;
    if MinPasswordLength = '' then
      MinPasswordLength := Const_ErrPass_SenhaMinima;
    if InvalidNewPassword = '' then
      InvalidNewPassword := Const_ErrPass_SenhaInvalida;
  end;

  with DestSettings.ResetPassword do
  begin
    if WindowCaption = '' then
      WindowCaption := Const_DefPass_WindowCaption;
    if LabelPassword = '' then
      LabelPassword := Const_DefPass_LabelSenha;
  end;

  with DestSettings.Log do
  begin
    if WindowCaption = '' then
      WindowCaption := Const_LogC_WindowCaption;
    if LabelDescription = '' then
      LabelDescription := Const_LogC_LabelDescricao;
    if LabelUser = '' then
      LabelUser := Const_LogC_LabelUsuario;
    if LabelDate = '' then
      LabelDate := Const_LogC_LabelData;
    if LabelLevel = '' then
      LabelLevel := Const_LogC_LabelNivel;
    if ColLevel = '' then
      ColLevel := Const_LogC_ColunaNivel;
    if ColAppID = '' then
      ColAppID := Const_LogC_ColunaAppID;
    if ColMessage = '' then
      ColMessage := Const_LogC_ColunaMensagem;
    if ColUser = '' then
      ColUser := Const_LogC_ColunaUsuario;
    if ColDate = '' then
      ColDate := Const_LogC_ColunaData;
    if BtFilter = '' then
      BtFilter := Const_LogC_BtFiltro;
    if BtDelete = '' then
      BtDelete := Const_LogC_BtExcluir;
    if BtClose = '' then
      BtClose := Const_LogC_BtFechar;
    if PromptDelete = '' then
      PromptDelete := Const_LogC_ConfirmaExcluir;
    if PromptDelete_WindowCaption = '' then
      PromptDelete_WindowCaption := Const_LogC_ConfirmaDelete_WindowCaption; //added by fduenas
    if OptionUserAll = '' then
      OptionUserAll := Const_LogC_Todos; //added by fduenas
    if OptionLevelLow = '' then
      OptionLevelLow := Const_LogC_Low; //added by fduenas
    if OptionLevelNormal = '' then
      OptionLevelNormal := Const_LogC_Normal; //added by fduenas
    if OptionLevelHigh = '' then
      OptionLevelHigh := Const_LogC_High; //added by fduenas
    if OptionLevelCritic = '' then
      OptionLevelCritic := Const_LogC_Critic; //added by fduenas
    if DeletePerformed = '' then
      DeletePerformed := Const_LogC_ExcluirEfectuada; //added by fduenas
  end;

  with DestSettings.AppMessages do
  begin
    if MsgsForm_BtNew = '' then
      MsgsForm_BtNew := Const_Msgs_BtNew;
    if MsgsForm_BtReplay = '' then
      MsgsForm_BtReplay := Const_Msgs_BtReplay;
    if MsgsForm_BtForward = '' then
      MsgsForm_BtForward := Const_Msgs_BtForward;
    if MsgsForm_BtDelete = '' then
      MsgsForm_BtDelete := Const_Msgs_BtDelete;
    if MsgsForm_BtClose = '' then
      MsgsForm_BtDelete := Const_Msgs_BtClose; //added by fduenas
    if MsgsForm_WindowCaption = '' then
      MsgsForm_WindowCaption := Const_Msgs_WindowCaption;
    if MsgsForm_ColFrom = '' then
      MsgsForm_ColFrom := Const_Msgs_ColFrom;
    if MsgsForm_ColSubject = '' then
      MsgsForm_ColSubject := Const_Msgs_ColSubject;
    if MsgsForm_ColDate = '' then
      MsgsForm_ColDate := Const_Msgs_ColDate;
    if MsgsForm_PromptDelete = '' then
      MsgsForm_PromptDelete := Const_Msgs_PromptDelete;
    if MsgsForm_PromptDelete_WindowCaption = '' then
      MsgsForm_PromptDelete_WindowCaption := Const_Msgs_PromptDelete_WindowCaption;
    if MsgsForm_NoMessagesSelected = '' then
      MsgsForm_NoMessagesSelected := Const_Msgs_NoMessagesSelected;
    if MsgsForm_NoMessagesSelected_WindowCaption = '' then
      MsgsForm_NoMessagesSelected_WindowCaption := Const_Msgs_NoMessagesSelected_WindowCaption;
    if MsgRec_BtClose = '' then
      MsgRec_BtClose := Const_MsgRec_BtClose;
    if MsgRec_WindowCaption = '' then
      MsgRec_WindowCaption := Const_MsgRec_WindowCaption;
    if MsgRec_Title = '' then
      MsgRec_Title := Const_MsgRec_Title;
    if MsgRec_LabelFrom = '' then
      MsgRec_LabelFrom := Const_MsgRec_LabelFrom;
    if MsgRec_LabelDate = '' then
      MsgRec_LabelDate := Const_MsgRec_LabelDate;
    if MsgRec_LabelSubject = '' then
      MsgRec_LabelSubject := Const_MsgRec_LabelSubject;
    if MsgRec_LabelMessage = '' then
      MsgRec_LabelMessage := Const_MsgRec_LabelMessage;
    if MsgSend_BtSend = '' then
      MsgSend_BtSend := Const_MsgSend_BtSend;
    if MsgSend_BtCancel = '' then
      MsgSend_BtCancel := Const_MsgSend_BtCancel;
    if MsgSend_WindowCaption = '' then
      MsgSend_WindowCaption := Const_MsgSend_WindowCaption;
    if MsgSend_Title = '' then
      MsgSend_Title := Const_MsgSend_Title;
    if MsgSend_GroupTo = '' then
      MsgSend_GroupTo := Const_MsgSend_GroupTo;
    if MsgSend_RadioUser = '' then
      MsgSend_RadioUser := Const_MsgSend_RadioUser;
    if MsgSend_RadioAll = '' then
      MsgSend_RadioAll := Const_MsgSend_RadioAll;
    if MsgSend_GroupMessage = '' then
      MsgSend_GroupMessage := Const_MsgSend_GroupMessage;
    if MsgSend_LabelSubject = '' then
      MsgSend_LabelSubject := Const_MsgSend_LabelSubject; //added by fduenas
    if MsgSend_LabelMessageText = '' then
      MsgSend_LabelMessageText := Const_MsgSend_LabelMessageText; //added by fduenas
  end;

  DestSettings.WindowsPosition := poMainFormCenter;
end;

procedure IniSettings2(DestSettings: TUCSettings);
var
  tmp: TBitmap;
begin
  with DestSettings.CommonMessages do
  begin
    if BlankPassword = '' then
      BlankPassword := Const_Men_SenhaDesabitada;
    if PasswordChanged = '' then
      PasswordChanged := Const_Men_SenhaAlterada;
    if InitialMessage.Text = '' then
      InitialMessage.Text := Const_Men_MsgInicial;
    if MaxLoginAttemptsError = '' then
      MaxLoginAttemptsError := Const_Men_MaxTentativas;
    if InvalidLogin = '' then
      InvalidLogin := Const_Men_LoginInvalido;
    if AutoLogonError = '' then
      AutoLogonError := Const_Men_AutoLogonError;
    if UsuarioExiste = '' then
      UsuarioExiste := Const_Men_UsuarioExiste;
    if PasswordExpired  = '' then
      PasswordExpired := Const_Men_PasswordExpired; // by vicente barros leonel      
  end;

  with DestSettings.Login do
  begin
    if BtCancel = '' then
      BtCancel := Const_Log_BtCancelar;
    if BtOK = '' then
      BtOK := Const_Log_BtOK;
    if LabelPassword = '' then
      LabelPassword := Const_Log_LabelSenha;
    if LabelUser = '' then
      LabelUser := Const_Log_LabelUsuario;
    if WindowCaption = '' then
      WindowCaption := Const_Log_WindowCaption;
      
    if LabelTentativa = '' then
      LabelTentativa := Const_Log_LabelTentativa;
    if LabelTentativas = '' then
      LabelTentativas := Const_Log_LabelTentativas;

    try
      Tmp := TBitmap.Create;
      Tmp.LoadFromResourceName(HInstance, 'UCLOCKLOGIN');
      LeftImage.Assign(tmp);
    finally
      FreeAndNil(tmp);
    end;
  end;

  with DestSettings.UsersForm do
  begin
    if WindowCaption = '' then
      WindowCaption := Const_Cad_WindowCaption;
    if LabelDescription = '' then
      LabelDescription := Const_Cad_LabelDescricao;
    if ColName = '' then
      ColName := Const_Cad_ColunaNome;
    if ColLogin = '' then
      ColLogin := Const_Cad_ColunaLogin;
    if ColEmail = '' then
      ColEmail := Const_Cad_ColunaEmail;
    if BtAdd = '' then
      BtAdd := Const_Cad_BtAdicionar;
    if BtChange = '' then
      BtChange := Const_Cad_BtAlterar;
    if BtDelete = '' then
      BtDelete := Const_Cad_BtExcluir;
    if BtRights = '' then
      BtRights := Const_Cad_BtPermissoes;
    if BtPassword = '' then
      BtPassword := Const_Cad_BtSenha;
    if BtClose = '' then
      BtClose := Const_Cad_BtFechar;
    if PromptDelete = '' then
      PromptDelete := Const_Cad_ConfirmaExcluir;
    if PromptDelete_WindowCaption = '' then
      PromptDelete_WindowCaption := Const_Cad_ConfirmaDelete_WindowCaption; //added by fduenas
  end;

  with DestSettings.UsersProfile do
  begin
    if WindowCaption = '' then
      WindowCaption := Const_Prof_WindowCaption;
    if LabelDescription = '' then
      LabelDescription := Const_Prof_LabelDescricao;
    if ColProfile = '' then
      ColProfile := Const_Prof_ColunaNome;
    if BtAdd = '' then
      BtAdd := Const_Prof_BtAdicionar;
    if BtChange = '' then
      BtChange := Const_Prof_BtAlterar;
    if BtDelete = '' then
      BtDelete := Const_Prof_BtExcluir;
    if BtRights = '' then
      BtRights := Const_Prof_BtPermissoes;
    if BtClose = '' then
      BtClose := Const_Prof_BtFechar;
    if PromptDelete = '' then
      PromptDelete := Const_Prof_ConfirmaExcluir;
    if PromptDelete_WindowCaption = '' then
      PromptDelete_WindowCaption := Const_Prof_ConfirmaDelete_WindowCaption; //added by fduenas
  end;

  with DestSettings.AddChangeUser do
  begin
    if WindowCaption = '' then
      WindowCaption := Const_Inc_WindowCaption;
    if LabelAdd = '' then
      LabelAdd := Const_Inc_LabelAdicionar;
    if LabelChange = '' then
      LabelChange := Const_Inc_LabelAlterar;
    if LabelName = '' then
      LabelName := Const_Inc_LabelNome;
    if LabelLogin = '' then
      LabelLogin := Const_Inc_LabelLogin;
    if LabelEmail = '' then
      LabelEmail := Const_Inc_LabelEmail;
    if CheckPrivileged = '' then
      CheckPrivileged := Const_Inc_CheckPrivilegiado;
    if BtSave = '' then
      BtSave := Const_Inc_BtGravar;
    if BtCancel = '' then
      BtCancel := Const_Inc_BtCancelar;
    if LabelPerfil = '' then
      LabelPerfil := Const_Inc_LabelPerfil;
  end;

  with DestSettings.AddChangeProfile do
  begin
    if WindowCaption = '' then
      WindowCaption := Const_PInc_WindowCaption;
    if LabelAdd = '' then
      LabelAdd := Const_PInc_LabelAdicionar;
    if LabelChange = '' then
      LabelChange := Const_PInc_LabelAlterar;
    if LabelName = '' then
      LabelName := Const_PInc_LabelNome;
    if BtSave = '' then
      BtSave := Const_PInc_BtGravar;
    if BtCancel = '' then
      BtCancel := Const_PInc_BtCancelar;
  end;

  with DestSettings.Rights do
  begin
    if WindowCaption = '' then
      WindowCaption := Const_Perm_WindowCaption;
    if LabelUser = '' then
      LabelUser := Const_Perm_LabelUsuario;
    if LabelProfile = '' then
      LabelProfile := Const_Perm_LabelPerfil;
    if PageMenu = '' then
      PageMenu := Const_Perm_PageMenu;
    if PageActions = '' then
      PageActions := Const_Perm_PageActions;
    If PageControls = '' then
      PageControls := Const_Perm_PageControls; // by vicente barros leonel
    if BtUnlock = '' then
      BtUnlock := Const_Perm_BtLibera;
    if BtLock = '' then
      BtLock := Const_Perm_BtBloqueia;
    if BtSave = '' then
      BtSave := Const_Perm_BtGravar;
    if BtCancel = '' then
      BtCancel := Const_Perm_BtCancelar;
  end;

  with DestSettings.ChangePassword do
  begin
    if WindowCaption = '' then
      WindowCaption := Const_Troc_WindowCaption;
    if LabelDescription = '' then
      LabelDescription := Const_Troc_LabelDescricao;
    if LabelCurrentPassword = '' then
      LabelCurrentPassword := Const_Troc_LabelSenhaAtual;
    if LabelNewPassword = '' then
      LabelNewPassword := Const_Troc_LabelNovaSenha;
    if LabelConfirm = '' then
      LabelConfirm := Const_Troc_LabelConfirma;
    if BtSave = '' then
      BtSave := Const_Troc_BtGravar;
    if BtCancel = '' then
      BtCancel := Const_Troc_BtCancelar;
  end;

  with DestSettings.CommonMessages.ChangePasswordError do
  begin
    if InvalidCurrentPassword = '' then
      InvalidCurrentPassword := Const_ErrPass_SenhaAtualInvalida;
    if NewPasswordError = '' then
      NewPasswordError := Const_ErrPass_ErroNovaSenha;
    if NewEqualCurrent = '' then
      NewEqualCurrent := Const_ErrPass_NovaIgualAtual;
    if PasswordRequired = '' then
      PasswordRequired := Const_ErrPass_SenhaObrigatoria;
    if MinPasswordLength = '' then
      MinPasswordLength := Const_ErrPass_SenhaMinima;
    if InvalidNewPassword = '' then
      InvalidNewPassword := Const_ErrPass_SenhaInvalida;
  end;

  with DestSettings.ResetPassword do
  begin
    if WindowCaption = '' then
      WindowCaption := Const_DefPass_WindowCaption;
    if LabelPassword = '' then
      LabelPassword := Const_DefPass_LabelSenha;
  end;

  with DestSettings.Log do
  begin
    if WindowCaption = '' then
      WindowCaption := Const_LogC_WindowCaption;
    if LabelDescription = '' then
      LabelDescription := Const_LogC_LabelDescricao;
    if LabelUser = '' then
      LabelUser := Const_LogC_LabelUsuario;
    if LabelDate = '' then
      LabelDate := Const_LogC_LabelData;
    if LabelLevel = '' then
      LabelLevel := Const_LogC_LabelNivel;
    if ColLevel = '' then
      ColLevel := Const_LogC_ColunaNivel;
    if ColAppID = '' then
      ColAppID := Const_LogC_ColunaAppID;
    if ColMessage = '' then
      ColMessage := Const_LogC_ColunaMensagem;
    if ColUser = '' then
      ColUser := Const_LogC_ColunaUsuario;
    if ColDate = '' then
      ColDate := Const_LogC_ColunaData;
    if BtFilter = '' then
      BtFilter := Const_LogC_BtFiltro;
    if BtDelete = '' then
      BtDelete := Const_LogC_BtExcluir;
    if BtClose = '' then
      BtClose := Const_LogC_BtFechar;
    if PromptDelete = '' then
      PromptDelete := Const_LogC_ConfirmaExcluir;
    if PromptDelete_WindowCaption = '' then
      PromptDelete_WindowCaption := Const_LogC_ConfirmaDelete_WindowCaption; //added by fduenas
    if OptionUserAll = '' then
      OptionUserAll := Const_LogC_Todos; //added by fduenas
    if OptionLevelLow = '' then
      OptionLevelLow := Const_LogC_Low; //added by fduenas
    if OptionLevelNormal = '' then
      OptionLevelNormal := Const_LogC_Normal; //added by fduenas
    if OptionLevelHigh = '' then
      OptionLevelHigh := Const_LogC_High; //added by fduenas
    if OptionLevelCritic = '' then
      OptionLevelCritic := Const_LogC_Critic; //added by fduenas
    if DeletePerformed = '' then
      DeletePerformed := Const_LogC_ExcluirEfectuada; //added by fduenas
  end;

  with DestSettings.AppMessages do
  begin
    if MsgsForm_BtNew = '' then
      MsgsForm_BtNew := Const_Msgs_BtNew;
    if MsgsForm_BtReplay = '' then
      MsgsForm_BtReplay := Const_Msgs_BtReplay;
    if MsgsForm_BtForward = '' then
      MsgsForm_BtForward := Const_Msgs_BtForward;
    if MsgsForm_BtDelete = '' then
      MsgsForm_BtDelete := Const_Msgs_BtDelete;
    if MsgsForm_BtClose = '' then
      MsgsForm_BtClose := Const_Msgs_BtClose; //added by fduenas
    if MsgsForm_WindowCaption = '' then
      MsgsForm_WindowCaption := Const_Msgs_WindowCaption;
    if MsgsForm_ColFrom = '' then
      MsgsForm_ColFrom := Const_Msgs_ColFrom;
    if MsgsForm_ColSubject = '' then
      MsgsForm_ColSubject := Const_Msgs_ColSubject;
    if MsgsForm_ColDate = '' then
      MsgsForm_ColDate := Const_Msgs_ColDate;
    if MsgsForm_PromptDelete = '' then
      MsgsForm_PromptDelete := Const_Msgs_PromptDelete;
    if MsgsForm_PromptDelete_WindowCaption = '' then
      MsgsForm_PromptDelete_WindowCaption := Const_Msgs_PromptDelete_WindowCaption; //added by fduenas
    if MsgsForm_NoMessagesSelected = '' then
      MsgsForm_NoMessagesSelected := Const_Msgs_NoMessagesSelected; //added by fduenas
    if MsgsForm_NoMessagesSelected_WindowCaption = '' then
      MsgsForm_NoMessagesSelected_WindowCaption := Const_Msgs_NoMessagesSelected_WindowCaption; //added by fduenas
    if MsgRec_BtClose = '' then
      MsgRec_BtClose := Const_MsgRec_BtClose;
    if MsgRec_WindowCaption = '' then
      MsgRec_WindowCaption := Const_MsgRec_WindowCaption;
    if MsgRec_Title = '' then
      MsgRec_Title := Const_MsgRec_Title;
    if MsgRec_LabelFrom = '' then
      MsgRec_LabelFrom := Const_MsgRec_LabelFrom;
    if MsgRec_LabelDate = '' then
      MsgRec_LabelDate := Const_MsgRec_LabelDate;
    if MsgRec_LabelSubject = '' then
      MsgRec_LabelSubject := Const_MsgRec_LabelSubject;
    if MsgRec_LabelMessage = '' then
      MsgRec_LabelMessage := Const_MsgRec_LabelMessage;
    if MsgSend_BtSend = '' then
      MsgSend_BtSend := Const_MsgSend_BtSend;
    if MsgSend_BtCancel = '' then
      MsgSend_BtCancel := Const_MsgSend_BtCancel;
    if MsgSend_WindowCaption = '' then
      MsgSend_WindowCaption := Const_MsgSend_WindowCaption;
    if MsgSend_Title = '' then
      MsgSend_Title := Const_MsgSend_Title;
    if MsgSend_GroupTo = '' then
      MsgSend_GroupTo := Const_MsgSend_GroupTo;
    if MsgSend_RadioUser = '' then
      MsgSend_RadioUser := Const_MsgSend_RadioUser;
    if MsgSend_RadioAll = '' then
      MsgSend_RadioAll := Const_MsgSend_RadioAll;
    if MsgSend_GroupMessage = '' then
      MsgSend_GroupMessage := Const_MsgSend_GroupMessage;
    if MsgSend_LabelSubject = '' then
      MsgSend_LabelSubject := Const_MsgSend_LabelSubject; //added by fduenas
    if MsgSend_LabelMessageText = '' then
      MsgSend_LabelMessageText := Const_MsgSend_LabelMessageText; //added by fduenas
  end;

  DestSettings.WindowsPosition := poMainFormCenter;
end;

{$IFDEF DELPHI9_UP} {$ENDREGION} {$ENDIF}

{$IFDEF DELPHI9_UP} {$REGION 'TUCSettings'} {$ENDIF}

{ TUCSettings }

procedure TUCSettings.Assign(Source: TPersistent);
begin
  if Source is TUCUserSettings then
  begin
    Self.CommonMessages.Assign(TUCUserSettings(Source).CommonMessages); //modified by fduenas
    Self.AppMessages.Assign(TUCUserSettings(Source).AppMessages); //modified by fduenas
  end
  else
    inherited;
end;

constructor TUCSettings.Create(AOwner: TComponent);
begin
  inherited;

  FAppMessagesMSG     := TUCAppMessagesMSG.Create(nil);
  FLoginFormMSG       := TUCLoginFormMSG.Create(nil);
  FUserCommomMSG      := TUCUserCommonMSG.Create(nil);
  FCadUserFormMSG     := TUCCadUserFormMSG.Create(nil);
  FAddUserFormMSG     := TUCAddUserFormMSG.Create(nil);
  FAddProfileFormMSG  := TUCAddProfileFormMSG.Create(nil);
  FPermissFormMSG     := TUCPermissFormMSG.Create(nil);
  FProfileUserFormMSG := TUCProfileUserFormMSG.Create(nil);
  FTrocaSenhaFormMSG  := TUCTrocaSenhaFormMSG.Create(nil);
  FResetPassword      := TUCResetPassword.Create(nil);
  FLogControlFormMSG  := TUCLogControlFormMSG.Create(nil);

  if csDesigning in ComponentState then
    IniSettings2(Self);
end;

destructor TUCSettings.Destroy;
begin
  //added by fduenas
  FAppMessagesMSG.Free;
  FLoginFormMSG.Free;
  FUserCommomMSG.Free;
  FCadUserFormMSG.Free;
  FAddUserFormMSG.Free;
  FAddProfileFormMSG.Free;
  FPermissFormMSG.Free;
  FProfileUserFormMSG.Free;
  FTrocaSenhaFormMSG.Free;
  FResetPassword.Free;
  FLogControlFormMSG.Free;

  inherited;
end;

procedure TUCSettings.SetAppMessagesMSG(const Value: TUCAppMessagesMSG);
begin
  FAppMessagesMSG := Value;
end;

procedure TUCSettings.SetFAddProfileFormMSG(const Value: TUCAddProfileFormMSG);
begin
  FAddProfileFormMSG := Value;
end;

procedure TUCSettings.SetFAddUserFormMSG(const Value: TUCAddUserFormMSG);
begin
  FAddUserFormMSG := Value;
end;

procedure TUCSettings.SetFCadUserFormMSG(const Value: TUCCadUserFormMSG);
begin
  FCadUserFormMSG := Value;
end;

procedure TUCSettings.SetFFormLoginMsg(const Value: TUCLoginFormMSG);
begin
  FLoginFormMSG := Value;
end;

procedure TUCSettings.SetFLogControlFormMSG(const Value: TUCLogControlFormMSG);
begin
  FLogControlFormMSG := Value;
end;

procedure TUCSettings.SetFPermissFormMSG(const Value: TUCPermissFormMSG);
begin
  FPermissFormMSG := Value;
end;

procedure TUCSettings.SetFProfileUserFormMSG(const Value: TUCProfileUserFormMSG);
begin
  FProfileUserFormMSG := Value;
end;

procedure TUCSettings.SetFResetPassword(const Value: TUCResetPassword);
begin
  FResetPassword := Value;
end;

procedure TUCSettings.SetFTrocaSenhaFormMSG(const Value: TUCTrocaSenhaFormMSG);
begin
  FTrocaSenhaFormMSG := Value;
end;

procedure TUCSettings.SetFUserCommonMSg(const Value: TUCUserCommonMSG);
begin
  FUserCommomMSG := Value;
end;

{$IFDEF DELPHI9_UP} {$ENDREGION} {$ENDIF}

end.
