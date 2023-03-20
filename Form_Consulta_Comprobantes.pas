unit Form_Consulta_Comprobantes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, Unidad_Comprobantes, Unidad_Modelo_Indice_Comprobantes,
  Unidad_Facturas, Grids, Unidad_Clientes;

type
  TFConsultaComprobantes = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    EFechaDesde: TMaskEdit;
    Label3: TLabel;
    Label4: TLabel;
    EFechaHasta: TMaskEdit;
    CBTipoComp: TComboBox;
    Label5: TLabel;
    BBuscar: TButton;
    BSalir: TButton;
    ListadoComprobantes: TStringGrid;
    BImprimir: TButton;
    procedure BSalirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BBuscarClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FConsultaComprobantes: TFConsultaComprobantes;
  Comprobantes: Modelo_Factura;
  TiposComprobantes: Modelo_Comprobante;
  Comprobantes_Fecha: Tipo_Indice_Comp;
  Clientes: Modelo_Cliente;

implementation

uses Sistema_ABM, Form_Ingreso, Form_Reporte_Listado_Comprobantes;

{$R *.dfm}

procedure TFConsultaComprobantes.BSalirClick(Sender: TObject);
begin
  Close;
  FPrincipal.Visible:= true;
end;

procedure TFConsultaComprobantes.FormActivate(Sender: TObject);
var
  Reg_TComp: Registro_Comprobante;
  pos_TComp: Tipo_Posicion;
begin
  Comprobantes:= Modelo_Factura.Create(FIngreso.c_Ruta, 'Comprobantes');
  Comprobantes.Abrir;
  TiposComprobantes:= Modelo_Comprobante.Create(FIngreso.c_Ruta,'Tipos_Comprobantes');
  TiposComprobantes.Abrir;
  Comprobantes_Fecha:= Tipo_Indice_Comp.Create(FIngreso.c_Ruta,'Comprobantes_Fecha');
  Comprobantes_Fecha.Abrir;
  Clientes:= Modelo_Cliente.Create(FIngreso.c_Ruta,'Clientes');
  Clientes.Abrir;

  EFechaDesde.Text:= datetostr(now);
  EFechaHasta.Text:= datetostr(now);
  CBTipoComp.Clear;
  CBTipoComp.ItemIndex:= -1;

  pos_TComp:= 0;
  while pos_TComp < TiposComprobantes.Ultimo do
    begin
      TiposComprobantes.Capturar(Reg_TComp,pos_TComp);
      if Reg_TComp.Borrado = false then
       begin
        CBTipoComp.Items.Add(Reg_TComp.Descripcion);
       end;
      pos_TComp:= succ(pos_TComp);
    end;

  ListadoComprobantes.RowCount:= 1;
  ListadoComprobantes.ColCount:= 6;
  ListadoComprobantes.Cells[0,0]:= 'Fecha';
  ListadoComprobantes.Cells[1,0]:= 'Tipo Comp.';
  ListadoComprobantes.Cells[2,0]:= 'Num. Comp.';
  ListadoComprobantes.Cells[3,0]:= 'Cliente';
  ListadoComprobantes.Cells[4,0]:= 'CUIT';
  ListadoComprobantes.Cells[5,0]:= 'Total';
  ListadoComprobantes.ColWidths[0]:= 75;
  ListadoComprobantes.ColWidths[1]:= 120;
  ListadoComprobantes.ColWidths[2]:= 80;
  ListadoComprobantes.ColWidths[3]:= 190;
  ListadoComprobantes.ColWidths[4]:= 90;
  ListadoComprobantes.ColWidths[5]:= 100;
end;

procedure TFConsultaComprobantes.BBuscarClick(Sender: TObject);
var
  Reg_Comp: Registro_Factura;
  Reg_TipoComp: Registro_Comprobante;
  Reg_Cliente: Registro_Cliente;
  Reg_Comp_Fecha: Tipo_Reg_Indice;
  pos_Comp, pos_Comp_Fecha, i: Tipo_Posicion;
  borrado, corte: boolean;
begin
  Comprobantes_Fecha.Vaciar;

  ListadoComprobantes.RowCount:= 1;
  ListadoComprobantes.ColCount:= 6;
  ListadoComprobantes.Cells[0,0]:= 'Fecha';
  ListadoComprobantes.Cells[1,0]:= 'Tipo Comp.';
  ListadoComprobantes.Cells[2,0]:= 'Num. Comp.';
  ListadoComprobantes.Cells[3,0]:= 'Cliente';
  ListadoComprobantes.Cells[4,0]:= 'CUIT';
  ListadoComprobantes.Cells[5,0]:= 'Total';
  ListadoComprobantes.ColWidths[0]:= 75;
  ListadoComprobantes.ColWidths[1]:= 120;
  ListadoComprobantes.ColWidths[2]:= 80;
  ListadoComprobantes.ColWidths[3]:= 190;
  ListadoComprobantes.ColWidths[4]:= 90;
  ListadoComprobantes.ColWidths[5]:= 100;

  pos_Comp:= Comprobantes.Primero;
  while pos_Comp <> Comprobantes.Pos_Nula do
    begin
      Comprobantes.Capturar(Reg_Comp,pos_Comp);

      //Genero Indice organizado por la fecha
      Comprobantes_Fecha.Buscar(Reg_Comp.Fecha,pos_Comp_Fecha,borrado);
      Reg_Comp_Fecha.Clave:= Reg_Comp.Fecha;
      Reg_Comp_Fecha.Pos:= Reg_Comp.id;
      Reg_Comp_Fecha.Borrado:= Reg_Comp.Borrado;
      Comprobantes_Fecha.Insertar(Reg_Comp_Fecha,pos_Comp_Fecha);

      pos_Comp:= Comprobantes.Proximo(pos_Comp);
    end;

  if CBTipoComp.ItemIndex = -1 then
    begin
      corte:= false;
      pos_Comp_Fecha:= Comprobantes_Fecha.Primero;
      i:= 1;
      while (pos_Comp_Fecha <> Comprobantes_Fecha.Pos_Nula) or (corte = true) do
        begin
          Comprobantes_Fecha.Capturar(pos_Comp_Fecha,Reg_Comp_Fecha);
          if (StrToDate(Reg_Comp_Fecha.Clave) >= StrToDate(EFechaDesde.Text))
                and (StrToDate(Reg_Comp_Fecha.Clave) <= StrToDate(EFechaHasta.Text)) then
            begin
              Comprobantes.Capturar(Reg_Comp,Reg_Comp_Fecha.Pos);
              ListadoComprobantes.Cells[0,i]:= Reg_Comp.Fecha;
              TiposComprobantes.Capturar(Reg_TipoComp,Reg_Comp.id_TipoComprobante);
              ListadoComprobantes.Cells[1,i]:= Reg_TipoComp.Descripcion;
              ListadoComprobantes.Cells[2,i]:= IntToStr(Reg_Comp.Num_Comprobante);
              repeat
                ListadoComprobantes.Cells[2,i]:= '0' + ListadoComprobantes.Cells[2,i];
              until length(ListadoComprobantes.Cells[2,i]) = 8;

              Clientes.Capturar(Reg_Cliente,Reg_Comp.id_Cliente);
              ListadoComprobantes.Cells[3,i]:= Reg_Cliente.Nombre;
              ListadoComprobantes.Cells[4,i]:= Reg_Cliente.DNI;
              ListadoComprobantes.Cells[5,i]:= '$ '+FormatFloat('0.00',Reg_Comp.Total);
              i:= succ(i);
            end;
          pos_Comp_Fecha:= Comprobantes_Fecha.Proximo(pos_Comp_Fecha);
        end;
      ListadoComprobantes.RowCount:= i;
    end
  else
    begin
      corte:= false;
      pos_Comp_Fecha:= Comprobantes_Fecha.Primero;
      i:= 1;
      while (pos_Comp_Fecha <> Comprobantes_Fecha.Pos_Nula) or (corte = true) do
        begin
          Comprobantes_Fecha.Capturar(pos_Comp_Fecha,Reg_Comp_Fecha);
          if (StrToDate(Reg_Comp_Fecha.Clave) >= StrToDate(EFechaDesde.Text))
                and (StrToDate(Reg_Comp_Fecha.Clave) <= StrToDate(EFechaHasta.Text)) then
            begin
              Comprobantes.Capturar(Reg_Comp,Reg_Comp_Fecha.Pos);
              if (Reg_Comp.id_TipoComprobante = CBTipoComp.ItemIndex) then
                begin
                  ListadoComprobantes.Cells[0,i]:= Reg_Comp.Fecha;
                  TiposComprobantes.Capturar(Reg_TipoComp,Reg_Comp.id_TipoComprobante);
                  ListadoComprobantes.Cells[1,i]:= Reg_TipoComp.Descripcion;
                  ListadoComprobantes.Cells[2,i]:= IntToStr(Reg_Comp.Num_Comprobante);
                  repeat
                    ListadoComprobantes.Cells[2,i]:= '0' + ListadoComprobantes.Cells[2,i];
                  until length(ListadoComprobantes.Cells[2,i]) = 8;

                  Clientes.Capturar(Reg_Cliente,Reg_Comp.id_Cliente);
                  ListadoComprobantes.Cells[3,i]:= Reg_Cliente.Nombre;
                  ListadoComprobantes.Cells[4,i]:= Reg_Cliente.DNI;
                  ListadoComprobantes.Cells[5,i]:= '$ '+FormatFloat('0.00',Reg_Comp.Total);
                  i:= succ(i);
                end;
            end;
          pos_Comp_Fecha:= Comprobantes_Fecha.Proximo(pos_Comp_Fecha);
        end;
      ListadoComprobantes.RowCount:= i;
    end;
end;



procedure TFConsultaComprobantes.BImprimirClick(Sender: TObject);
begin
  FListadoComprobantes.QuickRepComprobantes.Preview;
end;

end.
