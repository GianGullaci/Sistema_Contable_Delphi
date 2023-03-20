unit Form_Reporte_Asientos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QuickRpt, QRCtrls, ExtCtrls, Unidad_Asientos, Unidad_Modelo_Indice,
  Unidad_Operaciones, Unidad_Plan_de_Cuentas;

type
  TFReporteAsientos = class(TForm)
    QuickRepAsientos: TQuickRep;
    BandPie: TQRBand;
    QRLabel_Pagina: TQRLabel;
    QRSysData_Pagina: TQRSysData;
    QRShape_Linea: TQRShape;
    QRLabel_Fecha: TQRLabel;
    QRSysData_Fecha: TQRSysData;
    BandInfo: TQRBand;
    LabelTitPase: TQRLabel;
    LabelTitCuenta: TQRLabel;
    LabelNombre: TQRLabel;
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
    LabelFCont: TQRLabel;
    LabelFechaAsiento: TQRLabel;
    LabelAsto: TQRLabel;
    LabelAsiento: TQRLabel;
    LabelCargado: TQRLabel;
    LabelRegistrado: TQRLabel;
    QRLabel1: TQRLabel;
    LabelTipoAsto: TQRLabel;
    LabelTeclado: TQRLabel;
    LabelPase: TQRLabel;
    LabelCuenta: TQRLabel;
    LabelNombreCuenta: TQRLabel;
    LabelFechaOp: TQRLabel;
    LabelFechaVto: TQRLabel;
    LabelComprob: TQRLabel;
    LabelSuc: TQRLabel;
    LabelSecc: TQRLabel;
    LabelLeyenda: TQRLabel;
    LabelDebe: TQRLabel;
    LabelHaber: TQRLabel;
    procedure QuickRepAsientosBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QuickRepAsientosNeedData(Sender: TObject;
      var MoreData: Boolean);
    procedure QRSubDetail_OperacionesNeedData(Sender: TObject;
      var MoreData: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    ModAsto: Modelo_Asientos;
    ModIndAsto: Tipo_Indice;
    ModOp: Modelo_Operaciones;
    ModPlan: Modelo_PDC;
    ModIndPlan: Tipo_Indice;
    pos_Asiento: LongInt;
    pos_Op: LongInt;
    id_Asto: LongInt;
    respuesta: boolean;
  end;

var
  FReporteAsientos: TFReporteAsientos;

implementation

{$R *.dfm}

procedure TFReporteAsientos.QuickRepAsientosBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  if respuesta = true then
    pos_Asiento:= ModIndAsto.Primero
  else
    pos_Asiento:= ModAsto.Primero;
end;

procedure TFReporteAsientos.QuickRepAsientosNeedData(Sender: TObject;
  var MoreData: Boolean);
var
  Reg_Asiento: Registro_Asiento;
  Reg_Indice: Tipo_Reg_Indice;
begin
 if respuesta = true then
 begin
  MoreData := (  pos_Asiento <> ModIndAsto.Pos_Nula);
  if MoreData then
  begin
    ModIndAsto.Capturar(pos_Asiento,Reg_Indice);
    ModAsto.Capturar(Reg_Asiento,Reg_Indice.Pos);
    LabelFechaAsiento.Caption     := Reg_Asiento.Fecha_Asiento;
    LabelAsiento.Caption    := IntToStr(Reg_Asiento.Numero_Asiento);
    if Reg_Asiento.Tipo = 1 then
      LabelTipoAsto.Caption := 'de'
    else
      if Reg_Asiento.Tipo = 5 then
        LabelTipoAsto.Caption := 'Normal';

    // Se presentó a un Asiento - Se inicializa todo para el NeedData del subdetalle
    id_Asto  := Reg_Asiento.id;
    ModOp.Buscar_Asiento(id_Asto,pos_Op,false);

    // Proximo elemento de la grilla
    Pos_Asiento := ModIndAsto.Proximo(Pos_Asiento);
  end;
 end
 else
 begin
  MoreData := (  pos_Asiento <> ModAsto.Pos_Nula);
  if MoreData then
  begin
    ModAsto.Capturar(Reg_Asiento,pos_Asiento);
    LabelFechaAsiento.Caption     := Reg_Asiento.Fecha_Asiento;
    LabelAsiento.Caption    := IntToStr(Reg_Asiento.Numero_Asiento);
    if Reg_Asiento.Tipo = 1 then
      LabelTipoAsto.Caption := 'de'
    else
      if Reg_Asiento.Tipo = 5 then
        LabelTipoAsto.Caption := 'Normal';

    // Se presentó a un Asiento - Se inicializa todo para el NeedData del subdetalle
    id_Asto  := Reg_Asiento.id;
    ModOp.Buscar_Asiento(id_Asto,pos_Op,false);

    // Proximo elemento de la grilla
    Pos_Asiento := ModAsto.Proximo(Pos_Asiento);
  end;
 end;
end;

procedure TFReporteAsientos.QRSubDetail_OperacionesNeedData(
  Sender: TObject; var MoreData: Boolean);
var
  Reg_Op: Registro_Operacion;
  Reg_Plan, Reg_Aux: Registro_PDC;
  pos_Indice_Plan: Tipo_Posicion;
  Reg_Indice_Plan: Tipo_Reg_Indice;
  bEncontrado: boolean;
begin
  MoreData:= (pos_Op <> ModOp.Pos_Nula);
  if MoreData then
    begin
      ModOp.Capturar(Reg_Op,pos_op);
      MoreData:= Reg_Op.id_Asiento = id_Asto;
      if MoreData then
        begin
          LabelPase.Caption:= IntToStr(Reg_Op.Pase);
          LabelCuenta.Caption:= IntToStr(Reg_Op.Cuenta) + '-' + IntToStr(Reg_Op.DV);
          Reg_Aux.Numero:= Reg_Op.Cuenta;
          bEncontrado:= false;
          Pos_Indice_Plan:= ModIndPlan.Primero;
          while (pos_Indice_Plan <> ModIndPlan.Pos_Nula) and (bEncontrado = false) do
            begin
              ModIndPlan.Capturar(pos_Indice_Plan,Reg_Indice_Plan);
              ModPlan.Capturar(Reg_Plan,Reg_Indice_Plan.Pos);
              if Reg_Plan.Numero = Reg_Aux.Numero then
                begin
                  bEncontrado:= true;
                  LabelNombreCuenta.Caption:= Reg_Plan.Nombre;
                end
              else
                pos_Indice_Plan:= ModIndPlan.Proximo(pos_Indice_Plan);
            end;
          LabelFechaOp.Caption:= Reg_Op.Fecha_Op;
          LabelFechaVto.Caption:= Reg_Op.Fecha_Vto;
          LabelComprob.Caption:= Reg_Op.Comprob;
          LabelSuc.Caption:= IntToStr(Reg_Op.Suc);
          LabelSecc.Caption:= IntToStr(Reg_Op.Secc);
          LabelLeyenda.Caption:= Reg_Op.Leyenda;
          if Reg_Op.DoH = 0 then
            begin
              LabelDebe.Caption:= FormatFloat('0.00',Reg_Op.Importe);
              LabelHaber.Caption:= '';
            end
          else
            begin
              LabelDebe.Caption:= '';
              LabelHaber.Caption:= FormatFloat('0.00',Reg_Op.Importe);
            end;
          pos_Op:= ModOp.Proximo(pos_Op);
        end;
    end;
end;


end.


