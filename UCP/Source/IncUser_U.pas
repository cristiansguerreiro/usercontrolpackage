unit IncUser_U;

interface

{$I 'UserControl.inc'}

uses
{$IFDEF DELPHI5_UP}
  Variants,
{$ENDIF}
  Buttons,
  Classes,
  Controls,
  DB,
  DBCtrls,
  Dialogs,
  ExtCtrls,
  Forms,
  Graphics,
  Messages,
  StdCtrls,
  SysUtils,
  UCBase,
  Windows,
  Spin;

type
  TfrmIncluirUsuario = class(TForm)
    Panel1:         TPanel;
    LbDescricao:    TLabel;
    Image1:         TImage;
    Panel3:         TPanel;
    btGravar:       TBitBtn;
    btCancela:      TBitBtn;
    Panel2:         TPanel;
    lbNome:         TLabel;
    EditNome:       TEdit;
    lbLogin:        TLabel;
    EditLogin:      TEdit;
    lbEmail:        TLabel;
    EditEmail:      TEdit;
    ckPrivilegiado: TCheckBox;
    lbPerfil:       TLabel;
    ComboPerfil:    TDBLookupComboBox;
    btlimpa:        TSpeedButton;
    ckUserExpired: TCheckBox;
    LabelExpira: TLabel;
    SpinExpira: TSpinEdit;
    LabelDias: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCancelaClick(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    function GetNewIdUser: Integer;
    procedure btlimpaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ckUserExpiredClick(Sender: TObject);
  private
    FormSenha : TCustomForm;
    { Private declarations }
  public
    { Public declarations }
    FAltera:      Boolean;
    FUserControl: TUserControl;
  end;

implementation

uses
  CadUser_U,
  SenhaForm_U;

{$R *.dfm}

procedure TfrmIncluirUsuario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmIncluirUsuario.FormCreate(Sender: TObject);
begin
  Self.BorderIcons   := [];
  Self.BorderStyle   := bsDialog;
end;

procedure TfrmIncluirUsuario.btCancelaClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmIncluirUsuario.btGravarClick(Sender: TObject);
var
  vNovaSenha:     String;
  vNome:          String;
  vLogin:         String;
  vEmail:         String;
  vUserExpired  : Integer;
  vNovoIDUsuario: Integer;
  vPerfil:        Integer;
  vPrivilegiado:  Boolean;
begin
  btGravar.Enabled := False;

  with FUserControl do
    if not FAltera then
    begin // inclui user
      if Self.FUserControl.ExisteUsuario(EditLogin.Text) then
      begin
        MessageDlg(Format(FUserControl.UserSettings.CommonMessages.UsuarioExiste, [EditLogin.Text]), mtWarning, [mbOK], 0);
        Exit;
      end;

      FormSenha := TSenhaForm.Create( Self );
      TSenhaForm(FormSenha).Position     := UserSettings.WindowsPosition;      
      TSenhaForm(FormSenha).fUserControl := fUserControl;
      TSenhaForm(FormSenha).Caption      := Format(FUserControl.UserSettings.ResetPassword.WindowCaption, [ EditLogin.Text ]);
      If TSenhaForm(FormSenha).ShowModal <> mrok then
        Begin
          btGravar.Enabled := True;
          Exit;
        End;
      vNovaSenha := TSenhaForm(FormSenha).edtSenha.Text;
      vNovoIDUsuario := GetNewIdUser;
      vNome          := EditNome.Text;
      vLogin         := EditLogin.Text;
      vEmail         := EditEmail.Text;
      FreeAndNil( FormSenha );

      if ComboPerfil.KeyValue = null then
        vPerfil := 0
      else
        vPerfil := ComboPerfil.KeyValue;

      vPrivilegiado := ckPrivilegiado.Checked;
      vUserExpired  := StrToInt(BoolToStr(ckUserExpired.Checked));

      AddUser(vLogin, vNovaSenha, vNome, vEmail, vPerfil, vUserExpired, SpinExpira.Value, vPrivilegiado);

      { TODO -oLuiz -cUpgrade : Consertar a Senha para poder avisar MD5 }
      if (Assigned(MailUserControl)) and (MailUserControl.AdicionaUsuario.Ativo) then
        try
          MailUserControl.EnviaEmailAdicionaUsuario(vNome, vLogin, Encrypt(vNovaSenha, EncryptKey), vEmail, IntToStr(vPerfil), EncryptKey);
        except
          on E: Exception do
            Log(E.Message, llMedio);
        end;

    end
    else
    begin // alterar user
      vNovoIDUsuario := TfrmCadastrarUsuario(Self.Owner).FDataSetCadastroUsuario.FieldByName('IdUser').AsInteger;
      vNome          := EditNome.Text;
      vLogin         := EditLogin.Text;
      vEmail         := EditEmail.Text;
      if ComboPerfil.KeyValue = null then
        vPerfil := 0
      else
        vPerfil := ComboPerfil.KeyValue;

      vUserExpired := StrToInt(BoolToStr(ckUserExpired.Checked)); //Added by Petrus van Breda 28/04/2007
      vPrivilegiado := ckPrivilegiado.Checked;
      ChangeUser(vNovoIDUsuario, vLogin, vNome, vEmail, vPerfil,vUserExpired , SpinExpira.Value, vPrivilegiado);

      { TODO -oLuiz -cUpgrade : Consertar a Senha para poder avisar MD5 }
      if (Assigned(MailUserControl)) and (MailUserControl.AlteraUsuario.Ativo) then
        try
          MailUserControl.EnviaEmailAlteraUsuario(vNome,
            vLogin,
            TfrmCadastrarUsuario(Self.Owner).FDataSetCadastroUsuario.FieldByName('SENHA').AsString,
            vEmail,
            IntToStr(vPerfil),
            EncryptKey);
        except
          on E: Exception do
            Log(E.Message, 2);
        end;
    end;
  TfrmCadastrarUsuario(Owner).FDataSetCadastroUsuario.Close;
  TfrmCadastrarUsuario(Owner).FDataSetCadastroUsuario.Open;

  TfrmCadastrarUsuario(Owner).FDataSetCadastroUsuario.Locate('idUser', vNovoIDUsuario, []);
  Close;
end;

function TfrmIncluirUsuario.GetNewIdUser: Integer;
var
  DataSet: TDataset;
  SQLStmt: String;
begin
  with FUserControl do
  begin
    SQLStmt := Format('SELECT %s.%s FROM %s ORDER BY %s DESC',
      [TableUsers.TableName,
      TableUsers.FieldUserID,
      TableUsers.TableName,
      TableUsers.FieldUserID]);
    try
      DataSet := DataConnector.UCGetSQLDataSet(SQLStmt);
      Result  := DataSet.Fields[0].AsInteger + 1;
      DataSet.Close;
    finally
      SysUtils.FreeAndNil(DataSet);
    end;
  end;
end;

procedure TfrmIncluirUsuario.btLimpaClick(Sender: TObject);
begin
  ComboPerfil.KeyValue := NULL;
end;

procedure TfrmIncluirUsuario.FormShow(Sender: TObject);
begin
  if not FUserControl.UserProfile.Active then
  begin
    lbPerfil.Visible    := False;
    ComboPerfil.Visible := False;
    btLimpa.Visible     := False;
  end
  else
  begin
    ComboPerfil.ListSource.DataSet.Close;
    ComboPerfil.ListSource.DataSet.Open;
  end;

  If FUserControl.Login.ActiveDateExpired = true then    //Op��o de senha so deve aparecer qdo setada como true no componente By Vicente Barros Leonel
    ckPrivilegiado.Visible := FUserControl.User.UsePrivilegedField
  else
    ckUserExpired.Visible := False;

  EditLogin.CharCase     := Self.FUserControl.Login.CharCaseUser;

  SpinExpira.Visible     := ckUserExpired.Visible;
  LabelExpira.Visible    := ckUserExpired.Visible;
  LabelDias.Visible      := ckUserExpired.Visible;

  if (FUserControl.User.ProtectAdministrator) and (EditLogin.Text = FUserControl.Login.InitialLogin.User) then
    EditLogin.Enabled := False;
end;

procedure TfrmIncluirUsuario.ckUserExpiredClick(Sender: TObject);
begin
  SpinExpira.Enabled := ckUserExpired.Checked;
end;

end.

