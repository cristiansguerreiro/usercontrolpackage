{-----------------------------------------------------------------------------
 Unit Name: UCBase
 Author:    QmD
 changed:   06-dez-2004
 Purpose:   Main Unit
 History:   included delphi 2005 support
-----------------------------------------------------------------------------}

(*

  Ves�es do Delphi

  VER120 = Delphi4
  VER130 = Delphi5
  VER140 = Delphi6
  VER150 = Delphi7
  VER160 = Delphi8
  VER170 = BDS2005
  VER180 = BDS2006

*)

unit UCBase;

interface

{$I 'UserControl.inc'}

uses
  ExtActns,
  Variants,
  Windows,
  {.$IFDEF UCACTMANAGER}
  ActnMan,
  ActnMenus,
  {.$ENDIF}
  ActnList,
  Classes,
  Controls,
  DB,
  Forms,
  Graphics,
  md5,
  Menus,
  SysUtils,
  UCDataConnector,
  UCDataInfo,
  {.$IFDEF Indy}
  UCMail,
  {.$ENDIF}
  UCMessages,
  UCSettings;

const
  llBaixo   = 0;
  llNormal  = 1;
  llMedio   = 2;
  llCritico = 3;

// Version
const
  UCVersion = '2.20RC3';

type
  // Pensando em usar GUID para gerar a chave das tabelas !!!!
  TUCGUID = class
    //Creates and returns a new globally unique identifier
    class function NovoGUID: TGUID;
    //sometimes we need to have an "empty" value, like NULL
    class function EmptyGUID: TGUID;
    //Checks whether a Guid is EmptyGuid
    class function IsEmptyGUID(GUID: TGUID): Boolean;
    //Convert to string
    class function ToString(GUID: TGUID): String;
    //convert to quoted string
    class function ToQuotedString(GUID: TGUID): String;
    //return a GUID from string
    class function FromString(Value: String): TGUID;
    //Indicates whether two TGUID values are the same
    class function EqualGUIDs(GUID1, GUID2: TGUID): Boolean;
    //Creates and returns a new globally unique identifier string
    class function NovoGUIDString: String;
  end;

  TUCAboutVar = String;

  //classe para armazenar usuario logado = currentuser
  TUCCurrentUser = class(TComponent)
  private
    FPerfilUsuario: TDataSet;
    FPerfilGrupo:   TDataSet;
  public
    UserID:         Integer;
    Profile:        Integer;
    UserIDOld:      Integer;
    IdLogon:        String;
    UserName:       String;
    UserLogin:      String;
    Password:       String;
    Email:          String;
    DateExpiration: TDateTime;
    Privileged:     Boolean;
  published
    { TODO 1 -oLuiz -cUpgrade : Terminar a implementa��o dos DataSets para os Perfis de Usuario Loggado }
    property PerfilUsuario: TDataSet read FPerfilUsuario write FPerfilUsuario;
    property PerfilGrupo: TDataSet read FPerfilGrupo write FPerfilGrupo;
  end;

  TUCUser = class(TPersistent) // armazenar menuitem ou action responsavel pelo cadastro de usuarios
  private
    FAction:               TAction;
    FMenuItem:             TMenuItem;
    FUsePrivilegedField:   Boolean;
    FProtectAdministrator: Boolean;
    procedure SetAction(const Value: TAction);
    procedure SetMenuItem(const Value: TMenuItem);
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Action: TAction read FAction write SetAction;
    property MenuItem: TMenuItem read FMenuItem write SetMenuItem;
    property UsePrivilegedField: Boolean read FUsePrivilegedField write FUsePrivilegedField default False;
    property ProtectAdministrator: Boolean read FProtectAdministrator write FProtectAdministrator default True;
  end;

  TUCUserProfile = class(TPersistent) // armazenar menuitem ou action responsavel pelo Perfil de usuarios
  private
    FAtive:    Boolean;
    FAction:   TAction;
    FMenuItem: TMenuItem;
    procedure SetAction(const Value: TAction);
    procedure SetMenuItem(const Value: TMenuItem);
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Active: Boolean read FAtive write FAtive default True;
    property Action: TAction read FAction write SetAction;
    property MenuItem: TMenuItem read FMenuItem write SetMenuItem;
  end;

  TUCUserPasswordChange = class(TPersistent) // armazenar menuitem ou action responsavel pelo Form trocar senha
  private
    FForcePassword:     Boolean;
    FMinPasswordLength: Integer;
    FAction:            TAction;
    FMenuItem:          TMenuItem;
    procedure SetAction(const Value: TAction);
    procedure SetMenuItem(const Value: TMenuItem);
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Action: TAction read FAction write SetAction;
    property MenuItem: TMenuItem read FMenuItem write SetMenuItem;
    property ForcePassword: Boolean read FForcePassword write FForcePassword default False;
    property MinPasswordLength: Integer read FMinPasswordLength write FMinPasswordLength default 0;
  end;

  TUCAutoLogin = class(TPersistent) // armazenar configuracao de Auto-Logon
  private
    FActive:         Boolean;
    FUser:           String;
    FPassword:       String;
    FMessageOnError: Boolean;
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Active: Boolean read FActive write FActive default False;
    property User: String read FUser write FUser;
    property Password: String read FPassword write FPassword;
    property MessageOnError: Boolean read FMessageOnError write FMessageOnError default True;
  end;

  TUCInitialLogin = class(TPersistent) // armazenar Dados do Login que sera criado na primeira execucao do programa.
  private
    FUser:          String;
    FPassword:      String;
    FInitialRights: TStrings;
    FEmail:         String;
    procedure SetInitialRights(const Value: TStrings);
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property User: String read FUser write FUser;
    property Email: String read FEmail write FEmail;
    property Password: String read FPassword write FPassword;
    property InitialRights: TStrings read FInitialRights write SetInitialRights;
  end;

  TUCGetLoginName = (lnNone, lnUserName, lnMachineName);

  TUCLogin = class(TPersistent)
  private
    FAutoLogin:        TUCAutoLogin;
    FMaxLoginAttempts: Integer;
    FInitialLogin:     TUCInitialLogin;
    FGetLoginName:     TUCGetLoginName;
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property AutoLogin: TUCAutoLogin read FAutoLogin write FAutoLogin;
    property InitialLogin: TUCInitialLogin read FInitialLogin write FInitialLogin;
    property MaxLoginAttempts: Integer read FMaxLoginAttempts write FMaxLoginAttempts;
    property GetLoginName: TUCGetLoginName read FGetLoginName write FGetLoginName default lnNone;
  end;

  TUCNotAllowedItems = class(TPersistent) // Ocultar e/ou Desabilitar os itens que o usuario nao tem acesso
  private
    FMenuVisible:   Boolean;
    FActionVisible: Boolean;
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property MenuVisible: Boolean read FMenuVisible write FMenuVisible default True;
    property ActionVisible: Boolean read FActionVisible write FActionVisible default True;
  end;

  TUCLogControl = class(TPersistent) // Responsavel pelo Controle de Log
  private
    FActive:   Boolean;
    FTableLog: String;
    FMenuItem: TMenuItem;
    FAction:   TAction;
    procedure SetMenuItem(const Value: TMenuItem);
    procedure SetAction(const Value: TAction);
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Action: TAction read FAction write SetAction;
    property Active: Boolean read FActive write FActive default True;
    property TableLog: String read FTableLog write FTableLog;
    property MenuItem: TMenuItem read FMenuItem write SetMenuItem;
  end;

  TUCControlRight = class(TPersistent) // Menu / ActionList/ActionManager ou ActionMainMenuBar a serem Controlados
  private
    FActionList:        TActionList;
    FActionManager:     TActionManager;
    FActionMainMenuBar: TActionMainMenuBar;
    FMainMenu:          TMenu;
    procedure SetActionList(const Value: TActionList);
    procedure SetActionManager(const Value: TActionManager);
    procedure SetActionMainMenuBar(const Value: TActionMainMenuBar);
    procedure SetMainMenu(const Value: TMenu);
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property ActionList: TActionList read FActionList write SetActionList;
    property MainMenu: TMenu read FMainMenu write SetMainMenu;
    property ActionManager: TActionManager read FActionManager write SetActionManager;
    property ActionMainMenuBar: TActionMainMenuBar read FActionMainMenuBar write SetActionMainMenuBar;
  end;

  TOnLogin = procedure(Sender: TObject; var User, Password: String) of object;
  TOnLoginSucess = procedure(Sender: TObject; IdUser: Integer; Usuario, Nome, Senha, Email: String; Privileged: Boolean) of object;
  TOnLoginError = procedure(Sender: TObject; Usuario, Senha: String) of object;
  TOnApplyRightsMenuItem = procedure(Sender: TObject; MenuItem: TMenuItem) of object;
  TOnApllyRightsActionItem = procedure(Sender: TObject; Action: TAction) of object;
  TCustomUserForm = procedure(Sender: TObject; var CustomForm: TCustomForm) of object;
  TCustomUserProfileForm = procedure(Sender: TObject; var CustomForm: TCustomForm) of object;
  TCustomLoginForm = procedure(Sender: TObject; var CustomForm: TCustomForm) of object;
  TCustomUserPasswordChangeForm = procedure(Sender: TObject; var CustomForm: TCustomForm) of object;
  TCustomLogControlForm = procedure(Sender: TObject; var CustomForm: TCustomForm) of object;
  TCustomInitialMessage = procedure(Sender: TObject; var CustomForm: TCustomForm; var Msg: TStrings) of object;
  TCustomUserLoggedForm = procedure(Sender: TObject; var CustomForm: TCustomForm) of object; //Cesar: 13/07/2005
  TOnAddUser = procedure(Sender: TObject; var Login, Password, Name, Mail: String; var Profile: Integer; var Privuser: Boolean) of object;
  TOnChangeUser = procedure(Sender: TObject; IDUser: Integer; var Login, Name, Mail: String; var Profile: Integer; var Privuser: Boolean) of object;
  TOnDeleteUser = procedure(Sender: TObject; IDUser: Integer; var CanDelete: Boolean; var ErrorMsg: String) of object;
  TOnAddProfile = procedure(Sender: TObject; var Profile: String) of object;
  TOnDeleteProfile = procedure(Sender: TObject; IDProfile: Integer; var CanDelete: Boolean; var ErrorMsg: String) of object;
  TOnChangePassword = procedure(Sender: TObject; IDUser: Integer; Login, CurrentPassword, NewPassword: String) of object;
  TOnLogoff = procedure(Sender: TObject; IDUser: Integer) of object;

  TUCExtraRights        = class;
  TUCExecuteThread      = class;
  TUCApplicationMessage = class;
  TUCControls           = class;
  TUCUsersLogged        = class; //Cesar: 12/07/2005

  TUCLoginMode    = (lmActive, lmPassive);
  TUCCriptografia = (cPadrao, cMD5);

  TUserControl = class(TComponent) // Classe principal
  private
    FCurrentUser:             TUCCurrentUser;
    FUserSettings:            TUCUserSettings;
    FApplicationID:           String;
    FNotAllowedItems:         TUCNotAllowedItems;
    FOnLogin:                 TOnLogin;
    FOnStartApplication:      TNotifyEvent;
    FOnLoginError:            TOnLoginError;
    FOnLoginSucess:           TOnLoginSucess;
    FOnApplyRightsActionIt:   TOnApllyRightsActionItem;
    FOnApplyRightsMenuIt:     TOnApplyRightsMenuItem;
    FLogControl:              TUCLogControl;
    {.$IFDEF Indy}
    FMailUserControl:         TMailUserControl;
    {.$ENDIF}
    FEncrytKey:               Word;
    FUser:                    TUCUser;
    FLogin:                   TUCLogin;
    FUserProfile:             TUCUserProfile;
    FUserPasswordChange:      TUCUserPasswordChange;
    FControlRight:            TUCControlRight;
    FOnCustomCadUsuarioForm:  TCustomUserForm;
    FCustomLogControlForm:    TCustomLogControlForm;
    FCustomLoginForm:         TCustomLoginForm;
    FCustomPerfilUsuarioForm: TCustomUserProfileForm;
    FCustomTrocarSenhaForm:   TCustomUserPasswordChangeForm;
    FOnAddProfile:            TOnAddProfile;
    FOnAddUser:               TOnAddUser;
    FOnChangePassword:        TOnChangePassword;
    FOnChangeUser:            TOnChangeUser;
    FOnDeleteProfile:         TOnDeleteProfile;
    FOnDeleteUser:            TOnDeleteUser;
    FOnLogoff:                TOnLogoff;
    FCustomInicialMsg:        TCustomInitialMessage;
    FAbout:                   TUCAboutVar;
    FExtraRights:             TUCExtraRights;
    FThUCRun:                 TUCExecuteThread;
    FAutoStart:               Boolean;
    FTableRights:             TUCTableRights;
    FTableUsers:              TUCTableUsers;
    FLoginMode:               TUCLoginMode;
    FControlList:             TList;
    FDataConnector:           TUCDataConnector;
    FLoginMonitorList:        TList;
    FAfterLogin:              TNotifyEvent;
    FCheckValidationKey:      Boolean;
    FCriptografia:            TUCCriptografia;
    FUsersLogged:             TUCUsersLogged;
    FTableUsersLogged:        TUCTableUsersLogged;
    procedure SetExtraRights(Value: TUCExtraRights);
    procedure SetWindow;
    procedure SetWindowProfile;
    {.$IFDEF Indy}
    procedure SetMailUserControl(const Value: TMailUserControl);
    {.$ENDIF}
    procedure ActionCadUser(Sender: TObject);
    procedure ActionTrocaSenha(Sender: TObject);
    procedure ActionUserProfile(Sender: TObject);
    procedure ActionUsersLogged(Sender: TObject);
    procedure ActionOKLogin(Sender: TObject);
    procedure TestaFecha(Sender: TObject; var CanClose: Boolean);
    procedure ApplySettings(SourceSettings: TUCSettings);
    procedure UnlockEX(FormObj: TCustomForm; ObjName: String);
    procedure LockEX(FormObj: TCustomForm; ObjName: String; naInvisible: Boolean);
    {.$IFDEF UCACTMANAGER}
    procedure TrataActMenuBarIt(IT: TActionClientItem; ADataset: TDataset);
    procedure IncPermissActMenuBar(idUser: Integer; Act: TAction);
    {.$ENDIF}
    procedure SetDataConnector(const Value: TUCDataConnector);
    procedure DoCheckValidationField;
  protected
    FRetry:                Integer;
    // Formul�rios
    FFormCadastroUsuarios: TCustomForm;
    FFormPerfilUsuarios:   TCustomForm;
    FFormTrocarSenha:      TCustomForm;
    FFormLogin:            TCustomForm;
    FFormLogControl:       TCustomForm;
    FFormUsersLogged:      TCustomForm;
    // -----

    procedure Loaded; override;
    procedure ActionBtPermissDefault;
    procedure ActionBtPermissProfileDefault;

    // Criar Formul�rios
    procedure CriaFormCadastroUsuarios; dynamic;
    procedure CriaFormPerfilUsuarios; dynamic;
    procedure CriaFormTrocarSenha; dynamic;
    procedure CriaFormUsersLogged; dynamic;
    // -----

    procedure ActionLog(Sender: TObject); dynamic;
    procedure ActionLogoff(Sender: TObject); dynamic;
    procedure ActionBtnPermissao(Sender: TObject); dynamic;
    procedure ActionBtnPermissaoProfile(Sender: TObject); dynamic;
    procedure ActionTSBtGrava(Sender: TObject);
    procedure SetUserSettings(const Value: TUCUserSettings);
    procedure SetfrmLoginWindow(Form: TCustomForm);
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure RegistraCurrentUser(Dados: TDataset);
    procedure ApplyRightsObj(ADataset: TDataset; FProfile: Boolean = False);
    procedure ActionEsqueceuSenha(Sender: TObject);
    procedure ShowLogin;
    procedure ApplyRights;

    // Criar Tabelas
    procedure CriaTabelaLog;
    procedure CriaTabelaRights(ExtraRights: Boolean = False);
    procedure CriaTabelaUsuarios(TableExists: Boolean);
    procedure CriaTabelaMsgs(const TableName: String);
    // -----

    procedure TryAutoLogon;
    procedure AddUCControlMonitor(UCControl: TUCControls);
    procedure DeleteUCControlMonitor(UCControl: TUCControls);
    procedure ApplyRightsUCControlMonitor;
    procedure LockControlsUCControlMonitor;
    procedure AddLoginMonitor(UCAppMessage: TUCApplicationMessage);
    procedure DeleteLoginMonitor(UCAppMessage: TUCApplicationMessage);
    procedure NotificationLoginMonitor;
  public
    procedure Logoff;
    procedure Execute;
    procedure StartLogin;
    procedure ShowUserManager;
    procedure ShowProfileManager;
    procedure ShowLogManager;
    procedure ShowChangePassword;
    procedure ChangeUser(IDUser: Integer; Login, Name, Mail: String; Profile: Integer; PrivUser: Boolean);
    procedure ChangePassword(IDUser: Integer; NewPassword: String);
    procedure AddRight(idUser: Integer; ItemRight: TObject; FullPath: Boolean = True); overload;
    procedure AddRight(idUser: Integer; ItemRight: String); overload;
    procedure AddRightEX(idUser: Integer; Module, FormName, ObjName: String);
    procedure HideField(Sender: TField; var Text: String; DisplayText: Boolean);
    procedure Log(MSG: String; Level: Integer = llNormal);
    function VerificaLogin(User, Password: String): Boolean;
    function GetLocalUserName: String;
    function GetLocalComputerName: String;
    function AddUser(Login, Password, Name, Mail: String; Profile: Integer; PrivUser: Boolean): Integer;
    function ExisteUsuario(Login: String): Boolean;
    property CurrentUser: TUCCurrentUser read FCurrentUser write FCurrentUser;
    property UserSettings: TUCUserSettings read FUserSettings write SetUserSettings;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property About: TUCAboutVar read FAbout write FAbout;
    property Criptografia: TUCCriptografia read FCriptografia write FCriptografia default cPadrao;
    property AutoStart: Boolean read FAutoStart write FAutoStart default False;
    property ApplicationID: String read FApplicationID write FApplicationID;
    property ControlRight: TUCControlRight read FControlRight write FControlRight;
    // Controle dos formularios
    property User: TUCUser read FUser write FUser;
    property UserProfile: TUCUserProfile read FUserProfile write FUserProfile;
    property UserPasswordChange: TUCUserPasswordChange read FUserPasswordChange write FUserPasswordChange;
    property UsersLogged: TUCUsersLogged read FUsersLogged write FUsersLogged;
    property LogControl: TUCLogControl read FLogControl write FLogControl;

    property EncryptKey: Word read FEncrytKey write FEncrytKey;
    property NotAllowedItems: TUCNotAllowedItems read FNotAllowedItems write FNotAllowedItems;
    property Login: TUCLogin read FLogin write FLogin;
    property ExtraRights: TUCExtraRights read FExtraRights write SetExtraRights;
    property LoginMode: TUCLoginMode read FLoginMode write FLoginMode default lmActive;
    {.$IFDEF Indy}
    property MailUserControl: TMailUserControl read FMailUserControl write SetMailUserControl;
    {.$ENDIF}

    // Tabelas
    property TableUsers: TUCTableUsers read FTableUsers write FTableUsers;
    property TableRights: TUCTableRights read FTableRights write FTableRights;
    property TableUsersLogged: TUCTableUsersLogged read FTableUsersLogged write FTableUsersLogged;

    property DataConnector: TUCDataConnector read FDataConnector write SetDataConnector;
    property CheckValidationKey: Boolean read FCheckValidationKey write FCheckValidationKey default False;
    // Eventos
    property OnLogin: TOnLogin read FOnLogin write FOnLogin;
    property OnStartApplication: TNotifyEvent read FOnStartApplication write FOnStartApplication;
    property OnLoginSucess: TOnLoginSucess read FOnLoginSucess write FOnLoginSucess;
    property OnLoginError: TOnLoginError read FOnLoginError write FOnLoginError;
    property OnApplyRightsMenuIt: TOnApplyRightsMenuItem read FOnApplyRightsMenuIt write FOnApplyRightsMenuIt;
    property OnApplyRightsActionIt: TOnApllyRightsActionItem read FOnApplyRightsActionIt write FOnApplyRightsActionIt;
    property OnCustomUsersForm: TCustomUserForm read FOnCustomCadUsuarioForm write FOnCustomCadUsuarioForm;
    property OnCustomUsersProfileForm: TCustomUserProfileForm read FCustomPerfilUsuarioForm write FCustomPerfilUsuarioForm;
    property OnCustomLoginForm: TCustomLoginForm read FCustomLoginForm write FCustomLoginForm;
    property OnCustomChangePasswordForm: TCustomUserPasswordChangeForm read FCustomTrocarSenhaForm write FCustomTrocarSenhaForm;
    property OnCustomLogControlForm: TCustomLogControlForm read FCustomLogControlForm write FCustomLogControlForm;
    property OnCustomInitialMsg: TCustomInitialMessage read FCustomInicialMsg write FCustomInicialMsg;
    property OnCustomUserLoggedForm: TCustomUserForm read FOnCustomCadUsuarioForm write FOnCustomCadUsuarioForm; //Cesar: 13/07/2005
    property OnAddUser: TOnAddUser read FOnAddUser write FOnAddUser;
    property OnChangeUser: TOnChangeUser read FOnChangeUser write FOnChangeUser;
    property OnDeleteUser: TOnDeleteUser read FOnDeleteUser write FOnDeleteUser;
    property OnAddProfile: TOnAddProfile read FOnAddProfile write FOnAddProfile;
    property OnDeleteProfile: TOnDeleteProfile read FOnDeleteProfile write FOnDeleteProfile;
    property OnChangePassword: TOnChangePassword read FOnChangePassword write FOnChangePassword;
    property OnLogoff: TOnLogoff read FOnLogoff write FOnLogoff;
    property OnAfterLogin: TNotifyEvent read FAfterLogin write FAfterLogin;
  end;

  TUCExtraRightsItem = class(TCollectionItem)
  private
    FFormName:  String;
    FCompName:  String;
    FCaption:   String;
    FGroupName: String;
    procedure SetFormName(const Value: String);
    procedure SetCompName(const Value: String);
    procedure SetCaption(const Value: String);
    procedure SetGroupName(const Value: String);
  protected
    function GetDisplayName: String; override;
  public
  published
    property FormName: String read FFormName write SetFormName;
    property CompName: String read FCompName write SetCompName;
    property Caption: String read FCaption write SetCaption;
    property GroupName: String read FGroupName write SetGroupName;
  end;

  TUCExtraRights = class(TCollection)
  private
    FUCBase: TUserControl;
    function GetItem(Index: Integer): TUCExtraRightsItem;
    procedure SetItem(Index: Integer; Value: TUCExtraRightsItem);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(UCBase: TUserControl);
    function Add: TUCExtraRightsItem;
    property Items[Index: Integer]: TUCExtraRightsItem read GetItem write SetItem; default;
  end;

  TUCVerificaMensagemThread = class(TThread)
  private
    procedure VerNovaMansagem;
  public
    AOwner: TComponent;
  protected
    procedure Execute; override;
  end;

  TUCExecuteThread = class(TThread)
  private
    procedure UCStart;
  public
    AOwner: TComponent;
  protected
    procedure Execute; override;
  end;

  TUCApplicationMessage = class(TComponent)
  private
    FActive:        Boolean;
    FReady:         Boolean;
    FInterval:      Integer;
    FUserControl:   TUserControl;
    FVerifThread:   TUCVerificaMensagemThread;
    FTableMessages: String;
    procedure SetActive(const Value: Boolean);
    procedure SetUserControl(const Value: TUserControl);
  protected
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
  public
    constructor Create(AOWner: TComponent); override;
    destructor Destroy; override;
    procedure ShowMessages(Modal: Boolean = True);
    procedure SendAppMessage(ToUser: Integer; Subject, Msg: String);
    procedure DeleteAppMessage(IdMsg: Integer);
    procedure CheckMessages;
  published
    property Active: Boolean read FActive write SetActive;
    property Interval: Integer read FInterval write FInterval;
    property TableMessages: String read FTableMessages write FTableMessages;
    property UserControl: TUserControl read FUserControl write SetUserControl;
  end;

  TUCComponentsVar = String;

  TUCNotAllowed = (naInvisible, naDisabled);

  TUCControls = class(TComponent)
  private
    FGroupName:   String;
    FComponents:  TUCComponentsVar;
    FUserControl: TUserControl;
    FNotAllowed:  TUCNotAllowed;
    function GetAccessType: String;
    function GetActiveForm: String;
    procedure SetGroupName(const Value: String);
    procedure SetUserControl(const Value: TUserControl);
  protected
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
  public
    destructor Destroy; override;
    procedure ApplyRights;
    procedure LockControls;
    procedure ListComponents(Form: String; List: TStrings);
  published
    property AccessType: String read GetAccessType;
    property ActiveForm: String read GetActiveForm;
    property GroupName: String read FGroupName write SetGroupName;
    property UserControl: TUserControl read FUserControl write SetUserControl;
    property Components: TUCComponentsVar read FComponents write FComponents;
    property NotAllowed: TUCNotAllowed read FNotAllowed write FNotAllowed default naInvisible;
  end;

  TUCUsersLogged = class(TPersistent) //Cesar: 12/07/2005: classe que armazena os usuarios logados no sistema
  private
    FUserControl: TUserControl;
    FAction:      TAction;
    FMenuItem:    TMenuItem;
    FAtive:       Boolean;
    procedure SetAction(const Value: TAction);
    procedure SetMenuItem(const Value: TMenuItem);
    procedure AddCurrentUser;
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure DelCurrentUser;
    procedure CriaTableUserLogado;
  published
    property Active: Boolean read FAtive write FAtive default True;
    property Action: TAction read FAction write SetAction;
    property MenuItem: TMenuItem read FMenuItem write SetMenuItem;
  end;

function Decrypt(const S: ansistring; Key: Word): ansistring;
function Encrypt(const S: ansistring; Key: Word): ansistring;
function MD5Sum(strValor: String): String;

(*
{$IFDEF DELPHI5}
  function StrToBool(Valor: String): Boolean;
  function BoolToStr(Valor: Boolean): String;
{$ENDIF}
*)

{ TODO -oLuiz -cUpgrade : Mudar o GetLoginName para a Unit principal }

implementation

{$R UCLock.res}

uses
  CadPerfil_U,
  CadUser_U,
  DBGrids,
  Dialogs,
  LoginWindow_U,
  MsgRecForm_U,
  MsgsForm_U,
  TrocaSenha_U,
  UCConsts,
  UserPermis_U,
  UsersLogged_U,
  ViewLog_U;

(*
{$IFDEF DELPHI5}
function StrToBool ( Valor : String) : Boolean;
begin
  if Valor = '-1' then Result := True else Result := False;
end;

function BoolToStr ( Valor : Boolean) : String;
begin
  if Valor then Result := '-1' else Result := '0';
end;
{$ENDIF}
*)

{$IFDEF DELPHI9_UP} {$REGION 'TUSerControl'} {$ENDIF}

{ TUserControl }

constructor TUserControl.Create(AOwner: TComponent);
begin
  inherited;
  FCurrentUser        := TUCCurrentUser.Create(self);
  FControlRight       := TUCControlRight.Create(Self);
  FLogin              := TUCLogin.Create(Self);
  FLogControl         := TUCLogControl.Create(Self);
  FUser               := TUCUser.Create(Self);
  FUserProfile        := TUCUserProfile.Create(Self);
  FUserPasswordChange := TUCUserPasswordChange.Create(Self);
  FUsersLogged        := TUCUsersLogged.Create(Self);
  FUserSettings       := TUCUserSettings.Create(Self);
  FNotAllowedItems    := TUCNotAllowedItems.Create(Self);
  FExtraRights        := TUCExtraRights.Create(Self);
  FTableUsers         := TUCTableUsers.Create(Self);
  FTableRights        := TUCTableRights.Create(Self);
  FTableUsersLogged   := TUCTableUsersLogged.Create(Self);

  if csDesigning in ComponentState then
  begin
    with TableUsers do
    begin
      if TableName = '' then
        TableName := Const_TableUsers_TableName;
      if FieldUserID = '' then
        FieldUserID := Const_TableUsers_FieldUserID;
      if FieldUserName = '' then
        FieldUserName := Const_TableUsers_FieldUserName;
      if FieldLogin = '' then
        FieldLogin := Const_TableUsers_FieldLogin;
      if FieldPassword = '' then
        FieldPassword := Const_TableUsers_FieldPassword;
      if FieldEmail = '' then
        FieldEmail := Const_TableUsers_FieldEmail;
      if FieldPrivileged = '' then
        FieldPrivileged := Const_TableUsers_FieldPrivileged;
      if FieldTypeRec = '' then
        FieldTypeRec := Const_TableUsers_FieldTypeRec;
      if FieldProfile = '' then
        FieldProfile := Const_TableUsers_FieldProfile;
      if FieldKey = '' then
        FieldKey := Const_TableUsers_FieldKey;
    end;

    with TableRights do
    begin
      if TableName = '' then
        TableName := Const_TableRights_TableName;
      if FieldUserID = '' then
        FieldUserID := Const_TableRights_FieldUserID;
      if FieldModule = '' then
        FieldModule := Const_TableRights_FieldModule;
      if FieldComponentName = '' then
        FieldComponentName := Const_TableRights_FieldComponentName;
      if FieldFormName = '' then
        FieldFormName := Const_TableRights_FieldFormName;
      if FieldKey = '' then
        FieldKey := Const_TableRights_FieldKey;
    end;

    with TableUsersLogged do
    begin
      if TableName = '' then
        TableName := Const_TableUsersLogged_TableName;
      if FieldLogonID = '' then
        FieldLogonID := Const_TableUsersLogged_FieldLogonID;
      if FieldUserID = '' then
        FieldUserID := Const_TableUsersLogged_FieldUserID;
      if FieldApplicationID = '' then
        FieldApplicationID := Const_TableUsersLogged_FieldApplicationID;
      if FieldMachineName = '' then
        FieldMachineName := Const_TableUsersLogged_FieldMachineName;
      if FieldData = '' then
        FieldData := Const_TableUsersLogged_FieldData;
    end;

    if LogControl.TableLog = '' then
      LogControl.TableLog := 'UCLog';
    if ApplicationID = '' then
      ApplicationID := 'ProjetoNovo';
    if Login.InitialLogin.User = '' then
      Login.InitialLogin.User := 'ADMIN';
    if Login.InitialLogin.Password = '' then
      Login.InitialLogin.Password := '#siffra';
    if Login.InitialLogin.Email = '' then
      Login.InitialLogin.Email := 'siffra@siffra.com';

    FLoginMode                    := lmActive;
    FCriptografia                 := cPadrao;
    FAutoStart                    := False;
    FUserProfile.Active           := True;
    FLogControl.Active            := True;
    FUser.UsePrivilegedField      := False;
    FUser.ProtectAdministrator    := True;
    FUsersLogged.Active           := True;
    NotAllowedItems.MenuVisible   := True;
    NotAllowedItems.ActionVisible := True;
  end
  else
  begin
    FControlList      := TList.Create;
    FLoginMonitorList := TList.Create;
  end;

  UCSettings.IniSettings(UserSettings);
end;

procedure TUserControl.Loaded;
var
  Contador: Integer;
begin
  inherited;
  if not (csDesigning in ComponentState) then
  begin
    if not Assigned(DataConnector) then
      raise Exception.Create(MsgExceptConnector);

    if ApplicationID = '' then
      raise Exception.Create(MsgExceptAppID);

    for Contador := 0 to Pred(Owner.ComponentCount) do
      if Owner.Components[Contador] is TUCSettings then
        ApplySettings(TUCSettings(Owner.Components[Contador]));

    if Assigned(User.MenuItem) and (not Assigned(User.MenuItem.OnClick)) then
      User.MenuItem.OnClick := ActionCadUser;

    if Assigned(User.Action) and (not Assigned(User.Action.OnExecute)) then
      User.Action.OnExecute := ActionCadUser;

    if UserProfile.Active then
    begin
      if Assigned(UserProfile.MenuItem) and (not Assigned(UserProfile.MenuItem.OnClick)) then
        UserProfile.MenuItem.OnClick := ActionUserProfile;

      if Assigned(UserProfile.Action) and (not Assigned(UserProfile.Action.OnExecute)) then
        UserProfile.Action.OnExecute := ActionUserProfile;
    end;

    if UsersLogged.Active then
    begin
      if Assigned(UsersLogged.MenuItem) and (not Assigned(UsersLogged.MenuItem.OnClick)) then
        UsersLogged.MenuItem.OnClick := ActionUsersLogged;

      if Assigned(UsersLogged.Action) and (not Assigned(UsersLogged.Action.OnExecute)) then
        UsersLogged.Action.OnExecute := ActionUsersLogged;
    end;

    if Assigned(UserPasswordChange.MenuItem) and (not Assigned(UserPasswordChange.MenuItem.OnClick)) then
      UserPasswordChange.MenuItem.OnClick := ActionTrocaSenha;

    if Assigned(UserPasswordChange.Action) and (not Assigned(UserPasswordChange.Action.OnExecute)) then
      UserPasswordChange.Action.OnExecute := ActionTrocaSenha;

    if (LogControl.Active) then
    begin
      if Assigned(LogControl.MenuItem) and (not Assigned(LogControl.MenuItem.OnClick)) then
        LogControl.MenuItem.OnClick := ActionLog;

      if Assigned(LogControl.Action) and (not Assigned(LogControl.Action.OnExecute)) then
        LogControl.Action.OnExecute := ActionLog;
    end;

    with TableUsers do
    begin
      if TableName = '' then
        Exception.Create(MsgExceptUsersTable);
      if FieldUserID = '' then
        Exception.Create(MsgExceptUsersTable + #13 + #10 + 'FieldUserID***');
      if FieldUserName = '' then
        Exception.Create(MsgExceptUsersTable + #13 + #10 + 'FieldUserName***');
      if FieldLogin = '' then
        Exception.Create(MsgExceptUsersTable + #13 + #10 + 'FieldLogin***');
      if FieldPassword = '' then
        Exception.Create(MsgExceptUsersTable + #13 + #10 + 'FieldPassword***');
      if FieldEmail = '' then
        Exception.Create(MsgExceptUsersTable + #13 + #10 + 'FieldEmail***');
      if FieldPrivileged = '' then
        Exception.Create(MsgExceptUsersTable + #13 + #10 + 'FieldPrivileged***');
      if FieldTypeRec = '' then
        Exception.Create(MsgExceptUsersTable + #13 + #10 + 'FieldTypeRec***');
      if FieldKey = '' then
        Exception.Create(MsgExceptUsersTable + #13 + #10 + 'FieldKey***');
      if FieldProfile = '' then
        Exception.Create(MsgExceptUsersTable + #13 + #10 + 'FieldProfile***');
    end;

    with TableRights do
    begin
      if TableName = '' then
        Exception.Create(MsgExceptRightsTable);
      if FieldUserID = '' then
        Exception.Create(MsgExceptRightsTable + #13 + #10 + 'FieldProfile***');
      if FieldModule = '' then
        Exception.Create(MsgExceptRightsTable + #13 + #10 + 'FieldModule***');
      if FieldComponentName = '' then
        Exception.Create(MsgExceptRightsTable + #13 + #10 + 'FieldComponentName***');
      if FieldFormName = '' then
        Exception.Create(MsgExceptRightsTable + #13 + #10 + 'FieldFormName***');
      if FieldKey = '' then
        Exception.Create(MsgExceptRightsTable + #13 + #10 + 'FieldKey***');
    end;

    if Assigned(OnStartApplication) then
      OnStartApplication(self);

    //desviar para thread monitorando conexao ao banco qmd 30/01/2004
    if FAutoStart then
    begin
      FThUCRun                 := TUCExecuteThread.Create(True);
      FThUCRun.AOwner          := Self;
      FThUCRun.FreeOnTerminate := True;
      FThUCRun.Resume;
    end;
  end;
end;

procedure TUserControl.ActionUserProfile(Sender: TObject);
begin
  if Assigned(OnCustomUsersProfileForm) then
    OnCustomUsersProfileForm(Self, FFormPerfilUsuarios);

  if FFormPerfilUsuarios = nil then
    CriaFormPerfilUsuarios;

  FFormPerfilUsuarios.ShowModal;
  FreeAndNil(FFormPerfilUsuarios);
end;

procedure TUserControl.ActionUsersLogged(Sender: TObject);
begin
  if Assigned(OnCustomUserLoggedForm) then
    OnCustomUserLoggedForm(Self, FFormUsersLogged);

  if FFormUsersLogged = nil then
    CriaFormUsersLogged;

  FFormUsersLogged.ShowModal;
  FreeAndNil(FFormUsersLogged);
end;

procedure TUserControl.ActionCadUser(Sender: TObject);
begin
  if Assigned(OnCustomUsersForm) then
    OnCustomUsersForm(Self, FFormCadastroUsuarios);

  if FFormCadastroUsuarios = nil then
    CriaFormCadastroUsuarios;

  FFormCadastroUsuarios.ShowModal;
  FreeAndNil(FFormCadastroUsuarios);
end;

procedure TUserControl.ActionTrocaSenha(Sender: TObject);
begin
  if Assigned(OnCustomChangePasswordForm) then
    OnCustomChangePasswordForm(Self, FFormTrocarSenha);

  if FFormTrocarSenha = nil then
    CriaFormTrocarSenha;

  FFormTrocarSenha.ShowModal;
  FreeAndNil(FFormTrocarSenha);
end;

procedure TUserControl.CriaFormPerfilUsuarios;
begin
  FFormPerfilUsuarios := TfrmCadastrarPerfil.Create(self);
  with Self.UserSettings.UsersProfile, TfrmCadastrarPerfil(FFormPerfilUsuarios) do
  begin
    Caption             := WindowCaption;
    lbDescricao.Caption := LabelDescription;
    btAdic.Caption      := BtAdd;
    BtAlt.Caption       := BtChange;
    BtExclui.Caption    := BtDelete;
    BtAcess.Caption     := BtRights;
    BtExit.Caption      := BtClose;
    BtAcess.OnClick     := ActionBtnPermissaoProfile;
    FUserControl        := Self;
    Position            := Self.UserSettings.WindowsPosition;
  end;
end;

procedure TUserControl.ActionBtnPermissaoProfile(Sender: TObject);
begin
  if TfrmCadastrarPerfil(FFormPerfilUsuarios).FDataSetPerfilUsuario.IsEmpty then
    Exit;
  UserPermis              := TUserPermis.Create(self);
  UserPermis.FUserControl := Self;
  SetWindowProfile;
  UserPermis.lbUser.Caption := TfrmCadastrarPerfil(FFormPerfilUsuarios).FDataSetPerfilUsuario.FieldByName('Nome').AsString;
  ActionBtPermissProfileDefault;
end;

procedure TUserControl.SetWindowProfile;
begin
  with Self.UserSettings.Rights do
  begin
    UserPermis.Caption             := WindowCaption;
    UserPermis.LbDescricao.Caption := LabelProfile;
    UserPermis.lbUser.Left         := UserPermis.LbDescricao.Left + UserPermis.LbDescricao.Width + 5;
    UserPermis.PageMenu.Caption    := PageMenu;
    UserPermis.PageAction.Caption  := PageActions;
    UserPermis.BtLibera.Caption    := BtUnlock;
    UserPermis.BtBloqueia.Caption  := BtLock;
    UserPermis.BtGrava.Caption     := BtSave;
    UserPermis.BtCancel.Caption    := BtCancel;
    UserPermis.Position            := Self.UserSettings.WindowsPosition;
  end;
end;

procedure TUserControl.CriaFormCadastroUsuarios;
begin
  FFormCadastroUsuarios := TfrmCadastrarUsuario.Create(self);
  with Self.UserSettings.UsersForm, TfrmCadastrarUsuario(FFormCadastroUsuarios) do
  begin
    Caption             := WindowCaption;
    lbDescricao.Caption := LabelDescription;
    btAdic.Caption      := BtAdd;
    BtAlt.Caption       := BtChange;
    BtExclui.Caption    := BtDelete;
    BtAcess.Caption     := BtRights;
    BtPass.Caption      := BtPassword;
    BtExit.Caption      := BtClose;
    BtAcess.OnClick     := Self.ActionBtnPermissao;
    FUserControl        := Self;
    Position            := Self.UserSettings.WindowsPosition;
  end;
end;

procedure TUserControl.ActionBtnPermissao(Sender: TObject);
begin
  if TfrmCadastrarUsuario(FFormCadastroUsuarios).FDataSetCadastroUsuario.IsEmpty then
    Exit;
  UserPermis              := TUserPermis.Create(self);
  UserPermis.FUserControl := Self;
  SetWindow;
  UserPermis.lbUser.Caption := TfrmCadastrarUsuario(FFormCadastroUsuarios).FDataSetCadastroUsuario.FieldByName('Login').AsString;
  ActionBtPermissDefault;
end;

procedure TUserControl.SetWindow;
begin
  with Self.UserSettings.Rights do
  begin
    UserPermis.Caption             := WindowCaption;
    UserPermis.LbDescricao.Caption := LabelUser;
    UserPermis.lbUser.Left         := UserPermis.LbDescricao.Left + UserPermis.LbDescricao.Width + 5;
    UserPermis.PageMenu.Caption    := PageMenu;
    UserPermis.PageAction.Caption  := PageActions;
    UserPermis.BtLibera.Caption    := BtUnlock;
    UserPermis.BtBloqueia.Caption  := BtLOck;
    UserPermis.BtGrava.Caption     := BtSave;
    UserPermis.BtCancel.Caption    := BtCancel;
    UserPermis.Position            := Self.UserSettings.WindowsPosition;
  end;
end;

function TUserControl.ExisteUsuario(Login: String): Boolean;
var
  SQLstmt: String;
  DataSet: TDataSet;
begin
  SQLstmt := Format('SELECT %s.%s FROM %s WHERE %s.%s=%s',
    [Self.TableUsers.TableName,
    Self.TableUsers.FieldLogin,
    Self.TableUsers.TableName,
    Self.TableUsers.TableName,
    Self.TableUsers.FieldLogin,
    QuotedStr(Login)]);

  try
    DataSet := Self.DataConnector.UCGetSQLDataset(SQLstmt);
    Result  := (Dataset.RecordCount > 0);
  finally
    SysUtils.FreeAndNil(DataSet);
  end;
end;

function TUserControl.GetLocalComputerName: String;
var
  Count:  DWORD;
  Buffer: String;
begin
  Count := MAX_COMPUTERNAME_LENGTH + 1;
  SetLength(Buffer, Count);
  if GetComputerName(PChar(Buffer), Count) then
    SetLength(Buffer, StrLen(PChar(Buffer)))
  else
    Buffer := '';
  Result := Buffer;
end;

function TUserControl.GetLocalUserName: String;
var
  Count:  DWORD;
  Buffer: String;
begin
  Count := 254;
  SetLength(Buffer, Count);
  if GetUserName(PChar(Buffer), Count) then
    SetLength(Buffer, StrLen(PChar(Buffer)))
  else
    Buffer := '';
  Result := Buffer;
end;

procedure TUserControl.CriaFormTrocarSenha;
begin
  FFormTrocarSenha := TTrocaSenha.Create(Self);
  with Self.UserSettings.ChangePassword do
  begin
    TTrocaSenha(FFormTrocarSenha).Caption             := WindowCaption;
    TTrocaSenha(FFormTrocarSenha).lbDescricao.Caption := LabelDescription;
    TTrocaSenha(FFormTrocarSenha).lbSenhaAtu.Caption  := LabelCurrentPassword;
    TTrocaSenha(FFormTrocarSenha).lbNovaSenha.Caption := LabelNewPassword;
    TTrocaSenha(FFormTrocarSenha).lbConfirma.Caption  := LabelConfirm;
    TTrocaSenha(FFormTrocarSenha).btGrava.Caption     := BtSave;
    TTrocaSenha(FFormTrocarSenha).btCancel.Caption    := BtCancel;
  end;
  TTrocaSenha(FFormTrocarSenha).Position        := Self.UserSettings.WindowsPosition; // Adicionado por Luiz Benevenuto
  TTrocaSenha(FFormTrocarSenha).btGrava.OnClick := ActionTSBtGrava;
  if CurrentUser.Password = '' then
    TTrocaSenha(FFormTrocarSenha).EditAtu.Enabled := False;
end;

procedure TUserControl.CriaFormUsersLogged;
begin
  FFormUsersLogged := TfrmUsersLogged.Create(Self);

  {
  with Settings.UserLogon, TUserLogado(FormUserLogado) do
  begin
    Caption := WindowCaption;
    lbDescricao.Caption := LabelDescription;
    BtExit.Caption := BtClose;
    BitRefresh.Caption := BtRefresh;
    BitMsg.Caption := BtMsg;
    DbGrid.Columns[0].Title.Caption := ColName;
    DbGrid.Columns[1].Title.Caption := ColLogin;
    DbGrid.Columns[2].Title.Caption := ColPC;
    DbGrid.Columns[3].Title.Caption := ColDate;
    Position := Self.Settings.WindowsPosition;
  end;
  }
  TfrmUsersLogged(FFormUsersLogged).Position     := Self.UserSettings.WindowsPosition;
  TfrmUsersLogged(FFormUsersLogged).FUserControl := Self;
end;

procedure TUserControl.ActionTSBtGrava(Sender: TObject);
begin
  if CurrentUser.Password <> MD5Sum(TTrocaSenha(FFormTrocarSenha).EditAtu.Text) then
  begin
    MessageDlg(UserSettings.CommonMessages.ChangePasswordError.InvalidCurrentPassword, mtWarning, [mbOK], 0);
    TTrocaSenha(FFormTrocarSenha).EditAtu.SetFocus;
    Exit;
  end;

  if TTrocaSenha(FFormTrocarSenha).EditNova.Text <> TTrocaSenha(FFormTrocarSenha).EditConfirma.Text then
  begin
    MessageDlg(UserSettings.CommonMessages.ChangePasswordError.InvalidNewPassword, mtWarning, [mbOK], 0);
    TTrocaSenha(FFormTrocarSenha).EditNova.SetFocus;
    Exit;
  end;

  if MD5Sum(TTrocaSenha(FFormTrocarSenha).EditNova.Text) = CurrentUser.Password then
  begin
    MessageDlg(UserSettings.CommonMessages.ChangePasswordError.NewEqualCurrent, mtWarning, [mbOK], 0);
    TTrocaSenha(FFormTrocarSenha).EditNova.SetFocus;
    Exit;
  end;

  if (UserPasswordChange.ForcePassword) and (TTrocaSenha(FFormTrocarSenha).EditNova.Text = '') then
  begin
    MessageDlg(UserSettings.CommonMessages.ChangePasswordError.PasswordRequired, mtWarning, [mbOK], 0);
    TTrocaSenha(FFormTrocarSenha).EditNova.Text;
    Exit;
  end;

  if Length(TTrocaSenha(FFormTrocarSenha).EditNova.Text) < UserPasswordChange.MinPasswordLength then
  begin
    MessageDlg(Format(UserSettings.CommonMessages.ChangePasswordError.MinPasswordLength, [UserPasswordChange.MinPasswordLength]), mtWarning, [mbOK], 0);
    TTrocaSenha(FFormTrocarSenha).EditNova.SetFocus;
    Exit;
  end;

  if Pos(LowerCase(TTrocaSenha(FFormTrocarSenha).EditNova.Text), 'abcdeasdfqwerzxcv1234567890321654987teste' + LowerCase(CurrentUser.UserName) + LowerCase(CurrentUser.UserLogin)) > 0 then
  begin
    MessageDlg(UserSettings.CommonMessages.ChangePasswordError.InvalidNewPassword, mtWarning, [mbOK], 0);
    TTrocaSenha(FFormTrocarSenha).EditNova.SetFocus;
    Exit;
  end;

  if Assigned(OnChangePassword) then
    OnChangePassword(Self, CurrentUser.UserID, CurrentUser.UserLogin, CurrentUser.Password, TTrocaSenha(FFormTrocarSenha).EditNova.Text);
  ChangePassword(CurrentUser.UserID, TTrocaSenha(FFormTrocarSenha).EditNova.Text);

  CurrentUser.Password := MD5Sum(TTrocaSenha(FFormTrocarSenha).EditNova.Text);
  if CurrentUser.Password = '' then
    MessageDlg(Format(UserSettings.CommonMessages.BlankPassword, [CurrentUser.UserLogin]), mtInformation, [mbOK], 0)
  else
    MessageDlg(UserSettings.CommonMessages.PasswordChanged, mtInformation, [mbOK], 0);

  {.$IFDEF Indy}
  if (Assigned(MailUserControl)) and (MailUserControl.SenhaTrocada.Ativo) then
    with CurrentUser do
      try
        MailUserControl.EnviaEmailSenhaTrocada(UserName, UserLogin, TTrocaSenha(FFormTrocarSenha).EditNova.Text, Email, '', EncryptKey);
      except
        on e: Exception do
          Log(e.Message, 2);
      end;
  {.$ENDIF}
  TTrocaSenha(FFormTrocarSenha).Close;
end;

procedure TUserControl.SetUserSettings(const Value: TUCUserSettings);
begin
  UserSettings := Value;
end;

procedure TUserControl.SetfrmLoginWindow(Form: TCustomForm);
begin
  with UserSettings.Login, Form as TfrmLoginWindow do
  begin
    Caption           := WindowCaption;
    LbUsuario.Caption := LabelUser;
    LbSenha.Caption   := LabelPassword;
    btOK.Caption      := UserSettings.Login.BtOk;
    BtCancela.Caption := BtCancel;
    if LeftImage <> nil then
      ImgLeft.Picture.Assign(LeftImage);
    if BottomImage <> nil then
      ImgBottom.Picture.Assign(BottomImage);
    if TopImage <> nil then
      ImgTop.Picture.Assign(TopImage);

    {.$IFDEF Indy}
    if Assigned(MailUserControl) then
    begin
      lbEsqueci.Visible := MailUserControl.EsqueceuSenha.Ativo;
      lbEsqueci.Caption := MailUserControl.EsqueceuSenha.LabelLoginForm;
    end;
    {.$ENDIF}
    Position := Self.UserSettings.WindowsPosition;
  end;
end;

procedure TUserControl.Notification(AComponent: TComponent; AOperation: TOperation);
begin
  if (AOperation = opRemove) then
  begin
    if AComponent = User.MenuItem then
      User.MenuItem := nil;
    if AComponent = User.Action then
      User.Action := nil;
    if AComponent = UserProfile.MenuItem then
      UserProfile.MenuItem := nil;
    if AComponent = UserProfile.Action then
      UserProfile.Action := nil;
    if AComponent = UserPasswordChange.Action then
      UserPasswordChange.Action := nil;
    if AComponent = UserPasswordChange.MenuItem then
      UserPasswordChange.MenuItem := nil;
    if AComponent = ControlRight.MainMenu then
      ControlRight.MainMenu := nil;
    if AComponent = ControlRight.ActionList then
      ControlRight.ActionList := nil;
    {.$IFDEF UCACTMANAGER}
    if AComponent = ControlRight.ActionManager then
      ControlRight.ActionManager := nil;
    if AComponent = ControlRight.ActionMainMenuBar then
      ControlRight.ActionMainMenuBar := nil;
    {.$ENDIF}
    if AComponent = LogControl.MenuItem then
      LogControl.MenuItem := nil;
    if AComponent = LogControl.Action then
      LogControl.Action := nil;
    if AComponent = FDataConnector then
      FDataConnector := nil;

    {.$IFDEF Indy}
    if AComponent = FMailUserControl then
      FMailUserControl := nil;
    {.$ENDIF}
  end;
  inherited Notification(AComponent, AOperation);
end;

procedure TUserControl.ActionLog(Sender: TObject);
begin
  FFormLogControl                       := TViewLog.Create(self);
  TViewLog(FFormLogControl).UCComponent := Self;
  with TViewLog(FFormLogControl), UserSettings.Log do
  begin
    Caption             := WindowCaption;
    lbDescricao.Caption := LabelDescription;
    lbUsuario.Caption   := LabelUser;
    lbData.Caption      := LabelDate;
    lbNivel.Caption     := LabelLevel;
    BtFiltro.Caption    := BtFilter;
    BtExclui.Caption    := BtDelete;
    BtFecha.Caption     := BtClose;
    with DBGrid1 do
    begin
      Columns[0].Title.Caption := ColAppID;
      Columns[0].FieldName     := 'APPLICATIONID';
      Columns[0].Width         := 60;
      Columns[1].Title.Caption := ColLevel;
      Columns[1].FieldName     := 'NIVEL';
      Columns[1].Width         := 32;
      Columns[2].Title.Caption := ColMessage;
      Columns[2].FieldName     := 'MSG';
      Columns[2].Width         := 260;
      Columns[3].Title.Caption := ColUser;
      Columns[3].FieldName     := 'NOME';
      Columns[3].Width         := 120;
      Columns[4].Title.Caption := ColDate;
      Columns[4].FieldName     := 'DATA';
      Columns[4].Width         := 111;
    end;
    Position := Self.UserSettings.WindowsPosition;
  end;
  TViewLog(FFormLogControl).ShowModal;
  FreeAndNil(FFormLogControl);
end;

procedure TUserControl.ActionLogoff(Sender: TObject);
begin
  Self.Logoff;
end;

procedure TUserControl.Log(MSG: String; Level: Integer);
begin
  // Adicionado ao log a identifica��o da Aplica��o
  if not LogControl.Active then
    Exit;
  DataConnector.UCExecSQL('INSERT INTO ' + LogControl.TableLog +
    '(APPLICATIONID, IDUSER, MSG, DATA, NIVEL) VALUES ( ' +
    QuotedStr(Self.ApplicationID) + ', ' +
    IntToStr(CurrentUser.UserID) + ', ' +
    QuotedStr(Copy(MSG, 1, 250)) + ', ' +
    QuotedStr(FormatDateTime('YYYYMMDDhhmmss', now)) + ', ' +
    IntToStr(Level) + ')');
end;

{.$IFDEF Indy}
procedure TUserControl.SetMailUserControl(const Value: TMailUserControl);
begin
  FMailUserControl := Value;
  if Value <> nil then
    Value.FreeNotification(Self);
end;

{.$ENDIF}

procedure TUserControl.RegistraCurrentUser(Dados: TDataset);
var
  SQLStmt: String;
begin
  with CurrentUser do
  begin
    UserID    := Dados.FieldByName(TableUsers.FieldUserID).AsInteger;
    UserName  := Dados.FieldByName(TableUsers.FieldUserName).AsString;
    UserLogin := Dados.FieldByName(TableUsers.FieldLogin).AsString;

    case Self.Criptografia of
      cPadrao: Password := Decrypt(Dados.FieldByName(TableUsers.FieldPassword).AsString, EncryptKey);
      cMD5: Password    := Dados.FieldByName(TableUsers.FieldPassword).AsString;
    end;

    Email      := Dados.FieldByName(TableUsers.FieldEmail).AsString;
    Privileged := StrToBool(Dados.FieldByName(TableUsers.FieldPrivileged).AsString);
    Profile    := Dados.FieldByName(TableUsers.FieldProfile).AsInteger;

    SQLStmt := Format('SELECT %s AS ObjName,' +
      ' %s AS UCKey,' +
      ' %s AS UserID' +
      ' FROM %s' +
      ' WHERE %s = %s AND %s = %s',
      [TableRights.FieldComponentName,
      TableRights.FieldKey,
      TableRights.FieldUserID,
      TableRights.TableName,
      TableRights.FieldUserID,
      IntToStr(UserID),
      TableRights.FieldModule,
      QuotedStr(ApplicationID)]);

    PerfilUsuario := DataConnector.UCGetSQLDataset(SQLStmt);

    // Aplica Permissoes do Perfil do usuario
    if CurrentUser.Profile > 0 then
    begin
      SQLStmt := Format('SELECT %s AS ObjName,' +
        ' %s AS UCKey,' +
        ' %s AS UserID' +
        ' FROM %s' +
        ' WHERE %s = %s AND %s = %s',
        [TableRights.FieldComponentName,
        TableRights.FieldKey,
        TableRights.FieldUserID,
        TableRights.TableName,
        TableRights.FieldUserID,
        IntToStr(CurrentUser.Profile),
        TableRights.FieldModule,
        QuotedStr(ApplicationID)]);

      PerfilGrupo := DataConnector.UCGetSQLDataset(SQLStmt);
    end
    else
      PerfilGrupo := nil;

    if Assigned(OnLoginSucess) then
      OnLoginSucess(Self, UserID, UserLogin, UserName, Password, EMail, Privileged);
  end;

  //Cesar: 13/07/2005
  if (CurrentUser.UserID <> 0) then
    UsersLogged.AddCurrentUser;

  ApplyRightsUCControlMonitor;
  NotificationLoginMonitor;
end;

{.$IFDEF Indy}
procedure TUserControl.ActionEsqueceuSenha(Sender: TObject);
var
  FDataset: TDataset;
begin
  FDataset := DataConnector.UCGetSQLDataset('Select * from ' + TableUsers.TableName + ' Where ' +
    TableUsers.FieldLogin + ' = ' + QuotedStr(TfrmLoginWindow(FFormLogin).EditUsuario.Text));
  with FDataset do
    try
      if not IsEmpty then
        { TODO -oLuiz -cUpgrade : Consertar o m�todo EnviarEsquceuSenha para usar a criptografia md5 }
        MailUserControl.EnviaEsqueceuSenha(FieldByName(TableUsers.FieldUserName).AsString,
          FieldByName(TableUsers.FieldLogin).AsString,
          FieldByName(TableUsers.FieldPassword).AsString,
          FieldByName(TableUsers.FieldEmail).AsString, '', EncryptKey)
      else
        MessageDlg(UserSettings.CommonMessages.InvalidLogin, mtWarning, [mbOK], 0);
    finally
      Close;
      Free;
    end;
end;

{.$ENDIF}

procedure TUserControl.TryAutoLogon;
begin
  if not VerificaLogin(Login.AutoLogin.User, Login.AutoLogin.Password) then
  begin
    if Login.AutoLogin.MessageOnError then
      MessageDlg(UserSettings.CommonMessages.AutoLogonError, mtWarning, [mbOK], 0);
    ShowLogin;
  end;
end;

function TUserControl.VerificaLogin(User, Password: String): Boolean;
var
  Senha:    String;
  Key:      String;
  SQLStmt:  String;
  Dataset:  TDataset;
  VerifKey: String;
begin
  case Self.Criptografia of
    cPadrao: Senha := TableUsers.FieldPassword + ' = ' + QuotedStr(Encrypt(Password, EncryptKey));
    cMD5: Senha    := TableUsers.FieldPassword + ' = ' + QuotedStr(MD5Sum(Password));
  end;

  SQLStmt := 'SELECT * FROM ' + TableUsers.TableName + ' WHERE ' +
    TableUsers.FieldLogin + ' = ' + QuotedStr(User) + ' AND ' + Senha;

  Dataset := DataConnector.UCGetSQLDataset(SQLStmt);
  with Dataset do
    try
      if not IsEmpty then
      begin
        case Self.Criptografia of
          cPadrao:
          begin
            Key      := Decrypt(Dataset.FieldByName(TableUsers.FieldKey).AsString, EncryptKey);
            VerifKey := Dataset.FieldByName(TableUsers.FieldUserID).AsString +
              Dataset.FieldByName(TableUsers.FieldLogin).AsString +
              Decrypt(Dataset.FieldByName(TableUsers.FieldPassword).AsString, EncryptKey);
          end;
          cMD5:
          begin
            Key      := Dataset.FieldByName(TableUsers.FieldKey).AsString;
            VerifKey := MD5Sum(Dataset.FieldByName(TableUsers.FieldUserID).AsString +
              Dataset.FieldByName(TableUsers.FieldLogin).AsString +
              Dataset.FieldByName(TableUsers.FieldPassword).AsString);
          end;
        end;
        if Key <> VerifKey then
        begin
          Result := False;
          if Assigned(OnLoginError) then
            OnLoginError(Self, User, Password);
        end
        else
        begin
          Result := True;
          RegistraCurrentuser(Dataset);
        end;
      end
      else
      begin
        Result := False;
        if Assigned(OnLoginError) then
          OnLoginError(Self, User, Password);
      end;
    finally
      Close;
      Free;
    end;
end;

procedure TUserControl.Logoff;
begin
  if Assigned(onLogoff) then
    onLogoff(Self, CurrentUser.UserID);

  LockControlsUCControlMonitor;
  UsersLogged.DelCurrentUser;
  CurrentUser.UserID := 0;
  if LoginMode = lmActive then
    ShowLogin;
  ApplyRights;
end;

function TUserControl.AddUser(Login, Password, Name, Mail: String; Profile: Integer; PrivUser: Boolean): Integer;
var
  Key:     String;
  SQLStmt: String;
  Senha:   String;
begin
  with DataConnector.UCGetSQLDataset('Select Max(' + TableUsers.FieldUserID + ') as IdUser from ' + TableUsers.TableName) do
  begin
    Result := FieldByName('idUser').AsInteger + 1;
    Close;
    Free;
  end;

  case Self.Criptografia of
    cPadrao:
    begin
      Key   := Encrypt(IntToStr(Result) + Login + Password, EncryptKey);
      Senha := Encrypt(Password, EncryptKey);
    end;
    cMD5:
    begin
      Key   := MD5Sum(IntToStr(Result) + Login + MD5Sum(Password));
      Senha := MD5Sum(Password);
    end;
  end;

  with TableUsers do
  begin
    SQLStmt := Format('INSERT INTO %s( %s, %s, %s, %s, %s, %s, %s, %s, %s) VALUES(%d, %s, %s, %s, %s, %s, %d, %s, %s)',
      [TableName,
      FieldUserID,
      FieldUserName,
      FieldLogin,
      FieldPassword,
      FieldEmail,
      FieldPrivileged,
      FieldProfile,
      FieldTypeRec,
      FieldKey,
      Result,
      QuotedStr(Name),
      QuotedStr(Login),
      QuotedStr(Senha),
      QuotedStr(Mail),
      BoolToStr(PrivUser),
      Profile,
      QuotedStr('U'),
      QuotedStr(Key)]);

    DataConnector.UCExecSQL(SQLStmt);
  end;

  if Assigned(OnAddUser) then
    OnAddUser(Self, Login, Password, Name, Mail, Profile, Privuser);
end;

procedure TUserControl.ChangePassword(IDUser: Integer; NewPassword: String);
var
  Login: String;
  Senha: String;
  Key:   String;
begin
  inherited;
  with DataConnector.UCGetSQLDataset('Select ' + TableUsers.FieldLogin + ' as login, ' + TableUsers.FieldPassword + ' as senha from ' + TableUsers.TableName + ' where ' + TableUsers.FieldUserID + ' = ' + IntToStr(IdUser)) do
  begin
    Login := FieldByName('Login').AsString;
    case Self.Criptografia of
      cPadrao:
      begin
        Key   := Encrypt(IntToStr(IDUser) + Login + NewPassword, EncryptKey);
        Senha := Decrypt(FieldByName('Senha').AsString, EncryptKey);
      end;
      cMD5:
      begin
        Key   := MD5Sum(IntToStr(IDUser) + Login + MD5Sum(NewPassword));
        Senha := FieldByName('Senha').AsString;
      end;
    end;

    Close;
    Free;
  end;
  DataConnector.UCExecSQL('Update ' + TableUsers.TableName +
    ' Set ' + TableUsers.FieldPassword + ' = ' + QuotedStr(MD5Sum(NewPassword)) +
    ', ' + TableUsers.FieldKey + ' = ' + QuotedStr(Key) + ' where ' +
    TableUsers.FieldUserID + ' = ' + IntToStr(IdUser));

  if Assigned(onChangePassword) then
    OnChangePassword(Self, IdUser, Login, Senha, NewPassword);
end;

procedure TUserControl.ChangeUser(IDUser: Integer; Login, Name, Mail: String; Profile: Integer; PrivUser: Boolean);
var
  Key, Password: String;
begin
  with DataConnector.UCGetSQLDataset('SELECT ' + TableUsers.FieldPassword +
      ' AS SENHA FROM ' + TableUsers.TableName + ' WHERE ' +
      TableUsers.FieldUserID + ' = ' + IntToStr(IdUser)) do
  begin
    case Self.Criptografia of
      cPadrao:
      begin
        Password := Decrypt(FieldByName('Senha').AsString, EncryptKey);
        Key      := Encrypt(IntToStr(IDUser) + Login + Password, EncryptKey);
      end;
      cMD5:
      begin
        Password := FieldByName('Senha').AsString;
        Key      := MD5Sum(IntToStr(IDUser) + Login + Password);
      end;
    end;
    Close;
    Free;
  end;

  with TableUsers do
    DataConnector.UCExecSQL('Update ' + TableName + ' Set ' +
      FieldUserName + ' = ' + QuotedStr(Name) + ', ' +
      FieldLogin + ' = ' + QuotedStr(Login) + ', ' +
      FieldEmail + ' = ' + QuotedStr(Mail) + ', ' +
      FieldPrivileged + ' = ' + BooltoStr(PrivUser) + ', ' +
      FieldProfile + ' = ' + IntToStr(Profile) + ', ' +
      FieldKey + ' = ' + QuotedStr(Key) +
      ' where ' + FieldUserID + ' = ' + IntToStr(IdUser));
  if Assigned(OnChangeUser) then
    OnChangeUser(Self, IdUser, Login, Name, Mail, Profile, PrivUser);
end;

procedure TUserControl.CriaTabelaMsgs(const TableName: String);
begin
  DataConnector.UCExecSQL('Create Table ' + TableName + ' ( ' +
    'IdMsg int ,' +
    'UsrFrom int, ' +
    'UsrTo int, ' +
    'Subject Varchar(50),' +
    'Msg Varchar(255),' +
    'DtSend Varchar(12),' +
    'DtReceive Varchar(12) )');
end;

destructor TUserControl.Destroy;
begin
  SysUtils.FreeAndNil(FExtraRights);
  SysUtils.FreeAndNil(FCurrentUser);
  SysUtils.FreeAndNil(FControlRight);
  SysUtils.FreeAndNil(FLogin);
  SysUtils.FreeAndNil(FLogControl);
  SysUtils.FreeAndNil(FUser);
  SysUtils.FreeAndNil(FUserProfile);
  SysUtils.FreeAndNil(FUserPasswordChange);
  SysUtils.FreeAndNil(FUserSettings);
  SysUtils.FreeAndNil(FNotAllowedItems);
  SysUtils.FreeAndNil(FControlList);
  SysUtils.FreeAndNil(FLoginMonitorList);
  SysUtils.FreeAndNil(FTableUsers);
  SysUtils.FreeAndNil(FTableRights);
  SysUtils.FreeAndNil(FTableUsersLogged);
  SysUtils.FreeAndNil(FUsersLogged);

  inherited Destroy;
end;

procedure TUserControl.SetExtraRights(Value: TUCExtraRights);
begin

end;

procedure TUserControl.HideField(Sender: TField; var Text: String; DisplayText: Boolean);
begin
  Text := '(Campo Bloqueado)';
end;

procedure TUserControl.StartLogin;
begin
  CurrentUser.UserID := 0;
  ShowLogin;
  ApplyRights;
end;

procedure TUserControl.Execute;
begin
  //    if not UCFindDataConnection then raise Exception.Create(Format(msgExceptConnection,[name]));
  if Assigned(FThUCRun) then
    FThUCRun.Terminate;
  try
    if not DataConnector.UCFindTable(FTableRights.TableName) then
      CriaTabelaRights;

    if not DataConnector.UCFindTable(FTableRights.TableName + 'EX') then
      CriaTabelaRights(True); //extra rights table

    if not DataConnector.UCFindTable(TableUsersLogged.TableName) then
      UsersLogged.CriaTableUserLogado;

    if LogControl.Active then
      if not DataConnector.UCFindTable(LogControl.TableLog) then
        CriaTabelaLog;

    CriaTabelaUsuarios(DataConnector.UCFindTable(FTableUsers.TableName));

    // testa campo KEY qmd 28-02-2005
    if FCheckValidationKey then
      DoCheckValidationField;
  finally
    if LoginMode = lmActive then
      if not Login.AutoLogin.Active then
        ShowLogin
      else
        TryAutoLogon;
    ApplyRights;
  end;
end;

procedure TUserControl.DoCheckValidationField;
var
  TempDS: TDataset;
  Key:    String;
  Login:  String;
  Senha:  String;
  UserID: Integer;
begin
  //verifica tabela de usuarios
  TempDS := DataConnector.UCGetSQLDataset('SELECT * FROM ' + TableUsers.TableName);

  if TempDS.FindField(TableUsers.FieldKey) = nil then
  begin
    DataConnector.UCExecSQL('ALTER TABLE ' + TableUsers.TableName + ' ADD ' + TableUsers.FieldKey + ' VARCHAR(255)');
    TempDS.First;
    with TempDS do
      while not EOF do
      begin
        UserID := TempDS.FieldByName(TableUsers.FieldUserID).AsInteger;
        Login  := TempDS.FieldByName(TableUsers.FieldLogin).AsString;
        case Self.Criptografia of
          cPadrao:
          begin
            Senha := Decrypt(TempDS.FieldByName(TableUsers.FieldPassword).AsString, EncryptKey);
            Key   := Encrypt(IntToStr(UserID) + Login + Senha, EncryptKey);
          end;
          cMD5:
          begin
            Senha := TempDS.FieldByName(TableUsers.FieldPassword).AsString;
            Key   := MD5Sum(IntToStr(UserID) + Login + Senha);
          end;
        end;
        DataConnector.UCExecSQL(Format('UPDATE %s SET %s = %s WHERE %s = %d',
          [TableUsers.TableName,
          TableUsers.FieldKey,
          QuotedStr(Key),
          TableUsers.FieldUserID,
          TempDS.FieldByName(TableUsers.FieldUserID).AsInteger]));
        Next;
      end;
  end;

  TempDS.Close;
  FreeAndNil(TempDS);

  //verifica tabela de permissoes
  TempDS := DataConnector.UCGetSQLDataset('SELECT * FROM ' + TableRights.TableName);

  if TempDS.FindField(TableRights.FieldKey) = nil then
  begin
    DataConnector.UCExecSQL('ALTER TABLE ' + TableRights.TableName + ' ADD ' + TableUsers.FieldKey + ' VARCHAR(255)');
    TempDS.First;
    with TempDS do
      while not EOF do
      begin
        UserID := TempDS.FieldByName(TableRights.FieldUserID).AsInteger;
        Login  := TempDS.FieldByName(TableRights.FieldComponentName).AsString;
        case Self.Criptografia of
          cPadrao: Key := Encrypt(IntToStr(UserID) + Login, EncryptKey);
          cMD5: Key    := MD5Sum(IntToStr(UserID) + Login);
        end;
        DataConnector.UCExecSQL(Format('UPDATE %s SET %s = %s where %s = %d and %s = %s and %s = %s',
          [TableRights.TableName,
          TableRights.FieldKey,
          QuotedStr(Key),
          TableRights.FieldUserID,
          TempDS.FieldByName(TableRights.FieldUserID).AsInteger,
          TableRights.FieldModule,
          QuotedStr(ApplicationID),
          TableRights.FieldComponentName,
          QuotedStr(Login)]));
        Next;
      end;
  end;
  TempDS.Close;
  FreeAndNil(TempDS);

  //verifica tabela de permissoes extendidas
  TempDS := DataConnector.UCGetSQLDataset('SELECT * FROM ' + TableRights.TableName + 'EX');
  if TempDS.FindField(TableRights.FieldKey) = nil then
  begin
    DataConnector.UCExecSQL('ALTER TABLE ' + TableRights.TableName + 'EX ADD ' +
      TableUsers.FieldKey + ' VARCHAR(255)');
    TempDS.First;
    with TempDS do
      while not EOF do
      begin
        UserID := TempDS.FieldByName(TableRights.FieldUserID).AsInteger;
        Login  := TempDS.FieldByName(TableRights.FieldComponentName).AsString; //componentname
        Senha  := TempDS.FieldByName(TableRights.FieldFormName).AsString; // formname
        case Self.Criptografia of
          cPadrao: Key := Encrypt(IntToStr(UserID) + Login, EncryptKey);
          cMD5: Key    := MD5Sum(IntToStr(UserID) + Login);
        end;
        DataConnector.UCExecSQL(Format('UPDATE %s SET %s = %s' +
          ' WHERE %s = %d AND' +
          ' %s = %s AND %s = %s AND' +
          ' %s = %s',
          [TableRights.TableName + 'EX',
          TableRights.FieldKey,
          QuotedStr(Key),
          TableRights.FieldUserID,
          TempDS.FieldByName(TableRights.FieldUserID).AsInteger,
          TableRights.FieldModule,
          QuotedStr(ApplicationID),
          TableRights.FieldComponentName,
          QuotedStr(Login), // componente name
          TableRights.FieldFormName,
          QuotedStr(Senha)])); // formname
        Next;
      end;
  end;
  TempDS.Close;
  FreeAndNil(TempDS);
end;

procedure TUserControl.ActionBtPermissDefault;
var
  TempCampos, TempCamposEX: String;
begin
  UserPermis.FTempIdUser := TfrmCadastrarUsuario(FFormCadastroUsuarios).FDataSetCadastroUsuario.FieldByName('IdUser').AsInteger;

  TempCampos   := Format(' %s as IdUser, %s as Modulo, %s as ObjName, %s as UCKey ',
    [TableRights.FieldUserID, TableRights.FieldModule, TableRights.FieldComponentName, TableRights.FieldKey]);
  TempCamposEX := Format(' %s, %s as FormName ',
    [TempCampos, TableRights.FieldFormName]);

  UserPermis.DSPermiss := DataConnector.UCGetSQLDataset(
    Format('SELECT %s FROM %s TAB WHERE TAB.%s = %s AND TAB.%s = %s',
    [TempCampos,
    TableRights.TableName,
    TableRights.FieldUserID,
    TfrmCadastrarUsuario(FFormCadastroUsuarios).FDataSetCadastroUsuario.FieldByName('IdUser').AsString,
    TableRights.FieldModule,
    QuotedStr(ApplicationID)]));
  UserPermis.DSPermiss.Open;

  UserPermis.DSPermissEX := DataConnector.UCGetSQLDataset(
    Format('SELECT %s FROM %s TAB1 WHERE TAB1.%s = %s AND TAB1.%s = %s',
    [TempCamposEX,
    TableRights.TableName + 'EX',
    TableRights.FieldUserID,
    TfrmCadastrarUsuario(FFormCadastroUsuarios).FDataSetCadastroUsuario.FieldByName('IdUser').AsString,
    TableRights.FieldModule,
    QuotedStr(ApplicationID)]));
  UserPermis.DSPermissEX.Open;

  UserPermis.DSPerfil := DataConnector.UCGetSQLDataset(
    Format('Select %s from %s tab Where tab.%s = %s and tab.%s = %s',
    [TempCampos,
    TableRights.TableName,
    TableRights.FieldUserID,
    TfrmCadastrarUsuario(FFormCadastroUsuarios).FDataSetCadastroUsuario.FieldByName('Perfil').AsString,
    TableRights.FieldModule,
    QuotedStr(ApplicationID)]));
  UserPermis.DSPerfil.Open;

  UserPermis.DSPerfilEX := DataConnector.UCGetSQLDataset(
    Format('Select %s from %s tab1 Where tab1.%s = %s and tab1.%s = %s',
    [TempCamposEX,
    TableRights.TableName + 'EX',
    TableRights.FieldUserID,
    TfrmCadastrarUsuario(FFormCadastroUsuarios).FDataSetCadastroUsuario.FieldByName('Perfil').AsString,
    TableRights.FieldModule,
    QuotedStr(ApplicationID)]));

  UserPermis.DSPerfilEX.Open;

  UserPermis.ShowModal;

  TfrmCadastrarUsuario(FFormCadastroUsuarios).FDataSetCadastroUsuario.Close;
  TfrmCadastrarUsuario(FFormCadastroUsuarios).FDataSetCadastroUsuario.Open;

  TfrmCadastrarUsuario(FFormCadastroUsuarios).FDataSetCadastroUsuario.Locate('idUser', UserPermis.FTempIdUser, []);

  FreeAndNil(UserPermis);
end;

procedure TUserControl.ActionBtPermissProfileDefault;
var
  TempCampos, TempCamposEX: String;
begin
  UserPermis.FTempIdUser := TfrmCadastrarPerfil(FFormPerfilUsuarios).FDataSetPerfilUsuario.FieldByName('IdUser').AsInteger;

  TempCampos   := Format(' %s as IdUser, %s as Modulo, %s as ObjName, %s as UCKey ',
    [TableRights.FieldUserID,
    TableRights.FieldModule,
    TableRights.FieldComponentName,
    TableRights.FieldKey]);
  TempCamposEX := Format('%s, %s as FormName ', [TempCampos, TableRights.FieldFormName]);

  UserPermis.DSPermiss := DataConnector.UCGetSQLDataset(Format('Select %s from %s tab Where tab.%s = %s and tab.%s = %s',
    [TempCampos,
    TableRights.TableName,
    TableRights.FieldUserID,
    TfrmCadastrarPerfil(FFormPerfilUsuarios).FDataSetPerfilUsuario.FieldByName('IdUser').AsString,
    TableRights.FieldModule,
    QuotedStr(ApplicationID)]));

  UserPermis.DSPermiss.Open;

  UserPermis.DSPermissEX := DataConnector.UCGetSQLDataset(Format('Select %s from %s tab1 Where tab1.%s = %s and tab1.%s = %s',
    [TempCamposEX,
    TableRights.TableName + 'EX',
    TableRights.FieldUserID,
    TfrmCadastrarPerfil(FFormPerfilUsuarios).FDataSetPerfilUsuario.FieldByName('IdUser').AsString,
    TableRights.FieldModule,
    QuotedStr(ApplicationID)]));

  UserPermis.DSPermissEX.Open;

  UserPermis.DSPerfil := TDataset.Create(UserPermis);

  UserPermis.ShowModal;

  TfrmCadastrarPerfil(FFormPerfilUsuarios).FDataSetPerfilUsuario.Close;
  TfrmCadastrarPerfil(FFormPerfilUsuarios).FDataSetPerfilUsuario.Open;
  TfrmCadastrarPerfil(FFormPerfilUsuarios).FDataSetPerfilUsuario.Locate('idUser', UserPermis.FTempIdUser, []);

  FreeAndNil(UserPermis);
end;

procedure TUserControl.ShowChangePassword;
begin
  ActionTrocaSenha(self);
end;

procedure TUserControl.ShowLogManager;
begin
  ActionLog(Self);
end;

procedure TUserControl.ShowProfileManager;
begin
  ActionUserProfile(self);
end;

procedure TUserControl.ShowUserManager;
begin
  ActionCadUser(Self);
end;

procedure TUserControl.AddUCControlMonitor(UCControl: TUCControls);
begin
  FControlList.Add(UCControl);
end;

procedure TUserControl.ApplyRightsUCControlMonitor;
var
  Contador: Integer;
begin
  for Contador := 0 to Pred(FControlList.Count) do
    TUCControls(FControlList.Items[Contador]).ApplyRights;
end;

procedure TUserControl.DeleteUCControlMonitor(UCControl: TUCControls);
var
  Contador:   Integer;
  SLControls: TStringList;
begin
  if not Assigned(FControlList) then
    Exit;
  SLControls := TStringList.Create;
  for Contador := 0 to Pred(FControlList.Count) do
    if TUCControls(FControlList.Items[Contador]) = UCControl then
      SLControls.Add(IntToStr(Contador));

  for Contador := 0 to Pred(SLControls.Count) do
    FControlList.Delete(StrToInt(SLControls[Contador]));

  FreeAndNil(SLControls);
end;

procedure TUserControl.LockControlsUCControlMonitor;
var
  Contador: Integer;
begin
  for Contador := 0 to Pred(FControlList.Count) do
    TUCControls(FControlList.Items[Contador]).LockControls;
end;

procedure TUserControl.SetDataConnector(const Value: TUCDataConnector);
begin
  FDataConnector := Value;
  if Assigned(Value) then
    Value.FreeNotification(Self);
end;

procedure TUserControl.AddLoginMonitor(UCAppMessage: TUCApplicationMessage);
begin
  FLoginMonitorList.Add(UCAppMessage);
end;

procedure TUserControl.DeleteLoginMonitor(UCAppMessage: TUCApplicationMessage);
var
  Contador:   Integer;
  SLControls: TStringList;
begin
  SLControls := TStringList.Create;
  if Assigned(FLoginMonitorList) then
    for Contador := 0 to Pred(FLoginMonitorList.Count) do
      if TUCApplicationMessage(FLoginMonitorList.Items[Contador]) = UCAppMessage then
        SLControls.Add(IntToStr(Contador));
  if assigned(SLControls) then
    for Contador := 0 to Pred(SLControls.Count) do
      FLoginMonitorList.Delete(StrToInt(SLControls[Contador]));
  SysUtils.FreeAndNil(SLControls);
end;

procedure TUserControl.NotificationLoginMonitor;
var
  Contador: Integer;
begin
  for Contador := 0 to Pred(FLoginMonitorList.Count) do
    TUCApplicationMessage(FLoginMonitorList.Items[Contador]).CheckMessages;
end;

procedure TUserControl.ShowLogin;
begin
  FRetry := 0;
  if Assigned(onCustomLoginForm) then
    OnCustomLoginForm(Self, FFormLogin);
  if FFormLogin = nil then
  begin
    FFormLogin := TfrmLoginWindow.Create(self);
    with FFormLogin as TfrmLoginWindow do
    begin
      SetfrmLoginWindow(TfrmLoginWindow(FFormLogin));
      FUserControl      := Self;
      btOK.onClick      := ActionOKLogin;
      onCloseQuery      := Testafecha;
      {.$IFDEF Indy}
      lbEsqueci.OnClick := ActionEsqueceuSenha;
      {.$ENDIF}
    end;
  end;
  FFormLogin.ShowModal;
  FreeAndNil(FFormLogin);
end;

procedure TUserControl.ActionOKLogin(Sender: TObject);
var
  TempUser:     String;
  TempPassword: String;
begin
  TempUser     := TfrmLoginWindow(FFormLogin).EditUsuario.Text;
  TempPassword := TfrmLoginWindow(FFormLogin).EditSenha.Text;

  if Assigned(OnLogin) then
    Onlogin(Self, TempUser, TempPassword);
  if VerificaLogin(TempUser, TempPassword) then
    TfrmLoginWindow(FFormLogin).Close
  else
  begin
    MessageDlg(UserSettings.CommonMessages.InvalidLogin, mtWarning, [mbOK], 0);
    Inc(FRetry);
    if (Login.MaxLoginAttempts > 0) and (FRetry = Login.MaxLoginAttempts) then
    begin
      MessageDlg(Format(UserSettings.CommonMessages.MaxLoginAttemptsError, [Login.MaxLoginAttempts]), mtError, [mbOK], 0);
      Halt;
    end;
  end;
end;

procedure TUserControl.TestaFecha(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := (CurrentUser.UserID > 0);
end;

procedure TUserControl.ApplyRights;
var
  DataSet: TDataset;
  SQLStmt: String;
begin
  try
    // Aplica Permissoes do Usuario logado
    SQLStmt := Format('SELECT %s AS ObjName,' +
      ' %s AS UCKey,' +
      ' %s AS UserID' +
      ' FROM %s' +
      ' WHERE %s = %s AND %s = %s',
      [TableRights.FieldComponentName,
      TableRights.FieldKey,
      TableRights.FieldUserID,
      TableRights.TableName,
      TableRights.FieldUserID,
      IntToStr(CurrentUser.UserID),
      TableRights.FieldModule,
      QuotedStr(ApplicationID)]);

    DataSet := DataConnector.UCGetSQLDataset(SQLStmt);
    ApplyRightsObj(DataSet);
    DataSet.Close;

    // Aplica Permissoes do Perfil do usuario
    if CurrentUser.Profile > 0 then
    begin
      SQLStmt := Format('SELECT %s AS ObjName,' +
        ' %s AS UCKey,' +
        ' %s AS UserID' +
        ' FROM %s' +
        ' WHERE %s = %s AND %s = %s',
        [TableRights.FieldComponentName,
        TableRights.FieldKey,
        TableRights.FieldUserID,
        TableRights.TableName,
        TableRights.FieldUserID,
        IntToStr(CurrentUser.Profile),
        TableRights.FieldModule,
        QuotedStr(ApplicationID)]);

      DataSet := DataConnector.UCGetSQLDataset(SQLStmt);
      ApplyRightsObj(DataSet, True);
      DataSet.Close;
    end;
  finally
    FreeAndNil(DataSet);
  end;

  if Assigned(FAfterLogin) then
    FAfterLogin(Self);
end;

procedure TUserControl.ApplyRightsObj(ADataset: TDataset; FProfile: Boolean = False);
var
  Contador:     Integer;
  Encontrado:   Boolean;
  KeyField:     String;
  Temp:         String;
  ObjetoAction: TObject;
  OwnerMenu:    TComponent;
begin
  //Permissao de Menus QMD
  Encontrado := False;
  if Assigned(ControlRight.MainMenu) then
  begin
    OwnerMenu := ControlRight.MainMenu.Owner;
    for Contador := 0 to Pred(OwnerMenu.ComponentCount) do
      if (OwnerMenu.Components[Contador].ClassType = TMenuItem) and (TMenuItem(OwnerMenu.Components[Contador]).GetParentMenu = ControlRight.MainMenu) then
      begin
        if not FProfile then
        begin
          Encontrado := ADataset.Locate('ObjName', OwnerMenu.Components[Contador].Name, []);
          KeyField   := ADataset.FindField('UCKey').AsString;
          //verifica key
          if Encontrado then
            case Self.Criptografia of
              cPadrao:
                Encontrado := (KeyField = Encrypt(ADataset.FieldByName('UserID').AsString + ADataset.FieldByName('ObjName').AsString, EncryptKey));
              cMD5:
                Encontrado := (KeyField = MD5Sum(ADataset.FieldByName('UserID').AsString + ADataset.FieldByName('ObjName').AsString));
            end;
          TMenuItem(OwnerMenu.Components[Contador]).Enabled := Encontrado;
          if not Encontrado then
            TMenuItem(OwnerMenu.Components[Contador]).Visible := NotAllowedItems.MenuVisible
          else
            TMenuItem(OwnerMenu.Components[Contador]).Visible := True;
        end
        else
          if ADataset.Locate('ObjName', OwnerMenu.Components[Contador].Name, []) then
          begin
            KeyField := ADataset.FindField('UCKey').AsString;
            case Self.Criptografia of
              cPadrao:
                Encontrado := (KeyField = Encrypt(ADataset.FieldByName('UserID').AsString + ADataset.FieldByName('ObjName').AsString, EncryptKey));
              cMD5:
                Encontrado := (KeyField = MD5Sum(ADataset.FieldByName('UserID').AsString + ADataset.FieldByName('ObjName').AsString));
            end;
            if Encontrado then
            begin
              TMenuItem(OwnerMenu.Components[Contador]).Enabled := True;
              TMenuItem(OwnerMenu.Components[Contador]).Visible := True;
            end; //verifica key
          end;
        if Assigned(OnApplyRightsMenuIt) then
          OnApplyRightsMenuIt(Self, TMenuItem(OwnerMenu.Components[Contador]));
      end;
  end; // Fim do controle do MainMenu

  //Permissao de Actions
  if (Assigned(ControlRight.ActionList))
    {.$IFDEF UCACTMANAGER} or (Assigned(ControlRight.ActionManager)) {.$ENDIF} then
  begin
    if Assigned(ControlRight.ActionList) then
      ObjetoAction := ControlRight.ActionList
    {.$IFDEF UCACTMANAGER}
    else
      ObjetoAction := ControlRight.ActionManager
    {.$ENDIF};
    for Contador := 0 to TActionList(ObjetoAction).ActionCount - 1 do
    begin
      if not FProfile then
      begin
        Encontrado := ADataset.Locate('ObjName', TActionList(ObjetoAction).Actions[contador].Name, []);
        KeyField   := ADataset.FindField('UCKey').AsString;
        //verifica key
        if Encontrado then
          case Self.Criptografia of
            cPadrao: Encontrado := (KeyField = Encrypt(ADataset.FieldByName('UserID').AsString + ADataset.FieldByName('ObjName').AsString, EncryptKey));
            cMD5: Encontrado    := (KeyField = MD5Sum(ADataset.FieldByName('UserID').AsString + ADataset.FieldByName('ObjName').AsString));
          end;

        TAction(TActionList(ObjetoAction).Actions[contador]).Enabled := Encontrado;

        if not Encontrado then
          TAction(TActionList(ObjetoAction).Actions[contador]).Visible := NotAllowedItems.ActionVisible
        else
          TAction(TActionList(ObjetoAction).Actions[contador]).Visible := True;
      end
      else
        if ADataset.Locate('ObjName', TActionList(ObjetoAction).Actions[contador].Name, []) then
        begin
          KeyField := ADataset.FindField('UCKey').AsString;
          case Self.Criptografia of
            cPadrao: Encontrado := (KeyField = Encrypt(ADataset.FieldByName('UserID').AsString + ADataset.FieldByName('ObjName').AsString, EncryptKey));
            cMD5: Encontrado    := (KeyField = MD5Sum(ADataset.FieldByName('UserID').AsString + ADataset.FieldByName('ObjName').AsString));
          end;
          if Encontrado then
          begin
            TAction(TActionList(ObjetoAction).Actions[contador]).Enabled := True;
            TAction(TActionList(ObjetoAction).Actions[contador]).Visible := True;
          end; //verifica key
        end;

      if Assigned(OnApplyRightsActionIt) then
        OnApplyRightsActionIt(Self, TAction(TActionList(ObjetoAction).Actions[contador]));
    end;
  end; // Fim das permiss�es de Actions

  {.$IFDEF UCACTMANAGER}
  if Assigned(ControlRight.ActionMainMenuBar) then
    for Contador := 0 to ControlRight.ActionMainMenuBar.ActionClient.Items.Count - 1 do
    begin
      Temp := IntToStr(Contador);
      if ControlRight.ActionMainMenuBar.ActionClient.Items[StrToInt(Temp)].Items.Count > 0 then
      begin
        if Self.Criptografia = cPadrao then
          ControlRight.ActionMainMenuBar.ActionClient.Items[StrToInt(Temp)].Visible :=
            (ADataset.Locate('ObjName', #1 + 'G' + ControlRight.ActionMainMenuBar.ActionClient.Items[StrToInt(Temp)].Caption, [])) and
            (ADataset.FieldByName('UCKey').AsString = Encrypt(ADataset.FieldByName('UserID').AsString + ADataset.FieldByName('ObjName').AsString, EncryptKey));

        if Self.Criptografia = cMD5 then
          ControlRight.ActionMainMenuBar.ActionClient.Items[StrToInt(Temp)].Visible :=
            (ADataset.Locate('ObjName', #1 + 'G' + ControlRight.ActionMainMenuBar.ActionClient.Items[StrToInt(Temp)].Caption, [])) and
            (ADataset.FieldByName('UCKey').AsString = MD5Sum(ADataset.FieldByName('UserID').AsString + ADataset.FieldByName('ObjName').AsString));

        TrataActMenuBarIt(ControlRight.ActionMainMenuBar.ActionClient.Items[StrToInt(Temp)], ADataset);
      end;
    end;
  {.$ENDIF}
end;

procedure TUserControl.UnlockEX(FormObj: TCustomForm; ObjName: String);
begin
  if FormObj.FindComponent(ObjName) = nil then
    Exit;

  if FormObj.FindComponent(ObjName) is TControl then
  begin
    TControl(FormObj.FindComponent(ObjName)).Enabled := True;
    TControl(FormObj.FindComponent(ObjName)).Visible := True;
  end;

  if FormObj.FindComponent(ObjName) is TMenuItem then // TMenuItem
  begin
    TMenuItem(FormObj.FindComponent(ObjName)).Enabled := True;
    TMenuItem(FormObj.FindComponent(ObjName)).Visible := True;
    //chama evento OnApplyRightsMenuIt
    if Assigned(OnApplyRightsMenuIt) then
      OnApplyRightsMenuIt(self, FormObj.FindComponent(ObjName) as TMenuItem);
  end;

  if FormObj.FindComponent(ObjName) is TAction then // TAction
  begin
    TAction(FormObj.FindComponent(ObjName)).Enabled := True;
    TAction(FormObj.FindComponent(ObjName)).Visible := True;
    //chama evento OnApplyRightsMenuIt
    if Assigned(OnApplyRightsActionIt) then
      OnApplyRightsActionIt(self, FormObj.FindComponent(ObjName) as TAction);
  end;

  if FormObj.FindComponent(ObjName) is TField then // TField
  begin
    TField(FormObj.FindComponent(ObjName)).ReadOnly  := False;
    TField(FormObj.FindComponent(ObjName)).Visible   := True;
    TField(FormObj.FindComponent(ObjName)).onGetText := nil;
  end;
end;

procedure TUserControl.LockEX(FormObj: TCustomForm; ObjName: String; naInvisible: Boolean);
begin
  if FormObj.FindComponent(ObjName) = nil then
    Exit;

  if FormObj.FindComponent(ObjName) is TControl then
  begin
    TControl(FormObj.FindComponent(ObjName)).Enabled := False;
    TControl(FormObj.FindComponent(ObjName)).Visible := not naInvisible;
  end;

  if FormObj.FindComponent(ObjName) is TMenuItem then // TMenuItem
  begin
    TMenuItem(FormObj.FindComponent(ObjName)).Enabled := False;
    TMenuItem(FormObj.FindComponent(ObjName)).Visible := not naInvisible;
    //chama evento OnApplyRightsMenuIt
    if Assigned(OnApplyRightsMenuIt) then
      OnApplyRightsMenuIt(self, FormObj.FindComponent(ObjName) as TMenuItem);
  end;

  if FormObj.FindComponent(ObjName) is TAction then // TAction
  begin
    TAction(FormObj.FindComponent(ObjName)).Enabled := False;
    TAction(FormObj.FindComponent(ObjName)).Visible := not naInvisible;
    //chama evento OnApplyRightsMenuIt
    if Assigned(OnApplyRightsActionIt) then
      OnApplyRightsActionIt(self, FormObj.FindComponent(ObjName) as TAction);
  end;

  if FormObj.FindComponent(ObjName) is TField then // TField
  begin
    TField(FormObj.FindComponent(ObjName)).ReadOnly  := True;
    TField(FormObj.FindComponent(ObjName)).Visible   := not naInvisible;
    TField(FormObj.FindComponent(ObjName)).onGetText := HideField;
  end;
end;

{.$IFDEF UCACTMANAGER}
procedure TUserControl.TrataActMenuBarIt(IT: TActionClientItem; ADataset: TDataset);
var
  Contador: Integer;
begin
  for contador := 0 to IT.Items.Count - 1 do
    if IT.Items[Contador].Caption <> '-' then
      if IT.Items[Contador].Items.Count > 0 then
      begin
        IT.Items[Contador].Visible := (ADataset.Locate('ObjName', #1 + 'G' + IT.Items[Contador].Caption, []));
        TrataActMenuBarIt(IT.Items[Contador], ADataset);
      end;
end;

{.$ENDIF}

procedure TUserControl.CriaTabelaRights(ExtraRights: Boolean = False);
var
  SQLStmt:   String;
  TipoCampo: String;
begin
  case Self.Criptografia of
    cPadrao: TipoCampo := 'VARCHAR(250)';
    cMD5: TipoCampo    := 'VARCHAR(32)';
  end;

  with TableRights do
    if not ExtraRights then
    begin
      SQLStmt := Format('CREATE TABLE %s( %s int, %s VARCHAR(50), %s VARCHAR(50), %s %s )',
        [TableName,
        FieldUserID,
        FieldModule,
        FieldComponentName,
        FieldKey,
        TipoCampo]);
      DataConnector.UCExecSQL(SQLStmt);
    end
    else
    begin
      SQLStmt := Format('CREATE TABLE %sEX( %s int, %s VARCHAR(50), %s VARCHAR(50), %s VARCHAR(50), %s %s )',
        [TableName,
        FieldUserID,
        FieldModule,
        FieldComponentName,
        FieldFormName,
        FieldKey,
        TipoCampo]);
      DataConnector.UCExecSQL(SQLStmt);
    end;
end;

procedure TUserControl.AddRightEX(idUser: Integer; Module, FormName, ObjName: String);
var
  KeyField: String;
  SQLStmt:  String;
begin
  case Self.Criptografia of
    cPadrao: KeyField := Encrypt(IntToStr(idUser) + ObjName, EncryptKey);
    cMD5: KeyField    := MD5Sum(IntToStr(idUser) + ObjName);
  end;

  with TableRights do
    SQLStmt := Format('INSERT INTO %sEX( %s, %s, %s, %s, %s) VALUES (%d, %s, %s, %s, %s)',
      [TableName,
      FieldUserID,
      FieldModule,
      FieldFormName,
      FieldComponentName,
      FieldKey,
      IdUser,
      QuotedStr(Module),
      QuotedStr(FormName),
      QuotedStr(ObjName),
      QuotedStr(KeyField)]);

  DataConnector.UCExecSQL(SQLStmt);
end;

procedure TUserControl.AddRight(idUser: Integer; ItemRight: String);
var
  KeyField: String;
  SQLStmt:  String;
begin
  if ItemRight = '' then
    Exit;

  case Self.Criptografia of
    cPadrao: KeyField := Encrypt(IntToStr(idUser) + ItemRight, EncryptKey);
    cMD5: KeyField    := MD5Sum(IntToStr(idUser) + ItemRight);
  end;

  SQLStmt := Format('Insert into %s( %s, %s, %s, %s) Values( %d, %s, %s, %s)',
    [TableRights.TableName,
    TableRights.FieldUserID,
    TableRights.FieldModule,
    TableRights.FieldComponentName,
    TableRights.FieldKey,
    idUser,
    QuotedStr(ApplicationID),
    QuotedStr(ItemRight),
    QuotedStr(KeyField)]);

  DataConnector.UCExecSQL(SQLStmt);
end;

procedure TUserControl.AddRight(idUser: Integer; ItemRight: TObject; FullPath: Boolean = True);
var
  Obj: TObject;
begin
  if ItemRight = nil then
    Exit;

  Obj := ItemRight;

  if Obj.ClassType = TMenuItem then
    while Assigned(Obj) and (Obj.ClassType = TMenuItem) and (TComponent(Obj).Name <> '') do
    begin
      AddRight(idUser, TComponent(Obj).Name);
      if FullPath then
        Obj := TMenuItem(Obj).Parent
      else
        Obj := nil;
    end
  else
    AddRight(idUser, TComponent(Obj).Name);
end;

procedure TUserControl.CriaTabelaLog;
begin
  DataConnector.UCExecSQL('CREATE TABLE ' + LogControl.TableLog +
    ' (APPLICATIONID VARCHAR(250), IDUSER INT , MSG VARCHAR(250), DATA VARCHAR(14), NIVEL INT)');
end;

{.$IFDEF UCACTMANAGER}
procedure TUserControl.IncPermissActMenuBar(idUser: Integer; Act: TAction);
var
  Temp: TActionClientItem;
begin
  if Act = nil then
    exit;

  Temp := ControlRight.ActionMainMenuBar.ActionManager.FindItemByAction(Act);
  while Temp <> nil do
  begin
    AddRight(idUser, #1 + 'G' + Temp.Caption);
    Temp := (TActionClientItem(Temp).ParentItem as TActionClientItem);
  end;
end;

{.$ENDIF}

procedure TUserControl.CriaTabelaUsuarios(TableExists: Boolean);
var
  Contador:         Integer;
  IDUsuario:        Integer;
  CustomForm:       TCustomForm;
  Mensagens:        TStrings;
  DataSetUsuario:   TDataSet;
  DataSetPermissao: TDataSet;
  SQLStmt:          String;
  TipoCampo:        String;
begin
  case Self.Criptografia of
    cPadrao: TipoCampo := 'VARCHAR(250)';
    cMD5: TipoCampo    := 'VARCHAR(32)';
  end;

  if not TableExists then
    with TableUsers do
    begin
      SQLStmt := Format('Create Table %s ' + // TableName
        '( ' +
        '%s int, ' +         // FieldUserID
        '%s varchar(30), ' + // FieldUserName
        '%s varchar(30), ' + // FieldLogin
        '%s %s, ' +          // FieldPassword
        '%s varchar(150), ' +
        '%s int, ' +
        '%s char(1), ' +
        '%s int, ' +
        '%s %s ' + // FieldKey
        ')',
        [TableName,
        FieldUserID,
        FieldUserName,
        FieldLogin,
        FieldPassword,
        TipoCampo,
        FieldEmail,
        FieldPrivileged,
        FieldTypeRec,
        FieldProfile,
        FieldKey,
        TipoCampo]);

      DataConnector.UCExecSQL(SQLstmt);
    end;

  SQLStmt := 'SELECT ' + TableUsers.FieldUserID + ' as idUser ' +
    'FROM ' + TableUsers.TableName + ' ' +
    'WHERE ' + TableUsers.FieldLogin + ' = ' + QuotedStr(Login.InitialLogin.User);

  DataSetUsuario := DataConnector.UCGetSQLDataset(SQLstmt);

  // Inserir login inicial
  if DataSetUsuario.IsEmpty then
    IDUsuario := AddUser(Login.InitialLogin.User,
      Login.InitialLogin.Password,
      Login.InitialLogin.User,
      Login.InitialLogin.Email,
      0,
      True)
  else
    IDUsuario := DataSetUsuario.FieldByName('idUser').AsInteger;

  DataSetUsuario.Close;
  FreeAndNil(DataSetUsuario);

  SQLStmt := 'SELECT ' + TableRights.FieldUserID + ' AS IDUSER ' +
    'FROM ' + TableRights.TableName + ' ' +
    'WHERE ' + TableRights.FieldUserID + ' = ' + IntToStr(IDUsuario) + ' ' +
    'AND ' + TableRights.FieldModule + ' = ' + QuotedStr(ApplicationID);

  DataSetPermissao := DataConnector.UCGetSQLDataset(SQLStmt);

  if not DataSetPermissao.IsEmpty then
  begin
    DataSetPermissao.Close;
    FreeAndNil(DataSetPermissao);
    Exit; //login!
  end;

  DataSetPermissao.Close;
  FreeAndNil(DataSetPermissao);

  AddRight(IDUsuario, User.MenuItem);
  AddRight(IDUsuario, User.Action);
  AddRight(IDUsuario, UserProfile.MenuItem);
  AddRight(IDUsuario, UserProfile.Action);

  AddRight(IDUsuario, UserPasswordChange.MenuItem);
  AddRight(IDUsuario, UserPasswordChange.Action);

  {.$IFDEF UCACTMANAGER}
  if Assigned(ControlRight.ActionMainMenuBar) then
    IncPermissActMenuBar(IDUsuario, User.Action);
  if Assigned(ControlRight.ActionMainMenuBar) then
    IncPermissActMenuBar(IDUsuario, UserProfile.Action);
  if Assigned(ControlRight.ActionMainMenuBar) then
    IncPermissActMenuBar(IDUsuario, UserPasswordChange.Action);
  {.$ENDIF}
  if LogControl.Active then
  begin
    AddRight(IDUsuario, LogControl.MenuItem);
    AddRight(IDUsuario, LogControl.Action);
    {.$IFDEF UCACTMANAGER}
    if Assigned(ControlRight.ActionMainMenuBar) then
      IncPermissActMenuBar(IDUsuario, LogControl.Action);
    {.$ENDIF}
  end;

  for Contador := 0 to Pred(Login.InitialLogin.InitialRights.Count) do
    if Owner.FindComponent(Login.InitialLogin.InitialRights[contador]) <> nil then
    begin
      AddRight(IDUsuario, Owner.FindComponent(Login.InitialLogin.InitialRights[contador]));
      AddRightEX(IDUsuario, ApplicationID, TcustomForm(Owner).Name, Login.InitialLogin.InitialRights[contador]);
    end;

  try
    Mensagens := TStringList.Create;
    Mensagens.Assign(UserSettings.CommonMessages.InitialMessage);
    Mensagens.Text := StringReplace(Mensagens.Text, ':user', Login.InitialLogin.User, [rfReplaceAll]);
    Mensagens.Text := StringReplace(Mensagens.Text, ':password', Login.InitialLogin.Password, [rfReplaceAll]);

    if Assigned(OnCustomInitialMsg) then
      OnCustomInitialMsg(Self, CustomForm, Mensagens);

    if CustomForm <> nil then
      CustomForm.ShowModal
    else
      MessageDlg(Mensagens.Text, mtInformation, [mbOK], 0);

  finally
    FreeAndNil(Mensagens);
  end;
end;

procedure TUserControl.ApplySettings(SourceSettings: TUCSettings);
begin
  with UserSettings.CommonMessages do
  begin
    BlankPassword         := SourceSettings.CommonMessages.BlankPassword;
    PasswordChanged       := SourceSettings.CommonMessages.PasswordChanged;
    InitialMessage.Text   := SourceSettings.CommonMessages.InitialMessage.Text;
    MaxLoginAttemptsError := SourceSettings.CommonMessages.MaxLoginAttemptsError;
    InvalidLogin          := SourceSettings.CommonMessages.InvalidLogin;
    AutoLogonError        := SourceSettings.CommonMessages.AutoLogonError;
    UsuarioExiste         := SourceSettings.CommonMessages.UsuarioExiste; // Luiz Benevenuto 20/04/06
  end;

  with UserSettings.Login do
  begin
    BtCancel      := SourceSettings.Login.BtCancel;
    BtOK          := SourceSettings.Login.BtOK;
    LabelPassword := SourceSettings.Login.LabelPassword;
    LabelUser     := SourceSettings.Login.LabelUser;
    WindowCaption := SourceSettings.Login.WindowCaption;

    if Assigned(SourceSettings.Login.LeftImage.Bitmap) then
      LeftImage.Bitmap := SourceSettings.Login.LeftImage.Bitmap
    else
      LeftImage.Bitmap := nil;

    if Assigned(SourceSettings.Login.TopImage.Bitmap) then
      TopImage.Bitmap := SourceSettings.Login.TopImage.Bitmap
    else
      TopImage.Bitmap := nil;

    if Assigned(SourceSettings.Login.BottomImage.Bitmap) then
      BottomImage.Bitmap := SourceSettings.Login.BottomImage.Bitmap
    else
      BottomImage.Bitmap := nil;
  end;

  with UserSettings.UsersForm do
  begin
    WindowCaption              := SourceSettings.UsersForm.WindowCaption;
    LabelDescription           := SourceSettings.UsersForm.LabelDescription;
    ColName                    := SourceSettings.UsersForm.ColName;
    ColLogin                   := SourceSettings.UsersForm.ColLogin;
    ColEmail                   := SourceSettings.UsersForm.ColEmail;
    BtAdd                      := SourceSettings.UsersForm.BtAdd;
    BtChange                   := SourceSettings.UsersForm.BtChange;
    BtDelete                   := SourceSettings.UsersForm.BtDelete;
    BtRights                   := SourceSettings.UsersForm.BtRights;
    BtPassword                 := SourceSettings.UsersForm.BtPassword;
    BtClose                    := SourceSettings.UsersForm.BtClose;
    PromptDelete               := SourceSettings.UsersForm.PromptDelete;
    PromptDelete_WindowCaption := SourceSettings.UsersForm.PromptDelete_WindowCaption; //added by fduenas
  end;

  with UserSettings.UsersProfile do
  begin
    WindowCaption              := SourceSettings.UsersProfile.WindowCaption;
    LabelDescription           := SourceSettings.UsersProfile.LabelDescription;
    ColProfile                 := SourceSettings.UsersProfile.ColProfile;
    BtAdd                      := SourceSettings.UsersProfile.BtAdd;
    BtChange                   := SourceSettings.UsersProfile.BtChange;
    BtDelete                   := SourceSettings.UsersProfile.BtDelete;
    BtRights                   := SourceSettings.UsersProfile.BtRights; //added by fduenas
    BtClose                    := SourceSettings.UsersProfile.BtClose;
    PromptDelete               := SourceSettings.UsersProfile.PromptDelete;
    PromptDelete_WindowCaption := SourceSettings.UsersProfile.PromptDelete_WindowCaption; //added by fduenas
  end;

  with UserSettings.AddChangeUser do
  begin
    WindowCaption   := SourceSettings.AddChangeUser.WindowCaption;
    LabelAdd        := SourceSettings.AddChangeUser.LabelAdd;
    LabelChange     := SourceSettings.AddChangeUser.LabelChange;
    LabelName       := SourceSettings.AddChangeUser.LabelName;
    LabelLogin      := SourceSettings.AddChangeUser.LabelLogin;
    LabelEmail      := SourceSettings.AddChangeUser.LabelEmail;
    CheckPrivileged := SourceSettings.AddChangeUser.CheckPrivileged;
    BtSave          := SourceSettings.AddChangeUser.BtSave;
    BtCancel        := SourceSettings.AddChangeUser.BtCancel;
  end;

  with UserSettings.AddChangeProfile do
  begin
    WindowCaption := SourceSettings.AddChangeProfile.WindowCaption;
    LabelAdd      := SourceSettings.AddChangeProfile.LabelAdd;
    LabelChange   := SourceSettings.AddChangeProfile.LabelChange;
    LabelName     := SourceSettings.AddChangeProfile.LabelName;
    BtSave        := SourceSettings.AddChangeProfile.BtSave;
    BtCancel      := SourceSettings.AddChangeProfile.BtCancel;
  end;

  with UserSettings.Rights do
  begin
    WindowCaption := SourceSettings.Rights.WindowCaption;
    LabelUser     := SourceSettings.Rights.LabelUser;
    LabelProfile  := SourceSettings.Rights.LabelProfile;
    PageMenu      := SourceSettings.Rights.PageMenu;
    PageActions   := SourceSettings.Rights.PageActions;
    BtUnlock      := SourceSettings.Rights.BtUnlock;
    BtLock        := SourceSettings.Rights.BtLock;
    BtSave        := SourceSettings.Rights.BtSave;
    BtCancel      := SourceSettings.Rights.BtCancel;
  end;

  with UserSettings.ChangePassword do
  begin
    WindowCaption        := SourceSettings.ChangePassword.WindowCaption;
    LabelDescription     := SourceSettings.ChangePassword.LabelDescription;
    LabelCurrentPassword := SourceSettings.ChangePassword.LabelCurrentPassword;
    LabelNewPassword     := SourceSettings.ChangePassword.LabelNewPassword;
    LabelConfirm         := SourceSettings.ChangePassword.LabelConfirm;
    BtSave               := SourceSettings.ChangePassword.BtSave;
    BtCancel             := SourceSettings.ChangePassword.BtCancel;
  end;

  with UserSettings.CommonMessages.ChangePasswordError do
  begin
    InvalidCurrentPassword := SourceSettings.CommonMessages.ChangePasswordError.InvalidCurrentPassword;
    NewPasswordError       := SourceSettings.CommonMessages.ChangePasswordError.NewPasswordError;
    NewEqualCurrent        := SourceSettings.CommonMessages.ChangePasswordError.NewEqualCurrent;
    PasswordRequired       := SourceSettings.CommonMessages.ChangePasswordError.PasswordRequired;
    MinPasswordLength      := SourceSettings.CommonMessages.ChangePasswordError.MinPasswordLength;
    InvalidNewPassword     := SourceSettings.CommonMessages.ChangePasswordError.InvalidNewPassword;
  end;

  with UserSettings.ResetPassword do
  begin
    WindowCaption := SourceSettings.ResetPassword.WindowCaption;
    LabelPassword := SourceSettings.ResetPassword.LabelPassword;
  end;

  with UserSettings.Log do
  begin
    WindowCaption              := SourceSettings.Log.WindowCaption;
    LabelDescription           := SourceSettings.Log.LabelDescription;
    LabelUser                  := SourceSettings.Log.LabelUser;
    LabelDate                  := SourceSettings.Log.LabelDate;
    LabelLevel                 := SourceSettings.Log.LabelLevel;
    ColLevel                   := SourceSettings.Log.ColLevel;
    ColMessage                 := SourceSettings.Log.ColMessage;
    ColUser                    := SourceSettings.Log.ColUser;
    ColDate                    := SourceSettings.Log.ColDate;
    BtFilter                   := SourceSettings.Log.BtFilter;
    BtDelete                   := SourceSettings.Log.BtDelete;
    BtClose                    := SourceSettings.Log.BtClose;
    PromptDelete               := SourceSettings.Log.PromptDelete;
    PromptDelete_WindowCaption := SourceSettings.Log.PromptDelete_WindowCaption; //added by fduenas
    OptionUserAll              := SourceSettings.Log.OptionUserAll;  //added by fduenas
    OptionLevelLow             := SourceSettings.Log.OptionLevelLow; //added by fduenas
    OptionLevelNormal          := SourceSettings.Log.OptionLevelNormal; //added by fduenas
    OptionLevelHigh            := SourceSettings.Log.OptionLevelHigh; //added by fduenas
    OptionLevelCritic          := SourceSettings.Log.OptionLevelCritic; //added by fduenas
    DeletePerformed            := SourceSettings.Log.DeletePerformed; //added by fduenas
  end;

  with UserSettings.AppMessages do
  begin
    MsgsForm_BtNew                            := SourceSettings.AppMessages.MsgsForm_BtNew;
    MsgsForm_BtReplay                         := SourceSettings.AppMessages.MsgsForm_BtReplay;
    MsgsForm_BtForward                        := SourceSettings.AppMessages.MsgsForm_BtForward;
    MsgsForm_BtDelete                         := SourceSettings.AppMessages.MsgsForm_BtDelete;
    MsgsForm_BtClose                          := SourceSettings.AppMessages.MsgsForm_BtClose; //added by fduenas
    MsgsForm_WindowCaption                    := SourceSettings.AppMessages.MsgsForm_WindowCaption;
    MsgsForm_ColFrom                          := SourceSettings.AppMessages.MsgsForm_ColFrom;
    MsgsForm_ColSubject                       := SourceSettings.AppMessages.MsgsForm_ColSubject;
    MsgsForm_ColDate                          := SourceSettings.AppMessages.MsgsForm_ColDate;
    MsgsForm_PromptDelete                     := SourceSettings.AppMessages.MsgsForm_PromptDelete;
    MsgsForm_PromptDelete_WindowCaption       := SourceSettings.AppMessages.MsgsForm_PromptDelete_WindowCaption; //added by fduenas
    MsgsForm_NoMessagesSelected               := SourceSettings.AppMessages.MsgsForm_NoMessagesSelected; //added by fduenas
    MsgsForm_NoMessagesSelected_WindowCaption := SourceSettings.AppMessages.MsgsForm_NoMessagesSelected_WindowCaption; //added by fduenas

    MsgRec_BtClose           := SourceSettings.AppMessages.MsgRec_BtClose;
    MsgRec_WindowCaption     := SourceSettings.AppMessages.MsgRec_WindowCaption;
    MsgRec_Title             := SourceSettings.AppMessages.MsgRec_Title;
    MsgRec_LabelFrom         := SourceSettings.AppMessages.MsgRec_LabelFrom;
    MsgRec_LabelDate         := SourceSettings.AppMessages.MsgRec_LabelDate;
    MsgRec_LabelSubject      := SourceSettings.AppMessages.MsgRec_LabelSubject;
    MsgRec_LabelMessage      := SourceSettings.AppMessages.MsgRec_LabelMessage;
    MsgSend_BtSend           := SourceSettings.AppMessages.MsgSend_BtSend;
    MsgSend_BtCancel         := SourceSettings.AppMessages.MsgSend_BtCancel;
    MsgSend_WindowCaption    := SourceSettings.AppMessages.MsgSend_WindowCaption;
    MsgSend_Title            := SourceSettings.AppMessages.MsgSend_Title;
    MsgSend_GroupTo          := SourceSettings.AppMessages.MsgSend_GroupTo;
    MsgSend_RadioUser        := SourceSettings.AppMessages.MsgSend_RadioUser;
    MsgSend_RadioAll         := SourceSettings.AppMessages.MsgSend_RadioAll;
    MsgSend_GroupMessage     := SourceSettings.AppMessages.MsgSend_GroupMessage;
    MsgSend_LabelSubject     := SourceSettings.AppMessages.MsgSend_LabelSubject; //added by fduenas
    MsgSend_LabelMessageText := SourceSettings.AppMessages.MsgSend_LabelMessageText; //added by fduenas
  end;

  UserSettings.WindowsPosition := SourceSettings.WindowsPosition;
end;

{$IFDEF DELPHI9_UP} {$ENDREGION} {$ENDIF}

{$IFDEF DELPHI9_UP} {$REGION 'Criptografia'} {$ENDIF}

const
  Codes64 = '0A1B2C3D4E5F6G7H89IjKlMnOPqRsTuVWXyZabcdefghijkLmNopQrStUvwxYz+/';
  C1      = 52845;
  C2      = 22719;

function Decode(const S: ansistring): ansistring;
const
  Map: array[char] of Byte = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 62, 0, 0, 0, 63, 52, 53,
    54, 55, 56, 57, 58, 59, 60, 61, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2,
    3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19,
    20, 21, 22, 23, 24, 25, 0, 0, 0, 0, 0, 0, 26, 27, 28, 29, 30,
    31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45,
    46, 47, 48, 49, 50, 51, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0);
var
  I: longint;
begin
  case Length(S) of
    2:
    begin
      I := Map[S[1]] + (Map[S[2]] shl 6);
      SetLength(Result, 1);
      Move(I, Result[1], Length(Result));
    end;
    3:
    begin
      I := Map[S[1]] + (Map[S[2]] shl 6) + (Map[S[3]] shl 12);
      SetLength(Result, 2);
      Move(I, Result[1], Length(Result));
    end;
    4:
    begin
      I := Map[S[1]] + (Map[S[2]] shl 6) + (Map[S[3]] shl 12) + (Map[S[4]] shl 18);
      SetLength(Result, 3);
      Move(I, Result[1], Length(Result));
    end
  end;
end;

function Encode(const S: ansistring): ansistring;
const
  Map: array[0..63] of char = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
var
  I: longint;
begin
  I := 0;
  Move(S[1], I, Length(S));
  case Length(S) of
    1:
      Result := Map[I mod 64] + Map[(I shr 6) mod 64];
    2:
      Result := Map[I mod 64] + Map[(I shr 6) mod 64] + Map[(I shr 12) mod 64];
    3:
      Result := Map[I mod 64] + Map[(I shr 6) mod 64] + Map[(I shr 12) mod 64] + Map[(I shr 18) mod 64];
  end;
end;

function InternalDecrypt(const S: ansistring; Key: Word): ansistring;
var
  I:    Word;
  Seed: int64;
begin
  Result := S;
  Seed   := Key;
  for I := 1 to Length(Result) do
  begin
    Result[I] := char(byte(Result[I]) xor (Seed shr 8));
    Seed      := (byte(S[I]) + Seed) * word(C1) + word(C2);
  end;
end;

function PreProcess(const S: ansistring): ansistring;
var
  SS: ansistring;
begin
  SS     := S;
  Result := '';
  while SS <> '' do
  begin
    Result := Result + Decode(Copy(SS, 1, 4));
    Delete(SS, 1, 4);
  end;
end;

function Decrypt(const S: ansistring; Key: Word): ansistring;
begin
  Result := InternalDecrypt(PreProcess(S), Key);
end;

function PostProcess(const S: ansistring): ansistring;
var
  SS: ansistring;
begin
  SS     := S;
  Result := '';
  while SS <> '' do
  begin
    Result := Result + Encode(Copy(SS, 1, 3));
    Delete(SS, 1, 3);
  end;
end;

function InternalEncrypt(const S: ansistring; Key: Word): ansistring;
var
  I:    Word;
  Seed: int64;
begin
  Result := S;
  Seed   := Key;
  for I := 1 to Length(Result) do
  begin
    Result[I] := char(byte(Result[I]) xor (Seed shr 8));
    Seed      := (byte(Result[I]) + Seed) * word(C1) + word(C2);
  end;
end;

function Encrypt(const S: ansistring; Key: Word): ansistring;
begin
  Result := PostProcess(InternalEncrypt(S, Key));
end;

function MD5Sum(strValor: String): String;
begin
  Result := md5.MD5Print(md5.MD5String(strValor));
end;

{$IFDEF DELPHI9_UP} {$ENDREGION} {$ENDIF}

{$IFDEF DELPHI9_UP} {$REGION 'TUCAutoLogin'} {$ENDIF}

{ TUCAutoLogin }

procedure TUCAutoLogin.Assign(Source: TPersistent);
begin
  if Source is TUCAutoLogin then
  begin
    Self.Active   := TUCAutoLogin(Source).Active;
    Self.User     := TUCAutoLogin(Source).User;
    Self.Password := TUCAutoLogin(Source).Password;
  end
  else
    inherited;
end;

constructor TUCAutoLogin.Create(AOwner: TComponent);
begin
  inherited Create;
  Self.Active         := False;
  Self.MessageOnError := True;
end;

destructor TUCAutoLogin.Destroy;
begin
  inherited Destroy;
end;

{$IFDEF DELPHI9_UP} {$ENDREGION} {$ENDIF}

{$IFDEF DELPHI9_UP} {$REGION 'TNaoPermitidos'} {$ENDIF}

{ TNaoPermitidos }

procedure TUCNotAllowedItems.Assign(Source: TPersistent);
begin
  if Source is TUCNotAllowedItems then
  begin
    Self.MenuVisible   := TUCNotAllowedItems(Source).MenuVisible;
    Self.ActionVisible := TUCNotAllowedItems(Source).ActionVisible; // Consertado Luiz Benvenuto
  end
  else
    inherited;
end;

constructor TUCNotAllowedItems.Create(AOwner: TComponent);
begin
  inherited Create;
  Self.MenuVisible   := True;
  Self.ActionVisible := True;
end;

destructor TUCNotAllowedItems.Destroy;
begin
  inherited Destroy;
end;

{$IFDEF DELPHI9_UP} {$ENDREGION} {$ENDIF}

{$IFDEF DELPHI9_UP} {$REGION 'TLogControl'} {$ENDIF}

{ TLogControl }

constructor TUCLogControl.Create(AOwner: TComponent);
begin
  inherited Create;
  Self.Active := True;
end;

destructor TUCLogControl.Destroy;
begin
  inherited Destroy;
end;

procedure TUCLogControl.Assign(Source: TPersistent);
begin
  if Source is TUCLogControl then
  begin
    Self.Active   := TUCLogControl(Source).Active;
    Self.TableLog := TUCLogControl(Source).TableLog;
    Self.MenuItem := TUCLogControl(Source).MenuItem;
    Self.Action   := TUCLogControl(Source).Action;
  end
  else
    inherited;
end;

procedure TUCLogControl.SetAction(const Value: TAction);
begin
  FAction := Value;
  if Value <> nil then
  begin
    Self.MenuItem := nil;
    Value.FreeNotification(Self.Action);
  end;
end;

procedure TUCLogControl.SetMenuItem(const Value: TMenuItem);
begin
  FMenuItem := Value;
  if Value <> nil then
  begin
    Self.Action := nil;
    Value.FreeNotification(Self.MenuItem);
  end;
end;

{$IFDEF DELPHI9_UP} {$ENDREGION} {$ENDIF}

{$IFDEF DELPHI9_UP} {$REGION 'TCadastroUsuarios'} {$ENDIF}

{ TCadastroUsuarios }

procedure TUCUser.Assign(Source: TPersistent);
begin
  if Source is TUCUser then
  begin
    Self.MenuItem := TUCUser(Source).MenuItem;
    Self.Action   := TUCUser(Source).Action;
  end
  else
    inherited;
end;

constructor TUCUser.Create(AOwner: TComponent);
begin
  inherited Create;
  Self.FProtectAdministrator := True;
  Self.FUsePrivilegedField   := False;
end;

destructor TUCUser.Destroy;
begin
  inherited Destroy;
end;

procedure TUCUser.SetAction(const Value: TAction);
begin
  FAction := Value;
  if Value <> nil then
  begin
    Self.FMenuItem := nil;
    Value.FreeNotification(Self.Action);
  end;
end;

procedure TUCUser.SetMenuItem(const Value: TMenuItem);
begin
  FMenuItem := Value;
  if Value <> nil then
  begin
    Self.Action := nil;
    Value.FreeNotification(Self.MenuItem);
  end;
end;

{$IFDEF DELPHI9_UP} {$ENDREGION} {$ENDIF}

{$IFDEF DELPHI9_UP} {$REGION 'TLogin'} {$ENDIF}

{ TLogin }

constructor TUCLogin.Create(AOwner: TComponent);
begin
  inherited Create;
  AutoLogin    := TUCAutoLogin.Create(nil);
  InitialLogin := TUCInitialLogin.Create(nil);
  if not AutoLogin.MessageOnError then
    AutoLogin.MessageOnError := True;
end;

destructor TUCLogin.Destroy;
begin
  SysUtils.FreeAndNil(Self.FAutoLogin);
  SysUtils.FreeAndNil(Self.FInitialLogin);

  inherited Destroy;
end;

procedure TUCLogin.Assign(Source: TPersistent);
begin
  if Source is TUCLogin then
    Self.MaxLoginAttempts := TUCLogin(Source).MaxLoginAttempts
  else
    inherited;
end;

{$IFDEF DELPHI9_UP} {$ENDREGION} {$ENDIF}

{$IFDEF DELPHI9_UP} {$REGION 'TPerfilUsuarios'} {$ENDIF}

{ TPerfilUsuarios }

constructor TUCUserProfile.Create(AOwner: TComponent);
begin
  inherited Create;
  Self.Active := True;
end;

destructor TUCUserProfile.Destroy;
begin
  inherited Destroy;
end;

procedure TUCUserProfile.Assign(Source: TPersistent);
begin
  if Source is TUCUserProfile then
  begin
    Self.MenuItem := TUCUserProfile(Source).MenuItem;
    Self.Action   := TUCUserProfile(Source).Action;
  end
  else
    inherited;
end;

procedure TUCUserProfile.SetAction(const Value: TAction);
begin
  FAction := Value;
  if Value <> nil then
  begin
    Self.MenuItem := nil;
    Value.FreeNotification(Self.Action);
  end;
end;

procedure TUCUserProfile.SetMenuItem(const Value: TMenuItem);
begin
  FMenuItem := Value;
  if Value <> nil then
  begin
    Self.Action := nil;
    Value.FreeNotification(Self.MenuItem);
  end;
end;

{$IFDEF DELPHI9_UP} {$ENDREGION} {$ENDIF}

{$IFDEF DELPHI9_UP} {$REGION 'TTrocarSenha'} {$ENDIF}

{ TTrocarSenha }
procedure TUCUserPasswordChange.Assign(Source: TPersistent);
begin
  if Source is TUCUserPasswordChange then
  begin
    Self.MenuItem          := TUCUserPasswordChange(Source).MenuItem;
    Self.Action            := TUCUserPasswordChange(Source).Action;
    Self.ForcePassword     := TUCUserPasswordChange(Source).ForcePassword;
    Self.MinPasswordLength := TUCUserPasswordChange(Source).MinPasswordLength;
  end
  else
    inherited;
end;

constructor TUCUserPasswordChange.Create(AOwner: TComponent);
begin
  inherited Create;
  Self.ForcePassword := False;
end;

destructor TUCUserPasswordChange.Destroy;
begin
  inherited Destroy;
end;

procedure TUCUserPasswordChange.SetAction(const Value: TAction);
begin
  FAction := Value;
  if Value <> nil then
  begin
    Self.MenuItem := nil;
    Value.FreeNotification(Self.Action);
  end;
end;

procedure TUCUserPasswordChange.SetMenuItem(const Value: TMenuItem);
begin
  FMenuItem := Value;
  if Value <> nil then
  begin
    Self.Action := nil;
    Value.FreeNotification(Self.MenuItem);
  end;
end;

{$IFDEF DELPHI9_UP} {$ENDREGION} {$ENDIF}

{$IFDEF DELPHI9_UP} {$REGION 'TInitialLogin'} {$ENDIF}

{ TInitialLogin }

procedure TUCInitialLogin.Assign(Source: TPersistent);
begin
  if Source is TUCInitialLogin then
  begin
    Self.User     := TUCInitialLogin(Source).User;
    Self.Password := TUCInitialLogin(Source).Password;
  end
  else
    inherited;
end;

constructor TUCInitialLogin.Create(AOwner: TComponent);
begin
  inherited Create;
  FInitialRights := TStringList.Create;
end;

destructor TUCInitialLogin.Destroy;
begin
  if Assigned(Self.FInitialRights) then
    Self.InitialRights.Free;
  inherited Destroy;
end;

procedure TUCInitialLogin.SetInitialRights(const Value: TStrings);
begin
  FInitialRights.Assign(Value);
end;

{$IFDEF DELPHI9_UP} {$ENDREGION} {$ENDIF}

{$IFDEF DELPHI9_UP} {$REGION 'TUCControlRight'} {$ENDIF}

{ TUCControlRight }

procedure TUCControlRight.Assign(Source: TPersistent);
begin
  if Source is TUCControlRight then
    Self.ActionList := TUCControlRight(Source).ActionList
  {.$IFDEF UCACTMANAGER}
  {.$ENDIF}
  else
    inherited;
end;

constructor TUCControlRight.Create(AOwner: TComponent);
begin
  inherited Create;
end;

destructor TUCControlRight.Destroy;
begin
  inherited Destroy;
end;

procedure TUCControlRight.SetActionList(const Value: TActionList);
begin
  FActionList := Value;
  if Value <> nil then
  begin
    Value.FreeNotification(Self.ActionList);
    ActionManager     := nil;
    ActionMainMenuBar := nil;
    MainMenu          := nil;
  end;
end;

{.$IFDEF UCACTMANAGER}
procedure TUCControlRight.SetActionMainMenuBar(const Value: TActionMainMenuBar);
begin
  FActionMainMenuBar := Value;
  if Value <> nil then
  begin
    Value.FreeNotification(Self.ActionMainMenuBar);
    ActionList    := nil;
    ActionManager := nil;
    MainMenu      := nil;
  end;
end;

procedure TUCControlRight.SetActionManager(const Value: TActionManager);
begin
  FActionManager := Value;
  if Value <> nil then
  begin
    Value.FreeNotification(Self.ActionManager);
    ActionList        := nil;
    ActionMainMenuBar := nil;
    MainMenu          := nil;
  end;
end;

{.$ENDIF}

procedure TUCControlRight.SetMainMenu(const Value: TMenu);
begin
  FMainMenu := Value;
  if Value <> nil then
  begin
    Value.FreeNotification(Self.MainMenu);
    ActionList        := nil;
    ActionMainMenuBar := nil;
    ActionManager     := nil;
  end;
end;

{$IFDEF DELPHI9_UP} {$ENDREGION} {$ENDIF}

{$IFDEF DELPHI9_UP} {$REGION 'TUCAppMessage'} {$ENDIF}

{ TUCAppMessage }

procedure TUCApplicationMessage.CheckMessages;

  function FmtDtHr(dt: String): String;
  begin
    Result := Copy(dt, 7, 2) + '/' + Copy(dt, 5, 2) + '/' + Copy(dt, 1, 4) + ' ' + Copy(dt, 9, 2) + ':' + Copy(dt, 11, 2);
  end;

begin
  if not FReady then
    Exit;

  with Self.UserControl.DataConnector.UCGetSQLDataset('SELECT UCM.IdMsg, ' +
      'UCC.' + Self.UserControl.TableUsers.FieldUserName + ' AS De, ' +
      'UCC_1.' + Self.UserControl.TableUsers.FieldUserName + ' AS Para, ' +
      'UCM.Subject, ' +
      'UCM.Msg, ' +
      'UCM.DtSend, ' +
      'UCM.DtReceive ' +
      'FROM (' + Self.TableMessages + ' UCM INNER JOIN ' + Self.UserControl.TableUsers.TableName + ' UCC ON UCM.UsrFrom = UCC.' + Self.UserControl.TableUsers.FieldUserID + ') INNER JOIN ' +
      Self.UserControl.TableUsers.TableName + ' UCC_1 ON UCM.UsrTo = UCC_1.' + Self.UserControl.TableUsers.FieldUserID + ' where UCM.DtReceive is NULL and  UCM.UsrTo = ' + IntToStr(Self.UserControl.CurrentUser.UserID)) do
  begin
    while not EOF do
    begin
      MsgRecForm                   := TMsgRecForm.Create(Self);
      MsgRecForm.stDe.Caption      := FieldByName('De').AsString;
      MsgRecForm.stData.Caption    := FmtDtHr(FieldByName('DtSend').AsString);
      MsgRecForm.stAssunto.Caption := FieldByName('Subject').AsString;
      MsgRecForm.MemoMsg.Text      := FieldByName('msg').AsString;
      Self.UserControl.DataConnector.UCExecSQL('Update ' + Self.TableMessages + ' set DtReceive =  ' +
        QuotedStr(FormatDateTime('YYYYMMDDhhmm', now)) +
        ' Where  idMsg = ' + FieldByName('idMsg').AsString);
      MsgRecForm.Show;
      Next;
    end;
    Close;
    Free;
  end;
end;

constructor TUCApplicationMessage.Create(AOWner: TComponent);
begin
  inherited Create(AOWner);
  FReady := False;
  if csDesigning in ComponentState then
  begin
    if Self.TableMessages = '' then
      Self.TableMessages := 'UCTABMESSAGES';
    Interval := 60000;
    Active := True;
  end;
  Self.FVerifThread                 := TUCVerificaMensagemThread.Create(False);
  Self.FVerifThread.AOwner          := Self;
  Self.FVerifThread.FreeOnTerminate := True;
end;

destructor TUCApplicationMessage.Destroy;
begin

  if not (csDesigning in ComponentState) then
    if Assigned(UserControl) then
      Usercontrol.DeleteLoginMonitor(Self);

  Self.FVerifThread.Terminate;

  inherited Destroy;
end;

procedure TUCApplicationMessage.DeleteAppMessage(IdMsg: Integer);
begin
  if MessageDlg(FUserControl.UserSettings.AppMessages.MsgsForm_PromptDelete, mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;
  UserControl.DataConnector.UCExecSQL('Delete from ' + TableMessages + ' where IdMsg = ' + IntToStr(idMsg));
end;

procedure TUCApplicationMessage.Loaded;
begin
  inherited;
  if not (csDesigning in ComponentState) then
  begin
    if not Assigned(FUserControl) then
      raise Exception.Create('Component UserControl not defined!');
    Usercontrol.AddLoginMonitor(Self);
    if not FUserControl.DataConnector.UCFindTable(TableMessages) then
      FUserControl.CriaTabelaMsgs(TableMessages);
  {    FVerifThread := TVerifThread.Create(True);
      FVerifThread.AOwner := Self;
      FVerifThread.FreeOnTerminate := True;}
  end;
  FReady := True;
end;

procedure TUCApplicationMessage.Notification(AComponent: TComponent; AOperation: TOperation);
begin
  if AOperation = opRemove then
    if AComponent = FUserControl then
      FUserControl := nil;
  inherited Notification(AComponent, AOperation);
end;

procedure TUCApplicationMessage.SendAppMessage(ToUser: Integer; Subject, Msg: String);
var
  UltId: Integer;
begin
  with UserControl.DataConnector.UCGetSQLDataset('Select Max(idMsg) as nr from ' + TableMessages) do
  begin
    UltID := FieldByName('nr').AsInteger + 1;
    Close;
    Free;
  end;
  UserControl.DataConnector.UCExecSQL('Insert into ' + TableMessages + '( idMsg, UsrFrom, UsrTo, Subject, Msg, DtSend) Values (' +
    IntToStr(UltId) + ', ' +
    IntToStr(UserControl.CurrentUser.UserID) + ', ' +
    IntToStr(toUser) + ', ' +
    QuotedStr(Subject) + ', ' +
    QuotedStr(Msg) + ', ' +
    QuotedStr(FormatDateTime('YYYYMMDDHHMM', now)) + ')');

end;

procedure TUCApplicationMessage.SetActive(const Value: Boolean);
begin
  FActive := Value;
  if (csDesigning in ComponentState) then
    exit;
  if FActive then
    FVerifThread.Resume
  else
    FVerifThread.Suspend;
end;

procedure TUCApplicationMessage.SetUserControl(const Value: TUserControl);
begin
  FUserControl := Value;
  if Value <> nil then
    Value.FreeNotification(self);
end;

procedure TUCApplicationMessage.ShowMessages;
begin
  try
    MsgsForm := TMsgsForm.Create(self);
    with FUserControl.UserSettings.AppMessages do
    begin
      MsgsForm.Caption              := MsgsForm_WindowCaption;
      MsgsForm.btnova.Caption       := MsgsForm_BtNew;
      MsgsForm.btResponder.Caption  := MsgsForm_BtReplay;
      MsgsForm.btEncaminhar.Caption := MsgsForm_BtForward;
      MsgsForm.btExcluir.Caption    := MsgsForm_BtDelete;
      MsgsForm.btClose.Caption      := MsgsForm_BtClose;

      MsgsForm.ListView1.Columns[0].Caption := MsgsForm_ColFrom;
      MsgsForm.ListView1.Columns[1].Caption := MsgsForm_ColSubject;
      MsgsForm.ListView1.Columns[2].Caption := MsgsForm_ColDate;
    end;

    MsgsForm.DSMsgs := UserControl.DataConnector.UCGetSQLDataset('SELECT UCM.IdMsg, UCM.UsrFrom, UCC.' + Self.UserControl.TableUsers.FieldUserName + ' AS De, UCC_1.' + Self.UserControl.TableUsers.FieldUserName + ' AS Para, UCM.Subject, UCM.Msg, UCM.DtSend, UCM.DtReceive ' +
      'FROM (' + TableMessages + ' UCM INNER JOIN ' + UserControl.TableUsers.TableName + ' UCC ON UCM.UsrFrom = UCC.' + Self.UserControl.TableUsers.FieldUserID + ') ' +
      ' INNER JOIN ' + UserControl.TableUsers.TableName + ' UCC_1 ON UCM.UsrTo = UCC_1.' + Self.UserControl.TableUsers.FieldUserID + ' WHERE UCM.UsrTo = ' + IntToStr(UserControl.CurrentUser.UserID) + ' ORDER BY UCM.DtReceive DESC');
    MsgsForm.DSMsgs.Open;
    MsgsForm.DSUsuarios := UserControl.DataConnector.UCGetSQLDataset('SELECT ' +
      UserControl.TableUsers.FieldUserID + ' as idUser, ' +
      UserControl.TableUsers.FieldLogin + ' as Login, ' +
      UserControl.TableUsers.FieldUserName + ' as Nome, ' +
      UserControl.TableUsers.FieldPassword + ' as Senha, ' +
      UserControl.TableUsers.FieldEmail + ' as Email, ' +
      UserControl.TableUsers.FieldPrivileged + ' as Privilegiado, ' +
      UserControl.TableUsers.FieldTypeRec + ' as Tipo, ' +
      UserControl.TableUsers.FieldProfile + ' as Perfil ' +
      ' FROM ' + UserControl.TableUsers.TableName +
      ' WHERE ' + UserControl.TableUsers.FieldUserID + ' <> ' + IntToStr(UserControl.CurrentUser.UserID) +
      ' AND ' + UserControl.TableUsers.FieldTypeRec + ' = ' + QuotedStr('U') +
      ' ORDER BY ' + UserControl.TableUsers.FieldUserName);
    MsgsForm.DSUsuarios.Open;

    MsgsForm.Position := Self.FUserControl.UserSettings.WindowsPosition;

    MsgsForm.ShowModal;
  finally
  (*
        if Assigned (MsgsForm) then
          SysUtils.FreeAndNil(MsgsForm);
  
  *)  end;
end;

{$IFDEF DELPHI9_UP} {$ENDREGION} {$ENDIF}

{$IFDEF DELPHI9_UP} {$REGION 'TVerifThread'} {$ENDIF}

{ TVerifThread }

procedure TUCVerificaMensagemThread.Execute;
begin
  if (Assigned(TUCApplicationMessage(AOwner).UserControl)) and (TUCApplicationMessage(AOwner).UserControl.CurrentUser.UserID <> 0) then
    Synchronize(VerNovaMansagem);
  Sleep(TUCApplicationMessage(AOwner).Interval);
end;

procedure TUCVerificaMensagemThread.VerNovaMansagem;
begin
  TUCApplicationMessage(AOwner).CheckMessages;
end;

{$IFDEF DELPHI9_UP} {$ENDREGION} {$ENDIF}

{$IFDEF DELPHI9_UP} {$REGION 'TUCCollectionItem'} {$ENDIF}

{ TUCCollectionItem }

function TUCExtraRightsItem.GetDisplayName: String;
begin
  Result := FormName + '.' + CompName;
  if Result = '' then
    Result := inherited GetDisplayName;
end;

procedure TUCExtraRightsItem.SetFormName(const Value: String);
begin
  if FFormName <> Value then
    FFormName := Value;
end;

procedure TUCExtraRightsItem.SetCompName(const Value: String);
begin
  if FCompName <> Value then
    FCompName := Value;
end;

procedure TUCExtraRightsItem.SetCaption(const Value: String);
begin
  if FCaption <> Value then
    FCaption := Value;
end;

procedure TUCExtraRightsItem.SetGroupName(const Value: String);
begin
  if FGroupName <> Value then
    FGroupname := Value;
end;

{$IFDEF DELPHI9_UP} {$ENDREGION} {$ENDIF}

{$IFDEF DELPHI9_UP} {$REGION 'TUCCollection'} {$ENDIF}

{ TUCCollection }

constructor TUCExtraRights.Create(UCBase: TUserControl);
begin
  inherited Create(TUCExtraRightsItem);
  FUCBase := UCBase;
end;

function TUCExtraRights.Add: TUCExtraRightsItem;
begin
  Result := TUCExtraRightsItem(inherited Add);
end;

function TUCExtraRights.GetItem(Index: Integer): TUCExtraRightsItem;
begin
  Result := TUCExtraRightsItem(inherited GetItem(Index));
end;

procedure TUCExtraRights.SetItem(Index: Integer; Value: TUCExtraRightsItem);
begin
  inherited SetItem(Index, Value);
end;

function TUCExtraRights.GetOwner: TPersistent;
begin
  Result := FUCBase;
end;

{$IFDEF DELPHI9_UP} {$ENDREGION} {$ENDIF}

{$IFDEF DELPHI9_UP} {$REGION 'TUCRun'} {$ENDIF}

{ TUCRun }

procedure TUCExecuteThread.Execute;
begin
  while not self.Terminated do
  begin
    if TUserControl(AOwner).DataConnector.UCFindDataConnection then
      Synchronize(UCStart);
    Sleep(50);
  end;
end;

procedure TUCExecuteThread.UCStart;
begin
  TUserControl(AOwner).Execute;
end;

{$IFDEF DELPHI9_UP} {$ENDREGION} {$ENDIF}

{$IFDEF DELPHI9_UP} {$REGION 'TUControls'} {$ENDIF}

{ TUCControls }

function TUCControls.GetActiveForm: String;
begin
  Result := Owner.Name;
end;

function TUCControls.GetAccessType: String;
begin
  if not Assigned(UserControl) then
    Result := ''
  else
    Result := UserControl.ClassName;
end;

procedure TUCControls.ListComponents(Form: String; List: TStrings);
var
  Contador: Integer;
begin
  List.Clear;
  if not Assigned(UserControl) then
    Exit;
  for Contador := 0 to Pred(UserControl.ExtraRights.Count) do
    if UpperCase(UserControl.ExtraRights[Contador].FormName) = UpperCase(Form) then
      List.Append(UserControl.ExtraRights[Contador].CompName);
end;

procedure TUCControls.ApplyRights;
var
  FListObj:  TStringList;
  TempDS:    TDataset;
  Contador:  Integer;
  SQLStmt:   String;
  ExisteObj: Boolean;
  String1:   String;
  String2:   String;
begin
  // Apply Extra Rights

  if not Assigned(UserControl) then
    Exit;
  with UserControl do
  begin
    if (UserControl.LoginMode = lmActive) and (CurrentUser.UserID = 0) then
      Exit;
    //qmd
{    if UserControl.LoginMode = lmActive then
      and
      repeat
        Application.ProcessMessages;
      until CurrentUser.UserID > 0;}
    FListObj := TStringList.Create;
    Self.ListComponents(Self.Owner.Name, FListObj);

    if UserControl.DataConnector.UCFindDataConnection then
    begin
      // permissoes do usuario
      SQLStmt := Format('SELECT %s AS UserID,' +
        '       %s AS ObjName,' +
        '       %s AS UCKey ' +
        'FROM %sEX ' +
        'WHERE %s = %d AND ' +
        '      %s = %s AND ' +
        '      %s = %s',
        [TableRights.FieldUserID,
        TableRights.FieldComponentName,
        TableRights.FieldKey,
        TableRights.TableName,
        TableRights.FieldUserID,
        CurrentUser.UserID,
        TableRights.FieldModule,
        QuotedStr(ApplicationID),
        TableRights.FieldFormName,
        QuotedStr(Self.Owner.Name)]);

      TempDS := DataConnector.UCGetSQLDataset(SQLStmt);

      for Contador := 0 to Pred(FListObj.Count) do
      begin
        UnlockEX(TCustomForm(Self.Owner), FListObj[Contador]);

        ExisteObj := (not TempDS.Locate('ObjName', FListObj[Contador], []));

        case Self.UserControl.Criptografia of
          cPadrao:
          begin
            String1 := Decrypt(TempDS.FieldByName('UCKey').AsString, EncryptKey);
            String2 := TempDS.FieldByName('UserID').AsString + TempDS.FieldByName('ObjName').AsString;
          end;
          cMD5:
          begin
            String1 := TempDS.FieldByName('UCKey').AsString;
            String2 := MD5Sum(TempDS.FieldByName('UserID').AsString + TempDS.FieldByName('ObjName').AsString);
          end;
        end;

        if not ExisteObj or (String1 <> String2) then
          LockEX(TCustomForm(Self.Owner), FListObj[Contador], NotAllowed = naDisabled);
      end;
      TempDS.Close;

      //permissoes do grupo
      SQLStmt := Format('SELECT' +
        '      %s AS UserID,' +
        '      %s AS ObjName,' +
        '      %s AS UCKey ' +
        'FROM %sEX ' +
        'WHERE %s = %d AND ' +
        '      %s = %s AND ' +
        '      %s = %s',
        [TableRights.FieldUserID,
        TableRights.FieldComponentName,
        TableRights.FieldKey,
        TableRights.TableName,
        TableRights.FieldUserID,
        CurrentUser.Profile,
        TableRights.FieldModule,
        QuotedStr(ApplicationID),
        TableRights.FieldFormName,
        QuotedStr(Self.Owner.Name)]);

      TempDS := DataConnector.UCGetSQLDataset(SQLStmt);

      for contador := 0 to Pred(FListObj.Count) do
      begin
        ExisteObj := (TempDS.Locate('ObjName', FListObj[Contador], []));

        case Self.UserControl.Criptografia of
          cPadrao:
          begin
            String1 := Decrypt(TempDS.FieldByName('UCKey').AsString, EncryptKey);
            String2 := TempDS.FieldByName('UserID').AsString + TempDS.FieldByName('ObjName').AsString;
          end;
          cMD5:
          begin
            String1 := TempDS.FieldByName('UCKey').AsString;
            String2 := MD5Sum(TempDS.FieldByName('UserID').AsString + TempDS.FieldByName('ObjName').AsString);
          end;
        end;

        if ExisteObj and (String1 = String2) then
          UnlockEX(TCustomForm(Self.Owner), FListObj[Contador]);
      end;
      TempDS.Close;
    end
    else
      LockControls;
  end;

  FreeAndNil(FListObj);
end;

procedure TUCControls.LockControls;
var
  Contador: Integer;
  FListObj: TStringList;
begin
  FListObj := TStringList.Create;
  Self.ListComponents(Self.Owner.Name, FListObj);
  for Contador := 0 to Pred(FListObj.Count) do
    UserControl.LockEX(TCustomForm(Self.Owner), FListObj[Contador], NotAllowed = naInvisible);
  FreeAndNil(FListObj);
end;

procedure TUCControls.Loaded;
begin
  inherited;
  if not (csDesigning in ComponentState) then
  begin
    ApplyRights;
    UserControl.AddUCControlMonitor(Self);
  end;
end;

procedure TUCControls.SetGroupName(const Value: String);
var
  Contador: Integer;
begin
  if FGroupName = Value then
    Exit;
  FGroupName := Value;
  if Assigned(UserControl) then
    for Contador := 0 to Pred(UserControl.ExtraRights.Count) do
      if UpperCase(UserControl.ExtraRights[Contador].FormName) = UpperCase(Owner.Name) then
        UserControl.ExtraRights[Contador].GroupName := Value;
end;

destructor TUCControls.Destroy;
begin
  if not (csDesigning in ComponentState) then
    if Assigned(UserControl) then
      UserControl.DeleteUCControlMonitor(Self);

  inherited Destroy;
end;

procedure TUCControls.SetUserControl(const Value: TUserControl);
begin
  FUserControl := Value;
  if Value <> nil then
    Value.FreeNotification(self.UserControl);
end;

procedure TUCControls.Notification(AComponent: TComponent; AOperation: TOperation);
begin
  if AOperation = opRemove then
    if AComponent = FUserControl then
      FUserControl := nil;

  inherited Notification(AComponent, AOperation);
end;

{$IFDEF DELPHI9_UP} {$ENDREGION} {$ENDIF}

{$IFDEF DELPHI9_UP} {$REGION 'TUCGUID'} {$ENDIF}

{ TUCGUID }

class function TUCGUID.EmptyGUID: TGUID;
begin
  Result := FromString('{00000000-0000-0000-0000-000000000000}');
end;

class function TUCGUID.EqualGUIDs(GUID1, GUID2: TGUID): Boolean;
begin
  Result := IsEqualGUID(Guid1, Guid2);
end;

class function TUCGUID.FromString(Value: String): TGUID;
begin
  Result := StringToGuid(Value);
end;

class function TUCGUID.IsEmptyGUID(GUID: TGUID): Boolean;
begin
  Result := EqualGuids(Guid, EmptyGuid);
end;

class function TUCGUID.NovoGUID: TGUID;
var
  GUID: TGUID;
begin
  CreateGUID(GUID);
  Result := GUID;
end;

class function TUCGUID.NovoGUIDString: String;
begin
  Result := ToString(NovoGUID);
end;

class function TUCGUID.ToQuotedString(GUID: TGUID): String;
begin
  Result := QuotedStr(ToString(Guid));
end;

class function TUCGUID.ToString(GUID: TGUID): String;
begin
  Result := GuidToString(Guid);
end;

{$IFDEF DELPHI9_UP} {$ENDREGION} {$ENDIF}

{$IFDEF DELPHI9_UP} {$REGION 'TUSERLOGGED'} {$ENDIF}
{ TUserLogged }

procedure TUCUsersLogged.AddCurrentUser;
var
  SQLStmt: String;
begin
  if not Active then
    Exit;
  with FUserControl do
  begin
    CurrentUser.IDLogon := TUCGUID.NovoGUIDString;
    SQLStmt             := Format('INSERT INTO %s (%s, %s, %s, %s, %s) Values( %s, %d, %s, %s, %s)',
      [TableUsersLogged.TableName,
      TableUsersLogged.FieldLogonID,
      TableUsersLogged.FieldUserID,
      TableUsersLogged.FieldApplicationID,
      TableUsersLogged.FieldMachineName,
      TableUsersLogged.FieldData,
      QuotedStr(CurrentUser.IDLogon),
      CurrentUser.UserID,
      QuotedStr(ApplicationID),
      QuotedStr(GetLocalComputerName),
      QuotedStr(FormatDateTime('dd/mm/yy hh:mm', now))]);
    DataConnector.UCExecSQL(SQLStmt);
  end;
end;

procedure TUCUsersLogged.Assign(Source: TPersistent);
begin
  inherited;

end;

constructor TUCUsersLogged.Create(AOwner: TComponent);
begin
  inherited Create;
  FUserControl := TUserControl(AOwner);
  Self.FAtive  := True;
end;

procedure TUCUsersLogged.CriaTableUserLogado;
var
  SQLStmt: String;
begin
  if not Active then
    Exit;

  with FUserControl.TableUsersLogged do
    SQLStmt := Format('CREATE TABLE %s (%s CHAR(38), %s INT, %s VARCHAR(50), %s VARCHAR(50), %s VARCHAR(14))',
      [TableName,
      FieldLogonID,
      FieldUserID,
      FieldApplicationID,
      FieldMachineName,
      FieldData]);
  FUserControl.DataConnector.UCExecSQL(SQLStmt);
end;

procedure TUCUsersLogged.DelCurrentUser;
var
  SQLStmt: String;
begin
  if not Active then
    Exit;

  if Assigned(FUserControl.DataConnector) = False then
    Exit;

  with FUserControl do
  begin
    SQLStmt := Format('DELETE FROM %s WHERE %s = %s',
      [TableUsersLogged.TableName,
      TableUsersLogged.FieldLogonID,
      QuotedStr(CurrentUser.IdLogon)]);

    if Assigned(DataConnector) then
      DataConnector.UCExecSQL(SQLStmt);
  end;
end;

destructor TUCUsersLogged.Destroy;
begin
  inherited Destroy;
end;

procedure TUCUsersLogged.SetAction(const Value: TAction);
begin
  FAction := Value;
  if Value <> nil then
    Value.FreeNotification(Self.Action);
end;

procedure TUCUsersLogged.SetMenuItem(const Value: TMenuItem);
begin
  FMenuItem := Value;
  if Value <> nil then
    Value.FreeNotification(Self.MenuItem);
end;

{$IFDEF DELPHI9_UP} {$ENDREGION} {$ENDIF}

end.
