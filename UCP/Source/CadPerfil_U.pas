{-----------------------------------------------------------------------------
 Unit Name: CadPerfil_U
 Author:    QmD
 Last Change:      25-abr-2005
 Purpose: User profile
 History: Corrected Bug on Apply XPStyle definitions
-----------------------------------------------------------------------------}

unit CadPerfil_U;

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
  IncPerfil_U,
  Menus,
  Messages,
  StdCtrls,
  SysUtils,
  UCBase,
  Windows;

type
  TfrmCadastrarPerfil = class(TForm)
    DBGrid1:     TDBGrid;
    Panel1:      TPanel;
    lbDescricao: TLabel;
    Image1:      TImage;
    Panel3:      TPanel;
    btAdic:      TBitBtn;
    BtAlt:       TBitBtn;
    BtExclui:    TBitBtn;
    BtExit:      TBitBtn;
    DataSource1: TDataSource;
    BtAcess:     TBitBtn;
    procedure BtExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure btAdicClick(Sender: TObject);
    procedure BtAltClick(Sender: TObject);
    procedure BtExcluiClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FIncluirPerfil: TfrmIncluirPerfil;
  public
    FUserControl:          TUserControl;
    FDataSetPerfilUsuario: TDataset;
    procedure SetWindow(Adicionar: Boolean);
  end;

implementation

{$R *.dfm}

procedure TfrmCadastrarPerfil.BtExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCadastrarPerfil.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmCadastrarPerfil.DBGrid1DblClick(Sender: TObject);
begin
  BtAlt.Click;
end;

procedure TfrmCadastrarPerfil.btAdicClick(Sender: TObject);
begin
  try
    FIncluirPerfil              := TfrmIncluirPerfil.Create(Self);
    FIncluirPerfil.FUserControl := Self.FUserControl;
    SetWindow(True);
    FIncluirPerfil.ShowModal;
  finally
    FreeAndNil(FIncluirPerfil);
  end;
end;

procedure TfrmCadastrarPerfil.SetWindow(Adicionar: Boolean);
begin
  with TUserControl(owner).UserSettings.AddChangeProfile do
  begin
    FIncluirPerfil.Caption := WindowCaption;
    if Adicionar then
      FIncluirPerfil.LbDescricao.Caption := LabelAdd
    else
      FIncluirPerfil.LbDescricao.Caption := LabelChange;

    FIncluirPerfil.lbNome.Caption    := LabelName;
    FIncluirPerfil.btGravar.Caption  := BtSave;
    FIncluirPerfil.btCancela.Caption := BtCancel;
    FIncluirPerfil.Position          := Self.FUserControl.UserSettings.WindowsPosition;
  end;
end;

procedure TfrmCadastrarPerfil.BtAltClick(Sender: TObject);
begin
  if FDataSetPerfilUsuario.IsEmpty then
    Exit;
  try
    FIncluirPerfil              := TfrmIncluirPerfil.Create(self);
    FIncluirPerfil.FUserControl := Self.FUserControl;
    SetWindow(False);
    with FIncluirPerfil do
    begin
      FAltera            := True;
      EditDescricao.Text := FDataSetPerfilUsuario.FieldByName('Nome').AsString;
      ShowModal;
    end;
  finally
    FreeAndNil(FIncluirPerfil);
  end;
end;

procedure TfrmCadastrarPerfil.BtExcluiClick(Sender: TObject);
var
  TempID:    Integer;
  CanDelete: Boolean;
  ErrorMsg:  String;
  TempDS:    TDataset;
begin
  if FDataSetPerfilUsuario.IsEmpty then
    Exit;
  TempID := FDataSetPerfilUsuario.FieldByName('IDUser').AsInteger;
  TempDS := FUserControl.DataConnector.UCGetSQLDataset('Select ' + FUserControl.TableUsers.FieldUserID + ' as IdUser from ' +
    FUserControl.TableUsers.TableName +
    ' Where ' + FUserControl.TableUsers.FieldTypeRec + ' = ' + QuotedStr('U') +
    ' AND ' + FUserControl.TableUsers.FieldProfile + ' = ' + IntToStr(TempID));

  if TempDS.FieldByName('IdUser').AsInteger > 0 then
  begin
    TempDS.Close;
    FreeAndNil(TempDS);
    //changed by fduenas: PromptDelete_WindowCaption
    if MessageBox(handle, PChar(Format(FUserControl.UserSettings.UsersProfile.PromptDelete, [FDataSetPerfilUsuario.FieldByName('Nome').AsString])),
      PChar(FUserControl.UserSettings.UsersProfile.PromptDelete_WindowCaption), MB_ICONQUESTION or MB_YESNO or MB_DEFBUTTON2) <> idYes then
      Exit;
  end;
  TempDS.Close;
  FreeAndNil(TempDS);

  CanDelete := True;
  if Assigned(FUserControl.onDeleteProfile) then
    FUserControl.onDeleteProfile(TObject(Owner), TempID, CanDelete, ErrorMsg);
  if not CanDelete then
  begin
    MessageDlg(ErrorMSG, mtWarning, [mbOK], 0);
    Exit;
  end;

  with FUserControl do
  begin
    DataConnector.UCExecSQL('Delete from ' + TableUsers.TableName + ' where ' + TableUsers.FieldUserID + ' = ' + IntToStr(TempID));
    DataConnector.UCExecSQL('Delete from ' + TableRights.TableName + ' where ' + TableRights.FieldUserID + ' = ' + IntToStr(TempID));
    DataConnector.UCExecSQL('Delete from ' + TableRights.TableName + 'EX where ' + TableRights.FieldUserID + ' = ' + IntToStr(TempID));
    DataConnector.UCExecSQL('Update ' + TableUsers.TableName +
      ' Set ' + TableUsers.FieldProfile + ' = null where ' + TableUsers.FieldUserID + ' = ' + IntToStr(TempID));
  end;
  FDataSetPerfilUsuario.Close;
  FDataSetPerfilUsuario.Open;
end;

procedure TfrmCadastrarPerfil.FormShow(Sender: TObject);
begin
  with FUserControl do
  begin
    FDataSetPerfilUsuario := DataConnector.UCGetSQLDataset(
      Format('Select %s as IdUser, %s as Login, %s as Nome, %s as Tipo from %s Where %s  = %s ORDER BY %s',
      [TableUsers.FieldUserID,
      TableUsers.FieldLogin,
      TableUsers.FieldUserName,
      TableUsers.FieldTypeRec,
      TableUsers.TableName,
      TableUsers.FieldTypeRec,
      QuotedStr('P'),
      TableUsers.FieldUserName]));


    DBGrid1.Columns[0].Title.Caption := UserSettings.UsersProfile.ColProfile;
  end;
  DataSource1.Dataset := FDataSetPerfilUsuario;
end;

end.
