unit Form_TipoContribuyente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Sistema_ABM, Unidad_Contribuyentes;

type
  TFTiposContribuyente = class(TForm)
    Label4: TLabel;
    Label7: TLabel;
    UsuarioRegistrado: TLabel;
    Label8: TLabel;
    NombreEmpresa: TLabel;
    BSalir: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    EClave: TEdit;
    EDescripcion: TEdit;
    BGuardar: TButton;
    ListadoContribuyentes: TStringGrid;
    procedure BSalirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BGuardarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FTiposContribuyente: TFTiposContribuyente;
  Contribuyentes: Modelo_Contribuyente;
  pos: Tipo_Posicion;

implementation

uses Form_Ingreso;

{$R *.dfm}

procedure TFTiposContribuyente.BSalirClick(Sender: TObject);
begin
  Close;
  FPrincipal.Visible:= true;
end;

procedure TFTiposContribuyente.FormActivate(Sender: TObject);
var
  Registro: Registro_Contribuyente;
begin
  Contribuyentes:= Modelo_Contribuyente.Create(FIngreso.c_Ruta,'Contribuyentes');
  Contribuyentes.Abrir;
  EClave.Text:= '';
  EDescripcion.Text:= '';
  ListadoContribuyentes.RowCount:= 1;
  ListadoContribuyentes.ColCount:= 2;
  ListadoContribuyentes.Cells[0,0]:= 'Clave';
  ListadoContribuyentes.Cells[1,0]:= 'Descripcion';
  ListadoContribuyentes.ColWidths[1]:= 260;
  pos:= 0;
  while pos < Contribuyentes.Ultimo do
    begin
      Contribuyentes.Capturar(Registro,pos);
      if Registro.Borrado = false then
       begin
        ListadoContribuyentes.RowCount:= ListadoContribuyentes.RowCount + 1;
        ListadoContribuyentes.Cells[0,ListadoContribuyentes.RowCount-1]:= Registro.Clave;
        ListadoContribuyentes.Cells[1,ListadoContribuyentes.RowCount-1]:= Registro.Descripcion;
       end;
      pos:= succ(pos);
    end;
end;

procedure TFTiposContribuyente.BGuardarClick(Sender: TObject);
var
  Registro: Registro_Contribuyente;
begin
  Registro.Clave:= EClave.Text;
  Registro.Descripcion:= EDescripcion.Text;
  if ((EClave.Text <> '') and (EDescripcion.Text <> '') and (strtoint(EClave.Text)>0) and (strtoint(EClave.Text)<100)) then
    begin
      if Contribuyentes.Buscar(Registro.Clave,pos,true) = false then
        begin
          Contribuyentes.Insertar(Registro,pos);
          pos:= 0;
          EClave.Clear;
          EClave.SetFocus;
          EDescripcion.Clear;
          ListadoContribuyentes.RowCount:= 1;
          while pos < Contribuyentes.Ultimo do
            begin
              Contribuyentes.Capturar(Registro,pos);
              if Registro.Borrado = false then
               begin
                ListadoContribuyentes.RowCount:= ListadoContribuyentes.RowCount + 1;
                ListadoContribuyentes.Cells[0,ListadoContribuyentes.RowCount-1]:= Registro.Clave;
                ListadoContribuyentes.Cells[1,ListadoContribuyentes.RowCount-1]:= Registro.Descripcion;
               end;
              pos:= succ(pos);
            end;
        end
      else
        begin
          showmessage('La clave ya existe');
          EClave.Clear;
          EClave.SetFocus;
        end;
    end
  else
    begin
      if ((EClave.Text = '') or (strtoint(EClave.Text)<=0) or (strtoint(EClave.Text)>99)) then
        begin
          showmessage('Ingrese una clave valida');
          EClave.Clear;
          EClave.SetFocus;
        end
      else
        if EDescripcion.Text = '' then
          begin
            showmessage('Ingrese el nombre del tipo de contribuyente');
            EDescripcion.Clear;
            EDescripcion.SetFocus;
          end;
    end;
end;

end.
