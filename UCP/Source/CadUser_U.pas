unit CadUser_U;

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
  DBGrids,
  Dialogs,
  ExtCtrls,
  Forms,
  Graphics,
  Grids,
  IncUser_U,
  Menus,
  Messages,
  StdCtrls,
  SysUtils,
  UCBase,
  Windows;

type
  TfrmCadastrarUsuario = class(TForm)
    DataSource1: TDataSource;
    DBGrid1:     TDBGrid;
    Panel1:      TPanel;
    lbDescricao: TLabel;
    Image1:      TImage;
    PopupMenu1:  TPopupMenu;
    Alterar1:    TMenuItem;
    Excluir1:    TMenuItem;
    N1:          TMenuItem;
    Permisses1:  TMenuItem;
    Panel3:      TPanel;
    btAdic:      TBitBtn;
    BtAlt:       TBitBtn;
    BtExclui:    TBitBtn;
    BtAcess:     TBitBtn;
    BtExit:      TBitBtn;
    BtPass:      TBitBtn;
    DataSource2: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtExitClick(Sender: TObject);
    procedure btAdicClick(Sender: TObject);
    procedure BtAltClick(Sender: TObject);
    procedure BtExcluiClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure BtPassClick(Sender: TObject);
    procedure SetWindow(Adicionar: Boolean);
    procedure FDataSetCadastroUsuarioAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
  private
    FLockAdmin:            Boolean;
    FDataSetPerfilUsuario: TDataset;
    FfrmIncluirUsuario:    TfrmIncluirUsuario;
    function GetAveCharSize(Canvas: TCanvas): TPoint;
    function InputSenha(const ACaption, APrompt: String; var Value: String): Boolean;
  public
    FUserControl:            TUserControl;
    FDataSetCadastroUsuario: TDataset;
  end;

implementation

uses
  Consts;

{$R *.dfm}

function TfrmCadastrarUsuario.GetAveCharSize(Canvas: TCanvas): TPoint;
var
  I:      Integer;
  Buffer: array[0..51] of char;
begin
  for I := 0 to 25 do
    Buffer[I] := Chr(I + Ord('A'));
  for I := 0 to 25 do
    Buffer[I + 26] := Chr(I + Ord('a'));
  GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
  Result.X := Result.X div 52;
end;

function TfrmCadastrarUsuario.InputSenha(const ACaption, APrompt: String; var Value: String): Boolean;
var
  Form:         TForm;
  Prompt:       TLabel;
  Edit:         TEdit;
  DialogUnits:  TPoint;
  ButtonTop:    Integer;
  ButtonHeight: Integer;
  ButtonWidth:  Integer;
begin
  Result := False;
  Form   := TForm.Create(Application);
  with Form do
    try
      Canvas.Font := Font;
      DialogUnits := GetAveCharSize(Canvas);
      BorderStyle := bsDialog;
      Caption     := ACaption;
      ClientWidth := MulDiv(180, DialogUnits.X, 4);
      Position    := Self.FUserControl.UserSettings.WindowsPosition;
      Prompt      := TLabel.Create(Form);
      with Prompt do
      begin
        Parent               := Form;
        Caption              := APrompt;
        Left                 := MulDiv(8, DialogUnits.X, 4);
        Top                  := MulDiv(8, DialogUnits.Y, 8);
        Constraints.MaxWidth := MulDiv(164, DialogUnits.X, 4);
        WordWrap             := True;
      end;
      Edit := TEdit.Create(Form);
      with Edit do
      begin
        Parent       := Form;
        Left         := Prompt.Left;
        Top          := Prompt.Top + Prompt.Height + 5;
        Width        := MulDiv(164, DialogUnits.X, 4);
        MaxLength    := 255;
        PasswordChar := '*';
        Text         := Value;
        SelectAll;
      end;
      ButtonTop    := Edit.Top + Edit.Height + 15;
      ButtonWidth  := MulDiv(50, DialogUnits.X, 4);
      ButtonHeight := MulDiv(14, DialogUnits.Y, 8);
      with TButton.Create(Form) do
      begin
        Parent      := Form;
        Caption     := SMsgDlgOK;
        ModalResult := mrOk;
        Default     := True;
        SetBounds(MulDiv(38, DialogUnits.X, 4), ButtonTop, ButtonWidth, ButtonHeight);
      end;
      with TButton.Create(Form) do
      begin
        Parent      := Form;
        Caption     := SMsgDlgCancel;
        ModalResult := mrCancel;
        Cancel      := True;
        Caption     := SMsgDlgCancel;
        SetBounds(MulDiv(92, DialogUnits.X, 4), Edit.Top + Edit.Height + 15, ButtonWidth, ButtonHeight);
        Form.ClientHeight := Top + Height + 13;
      end;
      if ShowModal = mrOk then
      begin
        Value  := Edit.Text;
        Result := True;
      end;
    finally
      Form.Free;
    end;
end;

procedure TfrmCadastrarUsuario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmCadastrarUsuario.BtExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCadastrarUsuario.btAdicClick(Sender: TObject);
begin
  FfrmIncluirUsuario              := TfrmIncluirUsuario.Create(Self);
  FfrmIncluirUsuario.FUserControl := Self.FUserControl;
  SetWindow(True);
  FfrmIncluirUsuario.ShowModal;
  FreeAndNil(FfrmIncluirUsuario);
end;

procedure TfrmCadastrarUsuario.SetWindow(Adicionar: Boolean);
begin
  with TUserControl(owner).UserSettings.AddChangeUser do
  begin
    FfrmIncluirUsuario.Caption := WindowCaption;
    if Adicionar then
      FfrmIncluirUsuario.LbDescricao.Caption := LabelAdd
    else
      FfrmIncluirUsuario.LbDescricao.Caption := LabelChange;

    FfrmIncluirUsuario.lbNome.Caption         := LabelName;
    FfrmIncluirUsuario.lbLogin.Caption        := LabelLogin;
    FfrmIncluirUsuario.lbEmail.Caption        := LabelEmail;
    FfrmIncluirUsuario.ckPrivilegiado.Caption := CheckPrivileged;
    FfrmIncluirUsuario.lbPerfil.Caption       := LabelPerfil;
    FfrmIncluirUsuario.btGravar.Caption       := BtSave;
    FfrmIncluirUsuario.btCancela.Caption      := BtCancel;
    FfrmIncluirUsuario.Position               := Self.FUserControl.UserSettings.WindowsPosition;
  end;
end;

procedure TfrmCadastrarUsuario.BtAltClick(Sender: TObject);
begin
  if FDataSetCadastroUsuario.IsEmpty then
    Exit;
  FfrmIncluirUsuario              := TfrmIncluirUsuario.Create(Self);
  FfrmIncluirUsuario.FUserControl := Self.FUserControl;
  SetWindow(False);
  with FfrmIncluirUsuario do
  begin
    FAltera                := True;
    EditNome.Text          := FDataSetCadastroUsuario.FieldByName('Nome').AsString;
    EditLogin.Text         := FDataSetCadastroUsuario.FieldByName('Login').AsString;
    EditEmail.Text         := FDataSetCadastroUsuario.FieldByName('Email').AsString;
    ComboPerfil.KeyValue   := FDataSetCadastroUsuario.FieldByName('Perfil').AsInteger;
    ckPrivilegiado.Checked := StrToBool(FDataSetCadastroUsuario.FieldByName('Privilegiado').AsString);
    If FDataSetCadastroUsuario.FieldByName('UserNaoExpira').AsInteger = 0 then
      ckUserExpired.Checked := False else ckUserExpired.Checked := True;
    ShowModal;
  end;
  FreeAndNil(FfrmIncluirUsuario);
end;

procedure TfrmCadastrarUsuario.BtExcluiClick(Sender: TObject);
var
  TempID:    Integer;
  CanDelete: Boolean;
  ErrorMsg:  String;
begin
  if FDataSetCadastroUsuario.IsEmpty then
    Exit;
  TempID := FDataSetCadastroUsuario.FieldByName('IDUser').AsInteger;
  //changed by fduenas: using PromptDelete_WindowCaption and Format functiom
  if MessageBox(Handle, PChar(Format(FUserControl.UserSettings.UsersForm.PromptDelete, [FDataSetCadastroUsuario.FieldByName('Login').AsString])), PChar(FUserControl.UserSettings.UsersForm.PromptDelete_WindowCaption), MB_ICONQUESTION or MB_YESNO or MB_DEFBUTTON2) = idYes then
  begin
    CanDelete := True;
    if Assigned(FUserControl.onDeleteUser) then
      FUserControl.onDeleteUser(TObject(Owner), TempID, CanDelete, ErrorMsg);
    if not CanDelete then
    begin
      MessageDlg(ErrorMSG, mtWarning, [mbOK], 0);
      Exit;
    end;

    FUserControl.DataConnector.UCExecSQL('Delete from ' + FUserControl.TableRights.TableName + ' where ' + FUserControl.TableRights.FieldUserID + ' = ' + IntToStr(TempID));
    FUserControl.DataConnector.UCExecSQL('Delete from ' + FUserControl.TableUsers.TableName + ' where ' + FUserControl.TableRights.FieldUserID + ' = ' + IntToStr(TempID));
    FDataSetCadastroUsuario.Close;
    FDataSetCadastroUsuario.Open;
  end;
end;

procedure TfrmCadastrarUsuario.DBGrid1DblClick(Sender: TObject);
begin
  BtAlt.Click;
end;

procedure TfrmCadastrarUsuario.BtPassClick(Sender: TObject);
var
  FNovasenha: String;
  //Nome, Login, Email: String;
begin
  if FDataSetCadastroUsuario.IsEmpty then
    Exit;
  if InputSenha(Format(FUserControl.UserSettings.ResetPassword.WindowCaption, [FDataSetCadastroUsuario.FieldByName('Login').AsString]), FUserControl.UserSettings.ResetPassword.LabelPassword, FNovaSenha) then
    FUserControl.ChangePassword(FDataSetCadastroUsuario.FieldByName('IDUser').AsInteger, FNovaSenha);
(*
  {$IFDEF VER130}
  {$ELSE}
    if (Assigned(FUserControl.MailUserControl)) and (FUserControl.MailUserControl.SenhaForcada.Ativo) then
      try
        with FDataSetCadastroUsuario do
        begin
          Nome  := FieldByName('nome').AsString;
          Login := FieldByName('login').AsString;
          Email := FieldByName('email').AsString;
        end;
        FUserControl.MailUserControl.EnviaEmailSenhaForcada(Nome, Login, FNovasenha, Email, '');
      except
        on E: Exception do
          FUserControl.Log(E.Message, llMedio);
      end;
  {$ENDIF}
*)
end;

procedure TfrmCadastrarUsuario.FDataSetCadastroUsuarioAfterScroll(DataSet: TDataSet);
begin
  if (FLockAdmin) and (Dataset.FieldByName('Login').AsString = TUserControl(Owner).Login.InitialLogin.User) then
  begin
    BtExclui.Enabled := False;
    BtPass.Enabled   := False;
    if TUserControl(Owner).CurrentUser.Username <> TUserControl(Owner).Login.InitialLogin.User then
      BtAcess.Enabled := False;
  end
  else
  begin
    BtExclui.Enabled := True;
    BtPass.Enabled   := True;
    BtAcess.Enabled  := True;
  end;
end;

procedure TfrmCadastrarUsuario.FormShow(Sender: TObject);
begin
  FLockAdmin := FUserControl.User.ProtectAdministrator;

  with FUserControl do
  begin
    FDataSetCadastroUsuario := DataConnector.UCGetSQLDataset(
      Format('Select %s as IdUser, %s as Login, %s as Nome, %s as Email, %s as Perfil, %s as Privilegiado, %s as Tipo, %s as Senha, %s as UserNaoExpira from %s Where %s  = %s ORDER BY %s',
      [TableUsers.FieldUserID, TableUsers.FieldLogin, TableUsers.FieldUserName, TableUsers.FieldEmail, TableUsers.FieldProfile, TableUsers.FieldPrivileged, TableUsers.FieldTypeRec, TableUsers.FieldPassword,
      TableUsers.FieldUserExpired, TableUsers.TableName, TableUsers.FieldTypeRec, QuotedStr('U'), TableUsers.FieldLogin]));


    DBGrid1.Columns[0].Title.Caption := UserSettings.UsersForm.ColName;
    DBGrid1.Columns[1].Title.Caption := UserSettings.UsersForm.ColLogin;
    DBGrid1.Columns[2].Title.Caption := UserSettings.UsersForm.ColEmail;

    FDataSetPerfilUsuario := DataConnector.UCGetSQLDataset(
      Format('Select %s as IdUser, %s as Login, %s as Nome, %s as Tipo from %s Where %s  = %s ORDER BY %s',
      [TableUsers.FieldUserID, TableUsers.FieldLogin, TableUsers.FieldUserName, TableUsers.FieldTypeRec,
      TableUsers.TableName, TableUsers.FieldTypeRec, QuotedStr('P'), TableUsers.FieldUserName]));

  end;

  DataSource1.Dataset                 := FDataSetCadastroUsuario;
  DataSource2.Dataset                 := FDataSetPerfilUsuario;
  FDataSetCadastroUsuario.AfterScroll := FDataSetCadastroUsuarioAfterScroll;
  FDataSetCadastroUsuarioAfterScroll(FDataSetCadastroUsuario);
end;

end.

