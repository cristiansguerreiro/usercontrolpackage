unit SenhaForm_U;

interface

{$I 'UserControl.inc'}

uses
  Buttons,
  Classes,
  Controls,
  Dialogs,
  Forms,
  Graphics,
  Messages,
  StdCtrls,
  SysUtils,
  Variants,
  Windows;

type
  TResultado = record
    Senha:     String;
    Cancelado: Boolean;
  end;

  TSenhaForm = class(TForm)
    edtSenha:         TEdit;
    edtConfirmaSenha: TEdit;
    btnOK:            TBitBtn;
    BitBtn1:          TBitBtn;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FSenha: String;
    function CompararSenhas(Senha, ConfirmaSenha: String): Boolean;
  public
    { Public declarations }
    class function Senha: TResultado;
  end;

implementation

{$R *.dfm}

{ TForm1 }

function TSenhaForm.CompararSenhas(Senha, ConfirmaSenha: String): Boolean;
begin
  if (Senha = '') or (ConfirmaSenha = '') then
    Result := False
  else
    Result := (Senha = ConfirmaSenha);
end;

procedure TSenhaForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TSenhaForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if not (ModalResult = mrCancel) then
  begin
    CanClose := CompararSenhas(edtSenha.Text, edtConfirmaSenha.Text);
    if not CanClose then
    begin
      ShowMessage('As senhas não são iguais...!');
      edtSenha.Clear;
      edtConfirmaSenha.Clear;
      edtSenha.SetFocus;
    end
    else
      FSenha := edtSenha.Text;
  end;
end;

procedure TSenhaForm.FormCreate(Sender: TObject);
begin
  edtSenha.Clear;
  edtConfirmaSenha.Clear;
end;

class function TSenhaForm.Senha: TResultado;
begin
  with TSenhaForm.Create(nil) do
    try
      ShowModal;
      Result.Cancelado := (ModalResult = mrCancel);
      Result.Senha     := FSenha;
    finally
      Free;
    end;
end;

end.
