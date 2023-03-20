unit Form_Reporte_Comprobantes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QuickRpt, QRCtrls, ExtCtrls, StrUtils, Unidad_Facturas, Unidad_Remitos, Unidad_Puntos_Venta,
  Unidad_Comprobantes, Unidad_Clientes, Unidad_Productos, Unidad_Impuestos,
  Unidad_Contribuyentes, Unidad_CondicionesComerciales, Form_Comprobantes;

type
  TFReporteComprobantes = class(TForm)
    QuickRepComprobantes: TQuickRep;
    BandPie: TQRBand;
    QRLabel_Pagina: TQRLabel;
    QRSysData_Pagina: TQRSysData;
    BandInfo: TQRBand;
    PageHeaderBand1: TQRBand;
    LabelTitulo: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRShape5: TQRShape;
    QRShape1: TQRShape;
    QRBand1: TQRBand;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel28: TQRLabel;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel32: TQRLabel;
    QRLabel33: TQRLabel;
    LNetoGravado: TQRLabel;
    L27: TQRLabel;
    L21: TQRLabel;
    L10: TQRLabel;
    L5: TQRLabel;
    L2: TQRLabel;
    L0: TQRLabel;
    LOtros: TQRLabel;
    LTotal: TQRLabel;
    LLetra: TQRLabel;
    LRazon: TQRLabel;
    LDomEmp: TQRLabel;
    LCondEmp: TQRLabel;
    LPtoVta: TQRLabel;
    LComp: TQRLabel;
    LFecha: TQRLabel;
    LCuitEmp: TQRLabel;
    QRLabel34: TQRLabel;
    QRLabel35: TQRLabel;
    LTipoComP: TQRLabel;
    LTitulo: TQRLabel;
    QRBand2: TQRBand;
    LCodigo: TQRLabel;
    LProducto: TQRLabel;
    LCantidad: TQRLabel;
    LUnidad: TQRLabel;
    LPrecioUnit: TQRLabel;
    LSubtotal: TQRLabel;
    LAlicuota: TQRLabel;
    LOtrosImp: TQRLabel;
    LSubtotalImp: TQRLabel;
    QRLabel1: TQRLabel;
    LCuitPers: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    LFormaPago: TQRLabel;
    LCondPers: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    LNombrePers: TQRLabel;
    LDomicilioPers: TQRLabel;
    QRShape2: TQRShape;
    QRShape4: TQRShape;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    procedure QuickRepComprobantesBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QuickRepComprobantesNeedData(Sender: TObject;
      var MoreData: Boolean);
  private
    { Private declarations }
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
    Reg_TipoComp: Registro_Comprobante;
    pos_TipoComp, pos_Comprobante: Tipo_Posicion;
    netogravado, iva27, iva21, iva10, iva5, iva2, iva0, otrostributos, total: real;
    FacturaA: boolean;
  end;

var
  FReporteComprobantes: TFReporteComprobantes;

implementation

{$R *.dfm}

procedure TFReporteComprobantes.QuickRepComprobantesBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  pos_Comprobante:= 1;
  total:= 0;
  netogravado:= 0;
  iva27:= 0;
  iva21:= 0;
  iva10:= 0;
  iva5:= 0;
  iva2:= 0;
  iva0:= 0;
  otrostributos:= 0;
end;

procedure TFReporteComprobantes.QuickRepComprobantesNeedData(
  Sender: TObject; var MoreData: Boolean);
begin
  MoreData:= (pos_Comprobante < FComprobante.ListadoDetalles.RowCount);
  if MoreData then
    begin
      LCodigo.Caption:= FComprobante.ListadoDetalles.Cells[0,pos_Comprobante];
      LProducto.Caption:= FComprobante.ListadoDetalles.Cells[1,pos_Comprobante];
      LCantidad.Caption:= FComprobante.ListadoDetalles.Cells[2,pos_Comprobante];
      LUnidad.Caption:= 'unidades';
      LPrecioUnit.Caption:= FComprobante.ListadoDetalles.Cells[3,pos_Comprobante];
      LSubtotal.Caption:= FComprobante.ListadoDetalles.Cells[4,pos_Comprobante];
      LAlicuota.Caption:= FComprobante.ListadoDetalles.Cells[5,pos_Comprobante];
      LOtrosImp.Caption:= FComprobante.ListadoDetalles.Cells[6,pos_Comprobante];
      LSubtotalImp.Caption:= FComprobante.ListadoDetalles.Cells[7,pos_Comprobante];
      pos_Comprobante:= succ(pos_Comprobante);
      netogravado:= netogravado + StrToFloat(LSubtotal.Caption);
      total:= total + StrToFloat(LSubtotalImp.Caption);

      if LAlicuota.Caption = '27' then
        iva27:= iva27 + (StrToFloat(LSubtotal.Caption) * 0.27);
      if LAlicuota.Caption = '21' then
        iva21:= iva21 + (StrToFloat(LSubtotal.Caption) * 0.21);
      if LAlicuota.Caption = '10,5' then
        iva10:= iva10 + (StrToFloat(LSubtotal.Caption) * 0.105);  
      if LAlicuota.Caption = '5' then
        iva5:= iva5 + (StrToFloat(LSubtotal.Caption) * 0.5);    
      if LAlicuota.Caption = '2,5' then
        iva2:= iva2 + (StrToFloat(LSubtotal.Caption) * 0.2);
      if LAlicuota.Caption = '0' then
        iva10:= 0;
      otrostributos:= otrostributos + StrToFloat(LOtrosImp.Caption);
    end
  else
    begin
      if FacturaA then
        begin
          LNetoGravado.Caption:= FormatFloat('0.00',netogravado);
          L27.Caption:= FormatFloat('0.00',iva27);
          L21.Caption:= FormatFloat('0.00',iva21);
          L10.Caption:= FormatFloat('0.00',iva10);
          L5.Caption:= FormatFloat('0.00',iva5);
          L2.Caption:= FormatFloat('0.00',iva2);
          L0.Caption:= FormatFloat('0.00',iva0);
          LOtros.Caption:= FormatFloat('0.00',otrostributos);
        end;
      LTotal.Caption:= FormatFloat('0.00',total);
    end;
end;

end.
