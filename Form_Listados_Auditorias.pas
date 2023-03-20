unit Form_Listados_Auditorias;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFListAuditorias = class(TForm)
    BAudClientes: TButton;
    BAudProvincias: TButton;
    BAudUsuarios: TButton;
    BAudPerfiles: TButton;
    BAudSalir: TButton;
    Label1: TLabel;
    Label7: TLabel;
    UsuarioRegistrado: TLabel;
    Label8: TLabel;
    NombreEmpresa: TLabel;
    procedure BAudSalirClick(Sender: TObject);
    procedure BAudPerfilesClick(Sender: TObject);
    procedure BAudUsuariosClick(Sender: TObject);
    procedure BAudProvinciasClick(Sender: TObject);
    procedure BAudClientesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FListAuditorias: TFListAuditorias;

implementation

uses Sistema_ABM, Form_Aud_Perfiles, Form_Aud_Usuarios,
  Form_Aud_Provincias, Form_Aud_Clientes;

{$R *.dfm}

procedure TFListAuditorias.BAudSalirClick(Sender: TObject);
begin
  Close;
  FPrincipal.Visible:= true;
end;

procedure TFListAuditorias.BAudPerfilesClick(Sender: TObject);
begin
  FAudPerfiles.Show;
  FListAuditorias.Visible:= false;
end;

procedure TFListAuditorias.BAudUsuariosClick(Sender: TObject);
begin
  FAudUsuarios.Show;
  FListAuditorias.Visible:= false;
end;

procedure TFListAuditorias.BAudProvinciasClick(Sender: TObject);
begin
  FAudProvincias.Show;
  FListAuditorias.Visible:= false;
end;

procedure TFListAuditorias.BAudClientesClick(Sender: TObject);
begin
  FAudClientes.Show;
  FListAuditorias.Visible:= false;
end;

end.
