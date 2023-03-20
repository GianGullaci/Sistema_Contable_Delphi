unit Form_Localidades;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Unidad_Clientes, Unidad_Localidades, Unidad_Provincias, Sistema_ABM;

type
  TFLocalidades = class(TForm)
    Label4: TLabel;
    Label7: TLabel;
    UsuarioRegistrado: TLabel;
    Label8: TLabel;
    NombreEmpresa: TLabel;
    BSalir: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    ECP: TEdit;
    EDescripcion: TEdit;
    BGuardarLocalidad: TButton;
    ListadoLocalidades: TStringGrid;
    Label3: TLabel;
    CBProvincia: TComboBox;
    procedure FormActivate(Sender: TObject);
    procedure BSalirClick(Sender: TObject);
    procedure BGuardarLocalidadClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FLocalidades: TFLocalidades;
  Localidades: Modelo_Localidad;
  Provincias: Modelo_Provincia;
  pos, pos_Provincia: Tipo_Posicion;

implementation

uses Form_Ingreso;

{$R *.dfm}

procedure TFLocalidades.FormActivate(Sender: TObject);
var
  Registro: Registro_Localidad;   
  Reg_Provincia: Registro_Provincia;
begin
  Localidades:= Modelo_Localidad.Create(FIngreso.c_Ruta,'Localidades');
  Localidades.Abrir;
  Provincias:= Modelo_Provincia.Create(FIngreso.c_Ruta,'Provincias');
  Provincias.Abrir;
  ECP.Text:= '';
  EDescripcion.Text:= '';
  CBProvincia.Clear;
  CBProvincia.ItemIndex:= -1;
  ListadoLocalidades.RowCount:= 1;
  ListadoLocalidades.ColCount:= 2;
  ListadoLocalidades.Cells[0,0]:= 'CP';
  ListadoLocalidades.Cells[1,0]:= 'Descripcion';
  ListadoLocalidades.ColWidths[1]:= 260;
  pos:= 0;
  while pos < Localidades.Ultimo do
    begin
      Localidades.Capturar(Registro,pos);
      if Registro.Borrado = false then
       begin
        ListadoLocalidades.RowCount:= ListadoLocalidades.RowCount + 1;
        ListadoLocalidades.Cells[0,ListadoLocalidades.RowCount-1]:= Registro.CP;
        ListadoLocalidades.Cells[1,ListadoLocalidades.RowCount-1]:= Registro.Descripcion;
       end;
      pos:= succ(pos);
    end;

  pos_Provincia:= 0;
  while pos_Provincia < Provincias.Ultimo do
    begin
      Provincias.Capturar(Reg_Provincia,pos_Provincia);
      if Reg_Provincia.Borrado = false then
        CBProvincia.Items.Add(Reg_Provincia.Clave+' - '+Reg_Provincia.Descripcion);
      pos_Provincia:= succ(pos_Provincia);
    end;
end;

procedure TFLocalidades.BSalirClick(Sender: TObject);
begin
  Close;
  FPrincipal.Visible:= true;
end;

procedure TFLocalidades.BGuardarLocalidadClick(Sender: TObject);
var
  Registro: Registro_Localidad;
begin
  Registro.CP:= ECP.Text;
  Registro.Descripcion:= EDescripcion.Text;
  Registro.id_Provincia:= CBProvincia.ItemIndex;
  if ((ECP.Text <> '') and (EDescripcion.Text <> '') and (strtoint(ECP.Text)>1000) and (CBProvincia.ItemIndex <> -1)) then
    begin
      if Localidades.Buscar(Registro.CP,pos,true) = false then
        begin
          Localidades.Insertar(Registro,pos);
          pos:= 0;
          ECP.Clear;
          ECP.SetFocus;
          EDescripcion.Clear;       
          CBProvincia.ItemIndex:= -1;
          ListadoLocalidades.RowCount:= 1;
          while pos < Localidades.Ultimo do
            begin
              Localidades.Capturar(Registro,pos);
              if Registro.Borrado = false then
               begin
                ListadoLocalidades.RowCount:= ListadoLocalidades.RowCount + 1;
                ListadoLocalidades.Cells[0,ListadoLocalidades.RowCount-1]:= Registro.CP;
                ListadoLocalidades.Cells[1,ListadoLocalidades.RowCount-1]:= Registro.Descripcion;
               end;
              pos:= succ(pos);
            end;
        end
      else
        begin
          showmessage('El CP ya existe');
          ECP.Clear;
          ECP.SetFocus;
        end;
    end
  else
    begin
      if ((ECP.Text = '') or (strtoint(ECP.Text)<=1000)) then
        begin
          showmessage('Ingrese una clave valida');
          ECP.Clear;
          ECP.SetFocus;
        end
      else
        if EDescripcion.Text = '' then
          begin
            showmessage('Ingrese el nombre de la Localidad');
            EDescripcion.Clear;
            EDescripcion.SetFocus;
          end
        else
          begin
            showmessage('Ingrese la Provincia');
            CBProvincia.SetFocus;
          end;
    end;
end;

end.
