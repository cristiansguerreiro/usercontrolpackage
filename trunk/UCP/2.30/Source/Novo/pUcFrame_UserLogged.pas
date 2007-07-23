unit pUcFrame_UserLogged;

interface

{$I 'UserControl.inc'}

uses
{$IFDEF DELPHI5}
{$ELSE}
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
  TUCFrame_UsersLogged = class(TFrame)
    dsDados:     TDataSource;
    DBGrid:      TDBGrid;
    Panel3:      TPanel;
    BtExit:      TBitBtn;
    BitMsg:      TBitBtn;
    BitRefresh:  TBitBtn;
    procedure BitRefreshClick(Sender: TObject);
    procedure BitMsgClick(Sender: TObject);
  private
    DSUserLogados: TDataset;
    UCMes : TUCApplicationMessage;
  public
    FUserControl: TUserControl;
    procedure SetWindow;
  end;

implementation

uses UCMessages;

{$R *.dfm}

procedure TUCFrame_UsersLogged.SetWindow;
var
  SQLStmt: String;
 I : Integer; Form : TForm;
begin
  UCMes := nil;
  Form  := Application.MainForm;
  For I := 0 to Form.ComponentCount - 1 do
    Begin
      If ( Form.Components[ I ] is TUCApplicationMessage ) then
        UCMes := TUCApplicationMessage( Form.Components[ I ] );
    end;
  BitMsg.Visible := UCMES <> Nil;


  with FUserControl do
  begin
    SQLStmt :=
      'SELECT U.' + TableUsers.FieldUserName + ' AS UserName,' +
      '       U.' + TableUsers.FieldUserId + ' AS id, ' +
      '       U.' + TableUsers.FieldLogin + ' AS Login,' +
      '       L.' + TableUsersLogged.FieldMachineName + ' AS MachineName,' +
      '       L.' + TableUsersLogged.FieldData + ' AS DATA ' +
      'FROM ' + TableUsersLogged.TableName + ' L ' +
      '    INNER JOIN ' + TableUsers.TableName + ' U ON U.' + TableUsers.FieldUserID + ' = L.' + TableUsersLogged.FieldUserID +
      '    LEFT  JOIN ' + TableUsers.TableName + ' P ON P.' + TableUsers.FieldUserID + ' = U.' + TableUsers.FieldProfile + ' ' +
      'WHERE L.' + TableUsersLogged.FieldApplicationID + ' = ' + QuotedStr(ApplicationID);

    DSUserLogados := DataConnector.UCGetSQLDataset(SQLStmt);

    With UserSettings.UsersLogged do
      Begin
        Caption             := LabelCaption;
        BitMsg.Caption      := BtnMessage;
        BitRefresh.Caption  := BtnRefresh;
        BtExit.Caption      := BtnClose;

        DBGrid.Columns[ 0 ].Title.Caption := ColName;
        DBGrid.Columns[ 1 ].Title.Caption := ColLogin;
        DBGrid.Columns[ 2 ].Title.Caption := ColComputer;
        DBGrid.Columns[ 3 ].Title.Caption := ColData;
      End;


  end;
  dsDados.Dataset := DSUserLogados;
end;

procedure TUCFrame_UsersLogged.BitRefreshClick(Sender: TObject);
begin
  try
    Screen.Cursor := crHourGlass;
    dsDados.DataSet.Close;
    dsDados.DataSet.Open;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TUCFrame_UsersLogged.BitMsgClick(Sender: TObject);
var Msg : String;
begin
  If Assigned( UcMes ) then
    begin
      If InputQuery(fUserControl.UserSettings.UsersLogged.InputText,fUserControl.UserSettings.UsersLogged.InputCaption,Msg) = true then
      UcMes.SendAppMessage( dsDados.DataSet.FieldValues['id'],fUserControl.UserSettings.UsersLogged.MsgSystem,Msg);
    End;
end;

end.

