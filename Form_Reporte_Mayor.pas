unit Form_Reporte_Mayor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QuickRpt, QRCtrls, ExtCtrls, Unidad_Asientos, Unidad_Modelo_Indice,
  Unidad_Operaciones, Unidad_Plan_de_Cuentas, Form_Asientos;

type
  TFReporteMayor = class(TForm)
    QuickRepMayor: TQuickRep;
    BandPie: TQRBand;
    QRLabel_Pagina: TQRLabel;
    QRSysData_Pagina: TQRSysData;
    QRShape_Linea: TQRShape;
    QRLabel_Fecha: TQRLabel;
    QRSysData_Fecha: TQRSysData;
    BandInfo: TQRBand;
    LabelTitPase: TQRLabel;
    LabelTitAsto: TQRLabel;
    LabelTitNombre: TQRLabel;
    LabelFOp: TQRLabel;
    LabelFVto: TQRLabel;
    LabelTitComprob: TQRLabel;
    LabelTitSuc: TQRLabel;
    LabelTitSecc: TQRLabel;
    LabelTitLeyenda: TQRLabel;
    LabelTitDebe: TQRLabel;
    LabelTitHaber: TQRLabel;
    QRBand_Cuerpo: TQRBand;
    PageHeaderBand1: TQRBand;
    LabelTitulo: TQRLabel;
    QRSubDetail_Operaciones: TQRSubDetail;
    LabelPase: TQRLabel;
    LabelAsiento: TQRLabel;
    LabelFechaOp: TQRLabel;
    LabelFechaVto: TQRLabel;
    LabelComprob: TQRLabel;
    LabelSuc: TQRLabel;
    LabelSecc: TQRLabel;
    LabelLeyenda: TQRLabel;
    LabelDebe: TQRLabel;
    LabelHaber: TQRLabel;
    LabelTitNumero: TQRLabel;
    LabelTitCodigo: TQRLabel;
    LabelTitSaldos: TQRLabel;
    LabelNumero: TQRLabel;
    LabelNombre: TQRLabel;
    LabelCodigo: TQRLabel;
    LabelSaldos: TQRLabel;
    procedure QuickRepMayorNeedData(Sender: TObject;
      var MoreData: Boolean);
    procedure QRSubDetail_OperacionesNeedData(Sender: TObject;
      var MoreData: Boolean);
    procedure QuickRepMayorBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    ModAsto: Modelo_Asientos;
    ModIndAsto: Tipo_Indice;
    ModOp: Modelo_Operaciones;
    ModPlan: Modelo_PDC;
    ModIndPlan: Tipo_Indice;
    pos_Asiento, pos_Plan: LongInt;
    pos_Op, pos_Ind_Op: LongInt;
    id_Asto: LongInt;
    Cuenta: ShortInt;
  end;

var
  FReporteMayor: TFReporteMayor;

implementation

{$R *.dfm}

procedure TFReporteMayor.QuickRepMayorBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  pos_Plan:= FAsientos.ListadoPlan.Row;
end;

procedure TFReporteMayor.QuickRepMayorNeedData(Sender: TObject;
  var MoreData: Boolean);
var
  borrado: boolean;
begin
  LabelNumero.Caption:= FAsientos.ListadoPlan.Cells[1,pos_Plan];
  LabelNombre.Caption:= FAsientos.ListadoPlan.Cells[3,pos_Plan];
  LabelCodigo.Caption:= FAsientos.ListadoPlan.Cells[0,pos_Plan];

  pos_Op:= 1;
end;

procedure TFReporteMayor.QRSubDetail_OperacionesNeedData(Sender: TObject;
  var MoreData: Boolean);
var
  Reg_Op: Registro_Operacion;
  Reg_Asiento: Registro_Asiento;
  Reg_Indice_Op: Tipo_Reg_Indice;
begin
  MoreData:= (pos_Op < FAsientos.ListadoMayor.RowCount);
  if MoreData then
    begin
      LabelAsiento.Caption:= FAsientos.ListadoMayor.Cells[0,pos_Op];
      LabelPase.Caption:= FAsientos.ListadoMayor.Cells[1,pos_Op];
      LabelFechaOp.Caption:= FAsientos.ListadoMayor.Cells[2,pos_Op];
      LabelFechaVto.Caption:= FAsientos.ListadoMayor.Cells[3,pos_Op];
      LabelComprob.Caption:= FAsientos.ListadoMayor.Cells[4,pos_Op];
      LabelSuc.Caption:= FAsientos.ListadoMayor.Cells[5,pos_Op];
      LabelSecc.Caption:= FAsientos.ListadoMayor.Cells[6,pos_Op];
      LabelLeyenda.Caption:= FAsientos.ListadoMayor.Cells[7,pos_Op];
      LabelDebe.Caption:= FAsientos.ListadoMayor.Cells[8,pos_Op];
      LabelHaber.Caption:= FAsientos.ListadoMayor.Cells[9,pos_Op];
      LabelSaldos.Caption:= FAsientos.ListadoMayor.Cells[10,pos_Op];
      pos_Op:= succ(pos_Op);
    end;
end;

end.
