unit Form_Reporte_Listado_Comprobantes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, QuickRpt, ExtCtrls, Unidad_Facturas, Form_Consulta_Comprobantes;

type
  TFListadoComprobantes = class(TForm)
    QuickRepComprobantes: TQuickRep;
    BandPie: TQRBand;
    QRLabel_Pagina: TQRLabel;
    QRSysData_Pagina: TQRSysData;
    QRShape_Linea: TQRShape;
    QRLabel_Fecha: TQRLabel;
    QRSysData_Fecha: TQRSysData;
    BandInfo: TQRBand;
    LabelCodigo: TQRLabel;
    LabelTitCuenta: TQRLabel;
    LabelDV: TQRLabel;
    LabelNombre: TQRLabel;
    LabelCUIT: TQRLabel;
    PageHeaderBand1: TQRBand;
    LabelTitulo: TQRLabel;
    BandDetalle: TQRBand;
    LFecha: TQRLabel;
    LTipoComp: TQRLabel;
    LNumComp: TQRLabel;
    LCliente: TQRLabel;
    LCuit: TQRLabel;
    QRLabel1: TQRLabel;
    LTotal: TQRLabel;
    procedure QuickRepComprobantesBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QuickRepComprobantesNeedData(Sender: TObject;
      var MoreData: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    pos_Comp: Tipo_Posicion;
  end;

var
  FListadoComprobantes: TFListadoComprobantes;

implementation

{$R *.dfm}

procedure TFListadoComprobantes.QuickRepComprobantesBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  pos_Comp:= 1;
end;

procedure TFListadoComprobantes.QuickRepComprobantesNeedData(
  Sender: TObject; var MoreData: Boolean);
begin
  MoreData:= (pos_Comp < FConsultaComprobantes.ListadoComprobantes.RowCount);
  if MoreData then
    begin
      LFecha.Caption:= FConsultaComprobantes.ListadoComprobantes.Cells[0,pos_Comp];
      LTipoComp.Caption:= FConsultaComprobantes.ListadoComprobantes.Cells[1,pos_Comp];   
      LNumComp.Caption:= FConsultaComprobantes.ListadoComprobantes.Cells[2,pos_Comp];
      LCliente.Caption:= FConsultaComprobantes.ListadoComprobantes.Cells[3,pos_Comp];
      LCuit.Caption:= FConsultaComprobantes.ListadoComprobantes.Cells[4,pos_Comp];
      LTotal.Caption:= FConsultaComprobantes.ListadoComprobantes.Cells[5,pos_Comp];

      pos_Comp:= succ(pos_Comp);
    end;
end;

end.
