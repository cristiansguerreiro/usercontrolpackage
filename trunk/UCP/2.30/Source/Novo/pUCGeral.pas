unit pUCGeral;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, ComCtrls, ExtCtrls, DB,
  UcBase;

type
  TFormUserPerf = class(TForm)
    Panel1: TPanel;
    LbDescricao: TLabel;
    Image1: TImage;
    Panel2: TPanel;
    SpeedUser: TSpeedButton;
    SpeedPerfil: TSpeedButton;
    Panel3: TPanel;
    SpeedLog: TSpeedButton;
    SpeedUserLog: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure SpeedUserClick(Sender: TObject);
    procedure SpeedPerfilClick(Sender: TObject);
    procedure SpeedLogClick(Sender: TObject);
    procedure SpeedUserLogClick(Sender: TObject);
    procedure SpeedUserMouseEnter(Sender: TObject);
    procedure SpeedUserMouseLeave(Sender: TObject);
  protected
    FrmFrame : TCustomFrame;
  private
    procedure FecharFrame(Sender: TObject);
    { Private declarations }
  public
    FUserControl:          TUserControl;
    FDataSetPerfilUsuario: TDataset;
    FDataSetCadastroUsuario: TDataset;
    { Public declarations }
  end;

var
  FormUserPerf: TFormUserPerf;

implementation

uses pUcFrame_User,pUcFrame_Profile,pUCFrame_Log,pUcFrame_UserLogged,
  UCMessages;

{$R *.dfm}
{ ---------------------------------------------------------------------------  }
{ FORM }

procedure TFormUserPerf.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFormUserPerf.FormShow(Sender: TObject);
begin
  with FUserControl do
  begin
    FDataSetCadastroUsuario := DataConnector.UCGetSQLDataset(
      Format('Select %s as IdUser, %s as Login, %s as Nome, %s as Email, %s as Perfil, %s as Privilegiado, %s as Tipo, %s as Senha, %s as UserNaoExpira, %s as DaysOfExpire , %s as UserInative from %s Where %s  = %s ORDER BY %s',
      [TableUsers.FieldUserID, TableUsers.FieldLogin, TableUsers.FieldUserName, TableUsers.FieldEmail, TableUsers.FieldProfile, TableUsers.FieldPrivileged, TableUsers.FieldTypeRec, TableUsers.FieldPassword,
      TableUsers.FieldUserExpired, TableUsers.FieldUserDaysSun, TableUsers.FieldUserInative, TableUsers.TableName, TableUsers.FieldTypeRec, QuotedStr('U'), TableUsers.FieldLogin]));

    FDataSetPerfilUsuario := DataConnector.UCGetSQLDataset(
      Format('Select %s as IdUser, %s as Login, %s as Nome, %s as Tipo from %s Where %s  = %s ORDER BY %s',
      [TableUsers.FieldUserID, TableUsers.FieldLogin, TableUsers.FieldUserName, TableUsers.FieldTypeRec,
      TableUsers.TableName, TableUsers.FieldTypeRec, QuotedStr('P'), TableUsers.FieldUserName]));

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
  end;
  SpeedPerfil.Visible  := FUserControl.UserProfile.Active;
  SpeedLog.Visible     := FUserControl.LogControl.Active;
  SpeedUserLog.Visible := FUserControl.UsersLogged.Active;

  SpeedUserClick(Sender);
  Caption := fUserControl.UserSettings.UsersForm.WindowCaption;

  SpeedUser.Caption    := FUserControl.UserSettings.Log.ColUser;
  SpeedPerfil.Caption  := FUserControl.UserSettings.UsersProfile.ColProfile;
//  SpeedLog.Caption    := FUserControl.UserSettings.Log;
  SpeedUserLog.Caption := FUserControl.UserSettings.UsersLogged.LabelDescricao;

end;

Procedure TFormUserPerf.FecharFrame( Sender : TObject);
Begin
  FreeAndNil( FrmFrame );
  Close;
End;


procedure TFormUserPerf.SpeedPerfilClick(Sender: TObject);
begin
  If FrmFrame Is TFrame_Profile then exit;
  If Assigned( FrmFrame )then
   FreeAndNil( FrmFrame );

  FrmFrame := TFrame_Profile.Create( Self );
  TFrame_Profile(FrmFrame).DataPerfil.DataSet      := FDataSetPerfilUsuario;
  TFrame_Profile(FrmFrame).BtnClose.OnClick        := FecharFrame;
  TFrame_Profile(FrmFrame).Height                  := Panel3.Height;
  TFrame_Profile(FrmFrame).Width                   := Panel3.Width;
  TFrame_Profile(FrmFrame).FDataSetPerfilUsuario   := FDataSetPerfilUsuario;
  TFrame_Profile(FrmFrame).fUsercontrol            := fUserControl;
  TFrame_Profile(FrmFrame).DbGridPerf.Columns[0].Title.Caption := fUserControl.UserSettings.UsersProfile.ColProfile;
  with fUserControl.UserSettings.UsersProfile, TFrame_Profile(FrmFrame) do
  begin
    lbDescricao.Caption := LabelDescription;
    BtnAddPer.Caption   := BtAdd;
    BtnAltPer.Caption   := BtChange;
    BtnExcPer.Caption   := BtDelete;
    BtnAcePer.Caption   := BtRights;
    BtnClose.Caption    := BtClose;
  end;
  FrmFrame.Parent := Panel3;
end;

procedure TFormUserPerf.SpeedUserClick(Sender: TObject);
begin
  If FrmFrame Is TUCFrame_User then exit;
  
  If Assigned( FrmFrame )then
   FreeAndNil( FrmFrame );

  FrmFrame := TUCFrame_User.Create( Self );
  TUCFrame_User(FrmFrame).FDataSetCadastroUsuario  := FDataSetCadastroUsuario;
  TUCFrame_User(FrmFrame).DataUser.DataSet         := TUCFrame_User(FrmFrame).FDataSetCadastroUsuario;
  TUCFrame_User(FrmFrame).DataPerfil.DataSet       := FDataSetPerfilUsuario;
  TUCFrame_User(FrmFrame).BtnClose.OnClick         := FecharFrame;
  TUCFrame_User(FrmFrame).fUsercontrol := fUserControl;
  TUCFrame_User(FrmFrame).Height                  := Panel3.Height;
  TUCFrame_User(FrmFrame).Width                   := Panel3.Width;
  TUCFrame_User(FrmFrame).SetWindow;
  lbDescricao.Caption                             := fUSerControl.UserSettings.UsersForm.LabelDescription;

  FrmFrame.Parent := Panel3;
end;

procedure TFormUserPerf.SpeedUserLogClick(Sender: TObject);
begin
  If FrmFrame Is TUCFrame_UsersLogged then exit;

  If Assigned( FrmFrame )then
    FreeAndNil( FrmFrame );

  FrmFrame := TUCFrame_UsersLogged.Create( Self );
  lbDescricao.Caption := fUSerControl.UserSettings.UsersLogged.LabelDescricao;
  TUCFrame_UsersLogged(FrmFrame).fUserControl    := fUserControl;
  TUCFrame_UsersLogged(FrmFrame).SetWindow;
  TUCFrame_UsersLogged(FrmFrame).Height          := Panel3.Height;
  TUCFrame_UsersLogged(FrmFrame).Width           := Panel3.Width;
  TUCFrame_UsersLogged(FrmFrame).BtExit.OnClick  := FecharFrame;
  FrmFrame.Parent := Panel3;
end;

procedure TFormUserPerf.SpeedUserMouseEnter(Sender: TObject);
begin
  With TSpeedButton(Sender) do
    Begin
      Font.Style := [ fsUnderline ];
      Cursor     := crHandPoint;
    End;
end;

procedure TFormUserPerf.SpeedUserMouseLeave(Sender: TObject);
begin
  With TSpeedButton(Sender) do
    Begin
      Font.Style := [];
      Cursor     := crDefault;
    End;
end;

procedure TFormUserPerf.SpeedLogClick(Sender: TObject);
begin
  If FrmFrame Is TUCFrame_Log then exit;
  If Assigned( FrmFrame )then
    FreeAndNil( FrmFrame );

  FrmFrame := TUCFrame_Log.Create( Self );
  lbDescricao.Caption := fUSerControl.UserSettings.Log.LabelDescription;
  TUCFrame_Log(FrmFrame).fUserControl := fUserControl;
  TUCFrame_Log(FrmFrame).SetWindow;
  TUCFrame_Log(FrmFrame).Height       := Panel3.Height;
  TUCFrame_Log(FrmFrame).Width        := Panel3.Width;
  TUCFrame_Log(FrmFrame).btfecha.OnClick         := FecharFrame;
  FrmFrame.Parent := Panel3;
end;

end.
