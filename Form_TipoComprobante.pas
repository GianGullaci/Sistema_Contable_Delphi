unit Form_TipoComprobante;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Sistema_ABM, Unidad_Comprobantes;

type
  TFTiposComprobante = class(TForm)
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
    ListadoComprobantes: TStringGrid;
    procedure BSalirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BGuardarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FTiposComprobante: TFTiposComprobante;
  Comprobantes: Modelo_Comprobante;
  pos: Tipo_Posicion;

implementation

uses Form_Ingreso;

{$R *.dfm}

procedure TFTiposComprobante.BSalirClick(Sender: TObject);
begin
  Close;
  FPrincipal.Visible:= true;
end;

procedure TFTiposComprobante.FormActivate(Sender: TObject);
var
  Registro: Registro_Comprobante;
begin
  Comprobantes:= Modelo_Comprobante.Create(FIngreso.c_Ruta,'Tipos_Comprobantes');
  Comprobantes.Abrir;
  EClave.Text:= '';
  EDescripcion.Text:= '';
  ListadoComprobantes.RowCount:= 1;
  ListadoComprobantes.ColCount:= 2;
  ListadoComprobantes.Cells[0,0]:= 'Clave';
  ListadoComprobantes.Cells[1,0]:= 'Descripcion';
  ListadoComprobantes.ColWidths[1]:= 260;
  pos:= 0;
  while pos < Comprobantes.Ultimo do
    begin
      Comprobantes.Capturar(Registro,pos);
      if Registro.Borrado = false then
       begin
        ListadoComprobantes.RowCount:= ListadoComprobantes.RowCount + 1;
        ListadoComprobantes.Cells[0,ListadoComprobantes.RowCount-1]:= Registro.Clave;
        ListadoComprobantes.Cells[1,ListadoComprobantes.RowCount-1]:= Registro.Descripcion;
       end;
      pos:= succ(pos);
    end;
end;

procedure TFTiposComprobante.BGuardarClick(Sender: TObject);
var
  Registro: Registro_Comprobante;
begin
  Registro.Clave:= EClave.Text;
  Registro.Descripcion:= EDescripcion.Text;
  if ((EClave.Text <> '') and (EDescripcion.Text <> '') and (strtoint(EClave.Text)>0) and (strtoint(EClave.Text)<1000)) then
    begin
      if Comprobantes.Buscar(Registro.Clave,pos,true) = false then
        begin
          Registro.ult_num:= 0;
          Comprobantes.Insertar(Registro,pos);
          pos:= 0;
          EClave.Clear;
          EClave.SetFocus;
          EDescripcion.Clear;
          ListadoComprobantes.RowCount:= 1;
          while pos < Comprobantes.Ultimo do
            begin
              Comprobantes.Capturar(Registro,pos);
              if Registro.Borrado = false then
               begin
                ListadoComprobantes.RowCount:= ListadoComprobantes.RowCount + 1;
                ListadoComprobantes.Cells[0,ListadoComprobantes.RowCount-1]:= Registro.Clave;
                ListadoComprobantes.Cells[1,ListadoComprobantes.RowCount-1]:= Registro.Descripcion;
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
      if ((EClave.Text = '') or (strtoint(EClave.Text)<=0) or (strtoint(EClave.Text)>999)) then
        begin
          showmessage('Ingrese una clave valida');
          EClave.Clear;
          EClave.SetFocus;
        end
      else
        if EDescripcion.Text = '' then
          begin
            showmessage('Ingrese el nombre del tipo de comprobante');
            EDescripcion.Clear;
            EDescripcion.SetFocus;
          end;
    end;
end;

end.
