unit ViewLog_U;

interface

{$I 'UserControl.inc'}

uses
{$IFDEF DELPHI5_UP}
{$ELSE}
  Variants,
{$ENDIF}
  Buttons,
  Classes,
  ComCtrls,
  Controls,
  DB,
  DBGrids,
  Dialogs,
  ExtCtrls,
  Forms,
  Graphics,
  Grids,
  ImgList,
  Messages,
  StdCtrls,
  SysUtils,
  UCBase,
  UCConsts,
  Windows;

type
  TViewLog = class(TForm)
    Panel1:       TPanel;
    lbDescricao:  TLabel;
    Image1:       TImage;
    Panel2:       TPanel;
    Splitter1:    TSplitter;
    Panel3:       TPanel;
    lbUsuario:    TLabel;
    ComboUsuario: TComboBox;
    Bevel1:       TBevel;
    lbData:       TLabel;
    data1:        TDateTimePicker;
    data2:        TDateTimePicker;
    Bevel2:       TBevel;
    lbNivel:      TLabel;
    ComboNivel:   TComboBox;
    btfiltro:     TBitBtn;
    Bevel3:       TBevel;
    DataSource1:  TDataSource;
    DBGrid1:      TDBGrid;
    ImageList1:   TImageList;
    btfecha:      TBitBtn;
    btexclui:     TBitBtn;
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure ComboNivelDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ComboUsuarioChange(Sender: TObject);
    procedure btfechaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btexcluiClick(Sender: TObject);
    procedure data1Change(Sender: TObject);
    procedure btfiltroClick(Sender: TObject);
  private
    procedure AplicaFiltro;
  public
    ListIdUser:   TStringList;
    DSLog, DSCmd: TDataset;
    UCComponent:  TUserControl;
  end;

implementation

uses
  UCDataInfo;

{$R *.dfm}

procedure TViewLog.FormCreate(Sender: TObject);
begin
  ComboNivel.Items.Clear;
  //Modified by fduenas
  ComboNivel.Items.Append(TUserControl(Owner).UserSettings.Log.OptionLevelLow);        //BGM
  ComboNivel.Items.Append(TUserControl(Owner).UserSettings.Log.OptionLevelNormal);     //BGM
  ComboNivel.Items.Append(TUserControl(Owner).UserSettings.Log.OptionLevelHigh);       //BGM
  ComboNivel.Items.Append(TUserControl(Owner).UserSettings.Log.OptionLevelCritic);     //BGM
  ComboNivel.ItemIndex := 0;
  ComboUsuario.Items.Clear;
  ListIdUser     := TStringList.Create;
  data1.Date     := EncodeDate(StrToInt(FormatDateTime('yyyy', Date)), 1, 1);
  data2.DateTime := Now;

  with Self do
  begin
    Width  := 800;
    Height := 600;
  end;
end;

procedure TViewLog.ComboNivelDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  TempImg: Graphics.TBitmap;
begin
  TempImg := Graphics.TBitmap.Create;
  Imagelist1.GetBitmap(Index, TempImg);
  ComboNivel.Canvas.Draw(Rect.Left + 5, Rect.Top + 1, TempImg);
  ComboNivel.Canvas.TextRect(Rect, Rect.Left + 30, Rect.Top + 2, ComboNivel.items[Index]);
  ComboNivel.Canvas.Draw(Rect.Left + 5, Rect.Top + 1, TempImg);
  FreeAndNil(TempImg);
end;

procedure TViewLog.FormShow(Sender: TObject);
var
  TabelaLog: String;
  SQLStmt:   String;
begin
  with TUserControl(Owner) do
    DSCmd := DataConnector.UCGetSQLDataset(
      Format('SELECT %s AS IDUSER, %s AS NOME FROM %s WHERE %s  = %s ORDER BY %s',
      [TableUsers.FieldUserID,
      TableUsers.FieldUserName,
      TableUsers.TableName,
      TableUsers.FieldTypeRec,
      QuotedStr('U'),
      TableUsers.FieldUserName]));
  ComboUsuario.Items.Append(TUserControl(Owner).UserSettings.Log.OptionUserAll);     //BGM,  modified by fduenas
  ListIdUser.Append('0');
  while not DSCmd.EOF do
  begin
    ComboUsuario.Items.Append(DSCmd.FieldByName('Nome').AsString);
    ListIdUser.Append(DSCmd.FieldByName('idUser').AsString);
    DSCmd.Next;
  end;
  DSCmd.Close;
  FreeAndNil(DSCmd);

  ComboUsuario.ItemIndex := 0;


  TabelaLog := TUserControl(Owner).LogControl.TableLog;
  with TUserControl(Owner) do
  begin
    SQLStmt := 'SELECT ' + TableUsers.TableName + '.' + TableUsers.FieldUserName + ' AS NOME, ' + TabelaLog + '.* from ' + TabelaLog +
      ' LEFT OUTER JOIN ' + TableUsers.TableName + ' on ' + TabelaLog + '.idUser = ' + TableUsers.TableName + '.' + TableUsers.FieldUserID +
      ' WHERE (DATA >=' + QuotedStr(FormatDateTime('yyyyMMddhhmmss', data1.DateTime)) + ') AND (DATA<=' + QuotedStr(FormatDateTime('yyyyMMddhhmmss', data2.DateTime)) + ') ORDER BY DATA DESC';
    DSLog   := DataConnector.UCGetSQLDataset(SQLStmt);
  end;
  DataSource1.Dataset := DSLog;
  btexclui.Enabled    := not DsLog.IsEmpty; //added by fduenas
end;

procedure TViewLog.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  TempImg:  Graphics.TBitmap;
  FData:    System.TDateTime;
  TempData: String;
begin
  if DSLog.IsEmpty then
    Exit;

  if UpperCase(Column.FieldName) = 'NIVEL' then //Done by Petrus v Breda 28/4/2007
  begin
    If Column.Field.AsInteger >= 0 then  // By Vicente Barros Leonel
      { No meu banco de dados, qdo não tinha log dava pau pq o TempIMG era null}
      Begin
        TempImg := Graphics.TBitmap.Create;
        imagelist1.GetBitmap(Column.Field.AsInteger, TempImg);
        DbGrid1.Canvas.Draw((((Rect.Left + Rect.Right) - TempImg.Width) div 2), rect.Top, Tempimg);
        FreeAndNil(TempImg);
      End
    else
      DbGrid1.Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, Column.Field.AsString);
  end
  else
  if UpperCase(Column.FieldName) = 'DATA' then //Done by Petrus v Breda 28/4/2007
  begin
    TempData := Column.Field.AsString;
    FData    := EncodeDate(StrToInt(Copy(Tempdata, 1, 4)), StrToInt(Copy(Tempdata, 5, 2)), StrToInt(Copy(Tempdata, 7, 2))) +
      EncodeTime(StrToInt(Copy(TempData, 9, 2)), StrToInt(Copy(TempData, 11, 2)), StrToInt(Copy(TempData, 13, 2)), 0);
    DbGrid1.Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, DateTimeToStr(FData));
  end
  else
    DbGrid1.Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, Column.Field.AsString);
end;

procedure TViewLog.DBGrid1TitleClick(Column: TColumn);
begin
  ShowMessage(IntToStr(Column.Width));
end;

procedure TViewLog.ComboUsuarioChange(Sender: TObject);
begin
  btFiltro.Enabled := True;
end;

procedure TViewLog.btfechaClick(Sender: TObject);
begin
  Close;
end;

procedure TViewLog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ListIdUser.Free;
  Action := caFree;
end;

procedure TViewLog.btexcluiClick(Sender: TObject);
var
  FTabLog, Temp: String;
begin
  //modified by fduenas
  if MessageBox(Handle, PChar(TUserControl(Owner).UserSettings.Log.PromptDelete),
    PChar(TUserControl(Owner).UserSettings.Log.PromptDelete_WindowCaption), mb_YesNo) <> mrYes then
    exit;

  btFiltro.Enabled := False;
  FTabLog          := TUserControl(Owner).LogControl.TableLog;
  Temp             := 'Delete from ' + FTabLog +
    ' Where (Data >=' + QuotedStr(FormatDateTime('yyyyMMddhhmmss', data1.DateTime)) + ') ' +
    ' and (Data <=' + QuotedStr(FormatDateTime('yyyyMMddhhmmss', data2.DateTime)) + ') ' +
    ' and nivel >=' + IntToStr(ComboNivel.ItemIndex);

  if ComboUsuario.ItemIndex > 0 then
    Temp := Temp + ' and ' + FTabLog + '.idUser = ' + ListIdUser[ComboUsuario.ItemIndex];

  try
    TUserControl(Owner).DataConnector.UCExecSQL(Temp);
    AplicaFiltro;
    DBGrid1.Repaint;
  except
  end;

  //modified by fduenas
  try
    TUserControl(Owner).Log(Format(TUserControl(Owner).UserSettings.Log.DeletePerformed, [comboUsuario.Text, DateTimeToStr(Data1.datetime), DateTimeToStr(Data2.datetime), ComboNivel.Text]), 2);
  except;
  end;

end;

procedure TViewLog.data1Change(Sender: TObject);
begin
  btFiltro.Enabled := True;
end;

procedure TViewLog.btfiltroClick(Sender: TObject);
begin
  AplicaFiltro;
end;

procedure TViewLog.AplicaFiltro;
var
  FTabUser, FTabLog: String;
  Temp:              String;
begin
  btFiltro.Enabled := False;
  DSLog.Close;
  FTabLog  := TUserControl(Owner).LogControl.TableLog;
  FTabUser := TUserControl(Owner).TableUsers.TableName;

  Temp := Format('Select TabUser.' + TUserControl(Owner).TableUsers.FieldUserName + ' as nome, ' + FTabLog + '.* ' +
    'from ' + FTabLog +
    '  Left outer join %s TabUser on ' + FTabLog + '.idUser = TabUser.%s ' +
    'Where (data >= ' + QuotedStr(FormatDateTime('yyyyMMddhhmmss', data1.DateTime)) + ') ' +
    'and (Data <= ' + QuotedStr(FormatDateTime('yyyyMMddhhmmss', data2.DateTime)) + ') ' +
    'and nivel >= ' + IntToStr(ComboNivel.ItemIndex),
    [TUserControl(Owner).TableUsers.TableName, TUserControl(Owner).TableUsers.FieldUserID]);

  if ComboUsuario.ItemIndex > 0 then
    Temp := Temp + ' and ' + FTabLog + '.idUser = ' + ListIdUser[ComboUsuario.ItemIndex];

  Temp := Temp + ' order by data desc';

  FreeAndNil(DSLog);
  DataSource1.DataSet := nil;
  DSLog               := TUserControl(Owner).DataConnector.UCGetSQLDataset(Temp);
  DataSource1.DataSet := DSLog;
  btexclui.Enabled    := not DsLog.IsEmpty;
end;

end.
