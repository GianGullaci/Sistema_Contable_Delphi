unit Form_Reporte_Balance;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, QuickRpt, ExtCtrls, Unidad_Plan_de_Cuentas;

type
  TFReporteBalance = class(TForm)
    QuickRepBalance: TQuickRep;
    BandPie: TQRBand;
    QRLabel_Pagina: TQRLabel;
    QRSysData_Pagina: TQRSysData;
    QRShape_Linea: TQRShape;
    QRLabel_Fecha: TQRLabel;
    QRSysData_Fecha: TQRSysData;
    BandInfo: TQRBand;
    LabelCodigo: TQRLabel;
    LabelTitCuenta: TQRLabel;
    LabelNombre: TQRLabel;
    PageHeaderBand1: TQRBand;
    LabelTitulo: TQRLabel;
    LabelInicial: TQRLabel;
    LabelDebitos: TQRLabel;
    LabelCreditos: TQRLabel;
    LabelAcumulado: TQRLabel;
    LabelCierre: TQRLabel;
    BandHeader: TQRBand;
    LCta: TQRLabel;
    LCodigo: TQRLabel;
    LNombre: TQRLabel;
    LInicial: TQRLabel;
    LDebitos: TQRLabel;
    LCreditos: TQRLabel;
    LAcumulado: TQRLabel;
    LCierre: TQRLabel;
    procedure QuickRepBalanceBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QuickRepBalanceNeedData(Sender: TObject;
      var MoreData: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    pos_Plan: Tipo_Posicion;
    total_Inicial, Total_Acum, Total_Cierre: real;
  end;

var
  FReporteBalance: TFReporteBalance;

implementation

uses Form_Asientos;

{$R *.dfm}

procedure TFReporteBalance.QuickRepBalanceBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  pos_Plan:= 0;
  Total_Inicial:= 0;
  Total_Acum:= 0;
  Total_Cierre:= 0;
end;

procedure TFReporteBalance.QuickRepBalanceNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData:= (pos_Plan < FAsientos.ListadoBalance.RowCount);
  if MoreData then
    begin
      LCodigo.Caption:= FAsientos.ListadoBalance.Cells[1,pos_Plan];
      LCta.Caption:= FAsientos.ListadoBalance.Cells[0,pos_Plan];
      LNombre.Caption:= FAsientos.ListadoBalance.Cells[2,pos_Plan];
      LInicial.Caption:= FAsientos.ListadoBalance.Cells[3,pos_Plan];
      LDebitos.Caption:= FAsientos.ListadoBalance.Cells[4,pos_Plan];
      LCreditos.Caption:= FAsientos.ListadoBalance.Cells[5,pos_Plan];
      LAcumulado.Caption:= FAsientos.ListadoBalance.Cells[6,pos_Plan];
      LCierre.Caption:= FAsientos.ListadoBalance.Cells[7,pos_Plan];
      pos_Plan:= succ(pos_Plan);
    end;
end;

end.
