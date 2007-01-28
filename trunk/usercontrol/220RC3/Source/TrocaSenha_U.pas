unit TrocaSenha_U;

interface

{$I 'UserControl.inc'}

uses
{$IFDEF DELPHI5_UP}
{$ELSE}
  Variants,
{$ENDIF}
  Buttons,
  Classes,
  Controls,
  Dialogs,
  ExtCtrls,
  Forms,
  Graphics,
  Messages,
  StdCtrls,
  SysUtils,
  Windows;

type
  TTrocaSenha = class(TForm)
    Panel1:       TPanel;
    lbDescricao:  TLabel;
    Image1:       TImage;
    Panel3:       TPanel;
    btGrava:      TBitBtn;
    btCancel:     TBitBtn;
    Panel2:       TPanel;
    lbSenhaAtu:   TLabel;
    lbNovaSenha:  TLabel;
    lbConfirma:   TLabel;
    EditAtu:      TEdit;
    EditNova:     TEdit;
    EditConfirma: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

{
var
  TrocaSenha: TTrocaSenha;
}

implementation

{$R *.dfm}

procedure TTrocaSenha.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TTrocaSenha.btCancelClick(Sender: TObject);
begin
  Close;
end;

end.
