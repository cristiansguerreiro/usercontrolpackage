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
  Windows;

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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCancelaClick(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    function GetNewIdUser: Integer;
    procedure btlimpaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
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
  Self.BorderIcons := [];
  Self.BorderStyle := bsDialog;
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
  vNovoIDUsuario: Integer;
  vPerfil:        Integer;
  vPrivilegiado:  Boolean;
  vResultado:     TResultado;
begin
//  btGravar.Enabled := False; - removido qmd

  with FUserControl do
    if not FAltera then
    begin // inclui user
      if Self.FUserControl.ExisteUsuario(EditLogin.Text) then
      begin
        MessageDlg(Format(FUserControl.UserSettings.CommonMessages.UsuarioExiste, [EditLogin.Text]), mtWarning, [mbOK], 0);
        Exit;
      end;

      vResultado := TSenhaForm.Senha(FUserControl.Login.CharCasePass);

      if vResultado.Cancelado then
      begin
//        btGravar.Enabled := True; - removido qmd
        Exit;
      end;

      vNovaSenha := vResultado.Senha;

      vNovoIDUsuario := GetNewIdUser;
      vNome          := EditNome.Text;
      vLogin         := EditLogin.Text;
      vEmail         := EditEmail.Text;
      if ComboPerfil.KeyValue = null then
        vPerfil := 0
      else
        vPerfil := ComboPerfil.KeyValue;

      vPrivilegiado := ckPrivilegiado.Checked;

      AddUser(vLogin, vNovaSenha, vNome, vEmail, vPerfil, vPrivilegiado);

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
      vPrivilegiado := ckPrivilegiado.Checked;
      ChangeUser(vNovoIDUsuario, vLogin, vNome, vEmail, vPerfil, vPrivilegiado);

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
  ckPrivilegiado.Visible := FUserControl.User.UsePrivilegedField;
  if (FUserControl.User.ProtectAdministrator) and (EditLogin.Text = FUserControl.Login.InitialLogin.User) then
    EditLogin.Enabled := False;
  EditLogin.CharCase := FUserControl.Login.CharCaseUser; // aproveitar a propriedade CharCaseUser na criacao do usuario - qmd
end;

end.

