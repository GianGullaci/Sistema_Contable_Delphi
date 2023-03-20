unit Form_Plan_de_Cuentas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Unidad_Plan_de_Cuentas, Unidad_Modelo_Indice, StdCtrls, Grids;

type
  TFPlanCuentas = class(TForm)
    BSalir: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ECodigo: TEdit;
    ENumero: TEdit;
    EDV: TEdit;
    ENombre: TEdit;
    BGuardarPlan: TButton;
    Label6: TLabel;
    ListadoPlan: TStringGrid;
    CBTipo: TComboBox;
    BListar: TButton;
    BNuevo: TButton;
    BModificar: TButton;
    procedure BSalirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BGuardarPlanClick(Sender: TObject);
    procedure BListarClick(Sender: TObject);
    procedure BNuevoClick(Sender: TObject);
    procedure BModificarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPlanCuentas: TFPlanCuentas;
  PlanCuentas: Modelo_PDC;
  Indice_Plan: Tipo_Indice;


implementation

uses Sistema_ABM, Form_Ingreso, Form_Reporte_PDC;

{$R *.dfm}

procedure TFPlanCuentas.BSalirClick(Sender: TObject);
begin
  Close;
  FPrincipal.Visible:= true;
end;

procedure TFPlanCuentas.FormActivate(Sender: TObject);
var
  Registro: Registro_PDC;
  Registro_Indice: Tipo_Reg_Indice;
  pos_Indice, i: Tipo_Posicion;
begin
  PlanCuentas:= Modelo_PDC.Create(FIngreso.c_Ruta, 'Plan_de_Cuentas');
  PlanCuentas.Abrir;

  Indice_Plan:= Tipo_Indice.Create(FIngreso.c_Ruta, 'Indice_Plan');
  Indice_Plan.Abrir;

  ECodigo.Enabled:= True;
  ECodigo.Clear;
  ENumero.Clear;
  EDV.Clear;
  ENombre.Clear;
  CBTipo.ItemIndex:= -1;

  ListadoPlan.RowCount:= 1;
  ListadoPlan.ColCount:= 5;
  ListadoPlan.Cells[0,0]:= 'C�digo';
  ListadoPlan.Cells[1,0]:= 'Num';
  ListadoPlan.Cells[2,0]:= 'D.V.';
  ListadoPlan.Cells[3,0]:= 'Nombre';
  ListadoPlan.Cells[4,0]:= 'Tipo';
  ListadoPlan.ColWidths[0]:= 100;
  ListadoPlan.ColWidths[1]:= 30;
  ListadoPlan.ColWidths[2]:= 30;
  ListadoPlan.ColWidths[3]:= 260;
  ListadoPlan.ColWidths[4]:= 50;

  pos_Indice:= Indice_Plan.Primero;
  i:= 1;
  while pos_Indice <> Indice_Plan.Pos_Nula do
    begin
      Indice_Plan.Capturar(pos_Indice,Registro_Indice);
      if Registro_Indice.Borrado = false then
        begin
          PlanCuentas.Capturar(Registro,Registro_Indice.Pos);
          ListadoPlan.Cells[0,i]:= Registro.Codigo;
          ListadoPlan.Cells[1,i]:= IntToStr(Registro.Numero);
          ListadoPlan.Cells[2,i]:= IntToStr(Registro.dv);
          ListadoPlan.Cells[3,i]:= Registro.Nombre;
          if Registro.Tipo then
            ListadoPlan.Cells[4,i]:= '1'
          else
            ListadoPlan.Cells[4,i]:= '0';
          i:= succ(i);
        end;
      pos_Indice:= Indice_Plan.Proximo(pos_Indice);
    end;
  ListadoPlan.RowCount:= i;
end;


procedure TFPlanCuentas.BGuardarPlanClick(Sender: TObject);
var
  Registro: Registro_PDC;
  Registro_Indice: Tipo_Reg_Indice;
  pos_Indice, i: Tipo_Posicion;
  borrado: boolean;
begin
  Registro.Codigo:= ECodigo.Text;
  Registro.Numero:= StrToInt(ENumero.Text);
  Registro.dv:= StrToInt(EDV.Text);
  Registro.Nombre:= ENombre.Text;
  if CBTipo.ItemIndex = 0 then
    Registro.Tipo:= False
  else
    Registro.Tipo:= True;

  if ((ECodigo.Text <> '') and (ENumero.Text <> '') and (EDV.Text <> '')
       and (ENombre.Text <> '')  and (CBTipo.ItemIndex <> -1)) then
    begin
      if Indice_Plan.Buscar(Registro.Codigo,pos_Indice,borrado) = false then
        begin
          Registro_Indice.Clave:= Registro.Codigo;
          Registro_Indice.Pos:= PlanCuentas.Pos_Nueva;

          Indice_Plan.Insertar(Registro_Indice,pos_Indice); 
          PlanCuentas.Insertar(Registro);


          ECodigo.Clear;
          ENumero.Clear;
          EDV.Clear;
          ENombre.Clear;
          CBTipo.ItemIndex:= 0;

          pos_Indice:= Indice_Plan.Primero;
          i:= 1;
          while pos_Indice <> Indice_Plan.Pos_Nula do
            begin
              Indice_Plan.Capturar(pos_Indice,Registro_Indice);
              if Registro_Indice.Borrado = false then
                begin
                  PlanCuentas.Capturar(Registro,Registro_Indice.Pos);
                  ListadoPlan.Cells[0,i]:= Registro.Codigo;
                  ListadoPlan.Cells[1,i]:= IntToStr(Registro.Numero);
                  ListadoPlan.Cells[2,i]:= IntToStr(Registro.dv);
                  ListadoPlan.Cells[3,i]:= Registro.Nombre;
                  i:= succ(i);
                end;
              pos_Indice:= Indice_Plan.Proximo(pos_Indice);
            end;
          ListadoPlan.RowCount:= i;
        end
      else
        begin
          if MessageDlg('El c�digo ya existe, �desea modificarlo?', mtWarning,[mbYes,mbNo], 0) = mrYes then
            begin
              Indice_Plan.Capturar(pos_Indice,Registro_Indice);
              PlanCuentas.Capturar(Registro,Registro_Indice.Pos);
              Registro.Codigo:= ECodigo.Text;
              Registro.Numero:= StrToInt(ENumero.Text);
              Registro.dv:= StrToInt(EDV.Text);
              Registro.Nombre:= ENombre.Text;
              if CBTipo.ItemIndex = 0 then
                Registro.Tipo:= False
              else
                Registro.Tipo:= True;
              PlanCuentas.Modificar(Registro,Registro_Indice.Pos);
              FPlanCuentas.FormActivate(Sender);
            end
          else
            begin
              FPlanCuentas.FormActivate(Sender);
            end;
        end;
    end
  else
    begin
      if (ECodigo.Text = '') then
        begin
          showmessage('Ingrese un c�digo');
          ECodigo.Clear;
          ECodigo.SetFocus;
        end
      else
        begin
          if (ENumero.Text = '') then
            begin
              showmessage('Ingrese un n�mero');
              ENumero.Clear;
              ENumero.SetFocus;
            end
          else
            begin
              if (EDV.Text = '') then
                begin
                  showmessage('Ingrese un D.V.');
                  EDV.Clear;
                  EDV.SetFocus;
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
                      showmessage('Seleccione un tipo');
                      CBTipo.SetFocus;
                    end;
                end;
            end;
        end;
    end;
end;

procedure TFPlanCuentas.BListarClick(Sender: TObject);
begin
  FReportePDC.ModPlan:= PlanCuentas;
  FReportePDC.ModIndPlan:= Indice_Plan;
  FReportePDC.QuickRepPDC.Preview;
end;

procedure TFPlanCuentas.BNuevoClick(Sender: TObject);
begin
  FPlanCuentas.FormActivate(Sender);
end;

procedure TFPlanCuentas.BModificarClick(Sender: TObject);
var
  Reg_Plan: Registro_PDC;
  Reg_Indice_Plan: Tipo_Reg_Indice;
  pos_Indice_Plan: Tipo_Posicion;
begin
  if ListadoPlan.Row <> 0 then
    begin
      pos_Indice_Plan:= ListadoPlan.Row - 1;
      Indice_Plan.Capturar(pos_Indice_Plan,Reg_Indice_Plan);
      PlanCuentas.Capturar(Reg_Plan,Reg_Indice_Plan.Pos);
      ECodigo.Text:= Reg_Plan.Codigo;
      ENumero.Text:= inttostr(Reg_Plan.Numero);
      EDV.Text:= inttostr(Reg_Plan.dv);
      ENombre.Text:= Reg_Plan.Nombre;
      if Reg_Plan.Tipo = false then
        CBTipo.ItemIndex:= 0
      else
        CBTipo.ItemIndex:= 1;
      ECodigo.Enabled:= false;
    end
  else
    showmessage('Seleccione una cuenta para modificar');
end;

end.
