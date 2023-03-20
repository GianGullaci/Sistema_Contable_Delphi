unit Form_Asientos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Unidad_Plan_de_Cuentas, Unidad_Asientos, Unidad_Operaciones, Unidad_Modelo_Indice,
  StdCtrls, Mask, ExtCtrls, Grids;

type
  TFAsientos = class(TForm)
    BSalir: TButton;
    PanelAsiento: TPanel;
    Label1: TLabel;
    EFecha: TMaskEdit;
    Label2: TLabel;
    Label3: TLabel;
    ENumero: TEdit;
    ETipo: TEdit;
    BCargarAsiento: TButton;
    PanelOperaciones: TPanel;
    Label4: TLabel;
    EPase: TEdit;
    Label5: TLabel;
    ECuenta: TEdit;
    EDV: TEdit;
    Label6: TLabel;
    EFechaOp: TMaskEdit;
    Label7: TLabel;
    EFechaVto: TMaskEdit;
    Label8: TLabel;
    EComprob: TEdit;
    Label9: TLabel;
    ESuc: TEdit;
    Label10: TLabel;
    ESecc: TEdit;
    Label11: TLabel;
    EImporte: TEdit;
    Label12: TLabel;
    EDH: TEdit;
    Label13: TLabel;
    NombreCuenta: TLabel;
    Label14: TLabel;
    ELeyenda: TEdit;
    Panel1: TPanel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    LTotalDebe: TLabel;
    LTotalHaber: TLabel;
    LSaldo: TLabel;
    ListadoOperaciones: TStringGrid;
    BCargarOp: TButton;
    BNuevo: TButton;
    BRetomar: TButton;
    ListadoPlan: TStringGrid;
    BListar: TButton;
    BMayor: TButton;
    BRegistrar: TButton;
    BModificar: TButton;
    ListadoMayor: TStringGrid;
    ListadoBalance: TStringGrid;
    BBalance: TButton;
    procedure BSalirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BCargarAsientoClick(Sender: TObject);
    procedure BNuevoClick(Sender: TObject);
    procedure BRetomarClick(Sender: TObject);
    procedure ECuentaExit(Sender: TObject);
    procedure BCargarOpClick(Sender: TObject);
    procedure BListarClick(Sender: TObject);
    procedure BRegistrarClick(Sender: TObject);
    procedure BModificarClick(Sender: TObject);
    procedure BMayorClick(Sender: TObject);
    procedure BBalanceClick(Sender: TObject);
  private
    { Private declarations }
    Importe_Anterior, Importe_Nuevo: real;
  public
    { Public declarations }
  end;

var
  FAsientos: TFAsientos;
  Asientos: Modelo_Asientos;
  Indice_Asientos_Fecha, Indice_Asientos_Num, Indice_Op_Fecha, Indice_Op_Cuenta: Tipo_Indice;
  Operaciones: Modelo_Operaciones;
  PlanCuentas: Modelo_PDC;
  Indice_Plan: Tipo_Indice;
  id_Asiento: Tipo_Posicion;

implementation

uses Sistema_ABM, Form_Ingreso, Form_Reporte_Asientos, Form_Reporte_Mayor,
  Form_Reporte_Balance;

{$R *.dfm}

procedure TFAsientos.BSalirClick(Sender: TObject);
begin
  Close;
  FPrincipal.Visible:= true;
end;

procedure TFAsientos.FormActivate(Sender: TObject);
var
  Reg_Plan, Reg_Plan_Aux: Registro_PDC;
  Reg_Asiento: Registro_Asiento;
  Reg_Op: Registro_Operacion;
  Reg_Indice_Plan, Reg_Indice_Plan_Aux: Tipo_Reg_Indice;
  pos_Indice_Plan, pos_Plan_Aux, i, pos_Op: Tipo_Posicion;
  inicial, debitos, creditos, acumulado, cierre: real;
  cod_aux: string;
begin
  Asientos:= Modelo_Asientos.Create(FIngreso.c_Ruta, 'Asientos');
  Asientos.Abrir;
  Indice_Asientos_Fecha:= Tipo_Indice.Create(FIngreso.c_Ruta, 'Indice_Asientos_Fecha');
  Indice_Asientos_Fecha.Abrir;
  Indice_Asientos_Num:= Tipo_Indice.Create(FIngreso.c_Ruta, 'Indice_Asientos_Num');
  Indice_Asientos_Num.Abrir;
  Operaciones:= Modelo_Operaciones.Create(FIngreso.c_Ruta, 'Operaciones');
  Operaciones.Abrir;
  Indice_Op_Fecha:= Tipo_Indice.Create(FIngreso.c_Ruta, 'Indice_Op_Fecha');
  Indice_Op_Fecha.Abrir;
  Indice_Op_Cuenta:= Tipo_Indice.Create(FIngreso.c_Ruta, 'Indice_Op_Cuenta');
  Indice_Op_Cuenta.Abrir;
  PlanCuentas:= Modelo_PDC.Create(FIngreso.c_Ruta, 'Plan_de_Cuentas');
  PlanCuentas.Abrir;

  Indice_Plan:= Tipo_Indice.Create(FIngreso.c_Ruta, 'Indice_Plan');
  Indice_Plan.Abrir;

  EFecha.Clear;
  ENumero.Clear;
  ETipo.Clear;
  EPase.Clear;
  ECuenta.Clear;
  EDV.Clear;
  EFechaOp.Clear;
  EFechaVto.Clear;
  EComprob.Clear;
  ESuc.Clear;
  ESecc.Clear;
  EDH.Clear;
  EImporte.Clear;
  ELeyenda.Clear;
  LTotalDebe.Caption:= '0.00';
  LTotalHaber.Caption:= '0.00';
  LSaldo.Caption:= '0.00';

  ListadoPlan.RowCount:= 1;
  ListadoPlan.ColCount:= 5;
  ListadoPlan.Cells[0,0]:= 'Código';
  ListadoPlan.Cells[1,0]:= 'Num';
  ListadoPlan.Cells[2,0]:= 'D.V.';
  ListadoPlan.Cells[3,0]:= 'Nombre';
  ListadoPlan.Cells[4,0]:= 'Tipo';
  ListadoPlan.ColWidths[0]:= 100;
  ListadoPlan.ColWidths[1]:= 30;
  ListadoPlan.ColWidths[2]:= 30;
  ListadoPlan.ColWidths[3]:= 220;
  ListadoPlan.ColWidths[4]:= 50;

  pos_Indice_Plan:= Indice_Plan.Primero;
  i:= 1;
  while pos_Indice_Plan <> Indice_Plan.Pos_Nula do
    begin
      Indice_Plan.Capturar(pos_Indice_Plan,Reg_Indice_Plan);
      if Reg_Indice_Plan.Borrado = false then
        begin
          PlanCuentas.Capturar(Reg_Plan,Reg_Indice_Plan.Pos);
          ListadoPlan.Cells[0,i]:= Reg_Plan.Codigo;
          ListadoPlan.Cells[1,i]:= IntToStr(Reg_Plan.Numero);
          ListadoPlan.Cells[2,i]:= IntToStr(Reg_Plan.dv);
          ListadoPlan.Cells[3,i]:= Reg_Plan.Nombre;
          if Reg_Plan.Tipo then
            ListadoPlan.Cells[4,i]:= '1'
          else
            ListadoPlan.Cells[4,i]:= '0';
          i:= succ(i);
        end;
      pos_Indice_Plan:= Indice_Plan.Proximo(pos_Indice_Plan);
    end;
  ListadoPlan.RowCount:= i;

  ListadoOperaciones.RowCount:= 1;
  ListadoOperaciones.ColCount:= 8;
  ListadoOperaciones.Cells[0,0]:= 'Pase';
  ListadoOperaciones.Cells[1,0]:= 'SubP';
  ListadoOperaciones.Cells[2,0]:= 'Cta';
  ListadoOperaciones.Cells[3,0]:= 'Leyenda';
  ListadoOperaciones.Cells[4,0]:= 'Suc';
  ListadoOperaciones.Cells[5,0]:= 'Secc';
  ListadoOperaciones.Cells[6,0]:= 'Debe';
  ListadoOperaciones.Cells[7,0]:= 'Haber';
  ListadoOperaciones.ColWidths[0]:= 30;
  ListadoOperaciones.ColWidths[1]:= 30;
  ListadoOperaciones.ColWidths[2]:= 30;
  ListadoOperaciones.ColWidths[3]:= 300;
  ListadoOperaciones.ColWidths[4]:= 30;
  ListadoOperaciones.ColWidths[5]:= 30;
  ListadoOperaciones.ColWidths[6]:= 150;
  ListadoOperaciones.ColWidths[7]:= 150;


  ListadoBalance.RowCount:= 1;
  ListadoBalance.ColCount:= 8;
  ListadoBalance.Cells[0,0]:= 'CTA';
  ListadoBalance.Cells[1,0]:= 'CODIGO';
  ListadoBalance.Cells[2,0]:= 'NOMBRE';
  ListadoBalance.Cells[3,0]:= 'S. INICIAL';
  ListadoBalance.Cells[4,0]:= 'DEBITOS';
  ListadoBalance.Cells[5,0]:= 'CREDITOS';
  ListadoBalance.Cells[6,0]:= 'SDO. ACUM.';
  ListadoBalance.Cells[7,0]:= 'S. CIERRE';
  ListadoBalance.ColWidths[0]:= 30;
  ListadoBalance.ColWidths[1]:= 100;
  ListadoBalance.ColWidths[2]:= 220;
  ListadoBalance.ColWidths[3]:= 100;
  ListadoBalance.ColWidths[4]:= 100;   
  ListadoBalance.ColWidths[5]:= 100;
  ListadoBalance.ColWidths[6]:= 100;
  ListadoBalance.ColWidths[7]:= 100;

  pos_Indice_Plan:= Indice_Plan.Ultimo;
  while pos_Indice_Plan <> Indice_Plan.Pos_Nula do
    begin
      Indice_Plan.Capturar(pos_Indice_Plan,Reg_Indice_Plan);
      PlanCuentas.Capturar(Reg_Plan,Reg_Indice_Plan.Pos);
      if Reg_Plan.Tipo = true then
        begin
          inicial:= 0;
          debitos:= 0;
          creditos:= 0;
          pos_Op:= Operaciones.Primero;
          while pos_Op <> Operaciones.Pos_Nula do
            begin
              Operaciones.Capturar(Reg_Op,pos_Op);
              if Reg_Op.Cuenta = Reg_Plan.Numero then
                begin
                  Asientos.Capturar(Reg_Asiento,Reg_Op.id_Asiento);
                  if Reg_Asiento.Tipo <> 1 then
                    if Reg_Op.DoH = 0 then
                      debitos:= debitos + Reg_Op.Importe
                    else
                      creditos:= creditos + Reg_Op.Importe
                  else
                    if Reg_Op.DoH = 0 then
                      inicial:= inicial + Reg_Op.Importe
                    else
                      inicial:= inicial - Reg_Op.Importe;
                end;
              pos_Op:= Operaciones.Proximo(pos_Op);
            end;
          ListadoBalance.Cells[0,pos_Indice_Plan]:= IntToStr(Reg_Plan.Numero);
          ListadoBalance.Cells[1,pos_Indice_Plan]:= Reg_Plan.Codigo;
          ListadoBalance.Cells[2,pos_Indice_Plan]:= Reg_Plan.Nombre;
          if inicial <> 0 then
            ListadoBalance.Cells[3,pos_Indice_Plan]:= FormatFloat('0.00',inicial);
          if debitos <> 0 then
            ListadoBalance.Cells[4,pos_Indice_Plan]:= FormatFloat('0.00',debitos);
          if creditos <> 0 then
            ListadoBalance.Cells[5,pos_Indice_Plan]:= FormatFloat('0.00',creditos);
          acumulado:= debitos - creditos;
          if acumulado <> 0 then
            ListadoBalance.Cells[6,pos_Indice_Plan]:= FormatFloat('0.00',acumulado);
          cierre:= inicial + acumulado;
          if cierre <> 0 then
            ListadoBalance.Cells[7,pos_Indice_Plan]:= FormatFloat('0.00',cierre);
        end
      else
        begin
          inicial:= 0;
          debitos:= 0;
          creditos:= 0;
          pos_Plan_Aux:= pos_Indice_Plan+1;
          while pos_Plan_Aux <> Indice_Plan.Pos_Nula do
            begin
              cod_aux:= '';
              Indice_Plan.Capturar(pos_Plan_Aux,Reg_Indice_Plan_Aux);
              PlanCuentas.Capturar(Reg_Plan_Aux,Reg_Indice_Plan_Aux.Pos);
              if (length(Reg_Plan.Codigo) >= 4) and (length(Reg_Plan_Aux.Codigo) > length(Reg_Plan.Codigo)) then
               begin
                cod_aux:= copy(Reg_Plan_Aux.Codigo,1,length(Reg_Plan_Aux.Codigo)-3);
                if cod_aux = Reg_Plan.Codigo then
                begin
                  pos_Op:= Operaciones.Primero;
                  while pos_Op <> Operaciones.Pos_Nula do
                    begin
                      Operaciones.Capturar(Reg_Op,pos_Op);
                      if Reg_Op.Cuenta = Reg_Plan_Aux.Numero then
                        begin
                          Asientos.Capturar(Reg_Asiento,Reg_Op.id_Asiento);
                          if Reg_Asiento.Tipo <> 1 then
                            if Reg_Op.DoH = 0 then
                              debitos:= debitos + Reg_Op.Importe
                            else
                              creditos:= creditos + Reg_Op.Importe
                          else
                            if Reg_Op.DoH = 0 then
                              inicial:= inicial + Reg_Op.Importe
                            else
                              inicial:= inicial - Reg_Op.Importe;
                        end;
                      pos_Op:= Operaciones.Proximo(pos_Op);
                    end;
                end;
               end
              else
               begin
                cod_aux:= copy(Reg_Plan_Aux.Codigo,1,1);
                if cod_aux = Reg_Plan.Codigo then
                begin
                  pos_Op:= Operaciones.Primero;
                  while pos_Op <> Operaciones.Pos_Nula do
                    begin
                      Operaciones.Capturar(Reg_Op,pos_Op);
                      if Reg_Op.Cuenta = Reg_Plan_Aux.Numero then
                        begin
                          Asientos.Capturar(Reg_Asiento,Reg_Op.id_Asiento);
                          if Reg_Asiento.Tipo <> 1 then
                            if Reg_Op.DoH = 0 then
                              debitos:= debitos + Reg_Op.Importe
                            else
                              creditos:= creditos + Reg_Op.Importe
                          else
                            if Reg_Op.DoH = 0 then
                              inicial:= inicial + Reg_Op.Importe
                            else
                              inicial:= inicial - Reg_Op.Importe;
                        end;
                      pos_Op:= Operaciones.Proximo(pos_Op);
                    end;
                end;
               end;
              pos_Plan_Aux:= Indice_Plan.Proximo(pos_Plan_Aux);
            end;
          ListadoBalance.Cells[0,pos_Indice_Plan]:= IntToStr(Reg_Plan.Numero);
          ListadoBalance.Cells[1,pos_Indice_Plan]:= Reg_Plan.Codigo;
          ListadoBalance.Cells[2,pos_Indice_Plan]:= Reg_Plan.Nombre;
          if inicial <> 0 then
            ListadoBalance.Cells[3,pos_Indice_Plan]:= FormatFloat('0.00',inicial);
          if debitos <> 0 then
            ListadoBalance.Cells[4,pos_Indice_Plan]:= FormatFloat('0.00',debitos);
          if creditos <> 0 then
            ListadoBalance.Cells[5,pos_Indice_Plan]:= FormatFloat('0.00',creditos);
          acumulado:= debitos - creditos;
          if acumulado <> 0 then
            ListadoBalance.Cells[6,pos_Indice_Plan]:= FormatFloat('0.00',acumulado);
          cierre:= inicial + acumulado;
          if cierre <> 0 then
            ListadoBalance.Cells[7,pos_Indice_Plan]:= FormatFloat('0.00',cierre);
        end;
      pos_Indice_Plan:= Indice_Plan.Anterior(pos_Indice_Plan);
    end;
  ListadoBalance.RowCount:= Indice_Plan.Ultimo+1;
end;

procedure TFAsientos.BCargarAsientoClick(Sender: TObject);
var
  Reg_Asiento: Registro_Asiento;
  pos_Asiento: Tipo_Posicion;
begin
  if ((StrToDate(EFecha.Text) >= StrToDate('01/01/2022')) and (StrToDate(EFecha.Text) <= StrToDate(datetostr(now))))
      and ((ETipo.Text = '1') or (ETipo.Text = '5') or (ETipo.Text = '9')) then
    begin
      Reg_Asiento.Fecha_Asiento:= EFecha.Text;
      Reg_Asiento.Numero_Asiento:= StrToInt(ENumero.Text);
      Reg_Asiento.Tipo:= StrToInt(ETipo.Text);
      Reg_Asiento.Debe:= 0;
      Reg_Asiento.Haber:= 0;
      Reg_Asiento.Saldo:= 0;
      Asientos.Buscar(IntToStr(Reg_Asiento.Numero_Asiento),pos_Asiento,true);

      id_Asiento:= pos_Asiento;

      Asientos.Insertar(Reg_Asiento,pos_Asiento);

      PanelAsiento.Enabled:= false;
      PanelOperaciones.Enabled:= True;
      EPase.Text:= '1';
      EFechaOp.Text:= Reg_Asiento.Fecha_Asiento;
      EFechaVto.Text:= Reg_Asiento.Fecha_Asiento;
      ECuenta.SetFocus;
    end
  else
    begin
      if (StrToDate(EFecha.Text) < StrToDate('01/01/2022')) or (StrToDate(EFecha.Text) > StrToDate(datetostr(now))) then
        begin
          showmessage('Ingrese una fecha válida');
          EFecha.Clear;
          EFecha.SetFocus;
        end
      else
        begin
          showmessage('Ingrese un tipo válido (1/5/9)');
          ETipo.Clear;
          ETipo.SetFocus;
        end;
    end;
end;

procedure TFAsientos.BNuevoClick(Sender: TObject);
begin
  EFecha.Clear;
  ENumero.Text:= IntToStr(Asientos.Pos_Nueva + 1);
  ETipo.Clear;
  EPase.Clear;
  ECuenta.Clear;
  NombreCuenta.Visible:= false;
  EDV.Clear;
  EFechaOp.Clear;
  EFechaVto.Clear;
  EComprob.Clear;
  ESuc.text:= '0';
  ESecc.text:= '0';
  EDH.text:= '0';
  EImporte.text:= '0.00';
  ELeyenda.Clear;
  LTotalDebe.Caption:= '0.00';
  LTotalHaber.Caption:= '0.00';
  LSaldo.Caption:= '0.00'; 
  PanelAsiento.Enabled:= True;
  PanelOperaciones.Enabled:= false;
  EFecha.SetFocus;
  ListadoOperaciones.RowCount:= 1;
  ListadoOperaciones.ColCount:= 8;
  ListadoOperaciones.Cells[0,0]:= 'Pase';
  ListadoOperaciones.Cells[1,0]:= 'SubP';
  ListadoOperaciones.Cells[2,0]:= 'Cta';
  ListadoOperaciones.Cells[3,0]:= 'Leyenda';
  ListadoOperaciones.Cells[4,0]:= 'Suc';
  ListadoOperaciones.Cells[5,0]:= 'Secc';
  ListadoOperaciones.Cells[6,0]:= 'Debe';
  ListadoOperaciones.Cells[7,0]:= 'Haber';
  ListadoOperaciones.ColWidths[0]:= 30;
  ListadoOperaciones.ColWidths[1]:= 30;
  ListadoOperaciones.ColWidths[2]:= 30;
  ListadoOperaciones.ColWidths[3]:= 300;
  ListadoOperaciones.ColWidths[4]:= 30;
  ListadoOperaciones.ColWidths[5]:= 30;
  ListadoOperaciones.ColWidths[6]:= 150;
  ListadoOperaciones.ColWidths[7]:= 150;
end;

procedure TFAsientos.BRetomarClick(Sender: TObject);
var
  Reg_Asiento: Registro_Asiento;
  Reg_Operacion: Registro_Operacion;
  nro_Asiento: string;
  respuesta, borrado: Boolean;
  pos_Asiento, pos_Operacion, i, pos_Indice_Num: Tipo_Posicion;
begin
  respuesta:= InputQuery('Retomar Asiento', 'Ingrese el número de asiento', nro_Asiento);
  if respuesta then
    begin
      Reg_Asiento.Numero_Asiento:= StrToInt(nro_Asiento);
      if Asientos.Buscar(IntToStr(Reg_Asiento.Numero_Asiento),Pos_Asiento,true) then
        begin
         if Indice_Asientos_Num.Buscar(IntToStr(Reg_Asiento.Numero_Asiento),pos_Indice_Num,borrado) = false then
         begin
          Asientos.Capturar(Reg_Asiento,pos_Asiento);
          EFecha.Text:= Reg_Asiento.Fecha_Asiento;
          ENumero.Text:= IntToStr(Reg_Asiento.Numero_Asiento);
          ETipo.Text:= IntToStr(Reg_Asiento.Tipo);

          pos_Operacion:= Operaciones.Primero;
          i:= 1;
          while pos_Operacion <> Operaciones.Pos_Nula do
            begin
              Operaciones.Capturar(Reg_Operacion,pos_Operacion);
              if (Reg_Operacion.Borrado = false) and (Reg_Operacion.id_Asiento = Reg_Asiento.id) then
                begin
                      ListadoOperaciones.Cells[0,i]:= IntToStr(Reg_Operacion.Pase);
                      ListadoOperaciones.Cells[1,i]:= '0';
                      ListadoOperaciones.Cells[2,i]:= IntToStr(Reg_Operacion.Cuenta);
                      ListadoOperaciones.Cells[3,i]:= Reg_Operacion.Leyenda;
                      ListadoOperaciones.Cells[4,i]:= IntToStr(Reg_Operacion.Suc);
                      ListadoOperaciones.Cells[5,i]:= IntToStr(Reg_Operacion.Secc);
                      if Reg_Operacion.DoH = 0 then
                        begin
                          ListadoOperaciones.Cells[6,i]:= FloatToStr(Reg_Operacion.Importe);
                          ListadoOperaciones.Cells[7,i]:= '';
                        end
                      else
                        begin
                          ListadoOperaciones.Cells[6,i]:= '';
                          ListadoOperaciones.Cells[7,i]:= FloatToStr(Reg_Operacion.Importe);
                        end;
                      i:= succ(i);
                end;
              pos_Operacion:= Operaciones.Proximo(pos_Operacion);
            end;
          ListadoOperaciones.RowCount:= i;
          LTotalDebe.Caption:= FloatToStr(Reg_Asiento.Debe);
          LTotalHaber.Caption:= FloatToStr(Reg_Asiento.Haber);
          LSaldo.Caption:= FloatToStr(Reg_Asiento.Saldo);
          PanelAsiento.Enabled:= false;
          PanelOperaciones.Enabled:= true;
          EPase.Text:= inttostr(i);
          ECuenta.Clear;
          EDV.Clear;
          EFechaOp.Text:= Reg_Asiento.Fecha_Asiento;
          EFechaVto.Text:= Reg_Asiento.Fecha_Asiento;
          EComprob.Clear;
          ESuc.text:= '0';
          ESecc.text:= '0';
          EDH.text:= '0';
          EImporte.text:= '0.00';
          ELeyenda.Clear;
          id_asiento:= Reg_Asiento.id;
         end
         else
         ShowMessage('El asiento no se puede retomar');
        end
      else
        ShowMessage('El asiento no existe');
    end;
end;

procedure TFAsientos.ECuentaExit(Sender: TObject);
var
  Reg_Plan, Reg_Aux: Registro_PDC;
  Reg_Indice_Plan: Tipo_Reg_Indice;
  pos_Indice_Plan: Tipo_Posicion;
  bEncontrado: boolean;
begin
  if  ECuenta.Text <> '' then
   begin
    Reg_Aux.Numero:= strToInt(ECuenta.Text);
    bEncontrado:= false;
    Pos_Indice_Plan:= Indice_Plan.Primero;
    while (pos_Indice_Plan <> Indice_Plan.Pos_Nula) and (bEncontrado = false)do
      begin
        Indice_Plan.Capturar(pos_Indice_Plan,Reg_Indice_Plan);
        PlanCuentas.Capturar(Reg_Plan,Reg_Indice_Plan.Pos);
        if Reg_Plan.Numero = Reg_Aux.Numero then
          begin
            bEncontrado:= true;
            NombreCuenta.Caption:= Reg_Plan.Nombre;
            NombreCuenta.Visible:= true;
            EDV.Text:= IntToStr(Reg_Plan.dv);
          end
        else
          pos_Indice_Plan:= Indice_Plan.Proximo(pos_Indice_Plan);
      end;
    if not bEncontrado then
      begin
        showmessage('Ingrese una cuenta válida');
        ECuenta.Clear;
        EDV.Clear;
        NombreCuenta.Visible:= false;
        ECuenta.SetFocus;
      end;
   end
  else
    begin
      showmessage('Ingrese una cuenta');
      ECuenta.SetFocus;
    end;
end;

procedure TFAsientos.BCargarOpClick(Sender: TObject);
var
  Reg_Asiento: Registro_Asiento;
  Reg_Op: Registro_Operacion;
  pos_Op, i, pos_Modif: Tipo_Posicion;
begin
  if (ECuenta.Text <> '') and (StrToDate(EFechaOp.Text) <= StrToDate(datetostr(now))) and (StrToDate(EFechaVto.Text) >= StrToDate(EFechaOp.Text)) and (ESuc.Text <> '')
      and (ESecc.Text <> '') and ((EDH.Text = '0') or (EDH.Text = '1')) and (EImporte.Text <> '') and (ELeyenda.Text <> '') then
    begin
      Reg_Op.Pase:= StrToInt(EPase.Text);
      Reg_Op.Cuenta:= StrToInt(ECuenta.Text);
      Reg_Op.DV:= StrToInt(EDV.Text);
      Reg_Op.Fecha_Op:= EFechaOp.Text;
      Reg_Op.Fecha_Vto:= EFechaVto.Text;
      Reg_Op.Comprob:= EComprob.Text;
      Reg_Op.Suc:= StrToInt(ESuc.Text);
      Reg_Op.Secc:= StrToInt(ESecc.Text);
      Reg_Op.DoH:= StrToInt(EDH.Text);
      Reg_Op.Importe:= StrToFloat(EImporte.Text);
      Reg_Op.Leyenda:= ELeyenda.Text;
      Reg_Op.id_Asiento:= id_Asiento;

     if Operaciones.Buscar(IntToStr(Reg_Op.Pase),id_Asiento,pos_Modif,true) = false then
     begin

      Operaciones.Insertar(Reg_Op,Operaciones.Ultimo+1);

      Asientos.Capturar(Reg_Asiento,id_Asiento);

      if Reg_Op.DoH = 0 then
        begin
          Reg_Asiento.Debe:= Reg_Asiento.Debe + Reg_Op.Importe;
          Reg_Asiento.Saldo:= Reg_Asiento.Saldo - Reg_Op.Importe;
        end
      else
        begin
          Reg_Asiento.Haber:= Reg_Asiento.Haber + Reg_Op.Importe;
          Reg_Asiento.Saldo:= Reg_Asiento.Saldo + Reg_Op.Importe;
        end;
      Asientos.Modificar(Reg_Asiento,id_Asiento);

      EPase.Text:= IntToStr(Reg_Op.Pase+1);
      ECuenta.Clear;
      EDV.Clear;
      EFechaOp.Text:= Reg_Asiento.Fecha_Asiento;
      EFechaVto.Text:= Reg_Asiento.Fecha_Asiento;
      EComprob.Clear;
      ESuc.text:= '0';
      ESecc.text:= '0';
      EDH.text:= '0';
      EImporte.text:= '0.00';
      ELeyenda.Clear;
      LTotalDebe.Caption:= '0.00';
      LTotalHaber.Caption:= '0.00';
      LSaldo.Caption:= '0.00';

      pos_Op:= Operaciones.Primero;
      i:= 1;
      while pos_Op <> Operaciones.Pos_Nula do
        begin
          Operaciones.Capturar(Reg_Op, pos_Op);
          if (Reg_Op.Borrado = false) and (Reg_Op.id_Asiento = Reg_Asiento.id) then
            begin
                  ListadoOperaciones.Cells[0,i]:= IntToStr(Reg_Op.Pase);
                  ListadoOperaciones.Cells[1,i]:= '0';
                  ListadoOperaciones.Cells[2,i]:= IntToStr(Reg_Op.Cuenta);
                  ListadoOperaciones.Cells[3,i]:= Reg_Op.Leyenda;
                  ListadoOperaciones.Cells[4,i]:= IntToStr(Reg_Op.Suc);
                  ListadoOperaciones.Cells[5,i]:= IntToStr(Reg_Op.Secc);
                  if Reg_Op.DoH = 0 then
                    begin
                      ListadoOperaciones.Cells[6,i]:= FormatFloat('0.00',Reg_Op.Importe);
                      ListadoOperaciones.Cells[7,i]:= '';
                    end
                  else
                    begin
                      ListadoOperaciones.Cells[6,i]:= '';
                      ListadoOperaciones.Cells[7,i]:= FormatFloat('0.00',Reg_Op.Importe);
                    end;
                  i:= succ(i);
            end;
          pos_Op:= Operaciones.Proximo(pos_Op);
        end;
      ListadoOperaciones.RowCount:= i;
      LTotalDebe.Caption:= FloatToStr(Reg_Asiento.Debe);
      LTotalHaber.Caption:= FloatToStr(Reg_Asiento.Haber);
      LSaldo.Caption:= FloatToStr(Reg_Asiento.Saldo);
     end
    else
      begin
        if MessageDlg('¿Desea modificar la operacíón?', mtWarning,[mbYes,mbNo], 0) = mrYes then
            begin
              Reg_Op.Pase:= StrToInt(EPase.Text);
              Reg_Op.Cuenta:= StrToInt(ECuenta.Text);
              Reg_Op.DV:= StrToInt(EDV.Text);
              Reg_Op.Fecha_Op:= EFechaOp.Text;
              Reg_Op.Fecha_Vto:= EFechaVto.Text;
              Reg_Op.Comprob:= EComprob.Text;
              Reg_Op.Suc:= StrToInt(ESuc.Text);
              Reg_Op.Secc:= StrToInt(ESecc.Text);
              Reg_Op.DoH:= StrToInt(EDH.Text);
              Reg_Op.Importe:= StrToFloat(EImporte.Text);
              Reg_Op.Leyenda:= ELeyenda.Text;
              Reg_Op.id_Asiento:= id_Asiento;
              Operaciones.Modificar(Reg_Op,pos_Modif);

              Importe_Nuevo:= Importe_Anterior - Reg_Op.Importe;

              Asientos.Capturar(Reg_Asiento,id_Asiento);

              if Reg_Op.DoH = 0 then
                begin
                  Reg_Asiento.Debe:= Reg_Asiento.Debe - Importe_Nuevo;
                  Reg_Asiento.Saldo:= Reg_Asiento.Saldo + Importe_Nuevo;
                end
              else
                begin
                  Reg_Asiento.Haber:= Reg_Asiento.Haber - Importe_Nuevo;
                  Reg_Asiento.Saldo:= Reg_Asiento.Saldo - Importe_Nuevo;
                end;
              Asientos.Modificar(Reg_Asiento,id_Asiento);

              ECuenta.Clear;
              EDV.Clear;
              EFechaOp.Text:= Reg_Asiento.Fecha_Asiento;
              EFechaVto.Text:= Reg_Asiento.Fecha_Asiento;
              EComprob.Clear;
              ESuc.text:= '0';
              ESecc.text:= '0';
              EDH.text:= '0';
              EImporte.text:= '0.00';
              ELeyenda.Clear;
              LTotalDebe.Caption:= '0.00';
              LTotalHaber.Caption:= '0.00';
              LSaldo.Caption:= '0.00';

              pos_Op:= Operaciones.Primero;
              i:= 1;
              while pos_Op <> Operaciones.Pos_Nula do
                begin
                  Operaciones.Capturar(Reg_Op, pos_Op);
                  if (Reg_Op.Borrado = false) and (Reg_Op.id_Asiento = Reg_Asiento.id) then
                    begin
                      ListadoOperaciones.Cells[0,i]:= IntToStr(Reg_Op.Pase);
                      ListadoOperaciones.Cells[1,i]:= '0';
                      ListadoOperaciones.Cells[2,i]:= IntToStr(Reg_Op.Cuenta);
                      ListadoOperaciones.Cells[3,i]:= Reg_Op.Leyenda;
                      ListadoOperaciones.Cells[4,i]:= IntToStr(Reg_Op.Suc);
                      ListadoOperaciones.Cells[5,i]:= IntToStr(Reg_Op.Secc);
                      if Reg_Op.DoH = 0 then
                        begin
                          ListadoOperaciones.Cells[6,i]:= FormatFloat('0.00',Reg_Op.Importe);
                          ListadoOperaciones.Cells[7,i]:= '';
                        end
                      else
                        begin
                          ListadoOperaciones.Cells[6,i]:= '';
                          ListadoOperaciones.Cells[7,i]:= FormatFloat('0.00',Reg_Op.Importe);
                        end;
                      i:= succ(i);
                    end;
                pos_Op:= Operaciones.Proximo(pos_Op);
              end;
              ListadoOperaciones.RowCount:= i;
              LTotalDebe.Caption:= FloatToStr(Reg_Asiento.Debe);
              LTotalHaber.Caption:= FloatToStr(Reg_Asiento.Haber);
              LSaldo.Caption:= FloatToStr(Reg_Asiento.Saldo); 
              EPase.Text:= IntToStr(i);
            end
        else
          begin
            Asientos.Capturar(Reg_Asiento,id_Asiento);

            ECuenta.Clear;
              EDV.Clear;
              EFechaOp.Text:= Reg_Asiento.Fecha_Asiento;
              EFechaVto.Text:= Reg_Asiento.Fecha_Asiento;
              EComprob.Clear;
              ESuc.text:= '0';
              ESecc.text:= '0';
              EDH.text:= '0';
              EImporte.text:= '0.00';
              ELeyenda.Clear;
              LTotalDebe.Caption:= '0.00';
              LTotalHaber.Caption:= '0.00';
              LSaldo.Caption:= '0.00';

              pos_Op:= Operaciones.Primero;
              i:= 1;
              while pos_Op <> Operaciones.Pos_Nula do
                begin
                  Operaciones.Capturar(Reg_Op, pos_Op);
                  if (Reg_Op.Borrado = false) and (Reg_Op.id_Asiento = Reg_Asiento.id) then
                    begin
                      ListadoOperaciones.Cells[0,i]:= IntToStr(Reg_Op.Pase);
                      ListadoOperaciones.Cells[1,i]:= '0';
                      ListadoOperaciones.Cells[2,i]:= IntToStr(Reg_Op.Cuenta);
                      ListadoOperaciones.Cells[3,i]:= Reg_Op.Leyenda;
                      ListadoOperaciones.Cells[4,i]:= IntToStr(Reg_Op.Suc);
                      ListadoOperaciones.Cells[5,i]:= IntToStr(Reg_Op.Secc);
                      if Reg_Op.DoH = 0 then
                        begin
                          ListadoOperaciones.Cells[6,i]:= FormatFloat('0.00',Reg_Op.Importe);
                          ListadoOperaciones.Cells[7,i]:= '';
                        end
                      else
                        begin
                          ListadoOperaciones.Cells[6,i]:= '';
                          ListadoOperaciones.Cells[7,i]:= FormatFloat('0.00',Reg_Op.Importe);
                        end;
                      i:= succ(i);
                    end;
                pos_Op:= Operaciones.Proximo(pos_Op);
              end;
              ListadoOperaciones.RowCount:= i;
              LTotalDebe.Caption:= FloatToStr(Reg_Asiento.Debe);
              LTotalHaber.Caption:= FloatToStr(Reg_Asiento.Haber);
              LSaldo.Caption:= FloatToStr(Reg_Asiento.Saldo); 
              EPase.Text:= IntToStr(i);
          end;
      end;
    end
  else
    begin
      if (ECuenta.Text = '') then
        begin
          showmessage('Ingrese una cuenta');
          ECuenta.Clear;
          ECuenta.SetFocus;
        end
      else
        begin
          if (StrToDate(EFechaOp.Text) > StrToDate(datetostr(now))) then
            begin
              showmessage('Ingrese una fecha válida');
              EFechaOp.Clear;
              EFechaOp.SetFocus;
            end
          else
            begin
              if (StrToDate(EFechaVto.Text) < StrToDate(EFechaOp.Text)) then
                begin
                  showmessage('La fecha de vencimiento debe ser después de la fecha de operación');
                  EFechaVto.Clear;
                  EFechaVto.SetFocus;
                end
              else
                begin
                  if (ESuc.Text = '') then
                    begin
                      showmessage('Ingrese suc');
                      ESuc.Clear;
                      ESuc.SetFocus;
                    end
                  else
                    begin
                      if (ESecc.Text = '') then
                        begin
                          showmessage('Ingrese secc');
                          ESecc.Clear;
                          ESecc.SetFocus;
                        end
                      else
                        begin
                          if (EDH.Text <> '0') or (EDH.Text <> '1') then
                            begin
                              showmessage('Ingrese en D/H (0/1)');
                              EDH.Clear;
                              EDH.SetFocus;
                            end
                          else
                            begin
                              if (EImporte.Text = '') then
                                begin
                                  showmessage('Ingrese el importe');
                                  EImporte.Clear;
                                  EImporte.SetFocus;
                                end
                              else
                                begin
                                  showmessage('Ingrese la leyenda');
                                  ELeyenda.Clear;
                                  ELeyenda.SetFocus;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;
end;

procedure TFAsientos.BListarClick(Sender: TObject);
begin
  if MessageDlg('¿Desea mostrar solo los asientos registrados?', mtInformation,[mbYes,mbNo], 0) = mrYes then
    FReporteAsientos.respuesta:= true
  else
    FReporteAsientos.respuesta:= false;
  FReporteAsientos.ModAsto:= Asientos;
  FReporteAsientos.ModIndAsto:= Indice_Asientos_Fecha;
  FReporteAsientos.ModOp:= Operaciones;
  FReporteAsientos.ModPlan:= PlanCuentas;
  FReporteAsientos.ModIndPlan:= Indice_Plan;
  FReporteAsientos.QuickRepAsientos.Preview;
end;

procedure TFAsientos.BRegistrarClick(Sender: TObject);
var
  Reg_Asiento: Registro_Asiento;
  Reg_Op: Registro_Operacion;
  Reg_Indice: Tipo_Reg_Indice;
  pos_Asiento, pos_Indice_Fecha, pos_Indice_Num, pos_Op, pos_Indice_Op, pos_Indice_Op_Cuenta: Tipo_Posicion;
  borrado: boolean;
begin
 if MessageDlg('¿Desea registrar los nuevos asientos?', mtWarning,[mbYes,mbNo], 0) = mrYes then
 begin
  Indice_Asientos_Fecha.Vaciar;
  Indice_Asientos_Num.Vaciar;
  Indice_Op_Fecha.Vaciar;

  pos_Asiento:= Asientos.Primero;
  while pos_Asiento <> Asientos.Pos_Nula do
    begin
      Asientos.Capturar(Reg_Asiento,pos_Asiento);

      Indice_Asientos_Fecha.Buscar_Asiento(Reg_Asiento.Fecha_Asiento,pos_Indice_Fecha,borrado);
      Reg_Indice.Clave:= Reg_Asiento.Fecha_Asiento;
      Reg_Indice.Pos:= Reg_Asiento.id;
      Reg_Indice.Borrado:= Reg_Asiento.Borrado;
      Indice_Asientos_Fecha.Insertar(Reg_Indice,pos_Indice_Fecha);

      Indice_Asientos_Num.Buscar(IntToStr(Reg_Asiento.Numero_Asiento),pos_Indice_Num,borrado);
      Reg_Indice.Clave:= IntToStr(Reg_Asiento.Numero_Asiento);
      Reg_Indice.Pos:= Reg_Asiento.id;
      Reg_Indice.Borrado:= Reg_Asiento.Borrado;
      Indice_Asientos_Num.Insertar(Reg_Indice,pos_Indice_Num);

      pos_Asiento:= Asientos.Proximo(pos_Asiento);
    end;

  pos_Op:= Operaciones.Primero;
  while pos_Op <> Operaciones.Pos_Nula do
    begin
      Operaciones.Capturar(Reg_Op,pos_Op);

      Indice_Op_Fecha.Buscar_Asiento(Reg_Op.Fecha_Op,pos_Indice_Op,borrado);
      Reg_Indice.Clave:= Reg_Op.Fecha_Op;
      Reg_Indice.Pos:= Reg_Op.id;
      Reg_Indice.Borrado:= Reg_Op.Borrado;
      Indice_Op_Fecha.Insertar(Reg_Indice,pos_Indice_Op);

      Indice_Op_Cuenta.Buscar(IntToStr(Reg_Op.Cuenta),pos_Indice_Op_Cuenta,borrado);
      Reg_Indice.Clave:= IntToStr(Reg_Op.Cuenta);
      Reg_Indice.Pos:= Reg_Op.id;
      Reg_Indice.Borrado:= Reg_Op.Borrado;
      Indice_Op_Cuenta.Insertar(Reg_Indice,pos_Indice_Op_Cuenta);

      pos_Op:= Operaciones.Proximo(pos_Op);
    end;
    
  FAsientos.FormActivate(Sender);
 end;
end;

procedure TFAsientos.BModificarClick(Sender: TObject);
var
  Reg_Op: Registro_Operacion;
  pos_Op: Tipo_Posicion;
begin
  if ListadoOperaciones.Row <> 0 then
    begin
      Operaciones.Buscar(IntToStr(ListadoOperaciones.Row),id_Asiento,pos_Op,true);
      Operaciones.Capturar(Reg_Op,pos_Op);
      EPase.Text:= IntToStr(Reg_Op.Pase);
      ECuenta.Text:= IntToStr(Reg_Op.Cuenta);
      EDV.Text:= IntToStr(Reg_Op.DV);
      EFechaOp.Text:= Reg_Op.Fecha_Op;
      EFechaVto.Text:= Reg_Op.Fecha_Vto;
      EComprob.Text:= Reg_Op.Comprob;
      ESuc.Text:= IntToStr(Reg_Op.Suc);
      ESecc.Text:= IntToStr(Reg_Op.Secc);
      EDH.Text:= IntToStr(Reg_Op.DoH);
      EImporte.Text:= FloatToStr(Reg_Op.Importe);
      ELeyenda.Text:= Reg_Op.Leyenda;

      Importe_Anterior:= Reg_Op.Importe;
    end
  else
    showmessage('Debe seleccionar una operación para modificar');
end;

procedure TFAsientos.BMayorClick(Sender: TObject);
var
  Reg_Op: Registro_Operacion;
  Reg_Plan: Registro_PDC;
  Reg_Indice_Op, Reg_Indice_Plan: Tipo_Reg_Indice;
  Reg_Asiento: Registro_Asiento;
  pos_indice_Op, i: Tipo_Posicion;
  saldo, debitos, creditos: Real;
begin
  for I := 1 to ListadoMayor.RowCount - 1 do
    ListadoMayor.Rows[i].Clear;
  ListadoMayor.RowCount:= 1;
  ListadoMayor.ColCount:= 11;
  ListadoMayor.Cells[0,0]:= 'Asto';
  ListadoMayor.Cells[1,0]:= 'Pase';
  ListadoMayor.Cells[2,0]:= 'F.Op';
  ListadoMayor.Cells[3,0]:= 'F.Vto';
  ListadoMayor.Cells[4,0]:= 'Comprob';
  ListadoMayor.Cells[5,0]:= 'Su';
  ListadoMayor.Cells[6,0]:= 'Se';
  ListadoMayor.Cells[7,0]:= 'Leyenda';
  ListadoMayor.Cells[8,0]:= 'Debe';
  ListadoMayor.Cells[9,0]:= 'Haber';
  ListadoMayor.Cells[10,0]:= 'Saldos';
  ListadoMayor.ColWidths[0]:= 30;
  ListadoMayor.ColWidths[1]:= 30;
  ListadoMayor.ColWidths[2]:= 60;
  ListadoMayor.ColWidths[3]:= 60;
  ListadoMayor.ColWidths[4]:= 100;
  ListadoMayor.ColWidths[5]:= 30;
  ListadoMayor.ColWidths[6]:= 30;
  ListadoMayor.ColWidths[7]:= 160;
  ListadoMayor.ColWidths[8]:= 60;
  ListadoMayor.ColWidths[9]:= 60;
  ListadoMayor.ColWidths[10]:= 60;
 if ListadoPlan.Row > 0 then
 begin
  Saldo:= 0;
  debitos:= 0;
  creditos:= 0;
  Indice_Plan.Capturar(ListadoPlan.Row-1,Reg_Indice_Plan);
  PlanCuentas.Capturar(Reg_Plan,Reg_Indice_Plan.Pos);

  pos_Indice_Op:= Indice_Op_Fecha.Primero;
  i:= 1;
  while pos_Indice_Op <> Indice_Op_Fecha.Pos_Nula do
    begin
      Indice_Op_Fecha.Capturar(pos_Indice_Op,Reg_Indice_Op);
      Operaciones.Capturar(Reg_Op,Reg_Indice_Op.Pos);
      if Reg_Op.Cuenta = Reg_Plan.Numero then
        begin
          Asientos.Capturar(Reg_Asiento,Reg_Op.id_Asiento);
          ListadoMayor.Cells[0,i]:= IntToStr(Reg_Asiento.Numero_Asiento);
          ListadoMayor.Cells[1,i]:= IntToStr(Reg_Op.Pase);
          ListadoMayor.Cells[2,i]:= Reg_Op.Fecha_Op;
          ListadoMayor.Cells[3,i]:= Reg_Op.Fecha_Vto;
          ListadoMayor.Cells[4,i]:= Reg_Op.Comprob;
          ListadoMayor.Cells[5,i]:= IntToStr(Reg_Op.Suc);
          ListadoMayor.Cells[6,i]:= IntToStr(Reg_Op.Secc);
          ListadoMayor.Cells[7,i]:= Reg_Op.Leyenda;
          if Reg_Op.DoH = 0 then
            begin
              ListadoMayor.Cells[8,i]:= FormatFloat('0.00',Reg_Op.Importe);
              ListadoMayor.Cells[9,i]:= '';
              saldo:= saldo + Reg_Op.Importe;
              debitos:= debitos + Reg_Op.Importe;
            end
          else
            begin
              ListadoMayor.Cells[8,i]:= '';
              ListadoMayor.Cells[9,i]:= FormatFloat('0.00',Reg_Op.Importe);
              saldo:= saldo - Reg_Op.Importe;
              creditos:= creditos + Reg_Op.Importe;
            end;
          ListadoMayor.Cells[10,i]:= FormatFloat('0.00',saldo);
          i:= succ(i);
        end;
      pos_Indice_Op:= Indice_Op_Fecha.Proximo(pos_Indice_Op);
    end;
  ListadoMayor.Cells[7,i]:= 'Total';
  if debitos <> 0 then
    ListadoMayor.Cells[8,i]:= FormatFloat('0.00',debitos);
  if creditos <> 0 then
    ListadoMayor.Cells[9,i]:= FormatFloat('0.00',creditos);
  ListadoMayor.Cells[10,i]:= FormatFloat('0.00',saldo);
  ListadoMayor.RowCount:= i+1;
  FReporteMayor.ModAsto:= Asientos;
  FReporteMayor.ModIndAsto:= Indice_Asientos_Fecha;
  FReporteMayor.ModOp:= Operaciones;
  FReporteMayor.ModPlan:= PlanCuentas;
  FReporteMayor.ModIndPlan:= Indice_Plan;
  FReporteMayor.QuickRepMayor.Preview;
 end
 else
  showmessage('Seleccione una cuenta');
end;

procedure TFAsientos.BBalanceClick(Sender: TObject);
begin
  FReporteBalance.QuickRepBalance.Preview;
end;

end.
