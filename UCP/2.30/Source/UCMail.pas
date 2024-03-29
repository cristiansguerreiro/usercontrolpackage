{-----------------------------------------------------------------------------
 Unit Name: UCMail
 Author:    QmD
 Date:      09-nov-2004
 Purpose: Send Mail messages (forget password, user add/change/password force/etc)
 History: included indy 10 support
-----------------------------------------------------------------------------}


unit UCMail;

interface

{.$I 'UserControl.inc'}


uses
  Classes,
  Dialogs,
  UCALSMTPClient,
  SysUtils,
  UcConsts_Language;

type
  TUCMailMessage = class(TPersistent)
  private
    FAtivo:  Boolean;
    FTitulo: String;
    FLines:  TStrings;
    procedure SetLines(const Value: TStrings);
  protected
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Ativo: Boolean read FAtivo write FAtivo;
    property Titulo: String read FTitulo write FTitulo;
    property Mensagem: TStrings read FLines write SetLines;
  end;

  TUCMEsqueceuSenha = class(TUCMailMessage)
  private
    FLabelLoginForm: String;
    FMailEnviado:    String;
  protected
  public
  published
    property LabelLoginForm: String read FLabelLoginForm write FLabelLoginForm;
    property MensagemEmailEnviado: String read FMailEnviado write FMailEnviado;
  end;

  TMessageTag = procedure(Tag: String; var ReplaceText: String) of object;

  TMailUserControl = class(TComponent)
  private
    FPorta:           Integer;
    FEmailRemetente:  String;
    FUsuario:         String;
    FNomeRemetente:   String;
    FSenha:           String;
    FSMTPServer:      String;
    FAdicionaUsuario: TUCMailMessage;
    FSenhaTrocada:    TUCMailMessage;
    FAlteraUsuario:   TUCMailMessage;
    FSenhaForcada:    TUCMailMessage;
    FEsqueceuSenha:   TUCMEsqueceuSenha;
    fAuthType: TAlSmtpClientAuthType;
    function ParseMailMSG(Nome, Login, Senha, Email, Perfil, txt: String): String;
    function TrataSenha(Senha: String; Key: Word): String;
    procedure onStatus(Status: String);
  protected
    procedure EnviaEmailTp(Nome, Login, USenha, Email, Perfil: String; UCMSG: TUCMailMessage);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure EnviaEmailAdicionaUsuario(Nome, Login, Senha, Email, Perfil: String; Key: Word);
    procedure EnviaEmailAlteraUsuario(Nome, Login, Senha, Email, Perfil: String; Key: Word);
    procedure EnviaEmailSenhaForcada(Nome, Login, Senha, Email, Perfil: String);
    procedure EnviaEmailSenhaTrocada(Nome, Login, Senha, Email, Perfil: String; Key: Word);
    procedure EnviaEsqueceuSenha(Nome, Login, Senha, Email, Perfil: String; Key: Word);
  published
    property AuthType : TAlSmtpClientAuthType read fAuthType write fAuthType;
    property ServidorSMTP: String read FSMTPServer write FSMTPServer;
    property Usuario: String read FUsuario write FUsuario;
    property Senha: String read FSenha write FSenha;
    property Porta: Integer read FPorta write FPorta default 0;
    property NomeRemetente: String read FNomeRemetente write FNomeRemetente;
    property EmailRemetente: String read FEmailRemetente write FEmailRemetente;
    property AdicionaUsuario: TUCMailMessage read FAdicionaUsuario write FAdicionaUsuario;
    property AlteraUsuario: TUCMailMessage read FAlteraUsuario write FAlteraUsuario;
    property EsqueceuSenha: TUCMEsqueceuSenha read FEsqueceuSenha write FEsqueceuSenha;
    property SenhaForcada: TUCMailMessage read FSenhaForcada write FSenhaForcada;
    property SenhaTrocada: TUCMailMessage read FSenhaTrocada write FSenhaTrocada;
  end;

implementation

uses
  UCBase,
  UCEMailForm_U;

{ TMailAdicUsuario }

procedure TUCMailMessage.Assign(Source: TPersistent);
begin
  if Source is TUCMailMessage then
  begin
    Self.Ativo  := TUCMailMessage(Source).Ativo;
    Self.Titulo := TUCMailMessage(Source).Titulo;
    Self.Mensagem.Assign(TUCMailMessage(Source).Mensagem);
  end
  else
    inherited;
end;

constructor TUCMailMessage.Create(AOwner: TComponent);
begin
  FLines := TStringList.Create;
end;

destructor TUCMailMessage.Destroy;
begin
  SysUtils.FreeAndNil(FLines);
  inherited;
end;

procedure TUCMailMessage.SetLines(const Value: TStrings);
begin
  FLines.Assign(Value);
end;

{ TMailUserControl }

constructor TMailUserControl.Create(AOwner: TComponent);
begin
  inherited;
  AdicionaUsuario := TUCMailMessage.Create(self);
  AdicionaUsuario.FLines.Add('Inclus�o de usu�rio');
  AdicionaUsuario.FLines.Add('');
  AdicionaUsuario.fLines.Add('Nome...: :nome');
  AdicionaUsuario.fLines.Add('Login..: :login');
  AdicionaUsuario.fLines.Add('Senha..: :senha');
  AdicionaUsuario.fLines.Add('Email..: :email');
  AdicionaUsuario.fLines.Add('Perfil.: :perfil');
  AdicionaUsuario.fTitulo := 'Inclus�o de usu�rio';


  AlteraUsuario   := TUCMailMessage.Create(self);
  AlteraUsuario.FLines.Add('Altera��o de usu�rio');
  AlteraUsuario.FLines.Add('');
  AlteraUsuario.fLines.Add('Nome...: :nome');
  AlteraUsuario.fLines.Add('Login..: :login');
  AlteraUsuario.fLines.Add('Senha..: :senha');
  AlteraUsuario.fLines.Add('Email..: :email');
  AlteraUsuario.fLines.Add('Perfil.: :perfil');
  AlteraUsuario.fTitulo := 'Altera��o de usu�rio';

  EsqueceuSenha   := TUCMEsqueceuSenha.Create(self);
  EsqueceuSenha.FLines.Add('Esquecia a senha');
  EsqueceuSenha.FLines.Add('');
  EsqueceuSenha.fLines.Add('Nome...: :nome');
  EsqueceuSenha.fLines.Add('Login..: :login');
  EsqueceuSenha.fLines.Add('Senha..: :senha');
  EsqueceuSenha.fLines.Add('Email..: :email');
  EsqueceuSenha.fLines.Add('Perfil.: :perfil');
  EsqueceuSenha.fTitulo := 'Lembrete de senha';

  SenhaForcada    := TUCMailMessage.Create(self);
  SenhaForcada.FLines.Add('Troca de senha for�ada');
  SenhaForcada.FLines.Add('');
  SenhaForcada.fLines.Add('Nome...: :nome');
  SenhaForcada.fLines.Add('Login..: :login');
  SenhaForcada.fLines.Add('Senha..: :senha');
  SenhaForcada.fLines.Add('Email..: :email');
  SenhaForcada.fLines.Add('Perfil.: :perfil');
  SenhaForcada.fTitulo := 'Troca de senha for�ada';

  SenhaTrocada    := TUCMailMessage.Create(self);
  SenhaTrocada.FLines.Add('Altera��o de senha');
  SenhaTrocada.FLines.Add('');
  SenhaTrocada.fLines.Add('Nome...: :nome');
  SenhaTrocada.fLines.Add('Login..: :login');
  SenhaTrocada.fLines.Add('Senha..: :senha');
  SenhaTrocada.fLines.Add('Email..: :email');
  SenhaTrocada.fLines.Add('Perfil.: :perfil');
  SenhaTrocada.fTitulo := 'Altera��o de senha';

  fAuthType       := alsmtpClientAuthPlain;
  if csDesigning in ComponentState then
  begin
    Porta                              := 25;
    AdicionaUsuario.Ativo              := True;
    AlteraUsuario.Ativo                := True;
    EsqueceuSenha.Ativo                := True;
    SenhaForcada.Ativo                 := True;
    SenhaTrocada.Ativo                 := True;
    EsqueceuSenha.LabelLoginForm       := RetornaLingua( ucPortuguesBr, 'Const_Log_LbEsqueciSenha');
    EsqueceuSenha.MensagemEmailEnviado := RetornaLingua( ucPortuguesBr,'Const_Log_MsgMailSend');
  end;

end;

destructor TMailUserControl.Destroy;
begin
  SysUtils.FreeAndNil(FAdicionaUsuario);
  SysUtils.FreeAndNil(FAlteraUsuario);
  SysUtils.FreeAndNil(FEsqueceuSenha);
  SysUtils.FreeAndNil(FSenhaForcada);
  SysUtils.FreeAndNil(FSenhaTrocada);

  inherited;
end;

procedure TMailUserControl.EnviaEmailAdicionaUsuario(Nome, Login, Senha, Email, Perfil: String; Key: Word);
begin
  Senha := TrataSenha(Senha, Key);
  EnviaEmailTP(Nome, Login, Senha, Email, Perfil, AdicionaUsuario);
end;

procedure TMailUserControl.EnviaEmailAlteraUsuario(Nome, Login, Senha, Email, Perfil: String; Key: Word);
begin
  Senha := TrataSenha(Senha, Key);
  EnviaEmailTP(Nome, Login, Senha, Email, Perfil, AlteraUsuario);
end;

procedure TMailUserControl.EnviaEmailSenhaForcada(Nome, Login, Senha, Email, Perfil: String);
begin
  EnviaEmailTP(Nome, Login, Senha, Email, Perfil, SenhaForcada);
end;

procedure TMailUserControl.EnviaEmailSenhaTrocada(Nome, Login, Senha, Email, Perfil: String; Key: Word);
begin
  EnviaEmailTP(Nome, Login, Senha, Email, Perfil, SenhaTrocada);
end;

function TMailUserControl.ParseMailMSG(Nome, Login, Senha, Email, Perfil, txt: String): String;
begin
  Txt    := StringReplace(txt, ':nome', nome, [rfReplaceAll]);
  Txt    := StringReplace(txt, ':login', login, [rfReplaceAll]);
  Txt    := StringReplace(txt, ':senha', senha, [rfReplaceAll]);
  Txt    := StringReplace(txt, ':email', email, [rfReplaceAll]);
  Txt    := StringReplace(txt, ':perfil', perfil, [rfReplaceAll]);
  Result := Txt;
end;

procedure TMailUserControl.onStatus( Status : String );
begin
  if not Assigned(UCEMailForm) then Exit;
  UCEMailForm.lbStatus.Caption := Status;
  UCEMailForm.Update;
end;

procedure TMailUserControl.EnviaEmailTp(Nome, Login, USenha, Email, Perfil: String; UCMSG: TUCMailMessage);
var
  MailMsg :  TAlSmtpClient;
  MailRecipients : TStringlist;
  MailHeader : TALSMTPClientHeader;
begin
  if Trim(Email) = '' then
    Exit;
  MailMsg :=  TAlSmtpClient.Create;
  MailMsg.OnStatus     := OnStatus;
  MailRecipients := TStringlist.Create;
  MailHeader := TALSMTPClientHeader.Create;
  MailHeader.From :=  EmailRemetente; //'rodrigo@oxio.com.br';
  MailHeader.SendTo :=  Email ;
  MailRecipients.Append(Email);
  MailHeader.Subject := UCMSG.Titulo;

  try
    try
      UCEMailForm := TUCEMailForm.Create(Self);
      UCEMailForm.lbStatus.Caption := '';
      UCEMailForm.Show;
      UCEMailForm.Update;
      
      MailMsg.SendMail(ServidorSMTP, FPorta, NomeRemetente ,
      MailRecipients, Usuario,  Senha, fAuthType , MailHeader.RawHeaderText,
      ParseMailMSG(Nome, Login, USenha, Email, Perfil, UCMSG.Mensagem.Text));
      
      UCEMailForm.Update;
    except
      on e: Exception do
      begin
        Beep;
        UCEMailForm.Close;
        MessageDlg(E.Message,mtWarning,[mbok],0);
        raise;
      end;
    end;
  finally
    FreeAndNil(MailMsg);
    FreeAndNil(MailHeader);
    FreeAndNil(MailRecipients);
    FreeAndNil(UCEMailForm);
  end;
end;

procedure TMailUserControl.EnviaEsqueceuSenha(Nome, Login, Senha, Email, Perfil: String; Key: Word);
begin
  if Trim(Email) = '' then
    Exit;
  try
    Senha := TrataSenha(Senha, Key);
    EnviaEmailTP(Nome, Login, Senha, Email, Perfil, EsqueceuSenha);
    MessageDlg(EsqueceuSenha.MensagemEmailEnviado, mtInformation, [mbOK], 0);
  except
  end;
end;

function TmailUserControl.TrataSenha(Senha: String; Key: Word): String;
begin
  Result := Decrypt(Senha, Key);
end;

end.
