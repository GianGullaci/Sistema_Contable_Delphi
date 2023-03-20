unit Form_Puntos_Venta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Sistema_ABM, Unidad_Puntos_Venta, Grids, StdCtrls;

type
  TFPuntosVenta = class(TForm)
    Label4: TLabel;
    Label7: TLabel;
    UsuarioRegistrado: TLabel;
    Label8: TLabel;
    NombreEmpresa: TLabel;
    BSalir: TButton;
    ListadoPuntos: TStringGrid;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    EClave: TEdit;
    EDescripcion: TEdit;
    BGuardar: TButton;
    procedure BSalirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BGuardarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPuntosVenta: TFPuntosVenta;
  PuntosVenta: Modelo_PuntosVenta;
  pos: Tipo_Posicion;

implementation

uses Form_Ingreso;

{$R *.dfm}

procedure TFPuntosVenta.BSalirClick(Sender: TObject);
begin
  Close;
  FPrincipal.Visible:= true;
end;

procedure TFPuntosVenta.FormActivate(Sender: TObject);
var
  Registro: Registro_PuntosVenta;
begin
  PuntosVenta:= Modelo_PuntosVenta.Create(FIngreso.c_Ruta,'PuntosVenta');
  PuntosVenta.Abrir;
  EClave.Text:= '';
  EDescripcion.Text:= '';
  ListadoPuntos.RowCount:= 1;
  ListadoPuntos.ColCount:= 2;
  ListadoPuntos.Cells[0,0]:= 'Num';
  ListadoPuntos.Cells[1,0]:= 'Descripcion';
  ListadoPuntos.ColWidths[1]:= 260;
  pos:= 0;
  while pos < PuntosVenta.Ultimo do
    begin
      PuntosVenta.Capturar(Registro,pos);
      if Registro.Borrado = false then
       begin
        ListadoPuntos.RowCount:= ListadoPuntos.RowCount + 1;
        ListadoPuntos.Cells[0,ListadoPuntos.RowCount-1]:= Registro.Clave;
        ListadoPuntos.Cells[1,ListadoPuntos.RowCount-1]:= Registro.Descripcion;
       end;
      pos:= succ(pos);
    end;
end;

procedure TFPuntosVenta.BGuardarClick(Sender: TObject);      
var
  Registro: Registro_PuntosVenta;
begin
  Registro.Clave:= EClave.Text;
  Registro.Descripcion:= EDescripcion.Text;
  if ((EClave.Text <> '') and (EDescripcion.Text <> '') and (strtoint(EClave.Text)>0) and (strtoint(EClave.Text)<=9999)) then
    begin
      if PuntosVenta.Buscar(Registro.Clave,pos,true) = false then
        begin
          PuntosVenta.Insertar(Registro,pos);
          pos:= 0;
          EClave.Clear;
          EClave.SetFocus;
          EDescripcion.Clear;
          ListadoPuntos.RowCount:= 1;
          while pos < PuntosVenta.Ultimo do
            begin
              PuntosVenta.Capturar(Registro,pos);
              if Registro.Borrado = false then
               begin
                ListadoPuntos.RowCount:= ListadoPuntos.RowCount + 1;
                ListadoPuntos.Cells[0,ListadoPuntos.RowCount-1]:= Registro.Clave;
                ListadoPuntos.Cells[1,ListadoPuntos.RowCount-1]:= Registro.Descripcion;
               end;
              pos:= succ(pos);
            end;
        end
      else
        begin
          showmessage('El número de punto de venta ya existe');
          EClave.Clear;
          EClave.SetFocus;
        end;
    end
  else
    begin
      if ((EClave.Text = '') or (strtoint(EClave.Text)<0) or (strtoint(EClave.Text)>9999)) then
        begin
          showmessage('Ingrese un número de punto de venta valido');
          EClave.Clear;
          EClave.SetFocus;
        end
      else
        if EDescripcion.Text = '' then
          begin
            showmessage('Ingrese la descripción del punto de venta');
            EDescripcion.Clear;
            EDescripcion.SetFocus;
          end;
    end;
end;

end.
