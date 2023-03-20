unit Form_Reporte_PDC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, QuickRpt, ExtCtrls, Unidad_Plan_de_Cuentas, Unidad_Modelo_Indice;

type
  TFReportePDC = class(TForm)
    QuickRepPDC: TQuickRep;
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
    LabelTipo: TQRLabel;
    PageHeaderBand1: TQRBand;
    LabelTitulo: TQRLabel;
    BandDetalle: TQRBand;
    LCodigo: TQRLabel;
    LCta: TQRLabel;
    LDV: TQRLabel;
    LNombre: TQRLabel;
    LTipo: TQRLabel;
    procedure QuickRepPDCBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QuickRepPDCNeedData(Sender: TObject; var MoreData: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    ModPlan: Modelo_PDC;
    ModIndPlan: Tipo_Indice;
    pos_Plan: longint;
  end;

var
  FReportePDC: TFReportePDC;

implementation

{$R *.dfm}

procedure TFReportePDC.QuickRepPDCBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  pos_Plan:= ModIndPlan.Primero;
end;

procedure TFReportePDC.QuickRepPDCNeedData(Sender: TObject;
  var MoreData: Boolean);
var
  Reg_Plan: Registro_PDC;
  Reg_Ind_Plan: Tipo_Reg_Indice;
begin
  MoreData:= (pos_Plan <> ModIndPlan.Pos_Nula);
  if MoreData then
    begin
      ModIndPlan.Capturar(pos_Plan,Reg_Ind_Plan);
      ModPlan.Capturar(Reg_Plan,Reg_Ind_Plan.Pos);
      LCodigo.Caption:= Reg_Plan.Codigo;
      LCta.Caption:= IntToStr(Reg_Plan.Numero);
      LDV.Caption:= IntToStr(Reg_Plan.dv);
      LNombre.Caption:= Reg_Plan.Nombre;
      if Reg_Plan.Tipo = false then
        LTipo.Caption:= '0'
      else
        LTipo.Caption:= '1';
      pos_Plan:= ModIndPlan.Proximo(pos_Plan);
    end;
end;

end.
