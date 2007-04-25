unit UsersLogged_U;

interface

uses
{$IFDEF Ver130}
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
  TfrmUsersLogged = class(TForm)
    dsDados:     TDataSource;
    DBGrid:      TDBGrid;
    Panel1:      TPanel;
    lbDescricao: TLabel;
    Panel3:      TPanel;
    BtExit:      TBitBtn;
    BitMsg:      TBitBtn;
    BitRefresh:  TBitBtn;
    Image2:      TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BitRefreshClick(Sender: TObject);
    procedure BitMsgClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    DSUserLogados: TDataset;
    UCMes : TUCApplicationMessage; // Por Vicente Barros Leonel
  public
    FUserControl: TUserControl;
  end;

implementation

{$R *.dfm}

procedure TfrmUsersLogged.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmUsersLogged.FormShow(Sender: TObject);
var
  SQLStmt: String;
begin
  with FUserControl do
  begin
    SQLStmt :=
      'SELECT U.' + TableUsers.FieldUserName + ' AS UserName,' +
      '       U.' + TableUsers.FieldLogin + ' AS Login,' +
      '       L.' + TableUsersLogged.FieldMachineName + ' AS MachineName,' +
      '       L.' + TableUsersLogged.FieldData + ' AS DATA ' +
      'FROM ' + TableUsersLogged.TableName + ' L ' +
      '    INNER JOIN ' + TableUsers.TableName + ' U ON U.' + TableUsers.FieldUserID + ' = L.' + TableUsersLogged.FieldUserID +
      '    LEFT  JOIN ' + TableUsers.TableName + ' P ON P.' + TableUsers.FieldUserID + ' = U.' + TableUsers.FieldProfile + ' ' +
      'WHERE L.' + TableUsersLogged.FieldApplicationID + ' = ' + QuotedStr(ApplicationID);

    DSUserLogados := DataConnector.UCGetSQLDataset(SQLStmt);
  end;
  dsDados.Dataset := DSUserLogados;
end;

procedure TfrmUsersLogged.BitRefreshClick(Sender: TObject);
begin
  //Cesar: 25/07/2005
  try
    Screen.Cursor := crHourGlass;
    dsDados.DataSet.Close;
    dsDados.DataSet.Open;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmUsersLogged.BitMsgClick(Sender: TObject);
var Msg : String;
begin
  //Vicente Barros Leonel
  If Assigned( UcMes ) then
    begin
      If InputQuery('Mensagem','Digite sua mensagem',Msg) = true then
      UcMes.SendAppMessage( dsDados.DataSet.FieldValues['id'],'Mensagem do Sistema',Msg);
    End;
end;

procedure TfrmUsersLogged.FormCreate(Sender: TObject);
Var I : Integer; Form : TForm; { Por Vicente Barros Leonel }
begin
  UCMes := nil;
  Form := Application.MainForm;
  For I := 0 to Form.ComponentCount - 1 do
    Begin
      If ( Form.Components[ I ] is TUCApplicationMessage ) then
        UCMes :=  TUCApplicationMessage( Form.Components[ I ] );
    end;

  BitMsg.Visible := UCMES <> Nil;
end;

procedure TfrmUsersLogged.FormDestroy(Sender: TObject);
begin { Por Vicente Barros Leonel }
  UCMes := Nil;
end;

end.

