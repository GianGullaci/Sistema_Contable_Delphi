unit Form_Productos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Sistema_ABM, Unidad_Productos, Unidad_Impuestos;

type
  TFProductos = class(TForm)
    Label6: TLabel;
    Label7: TLabel;
    UsuarioRegistrado: TLabel;
    Label8: TLabel;
    NombreEmpresa: TLabel;
    BSalir: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    ECostoUnit: TEdit;
    ECantidad: TEdit;
    ENombre: TEdit;
    BGuardar: TButton;
    CBImpuesto: TComboBox;
    EImpuestoInt: TEdit;
    ListadoProductos: TStringGrid;
    BNuevo: TButton;
    BModificar: TButton;
    EPrecioNeto: TEdit;
    Label4: TLabel;
    procedure BSalirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BGuardarClick(Sender: TObject);
    procedure BNuevoClick(Sender: TObject);
    procedure BModificarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FProductos: TFProductos;
  Productos: Modelo_Producto;
  Impuestos: Modelo_Impuesto;
  pos_Producto, pos_Impuesto: Tipo_Posicion;
  clave: Tipo_Clave;

implementation

uses Form_Ingreso;

{$R *.dfm}

procedure TFProductos.BSalirClick(Sender: TObject);
begin
  Close;
  FPrincipal.Visible:= true;
end;

procedure TFProductos.FormActivate(Sender: TObject);
var
  Reg_Producto: Registro_Producto;
  Reg_Impuesto: Registro_Impuesto;
  PrecioNeto: Real;
begin
  Productos:= Modelo_Producto.Create(FIngreso.c_Ruta,'Productos');
  Productos.Abrir;
  Impuestos:= Modelo_Impuesto.Create(FIngreso.c_Ruta,'Impuestos');
  Impuestos.Abrir;

  ENombre.SetFocus;
  ENombre.Clear;
  ECantidad.Clear;
  ECostoUnit.Clear;
  EPrecioNeto.Clear;
  CBImpuesto.Clear;
  CBImpuesto.ItemIndex:= -1;
  EImpuestoInt.Clear;
  ListadoProductos.RowCount:= 1;
  ListadoProductos.ColCount:= 6;
  ListadoProductos.Cells[0,0]:= 'Nombre';
  ListadoProductos.Cells[1,0]:= 'Cant';
  ListadoProductos.Cells[2,0]:= 'Costo Unit.';
  ListadoProductos.Cells[3,0]:= 'Precio Neto';  
  ListadoProductos.Cells[4,0]:= 'Tasa IVA';
  ListadoProductos.Cells[5,0]:= 'Impuesto Int.';
  ListadoProductos.ColWidths[0]:= 100;
  ListadoProductos.ColWidths[1]:= 40;
  ListadoProductos.ColWidths[2]:= 100;
  ListadoProductos.ColWidths[3]:= 100;
  ListadoProductos.ColWidths[4]:= 60;
  ListadoProductos.ColWidths[5]:= 100;
  pos_Producto:= 0;
  while pos_Producto < Productos.Ultimo do
    begin
      Productos.Capturar(Reg_Producto,pos_Producto);
      if Reg_Producto.Borrado = false then
       begin
        ListadoProductos.RowCount:= ListadoProductos.RowCount + 1;
        ListadoProductos.Cells[0,ListadoProductos.RowCount-1]:= Reg_Producto.Nombre;
        ListadoProductos.Cells[1,ListadoProductos.RowCount-1]:= IntToStr(Reg_Producto.Cantidad);
        ListadoProductos.Cells[2,ListadoProductos.RowCount-1]:= FormatFloat('0.00',Reg_Producto.CostoUnitario);
        Impuestos.Capturar(Reg_Impuesto,Reg_Producto.id_Impuesto);
        //PrecioNeto:= Reg_Producto.CostoUnitario + (Reg_Producto.CostoUnitario * Reg_Impuesto.Alicuota * 0.01);
        ListadoProductos.Cells[3,ListadoProductos.RowCount-1]:= FormatFloat('0.00',Reg_Producto.PrecioNeto);
        if Reg_Impuesto.Alicuota <> 0 then
          ListadoProductos.Cells[4,ListadoProductos.RowCount-1]:= FloatToStr(Reg_Impuesto.Alicuota)
        else
          ListadoProductos.Cells[4,ListadoProductos.RowCount-1]:= 'Exento';
        ListadoProductos.Cells[5,ListadoProductos.RowCount-1]:= FormatFloat('0.00',Reg_Producto.ImpuestoInterno);
       end;
      pos_Producto:= succ(pos_Producto);
    end;

  pos_Impuesto:= 0;
  while pos_Impuesto < Impuestos.Ultimo do
    begin
      Impuestos.Capturar(Reg_Impuesto,pos_Impuesto);
      if Reg_Impuesto.Borrado = false then
        CBImpuesto.Items.Add(Reg_Impuesto.Descripcion);
      pos_Impuesto:= succ(pos_Impuesto);
    end;
  
  clave:= IntToStr(Productos.Pos_Nueva + 1);
end;

procedure TFProductos.BGuardarClick(Sender: TObject);
var
  Reg_Producto: Registro_Producto;
  Reg_Impuesto: Registro_Impuesto;
begin
  Reg_Producto.Nombre:= ENombre.Text;
  Reg_Producto.Cantidad:= StrToInt(ECantidad.Text);
  Reg_Producto.CostoUnitario:= StrToFloat(ECostoUnit.Text);
  Reg_Producto.id_Impuesto:= CBImpuesto.ItemIndex;
  Reg_Producto.ImpuestoInterno:= StrToFloat(EImpuestoInt.Text);
  Impuestos.Capturar(Reg_Impuesto,Reg_Producto.id_Impuesto);
  Reg_Producto.PrecioNeto:= StrToFloat(EPrecioNeto.Text);

  if ((ENombre.Text <> '') and (ECantidad.Text <> '') and (StrToInt(ECantidad.Text) > 0) and (ECostoUnit.Text <> '')
        and (StrToFloat(ECostoUnit.Text) > 0) and (EPrecioNeto.Text <> '')
        and (StrToFloat(EPrecioNeto.Text) > 0) and (CBImpuesto.ItemIndex <> -1) and (EImpuestoInt.Text <> '')) then
    begin
      if Productos.Buscar(clave,pos_Producto,true) = false then
        begin
          Reg_Producto.Clave:= clave;
          Productos.Insertar(Reg_Producto,pos_Producto);


          ENombre.SetFocus;
          ENombre.Clear;
          ECantidad.Clear;
          ECostoUnit.Clear;     
          EPrecioNeto.Clear;
          CBImpuesto.ItemIndex:= -1;
          EImpuestoInt.Clear;

          pos_Producto:= 0;  
          ListadoProductos.RowCount:= 1;
          while pos_Producto < Productos.Ultimo do
            begin
              Productos.Capturar(Reg_Producto,pos_Producto);
              if Reg_Producto.Borrado = false then
                begin
                  ListadoProductos.RowCount:= ListadoProductos.RowCount + 1;
                  ListadoProductos.Cells[0,ListadoProductos.RowCount-1]:= Reg_Producto.Nombre;
                  ListadoProductos.Cells[1,ListadoProductos.RowCount-1]:= IntToStr(Reg_Producto.Cantidad);
                  ListadoProductos.Cells[2,ListadoProductos.RowCount-1]:= FormatFloat('0.00',Reg_Producto.CostoUnitario);
                  Impuestos.Capturar(Reg_Impuesto,Reg_Producto.id_Impuesto);
                  ListadoProductos.Cells[3,ListadoProductos.RowCount-1]:= FormatFloat('0.00',Reg_Producto.PrecioNeto);
                  if Reg_Impuesto.Alicuota <> 0 then
                    ListadoProductos.Cells[4,ListadoProductos.RowCount-1]:= FloatToStr(Reg_Impuesto.Alicuota)
                  else
                    ListadoProductos.Cells[4,ListadoProductos.RowCount-1]:= 'Exento';
                  ListadoProductos.Cells[5,ListadoProductos.RowCount-1]:= FormatFloat('0.00',Reg_Producto.ImpuestoInterno);
                end;
              pos_Producto:= succ(pos_Producto);
            end;
        end
      else
        begin
          if MessageDlg('¿Desea modificar el producto?', mtWarning,[mbYes,mbNo], 0) = mrYes then
            begin
              Productos.Capturar(Reg_Producto,pos_Producto);
              Reg_Producto.Nombre:= ENombre.Text;
              Reg_Producto.Cantidad:= StrToInt(ECantidad.Text);
              Reg_Producto.CostoUnitario:= StrToFloat(ECostoUnit.Text);
              Reg_Producto.id_Impuesto:= CBImpuesto.ItemIndex;
              Reg_Producto.ImpuestoInterno:= StrToFloat(EImpuestoInt.Text);
              Impuestos.Capturar(Reg_Impuesto,Reg_Producto.id_Impuesto);
              Reg_Producto.PrecioNeto:= StrToFloat(EPrecioNeto.Text);
              Productos.Modificar(Reg_Producto,pos_Producto);
              FProductos.FormActivate(Sender);
            end
          else
            begin
              FProductos.FormActivate(Sender);
            end;
        end;
    end
  else
    begin
      if (ENombre.Text = '') then
        begin
          showmessage('Ingrese un nombre');
          ENombre.Clear;
          ENombre.SetFocus;
        end
      else
        begin
          if (StrToInt(ECantidad.Text) < 0) or (ECantidad.Text = '') then
            begin
              showmessage('Ingrese una cantidad');
              ECantidad.Clear;
              ECantidad.SetFocus;
            end
          else
            begin
              if (StrToFloat(ECostoUnit.Text) < 0) or (ECostoUnit.Text = '') or (StrToFloat(EPrecioNeto.Text) < 0) or (EPrecioNeto.Text = '')then
                begin
                  showmessage('Ingrese el precio');
                end
              else
                begin
                  if (CBImpuesto.ItemIndex = -1) then
                    begin
                      showmessage('Ingrese un impuesto');
                      CBImpuesto.SetFocus;
                    end
                  else
                    begin
                      showmessage('Ingrese un impuesto interno');
                      EImpuestoInt.SetFocus;
                    end;
                end;
            end;
        end;
    end;
end;

procedure TFProductos.BNuevoClick(Sender: TObject);
begin
  FProductos.FormActivate(Sender);
  clave:= IntToStr(Productos.Pos_Nueva + 1);
end;

procedure TFProductos.BModificarClick(Sender: TObject);
var
  Reg_Producto: Registro_Producto;
begin
  if ListadoProductos.Row <> 0 then
    begin
      pos_Producto:= ListadoProductos.Row - 1;
      Productos.Capturar(Reg_Producto,pos_Producto);
      clave:= Reg_Producto.Clave;
      ENombre.Text:= Reg_Producto.Nombre;
      ECantidad.Text:= inttostr(Reg_Producto.Cantidad);
      ECostoUnit.Text:= Floattostr(Reg_Producto.CostoUnitario);
      EPrecioNeto.Text:= FloatToStr(Reg_Producto.PrecioNeto);
      CBImpuesto.ItemIndex:= Reg_Producto.id_Impuesto;
      EImpuestoInt.Text:= FloatToStr(Reg_Producto.ImpuestoInterno);
    end
  else
    showmessage('Seleccione un producto para modificar');
end;

end.
