unit Form_Comprobantes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, Grids, StrUtils, Unidad_Facturas, Unidad_Remitos, Unidad_Puntos_Venta,
  Unidad_Comprobantes, Unidad_Clientes, Unidad_Productos, Unidad_Impuestos,
  Unidad_Contribuyentes, Unidad_CondicionesComerciales;

type
  TFComprobante = class(TForm)
    GBComp: TGroupBox;
    Label1: TLabel;
    EFecha: TMaskEdit;
    Label2: TLabel;
    CBPtoVta: TComboBox;
    Label3: TLabel;
    CBComp: TComboBox;
    Label4: TLabel;
    ENumComp: TEdit;
    Label5: TLabel;
    CBClientes: TComboBox;
    Label6: TLabel;
    ECuit: TEdit;
    Label8: TLabel;
    EDomicilio: TEdit;
    Label9: TLabel;
    EResp: TEdit;
    GBDetalle: TGroupBox;
    BGuardarComp: TButton;
    Label10: TLabel;
    CBProducto: TComboBox;
    Label11: TLabel;
    ECantidad: TEdit;
    Label12: TLabel;
    EPrecioUnit: TEdit;
    Label13: TLabel;
    EImpuesto: TEdit;
    Label14: TLabel;
    ESubtotal: TEdit;
    Label15: TLabel;
    ESubtotalImp: TEdit;
    BCargarRemito: TButton;
    ListadoDetalles: TStringGrid;
    Label16: TLabel;
    EImpInt: TEdit;
    BSalir: TButton;
    Label7: TLabel;
    CBCondComerc: TComboBox;
    BModificar: TButton;
    BImprimir: TButton;
    procedure BSalirClick(Sender: TObject);
    procedure BGuardarCompClick(Sender: TObject);
    procedure CBClientesChange(Sender: TObject);
    procedure CBCompChange(Sender: TObject);
    procedure CBProductoChange(Sender: TObject);
    procedure BCargarRemitoClick(Sender: TObject);
    procedure ECantidadExit(Sender: TObject);
    procedure BModificarClick(Sender: TObject);
    procedure CBProductoExit(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    id_Comprobante: Tipo_Posicion;
    Clave_Remito: ShortInt;
    subtotal_Ant, subtotal_Nuevo: real;
    iva_Ant, iva_Nuevo: real;
    ImpuestoInterno_Ant, ImpuestoInterno_Nuevo: real;
    Total_Ant, Total_Nuevo: real;
  public
    { Public declarations }   
  Comprobantes: Modelo_Factura;
  Remitos: Modelo_Remito;
  PuntosVenta: Modelo_PuntosVenta;
  TiposComprobantes: Modelo_Comprobante;
  Clientes: Modelo_Cliente; 
  Productos: Modelo_Producto;
  Impuestos: Modelo_Impuesto;  
  Contribuyentes: Modelo_Contribuyente;   
  CondicionesComerciales: Modelo_CondicionesComerciales;
  end;

var
  FComprobante: TFComprobante;


implementation

uses Sistema_ABM, Form_Ingreso, Form_Reporte_Comprobantes;

{$R *.dfm}

procedure TFComprobante.BSalirClick(Sender: TObject);
begin  
  if MessageDlg('Al salir no podr� continuar el comprobante, �Desea continuar?', mtInformation,[mbYes,mbNo], 0) = mrYes then
    begin
      Close;
      FPrincipal.Visible:= true;
    end;
end;

procedure TFComprobante.BGuardarCompClick(Sender: TObject);
begin
  if (StrToDate(EFecha.Text) >= StrToDate(datetostr(now))) and (CBPtoVta.ItemIndex <> -1)
          and (CBComp.ItemIndex <> -1) and (CBClientes.ItemIndex <> -1) and (CBCondComerc.ItemIndex <> -1) then
    begin
      if ((CBComp.ItemIndex = 0) or (CBComp.ItemIndex = 1) or (CBComp.ItemIndex = 2)) and (StrToInt(EResp.Text) = 1)
          or ((CBComp.ItemIndex > 2) and (StrToInt(EResp.Text) > 1)) then
        begin
          GBComp.Enabled:= false;
          GBDetalle.Enabled:= true;
          Clave_Remito:= 1;
          CBProducto.SetFocus;
        end
      else
        begin
          showmessage('No se puede emitir ese comprobante al tipo de responsable del cliente');
          CBComp.SetFocus;
        end;
    end
  else
    begin
      if (StrToDate(EFecha.Text) < StrToDate(datetostr(now))) then
        begin
          showmessage('La fecha no puede ser anterior a la del d�a de hoy');
          EFecha.Clear;
          EFecha.SetFocus;
        end
      else
        begin
          if (CBPtoVta.ItemIndex = -1) then
            begin
              showmessage('Seleccione un punto de venta');
              CBPtoVta.SetFocus;
            end
          else
            begin
              if (CBComp.ItemIndex = -1) then
                begin
                  showmessage('Seleccione un tipo de comprobante');
                  CBComp.SetFocus;
                end
              else
                if (CBClientes.ItemIndex = -1) then
                  begin
                    showmessage('Seleccione un cliente');
                    CBClientes.SetFocus;
                  end
                else
                  begin
                    showmessage('Seleccione una forma de pago');
                    CBCondComerc.SetFocus;
                  end
            end;
        end;
    end;
end;

procedure TFComprobante.CBClientesChange(Sender: TObject);
var
  Reg_Cliente: Registro_Cliente;
  Reg_TipoCont: Registro_Contribuyente;
  pos_Cliente: Tipo_Posicion;
begin
  ECuit.Clear;
  EDomicilio.Clear;
  EResp.Clear;
  pos_Cliente:= CBClientes.ItemIndex;
  Clientes.Capturar(Reg_Cliente,pos_Cliente);
  ECuit.Text:= Reg_Cliente.DNI;
  EDomicilio.Text:= Reg_Cliente.Domicilio;
  Contribuyentes.Capturar(Reg_TipoCont,Reg_Cliente.id_TipoContribuyente);
  EResp.Text:= Reg_TipoCont.Clave;
end;

procedure TFComprobante.CBCompChange(Sender: TObject);
var
  Reg_TipoComp: Registro_Comprobante;
  pos_TipoComp: Tipo_Posicion;
begin
  ENumComp.Clear;
  pos_TipoComp:= CBComp.ItemIndex;
  TiposComprobantes.Capturar(Reg_TipoComp,pos_TipoComp);
  ENumComp.Text:= IntToStr(Reg_TipoComp.ult_num + 1);
end;

procedure TFComprobante.CBProductoChange(Sender: TObject);
var
  Reg_Producto: Registro_Producto;
  Reg_TipoImp: Registro_Impuesto;
  pos_Producto: Tipo_Posicion;
begin
  EPrecioUnit.Clear;
  EImpuesto.Clear;
  EImpInt.Clear;
  pos_Producto:= CBProducto.ItemIndex;
  Productos.Capturar(Reg_Producto,pos_Producto);
  EPrecioUnit.Text:= FloatToStr(Reg_Producto.CostoUnitario);
  EImpInt.Text:= FloatToStr(Reg_Producto.ImpuestoInterno);
  Impuestos.Capturar(Reg_TipoImp,Reg_Producto.id_Impuesto);
  EImpuesto.Text:= FloatToStr(Reg_TipoImp.Alicuota);
end;

procedure TFComprobante.BCargarRemitoClick(Sender: TObject);
var
  Reg_Comprobante: Registro_Factura;
  Reg_Remito: Registro_Remito;
  Reg_Producto: Registro_Producto;
  Reg_Impuesto: Registro_Impuesto;
  Reg_TipoComp: Registro_Comprobante;
  pos_Comprobante, pos_Remito, i, pos_Modif: Tipo_Posicion;
begin
  if (CBProducto.ItemIndex <> -1) and (ECantidad.Text <> '') and (StrToInt(ECantidad.Text) > 0) then
    begin
      if Comprobantes.Buscar(ENumComp.Text,CBComp.ItemIndex,pos_Comprobante,true) = false then
        begin
          Reg_Comprobante.Fecha:= EFecha.Text;
          Reg_Comprobante.id_PtoVta:= CBPtoVta.ItemIndex;
          Reg_Comprobante.Num_Comprobante:= StrToInt(ENumComp.Text);
          Reg_Comprobante.id_TipoComprobante:= CBComp.ItemIndex;
          Reg_Comprobante.id_Cliente:= CBClientes.ItemIndex;
          Reg_Comprobante.id_Cond_Comercial:= CBCondComerc.ItemIndex;
          Reg_Comprobante.subtotal:= 0;
          Reg_Comprobante.iva:= 0;
          Reg_Comprobante.ImpuestoInterno:= 0;
          Reg_Comprobante.Total:= 0;
          Comprobantes.Insertar(Reg_Comprobante,pos_Comprobante);
          TiposComprobantes.Capturar(Reg_TipoComp,Reg_Comprobante.id_TipoComprobante);
          Reg_TipoComp.ult_num:= StrToInt(ENumComp.Text);
          TiposComprobantes.Modificar(Reg_TipoComp,Reg_Comprobante.id_TipoComprobante);
        end;

      id_Comprobante:= pos_Comprobante;

      Reg_Remito.clave:= Clave_Remito;
      Reg_Remito.id_Comprobante:= id_Comprobante;
      Reg_Remito.id_Producto:= CBProducto.ItemIndex;
      Reg_Remito.CostoUnitario:= StrToFloat(EPrecioUnit.Text);
      Reg_Remito.Cantidad:= StrToInt(ECantidad.Text);
      Reg_Remito.subtotal:= StrToFloat(ESubtotal.Text);
      Reg_Remito.iva:= StrToFloat(ESubtotal.Text) * StrToFloat(EImpuesto.Text) * 0.01;
      Reg_Remito.ImpuestoInterno:= StrToFloat(EImpInt.Text);
      Reg_Remito.Total:= StrToFloat(ESubtotalImp.Text);

      if Remitos.Buscar(IntToStr(Reg_Remito.clave),Reg_Remito.id_Comprobante,pos_Modif,true) = false then
        begin
          Remitos.Insertar(Reg_Remito,Remitos.Ultimo+1);

          Comprobantes.Capturar(Reg_Comprobante,pos_Comprobante);
          Reg_Comprobante.subtotal:= Reg_Comprobante.subtotal + Reg_Remito.subtotal;
          Reg_Comprobante.iva:= Reg_Comprobante.iva + Reg_Remito.iva;
          Reg_Comprobante.ImpuestoInterno:= Reg_Comprobante.ImpuestoInterno + Reg_Remito.ImpuestoInterno;
          Reg_Comprobante.Total:= Reg_Comprobante.Total + Reg_Remito.Total;
          Comprobantes.Modificar(Reg_Comprobante,pos_Comprobante);

          Clave_Remito:= Clave_Remito + 1;
          CBProducto.ItemIndex:= -1;
          ECantidad.Clear;
          EPrecioUnit.Clear;
          ESubtotal.Clear;
          EImpuesto.Clear;
          EImpInt.Clear;
          ESubtotalImp.Clear;

          pos_Remito:= Remitos.Primero;
          i:= 1;
          while pos_Remito <> Remitos.Pos_Nula do
            begin
              Remitos.Capturar(Reg_Remito, pos_Remito);
              Productos.Capturar(Reg_Producto,Reg_Remito.id_Producto);
              Impuestos.Capturar(Reg_Impuesto,Reg_Producto.id_Impuesto);
              if (Reg_Remito.Borrado = false) and (Reg_Remito.id_Comprobante = Reg_Comprobante.id) then
                begin
                  ListadoDetalles.Cells[0,i]:= IntToStr(Reg_Remito.clave);
                  ListadoDetalles.Cells[1,i]:= Reg_Producto.Nombre;
                  ListadoDetalles.Cells[2,i]:= IntToStr(Reg_Remito.Cantidad);
                  ListadoDetalles.Cells[3,i]:= FormatFloat('0.00',Reg_Remito.CostoUnitario);
                  ListadoDetalles.Cells[4,i]:= FormatFloat('0.00',Reg_Remito.subtotal);
                  ListadoDetalles.Cells[5,i]:= FloatToStr(Reg_Impuesto.Alicuota);
                  ListadoDetalles.Cells[6,i]:= FormatFloat('0.00',Reg_Remito.ImpuestoInterno);
                  ListadoDetalles.Cells[7,i]:= FormatFloat('0.00',Reg_Remito.Total);
                  i:= succ(i);
                end;
              pos_Remito:= Remitos.Proximo(pos_Remito);
            end;
          ListadoDetalles.RowCount:= i;
        end
      else
        begin
          if MessageDlg('�Desea modificar la operac��n?', mtWarning,[mbYes,mbNo], 0) = mrYes then
            begin
              Reg_Remito.clave:= Clave_Remito;
              Reg_Remito.id_Comprobante:= id_Comprobante;
              Reg_Remito.id_Producto:= CBProducto.ItemIndex;
              Reg_Remito.CostoUnitario:= StrToFloat(EPrecioUnit.Text);
              Reg_Remito.Cantidad:= StrToInt(ECantidad.Text);
              Reg_Remito.subtotal:= StrToFloat(ESubtotal.Text);
              Reg_Remito.iva:= StrToFloat(ESubtotal.Text) * StrToFloat(EImpuesto.Text) * 0.01;
              Reg_Remito.ImpuestoInterno:= StrToFloat(EImpInt.Text);
              Reg_Remito.Total:= StrToFloat(ESubtotalImp.Text);
              Remitos.Modificar(Reg_Remito,pos_Modif);

              Subtotal_Nuevo:= Subtotal_Ant - Reg_Remito.subtotal;
              iva_Nuevo:= iva_Ant - Reg_Remito.iva;
              ImpuestoInterno_Nuevo:= ImpuestoInterno_Ant - Reg_Remito.ImpuestoInterno;
              Total_Nuevo:= Total_Ant - Reg_Remito.Total;

              Comprobantes.Capturar(Reg_Comprobante,id_Comprobante);
              Reg_Comprobante.subtotal:= Reg_Comprobante.subtotal - Subtotal_Nuevo;  
              Reg_Comprobante.iva:= Reg_Comprobante.iva - iva_Nuevo;
              Reg_Comprobante.ImpuestoInterno:= Reg_Comprobante.ImpuestoInterno - ImpuestoInterno_Nuevo;
              Reg_Comprobante.Total:= Reg_Comprobante.Total - Total_Nuevo;
              Comprobantes.Modificar(Reg_Comprobante,id_Comprobante);

              CBProducto.ItemIndex:= -1;
              ECantidad.Clear;
              EPrecioUnit.Clear;
              ESubtotal.Clear;
              EImpuesto.Clear;
              EImpInt.Clear;
              ESubtotalImp.Clear;

              pos_Remito:= Remitos.Primero;
              i:= 1;
              while pos_Remito <> Remitos.Pos_Nula do
                begin
                  Remitos.Capturar(Reg_Remito, pos_Remito);
                  Productos.Capturar(Reg_Producto,Reg_Remito.id_Producto);
                  Impuestos.Capturar(Reg_Impuesto,Reg_Producto.id_Impuesto);
                  if (Reg_Remito.Borrado = false) and (Reg_Remito.id_Comprobante = Reg_Comprobante.id) then
                    begin
                      ListadoDetalles.Cells[0,i]:= IntToStr(Reg_Remito.clave);
                      ListadoDetalles.Cells[1,i]:= Reg_Producto.Nombre;
                      ListadoDetalles.Cells[2,i]:= IntToStr(Reg_Remito.Cantidad);
                      ListadoDetalles.Cells[3,i]:= FormatFloat('0.00',Reg_Remito.CostoUnitario);
                      ListadoDetalles.Cells[4,i]:= FormatFloat('0.00',Reg_Remito.subtotal);
                      ListadoDetalles.Cells[5,i]:= FloatToStr(Reg_Impuesto.Alicuota);
                      ListadoDetalles.Cells[6,i]:= FormatFloat('0.00',Reg_Remito.ImpuestoInterno);
                      ListadoDetalles.Cells[7,i]:= FormatFloat('0.00',Reg_Remito.Total);
                      i:= succ(i);
                    end;
                  pos_Remito:= Remitos.Proximo(pos_Remito);
                end;
              ListadoDetalles.RowCount:= i;
              Clave_Remito:= i;
            end
          else
            begin
              CBProducto.ItemIndex:= -1;
              ECantidad.Clear;
              EPrecioUnit.Clear;
              ESubtotal.Clear;
              EImpuesto.Clear;
              EImpInt.Clear;
              ESubtotalImp.Clear;

              pos_Remito:= Remitos.Primero;
              i:= 1;
              while pos_Remito <> Remitos.Pos_Nula do
                begin
                  Remitos.Capturar(Reg_Remito, pos_Remito);
                  Productos.Capturar(Reg_Producto,Reg_Remito.id_Producto);
                  Impuestos.Capturar(Reg_Impuesto,Reg_Producto.id_Impuesto);
                  if (Reg_Remito.Borrado = false) and (Reg_Remito.id_Comprobante = Reg_Comprobante.id) then
                    begin
                      ListadoDetalles.Cells[0,i]:= IntToStr(Reg_Remito.clave);
                      ListadoDetalles.Cells[1,i]:= Reg_Producto.Nombre;
                      ListadoDetalles.Cells[2,i]:= IntToStr(Reg_Remito.Cantidad);
                      ListadoDetalles.Cells[3,i]:= FormatFloat('0.00',Reg_Remito.CostoUnitario);
                      ListadoDetalles.Cells[4,i]:= FormatFloat('0.00',Reg_Remito.subtotal);
                      ListadoDetalles.Cells[5,i]:= FloatToStr(Reg_Impuesto.Alicuota);
                      ListadoDetalles.Cells[6,i]:= FormatFloat('0.00',Reg_Remito.ImpuestoInterno);
                      ListadoDetalles.Cells[7,i]:= FormatFloat('0.00',Reg_Remito.Total);
                      i:= succ(i);
                    end;
                  pos_Remito:= Remitos.Proximo(pos_Remito);
                end;
              ListadoDetalles.RowCount:= i;
              Clave_Remito:= i;
            end;
        end;
    end
  else
    begin
      if (CBProducto.ItemIndex = -1) then
        begin
          showmessage('Ingrese un producto');
          CBProducto.SetFocus;
        end
      else
        begin
          if (ECantidad.Text = '') or (StrToInt(ECantidad.Text) <= 0) then
            begin
              showmessage('Ingrese una cantidad v�lida');
              ECantidad.Clear;
              ECantidad.SetFocus;
            end;
        end;
    end;
end;

procedure TFComprobante.ECantidadExit(Sender: TObject);
begin
  if (ECantidad.Text <> '') and (StrToInt(ECantidad.Text) >= 0) then
    begin
      ESubtotal.Clear;
      ESubtotal.Text:= FloatToStr(StrToFloat(EPrecioUnit.Text) * StrToFloat(ECantidad.Text));
      ESubtotalImp.Clear;
      ESubtotalImp.Text:= FloatToStr((StrToFloat(ESubtotal.Text) * StrToFloat(EImpuesto.Text) * 0.01) + StrToFloat(EImpInt.Text) + StrToFloat(ESubtotal.Text))
    end
  else
    begin
      ECantidad.SetFocus;
    end;
end;

procedure TFComprobante.BModificarClick(Sender: TObject);
var
  Reg_Remito: Registro_Remito;
  Reg_Producto: Registro_Producto;
  Reg_Impuesto: Registro_Impuesto;
  pos_Remito: Tipo_Posicion;
begin
  if ListadoDetalles.Row <> 0 then
    begin
      Remitos.Buscar(IntToStr(ListadoDetalles.Row),id_Comprobante,pos_Remito,true);
      Remitos.Capturar(Reg_Remito,pos_Remito);
      Clave_Remito:= Clave_Remito - 1;
      CBProducto.ItemIndex:= Reg_Remito.id_Producto;
      Productos.Capturar(Reg_Producto,Reg_Remito.id_Producto);
      Impuestos.Capturar(Reg_Impuesto,Reg_Producto.id_Impuesto);
      EPrecioUnit.Text:= FloatToStr(Reg_Remito.CostoUnitario);
      EImpuesto.Text:= FloatToStr(Reg_Impuesto.Alicuota);
      EImpInt.Text:= FloatToStr(Reg_Producto.ImpuestoInterno);
      ECantidad.Text:= IntToStr(Reg_Remito.Cantidad);
      ESubtotal.Text:= FloatToStr(Reg_Remito.subtotal);
      ESubtotalImp.Text:= FloatToStr(Reg_Remito.Total);

      Subtotal_Ant:= Reg_Remito.subtotal;
      iva_Ant:= Reg_Remito.iva;
      ImpuestoInterno_Ant:= Reg_Remito.ImpuestoInterno;
      Total_Ant:= Reg_Remito.Total;
    end
  else
    showmessage('Debe seleccionar una operaci�n para modificar');
end;

procedure TFComprobante.CBProductoExit(Sender: TObject);
begin
  if CBProducto.ItemIndex = -1 then
    CBProducto.SetFocus;
end;

procedure TFComprobante.BImprimirClick(Sender: TObject);
var
  Reg_TipoComp: Registro_Comprobante;
  Reg_PuntoVenta: Registro_PuntosVenta;
  Reg_Cliente: Registro_Cliente;
  Reg_Resp: Registro_Contribuyente;
  Reg_Condicion: Registro_CondicionesComerciales;
begin
  if (StrToDate(EFecha.Text) >= StrToDate(datetostr(now))) and (CBPtoVta.ItemIndex <> -1)
          and (CBComp.ItemIndex <> -1) and (CBClientes.ItemIndex <> -1) and (CBCondComerc.ItemIndex <> -1)
          and (ListadoDetalles.RowCount > 1) then
    begin
      FReporteComprobantes.Comprobantes:= Comprobantes;
      FReporteComprobantes.Remitos:= Remitos;
      FReporteComprobantes.PuntosVenta:= PuntosVenta;
      FReporteComprobantes.TiposComprobantes:= TiposComprobantes;
      FReporteComprobantes.Clientes:= Clientes;
      FReporteComprobantes.Productos:= Productos;
      FReporteComprobantes.Impuestos:= Impuestos;
      FReporteComprobantes.Contribuyentes:= Contribuyentes;
      FReporteComprobantes.CondicionesComerciales:= CondicionesComerciales;

      TiposComprobantes.Capturar(Reg_TipoComp,CBComp.ItemIndex);

      FReporteComprobantes.LLetra.Caption:= rightstr(Reg_TipoComp.Descripcion,1);
      FReporteComprobantes.LTipoComP.Caption:= UpperCase(Copy(Reg_TipoComp.Descripcion,1,length(Reg_TipoComp.Descripcion)-1));
      FReporteComprobantes.LRazon.Caption:= FIngreso.nombre_Empresa;
      FReporteComprobantes.LTitulo.Caption:= UpperCase(FIngreso.nombre_Empresa);
      FReporteComprobantes.LDomEmp.Caption:= 'Bah�a Blanca';
      FReporteComprobantes.LCondEmp.Caption:= 'IVA Responsable Inscripto';

      PuntosVenta.Capturar(Reg_PuntoVenta,CBPtoVta.ItemIndex);
      FReporteComprobantes.LPtoVta.Caption:= Reg_PuntoVenta.Clave;
      repeat
        FReporteComprobantes.LPtoVta.Caption:= '0' + FReporteComprobantes.LPtoVta.Caption;
      until length( FReporteComprobantes.LPtoVta.Caption) = 5;

      FReporteComprobantes.LComp.Caption:= ENumComp.Text;
      repeat
        FReporteComprobantes.LComp.Caption:= '0' + FReporteComprobantes.LComp.Caption;
      until length(FReporteComprobantes.LComp.Caption) = 8;

      FReporteComprobantes.LFecha.Caption:= EFecha.Text;
      FReporteComprobantes.LCuitEmp.Caption:= '20-11111111-2';

      Clientes.Capturar(Reg_Cliente,CBClientes.ItemIndex);
      Contribuyentes.Capturar(Reg_Resp,Reg_Cliente.id_TipoContribuyente);

      FReporteComprobantes.LCuitPers.Caption:= ECuit.Text;
      FReporteComprobantes.LCondPers.Caption:= Reg_Resp.Descripcion;

      CondicionesComerciales.Capturar(Reg_Condicion,CBCondComerc.ItemIndex);
      FReporteComprobantes.LFormaPago.Caption:= Reg_Condicion.Descripcion;
      FReporteComprobantes.LNombrePers.Caption:= Reg_Cliente.Nombre;
      FReporteComprobantes.LDomicilioPers.Caption:= Reg_Cliente.Domicilio;

      if FReporteComprobantes.LLetra.Caption = 'B' then
        begin
          FReporteComprobantes.LNetoGravado.Caption:= '0.00'; 
          FReporteComprobantes.L27.Caption:= '0,00';
          FReporteComprobantes.L21.Caption:= '0,00';
          FReporteComprobantes.L10.Caption:= '0,00';
          FReporteComprobantes.L5.Caption:= '0,00';
          FReporteComprobantes.L2.Caption:= '0,00';
          FReporteComprobantes.L0.Caption:= '0,00';
          FReporteComprobantes.LOtros.Caption:= '0,00';
        end
      else
        begin
          FReporteComprobantes.FacturaA:= true;
        end;


      FReporteComprobantes.QuickRepComprobantes.Preview;
    end;
end;

procedure TFComprobante.FormCreate(Sender: TObject);
begin    
  Comprobantes:= Modelo_Factura.Create(FIngreso.c_Ruta, 'Comprobantes');
  Comprobantes.Abrir;
  Remitos:= Modelo_Remito.Create(FIngreso.c_Ruta, 'Remitos');
  Remitos.Abrir;
  PuntosVenta:= Modelo_PuntosVenta.Create(FIngreso.c_Ruta,'PuntosVenta');
  PuntosVenta.Abrir;
  TiposComprobantes:= Modelo_Comprobante.Create(FIngreso.c_Ruta,'Tipos_Comprobantes');
  TiposComprobantes.Abrir;
  Clientes:= Modelo_Cliente.Create(FIngreso.c_Ruta,'Clientes');
  Clientes.Abrir;
  Productos:= Modelo_Producto.Create(FIngreso.c_Ruta,'Productos');
  Productos.Abrir;
  Impuestos:= Modelo_Impuesto.Create(FIngreso.c_Ruta,'Impuestos');
  Impuestos.Abrir;
  Contribuyentes:= Modelo_Contribuyente.Create(FIngreso.c_Ruta,'Contribuyentes');
  Contribuyentes.Abrir;
  CondicionesComerciales:= Modelo_CondicionesComerciales.Create(FIngreso.c_Ruta,'CondicionesComerciales');
  CondicionesComerciales.Abrir;
end;

end.
