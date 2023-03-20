unit Form_TipoImpuesto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Sistema_ABM, Unidad_Impuestos, Grids, StdCtrls;

type
  TFTiposImpuesto = class(TForm)
    Label4: TLabel;
    Label7: TLabel;
    UsuarioRegistrado: TLabel;
    Label8: TLabel;
    NombreEmpresa: TLabel;
    BSalir: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    EAlicuota: TEdit;
    EDescripcion: TEdit;
    BGuardar: TButton;
    ListadoImpuestos: TStringGrid;
    procedure BSalirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BGuardarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FTiposImpuesto: TFTiposImpuesto;
  Impuestos: Modelo_Impuesto;
  pos: Tipo_Posicion;

implementation

uses Form_Ingreso;

{$R *.dfm}

procedure TFTiposImpuesto.BSalirClick(Sender: TObject);
begin
  Close;
  FPrincipal.Visible:= true;
end;

procedure TFTiposImpuesto.FormActivate(Sender: TObject);
var
  Registro: Registro_Impuesto;
begin
  Impuestos:= Modelo_Impuesto.Create(FIngreso.c_Ruta,'Impuestos');
  Impuestos.Abrir;
  EDescripcion.Text:= '';
  EAlicuota.Text:= '';
  ListadoImpuestos.RowCount:= 1;
  ListadoImpuestos.ColCount:= 3;             
  ListadoImpuestos.Cells[0,0]:= 'Clave';
  ListadoImpuestos.Cells[1,0]:= 'Descripción';
  ListadoImpuestos.Cells[2,0]:= 'Alicuota';
  ListadoImpuestos.ColWidths[1]:= 210;
  ListadoImpuestos.ColWidths[2]:= 60;
  pos:= 0;
  while pos < Impuestos.Ultimo do
    begin
      Impuestos.Capturar(Registro,pos);
      if Registro.Borrado = false then
       begin
        ListadoImpuestos.RowCount:= ListadoImpuestos.RowCount + 1;              
        ListadoImpuestos.Cells[0,ListadoImpuestos.RowCount-1]:= Registro.Clave;
        ListadoImpuestos.Cells[1,ListadoImpuestos.RowCount-1]:= Registro.Descripcion;
        ListadoImpuestos.Cells[2,ListadoImpuestos.RowCount-1]:= FloatToStr(Registro.Alicuota);
       end;
      pos:= succ(pos);
    end;
end;

procedure TFTiposImpuesto.BGuardarClick(Sender: TObject);
var
  Registro: Registro_Impuesto;
begin
  Registro.Descripcion:= EDescripcion.Text;   
  Registro.Alicuota:= StrToFloat(EAlicuota.Text);
  if ((EDescripcion.Text <> '') and (EAlicuota.Text <> '') and (StrToFloat(EAlicuota.Text)>=0) and (strtoFloat(EAlicuota.Text)<100)) then
    begin
      if Impuestos.Buscar(Registro.Clave,pos,true) = false then
        begin
          Registro.Clave:= IntToStr(Impuestos.Pos_Nueva + 1);
          Impuestos.Insertar(Registro,pos);
          pos:= 0;
          EAlicuota.Clear;
          EDescripcion.Clear;
          EDescripcion.SetFocus;
          ListadoImpuestos.RowCount:= 1;
          while pos < Impuestos.Ultimo do
            begin
              Impuestos.Capturar(Registro,pos);
              if Registro.Borrado = false then
               begin
                ListadoImpuestos.RowCount:= ListadoImpuestos.RowCount + 1;       
                ListadoImpuestos.Cells[0,ListadoImpuestos.RowCount-1]:= Registro.Clave;
                ListadoImpuestos.Cells[1,ListadoImpuestos.RowCount-1]:= Registro.Descripcion;
                ListadoImpuestos.Cells[2,ListadoImpuestos.RowCount-1]:= FloatToStr(Registro.Alicuota);
               end;
              pos:= succ(pos);
            end;
        end
      else
        begin
          showmessage('La clave ya existe');
        end;
    end
  else
    begin
      if ((EAlicuota.Text = '') or (strtoFloat(EAlicuota.Text)<0) or (strtoFloat(EAlicuota.Text)>99)) then
        begin
          showmessage('Ingrese una alicuota valida');
          EAlicuota.Clear;
          EAlicuota.SetFocus;
        end
      else
        if EDescripcion.Text = '' then
          begin
            showmessage('Ingrese el nombre del tipo de impuesto');
            EDescripcion.Clear;
            EDescripcion.SetFocus;
          end;
    end;
end;

end.
