unit UCSettings;

interface

uses
  Classes,
  Forms,
  UCMessages,
  UcConsts_Language;

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
    fHistory: TUCHistoryMSG;
    fTypeFields: TUCFieldType;
    fLanguage: TUCLanguage;
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
    procedure SetfHistory(const Value: TUCHistoryMSG);
    procedure SetfLanguage(const Value: TUCLanguage);
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
    property History : TUCHistoryMSG read fHistory write SetfHistory;
    Property TypeFieldsDB : TUCFieldType read fTypeFields write fTypeFields;
    property WindowsPosition: TPosition read FPosition write FPosition default poMainFormCenter;
    Property Language : TUCLanguage read fLanguage write SetfLanguage;
  end;

procedure IniSettings (DestSettings: TUCUserSettings);
procedure IniSettings2(DestSettings: TUCSettings);

procedure AlterLanguage(DestSettings: TUCSettings);overload;

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
      BtAdd :=  Const_Prof_BtAdicionar;
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

    if CheckExpira = '' then
      CheckExpira := Const_Inc_CheckEspira;
    If Day = '' then
      Day := Const_Inc_Dia;
    If ExpiredIn = '' then
      ExpiredIn := Const_Inc_ExpiraEm;
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

  With DestSettings.History do
    Begin
      If Evento_Insert = '' then
        Evento_Insert := Const_Evento_Insert;
      if Evento_Delete = '' then
        Evento_Delete := Const_Evento_Delete;
      if Evento_Edit = '' then
        Evento_Edit := Const_Evento_Edit;
      If Evento_NewRecord = '' then
        Evento_NewRecord := Const_Evento_NewRecord;
      If Hist_all = '' then
        Hist_All := Const_Hist_All;
      If Msg_LimpHistorico = '' then
        Msg_LimpHistorico := Const_Msg_LimpHistorico;
      If Msg_MensConfirma = '' then
        Msg_MensConfirma := Const_Msg_MensConfirma;
      if Msg_LogEmptyHistory = '' then
        Msg_LogEmptyHistory := Const_Msg_LogEmptyHistory;
      if LabelDescricao = '' then
        LabelDescricao := Const_LabelDescricao;
      if LabelUser = '' then
        LabelUser := Const_LabelUser;
      if LabelForm = '' then
        LabelForm := Const_LabelForm;
      if LabelEvento = '' then
        LabelEvento := const_LabelEvento;
      if LabelTabela = '' then
        LabelTabela := const_LabelTabela;
      if LabelDataEvento = '' then
        LabelDataEvento := const_LabelDataEvento;
      if LabelHoraEvento = '' then
        LabelHoraEvento := const_LabelHoraEvento;
      if Msg_NewRecord = '' then
        Msg_NewRecord := const_Msg_NewRecord;
      if Hist_MsgExceptPropr = '' then
        Hist_MsgExceptPropr := Const_Hist_MsgExceptPropr;
      if Hist_BtnFiltro = '' then
        Hist_BtnFiltro := const_Hist_BtnFiltro;
      if Hist_BtnExcluir = '' then
        Hist_BtnExcluir := const_Hist_BtnExcluir;
      if Hist_BtnFechar = '' then
        Hist_BtnFechar := const_Hist_BtnFechar;
    End;

   With DestSettings.TypeFieldsDB do
     Begin
       If Type_VarChar = '' then
         Type_VarChar   := 'VarChar';
       if Type_Char = '' then
         Type_Char      := 'Char';
       if Type_Int = '' then
         Type_Int       := 'Int';
       if Type_MemoField = '' then
         Type_MemoField := 'BLOB SUB_TYPE 1 SEGMENT SIZE 1024';
     end;
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
      PromptDelete_WindowCaption := Const_Cad_ConfirmaDelete_WindowCaption;
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
      BtAdd := RetornaLingua( DestSettings.Language,'Const_Prof_BtAdicionar');
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

    if CheckExpira = '' then
      CheckExpira := Const_Inc_CheckEspira;
    If Day = '' then
      Day := Const_Inc_Dia;
    If ExpiredIn = '' then
      ExpiredIn := Const_Inc_ExpiraEm;
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

  With DestSettings.History do
    Begin
      If Evento_Insert = '' then
        Evento_Insert := Const_Evento_Insert;
      if Evento_Delete = '' then
        Evento_Delete := Const_Evento_Delete;
      if Evento_Edit = '' then
        Evento_Edit := Const_Evento_Edit;
      If Evento_NewRecord = '' then
        Evento_NewRecord := Const_Evento_NewRecord;
      If Hist_all = '' then
        Hist_All := Const_Hist_All;
      If Msg_LimpHistorico = '' then
        Msg_LimpHistorico := Const_Msg_LimpHistorico;
      If Msg_MensConfirma = '' then
        Msg_MensConfirma := Const_Msg_MensConfirma;
      if Msg_LogEmptyHistory = '' then
        Msg_LogEmptyHistory := Const_Msg_LogEmptyHistory;
      if LabelDescricao = '' then
        LabelDescricao := Const_LabelDescricao;
      if LabelUser = '' then
        LabelUser := Const_LabelUser;
      if LabelForm = '' then
        LabelForm := Const_LabelForm;
      if LabelEvento = '' then
        LabelEvento := const_LabelEvento;
      if LabelTabela = '' then
        LabelTabela := const_LabelTabela;
      if LabelDataEvento = '' then
        LabelDataEvento := const_LabelDataEvento;
      if LabelHoraEvento = '' then
        LabelHoraEvento := const_LabelHoraEvento;
      if Msg_NewRecord = '' then
        Msg_NewRecord := const_Msg_NewRecord;
      if Hist_MsgExceptPropr = '' then
        Hist_MsgExceptPropr := Const_Hist_MsgExceptPropr;
      if Hist_BtnFiltro = '' then
        Hist_BtnFiltro := const_Hist_BtnFiltro;
      if Hist_BtnExcluir = '' then
        Hist_BtnExcluir := const_Hist_BtnExcluir;
      if Hist_BtnFechar = '' then
        Hist_BtnFechar := const_Hist_BtnFechar;
    End;

   With DestSettings.TypeFieldsDB do
     Begin
       If Type_VarChar = '' then
         Type_VarChar   := 'VarChar';
       if Type_Char = '' then
         Type_Char      := 'Char';
       if Type_Int = '' then
         Type_Int       := 'Int';
       if Type_MemoField = '' then
         Type_MemoField := 'BLOB SUB_TYPE 1 SEGMENT SIZE 1024';
     end;
end;

{-------------------------------------------------------------------------------}

procedure AlterLanguage(DestSettings: TUCSettings);
begin
  with DestSettings.CommonMessages do
  begin
    BlankPassword := RetornaLingua( DestSettings.Language,'Const_Men_SenhaDesabitada');
    PasswordChanged := RetornaLingua( DestSettings.Language,'Const_Men_SenhaAlterada');
    InitialMessage.Text := RetornaLingua( DestSettings.Language,'Const_Men_MsgInicial');
    MaxLoginAttemptsError := RetornaLingua( DestSettings.Language,'Const_Men_MaxTentativas');
    InvalidLogin := RetornaLingua( DestSettings.Language,'Const_Men_LoginInvalido');
    AutoLogonError := RetornaLingua( DestSettings.Language,'Const_Men_AutoLogonError');
    UsuarioExiste := RetornaLingua( DestSettings.Language,'Const_Men_UsuarioExiste');
    PasswordExpired := RetornaLingua( DestSettings.Language,'Const_Men_PasswordExpired');
  end;

  with DestSettings.Login do
  begin
    BtCancel :=  RetornaLingua( DestSettings.Language,'Const_Log_BtCancelar');
    BtOK :=  RetornaLingua( DestSettings.Language,'Const_Log_BtOK');
    LabelPassword :=  RetornaLingua( DestSettings.Language,'Const_Log_LabelSenha');
    LabelUser := RetornaLingua( DestSettings.Language,'Const_Log_LabelUsuario');
    WindowCaption :=  RetornaLingua( DestSettings.Language,'Const_Log_WindowCaption');
    LabelTentativa :=  RetornaLingua( DestSettings.Language,'Const_Log_LabelTentativa');
    LabelTentativas :=  RetornaLingua( DestSettings.Language,'Const_Log_LabelTentativas');
  end;

  with DestSettings.UsersForm do
  begin
    WindowCaption :=  RetornaLingua( DestSettings.Language,'Const_Cad_WindowCaption');
    LabelDescription :=  RetornaLingua( DestSettings.Language,'Const_Cad_LabelDescricao');
    ColName :=  RetornaLingua( DestSettings.Language,'Const_Cad_ColunaNome');
    ColLogin :=  RetornaLingua( DestSettings.Language,'Const_Cad_ColunaLogin');
    ColEmail :=  RetornaLingua( DestSettings.Language,'Const_Cad_ColunaEmail');
    BtAdd :=  RetornaLingua( DestSettings.Language,'Const_Cad_BtAdicionar');
    BtChange :=  RetornaLingua( DestSettings.Language,'Const_Cad_BtAlterar');
    BtDelete :=  RetornaLingua( DestSettings.Language,'Const_Cad_BtExcluir');
    BtRights :=  RetornaLingua( DestSettings.Language,'Const_Cad_BtPermissoes');
    BtPassword :=  RetornaLingua( DestSettings.Language,'Const_Cad_BtSenha');
    BtClose :=  RetornaLingua( DestSettings.Language,'Const_Cad_BtFechar');
    PromptDelete := RetornaLingua( DestSettings.Language,'Const_Cad_ConfirmaExcluir');
    PromptDelete_WindowCaption := RetornaLingua( DestSettings.Language,'Const_Cad_ConfirmaDelete_WindowCaption');
  end;

  with DestSettings.UsersProfile do
  begin
    WindowCaption    := RetornaLingua( DestSettings.Language,'Const_Prof_WindowCaption');
    LabelDescription := RetornaLingua( DestSettings.Language,'Const_Prof_LabelDescricao');
    ColProfile       := RetornaLingua( DestSettings.Language,'Const_Prof_ColunaNome');
    BtAdd            := RetornaLingua( DestSettings.Language,'Const_Prof_BtAdicionar');
    BtChange         := RetornaLingua( DestSettings.Language,'Const_Prof_BtAlterar');
    BtDelete         := RetornaLingua( DestSettings.Language,'Const_Prof_BtExcluir');
    BtRights         := RetornaLingua( DestSettings.Language,'Const_Prof_BtPermissoes');
    BtClose          := RetornaLingua( DestSettings.Language,'Const_Prof_BtFechar');
    PromptDelete     := RetornaLingua( DestSettings.Language,'Const_Prof_ConfirmaExcluir');
    PromptDelete_WindowCaption := RetornaLingua( DestSettings.Language,'Const_Prof_ConfirmaDelete_WindowCaption');
  end;

  with DestSettings.AddChangeUser do
  begin
    WindowCaption := RetornaLingua( DestSettings.Language,'Const_Inc_WindowCaption');
    LabelAdd := RetornaLingua( DestSettings.Language,'Const_Inc_LabelAdicionar');
    LabelChange := RetornaLingua( DestSettings.Language,'Const_Inc_LabelAlterar');
    LabelName := RetornaLingua( DestSettings.Language,'Const_Inc_LabelNome');
    LabelLogin := RetornaLingua( DestSettings.Language,'Const_Inc_LabelLogin');
    LabelEmail := RetornaLingua( DestSettings.Language,'Const_Inc_LabelEmail');
    CheckPrivileged := RetornaLingua( DestSettings.Language,'Const_Inc_CheckPrivilegiado');
    BtSave := RetornaLingua( DestSettings.Language,'Const_Inc_BtGravar');
    BtCancel := RetornaLingua( DestSettings.Language,'Const_Inc_BtCancelar');
    LabelPerfil := RetornaLingua( DestSettings.Language,'Const_Inc_LabelPerfil');
    CheckExpira := RetornaLingua( DestSettings.Language,'Const_Inc_CheckEspira');
    Day := RetornaLingua( DestSettings.Language,'Const_Inc_Dia');
    ExpiredIn := RetornaLingua( DestSettings.Language,'Const_Inc_ExpiraEm');
  end;

  with DestSettings.AddChangeProfile do
  begin
      WindowCaption := RetornaLingua( DestSettings.Language,'Const_PInc_WindowCaption');
      LabelAdd := RetornaLingua( DestSettings.Language,'Const_PInc_LabelAdicionar');
      LabelChange := RetornaLingua( DestSettings.Language,'Const_PInc_LabelAlterar');
      LabelName := RetornaLingua( DestSettings.Language,'Const_PInc_LabelNome');
      BtSave := RetornaLingua( DestSettings.Language,'Const_PInc_BtGravar');
      BtCancel := RetornaLingua( DestSettings.Language,'Const_PInc_BtCancelar');
  end;

  with DestSettings.Rights do
  begin
      WindowCaption := RetornaLingua( DestSettings.Language,'Const_Perm_WindowCaption');
      LabelUser := RetornaLingua( DestSettings.Language,'Const_Perm_LabelUsuario');
      LabelProfile := RetornaLingua( DestSettings.Language,'Const_Perm_LabelPerfil');
      PageMenu := RetornaLingua( DestSettings.Language,'Const_Perm_PageMenu');
      PageActions := RetornaLingua( DestSettings.Language,'Const_Perm_PageActions');
      PageControls := RetornaLingua( DestSettings.Language,'Const_Perm_PageControls');
      BtUnlock := RetornaLingua( DestSettings.Language,'Const_Perm_BtLibera');
      BtLock := RetornaLingua( DestSettings.Language,'Const_Perm_BtBloqueia');
      BtSave := RetornaLingua( DestSettings.Language,'Const_Perm_BtGravar');
      BtCancel := RetornaLingua( DestSettings.Language,'Const_Perm_BtCancelar');
  end;

  with DestSettings.ChangePassword do
  begin
      WindowCaption := RetornaLingua( DestSettings.Language,'Const_Troc_WindowCaption');
      LabelDescription := RetornaLingua( DestSettings.Language,'Const_Troc_LabelDescricao');
      LabelCurrentPassword := RetornaLingua( DestSettings.Language,'Const_Troc_LabelSenhaAtual');
      LabelNewPassword := RetornaLingua( DestSettings.Language,'Const_Troc_LabelNovaSenha');
      LabelConfirm := RetornaLingua( DestSettings.Language,'Const_Troc_LabelConfirma');
      BtSave := RetornaLingua( DestSettings.Language,'Const_Troc_BtGravar');
      BtCancel := RetornaLingua( DestSettings.Language,'Const_Troc_BtCancelar');
  end;

  with DestSettings.CommonMessages.ChangePasswordError do
  begin
      InvalidCurrentPassword := RetornaLingua( DestSettings.Language,'Const_ErrPass_SenhaAtualInvalida');
      NewPasswordError := RetornaLingua( DestSettings.Language,'Const_ErrPass_ErroNovaSenha');
      NewEqualCurrent := RetornaLingua( DestSettings.Language,'Const_ErrPass_NovaIgualAtual');
      PasswordRequired := RetornaLingua( DestSettings.Language,'Const_ErrPass_SenhaObrigatoria');
      MinPasswordLength := RetornaLingua( DestSettings.Language,'Const_ErrPass_SenhaMinima');
      InvalidNewPassword := RetornaLingua( DestSettings.Language,'Const_ErrPass_SenhaInvalida');
  end;

  with DestSettings.ResetPassword do
  begin
      WindowCaption := RetornaLingua( DestSettings.Language,'Const_DefPass_WindowCaption');
      LabelPassword := RetornaLingua( DestSettings.Language,'Const_DefPass_LabelSenha');
  end;

  with DestSettings.Log do
  begin
      WindowCaption := RetornaLingua( DestSettings.Language,'Const_LogC_WindowCaption');
      LabelDescription := RetornaLingua( DestSettings.Language,'Const_LogC_LabelDescricao');
      LabelUser := RetornaLingua( DestSettings.Language,'Const_LogC_LabelUsuario');
      LabelDate := RetornaLingua( DestSettings.Language,'Const_LogC_LabelData');
      LabelLevel := RetornaLingua( DestSettings.Language,'Const_LogC_LabelNivel');
      ColLevel := RetornaLingua( DestSettings.Language,'Const_LogC_ColunaNivel');
      ColAppID := RetornaLingua( DestSettings.Language,'Const_LogC_ColunaAppID');
      ColMessage := RetornaLingua( DestSettings.Language,'Const_LogC_ColunaMensagem');
      ColUser := RetornaLingua( DestSettings.Language,'Const_LogC_ColunaUsuario');
      ColDate := RetornaLingua( DestSettings.Language,'Const_LogC_ColunaData');
      BtFilter := RetornaLingua( DestSettings.Language,'Const_LogC_BtFiltro');
      BtDelete := RetornaLingua( DestSettings.Language,'Const_LogC_BtExcluir');
      BtClose := RetornaLingua( DestSettings.Language,'Const_LogC_BtFechar');
      PromptDelete := RetornaLingua( DestSettings.Language,'Const_LogC_ConfirmaExcluir');
      PromptDelete_WindowCaption := RetornaLingua( DestSettings.Language,'Const_LogC_ConfirmaDelete_WindowCaption');
      OptionUserAll := RetornaLingua( DestSettings.Language,'Const_LogC_Todos');
      OptionLevelLow := RetornaLingua( DestSettings.Language,'Const_LogC_Low');
      OptionLevelNormal := RetornaLingua( DestSettings.Language,'Const_LogC_Normal');
      OptionLevelHigh := RetornaLingua( DestSettings.Language,'Const_LogC_High');
      OptionLevelCritic := RetornaLingua( DestSettings.Language,'Const_LogC_Critic');
      DeletePerformed := RetornaLingua( DestSettings.Language,'Const_LogC_ExcluirEfectuada');
  end;

  with DestSettings.AppMessages do
  begin
      MsgsForm_BtNew := RetornaLingua( DestSettings.Language,'Const_Msgs_BtNew');
      MsgsForm_BtReplay := RetornaLingua( DestSettings.Language,'Const_Msgs_BtReplay');
      MsgsForm_BtForward := RetornaLingua( DestSettings.Language,'Const_Msgs_BtForward');
      MsgsForm_BtDelete := RetornaLingua( DestSettings.Language,'Const_Msgs_BtDelete');
      MsgsForm_BtClose := RetornaLingua( DestSettings.Language,'Const_Msgs_BtClose'); //added by fduenas
      MsgsForm_WindowCaption := RetornaLingua( DestSettings.Language,'Const_Msgs_WindowCaption');
      MsgsForm_ColFrom := RetornaLingua( DestSettings.Language,'Const_Msgs_ColFrom');
      MsgsForm_ColSubject := RetornaLingua( DestSettings.Language,'Const_Msgs_ColSubject');
      MsgsForm_ColDate := RetornaLingua( DestSettings.Language,'Const_Msgs_ColDate');
      MsgsForm_PromptDelete := RetornaLingua( DestSettings.Language,'Const_Msgs_PromptDelete');
      MsgsForm_PromptDelete_WindowCaption := RetornaLingua( DestSettings.Language,'Const_Msgs_PromptDelete_WindowCaption'); //added by fduenas
      MsgsForm_NoMessagesSelected := RetornaLingua( DestSettings.Language,'Const_Msgs_NoMessagesSelected'); //added by fduenas
      MsgsForm_NoMessagesSelected_WindowCaption := RetornaLingua( DestSettings.Language,'Const_Msgs_NoMessagesSelected_WindowCaption'); //added by fduenas
      MsgRec_BtClose := RetornaLingua( DestSettings.Language,'Const_MsgRec_BtClose');
      MsgRec_WindowCaption := RetornaLingua( DestSettings.Language,'Const_MsgRec_WindowCaption');
      MsgRec_Title := RetornaLingua( DestSettings.Language,'Const_MsgRec_Title');
      MsgRec_LabelFrom := RetornaLingua( DestSettings.Language,'Const_MsgRec_LabelFrom');
      MsgRec_LabelDate := RetornaLingua( DestSettings.Language,'Const_MsgRec_LabelDate');
      MsgRec_LabelSubject := RetornaLingua( DestSettings.Language,'Const_MsgRec_LabelSubject');
      MsgRec_LabelMessage := RetornaLingua( DestSettings.Language,'Const_MsgRec_LabelMessage');
      MsgSend_BtSend := RetornaLingua( DestSettings.Language,'Const_MsgSend_BtSend');
      MsgSend_BtCancel := RetornaLingua( DestSettings.Language,'Const_MsgSend_BtCancel');
      MsgSend_WindowCaption := RetornaLingua( DestSettings.Language,'Const_MsgSend_WindowCaption');
      MsgSend_Title := RetornaLingua( DestSettings.Language,'Const_MsgSend_Title');
      MsgSend_GroupTo := RetornaLingua( DestSettings.Language,'Const_MsgSend_GroupTo');
      MsgSend_RadioUser := RetornaLingua( DestSettings.Language,'Const_MsgSend_RadioUser');
      MsgSend_RadioAll := RetornaLingua( DestSettings.Language,'Const_MsgSend_RadioAll');
      MsgSend_GroupMessage := RetornaLingua( DestSettings.Language,'Const_MsgSend_GroupMessage');
      MsgSend_LabelSubject := RetornaLingua( DestSettings.Language,'Const_MsgSend_LabelSubject'); //added by fduenas
      MsgSend_LabelMessageText := RetornaLingua( DestSettings.Language,'Const_MsgSend_LabelMessageText'); //added by fduenas
  end;

  DestSettings.WindowsPosition := poMainFormCenter;

  With DestSettings.History do
    Begin
        Evento_Insert := RetornaLingua( DestSettings.Language,'Const_Evento_Insert');
        Evento_Delete := RetornaLingua( DestSettings.Language,'Const_Evento_Delete');
        Evento_Edit := RetornaLingua( DestSettings.Language,'Const_Evento_Edit');
        Evento_NewRecord := RetornaLingua( DestSettings.Language,'Const_Evento_NewRecord');
        Hist_All := RetornaLingua( DestSettings.Language,'Const_Hist_All');
        Msg_LimpHistorico := RetornaLingua( DestSettings.Language,'Const_Msg_LimpHistorico');
        Msg_MensConfirma := RetornaLingua( DestSettings.Language,'Const_Msg_MensConfirma');
        Msg_LogEmptyHistory := RetornaLingua( DestSettings.Language,'Const_Msg_LogEmptyHistory');
        LabelDescricao := RetornaLingua( DestSettings.Language,'Const_LabelDescricao');
        LabelUser := RetornaLingua( DestSettings.Language,'Const_LabelUser');
        LabelForm := RetornaLingua( DestSettings.Language,'Const_LabelForm');
        LabelEvento := RetornaLingua( DestSettings.Language,'const_LabelEvento');
        LabelTabela := RetornaLingua( DestSettings.Language,'const_LabelTabela');
        LabelDataEvento := RetornaLingua( DestSettings.Language,'const_LabelDataEvento');
        LabelHoraEvento := RetornaLingua( DestSettings.Language,'const_LabelHoraEvento');
        Msg_NewRecord := RetornaLingua( DestSettings.Language,'const_Msg_NewRecord');
        Hist_MsgExceptPropr := RetornaLingua( DestSettings.Language,'Const_Hist_MsgExceptPropr');
        Hist_BtnFiltro := RetornaLingua( DestSettings.Language,'const_Hist_BtnFiltro');
        Hist_BtnExcluir := RetornaLingua( DestSettings.Language,'const_Hist_BtnExcluir');
        Hist_BtnFechar := RetornaLingua( DestSettings.Language,'const_Hist_BtnFechar');
    End;
end;

{-------------------------------------------------------------------------------}

{$IFDEF DELPHI9_UP} {$ENDREGION} {$ENDIF}

{$IFDEF DELPHI9_UP} {$REGION 'TUCSettings'} {$ENDIF}

{ TUCSettings }

procedure TUCSettings.Assign(Source: TPersistent);
begin
  if Source is TUCUserSettings then
  begin
    Self.CommonMessages.Assign(TUCUserSettings(Source).CommonMessages); //modified by fduenas
    Self.AppMessages.Assign(TUCUserSettings(Source).AppMessages); //modified by fduenas
    Self.WindowsPosition := WindowsPosition;
  end
  else
    inherited;
end;

constructor TUCSettings.Create(AOwner: TComponent);
begin
  inherited;
  fLanguage           := ucPortuguesBr;       
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
  fHistory            := TUCHistoryMSG.Create(Nil);
  fTypeFields         := TUCFieldType.Create(Nil);
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
  fHistory.Free;
  fTypeFields.Free;
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

procedure TUCSettings.SetfHistory(const Value: TUCHistoryMSG);
begin
  fHistory := Value;
end;

procedure TUCSettings.SetfLanguage(const Value: TUCLanguage);
begin
  fLanguage := Value;
  AlterLanguage(Self);
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
