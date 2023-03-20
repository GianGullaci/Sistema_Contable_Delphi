unit Form_CondicionesComerciales;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Sistema_ABM, Unidad_CondicionesComerciales, Grids, StdCtrls;

type
  TFCondicionesComerciales = class(TForm)
    Label4: TLabel;
    Label7: TLabel;
    UsuarioRegistrado: TLabel;
    Label8: TLabel;
    NombreEmpresa: TLabel;
    BSalir: TButton;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    EDescripcion: TEdit;
    BGuardar: TButton;
    ListadoCondiciones: TStringGrid;
    BNuevo: TButton;
    BModificar: TButton;
    procedure BSalirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BGuardarClick(Sender: TObject);
    procedure BNuevoClick(Sender: TObject);
    procedure BModificarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCondicionesComerciales: TFCondicionesComerciales;
  CondicionesComerciales: Modelo_CondicionesComerciales;
  pos: Tipo_Posicion;
  clave: Tipo_Clave;

implementation

uses Form_Ingreso;

{$R *.dfm}

procedure TFCondicionesComerciales.BSalirClick(Sender: TObject);
begin
  Close;
  FPrincipal.Visible:= true;
end;

procedure TFCondicionesComerciales.FormActivate(Sender: TObject);
var
  Registro: Registro_CondicionesComerciales;
begin
  CondicionesComerciales:= Modelo_CondicionesComerciales.Create(FIngreso.c_Ruta,'CondicionesComerciales');
  CondicionesComerciales.Abrir;
  EDescripcion.Text:= '';
  EDescripcion.Enabled:= false;
  ListadoCondiciones.RowCount:= 1;
  ListadoCondiciones.ColCount:= 2;
  ListadoCondiciones.Cells[0,0]:= 'Clave';
  ListadoCondiciones.Cells[1,0]:= 'Descripcion';
  ListadoCondiciones.ColWidths[1]:= 260;
  pos:= 0;
  while pos < CondicionesComerciales.Ultimo do
    begin
      CondicionesComerciales.Capturar(Registro,pos);
      if Registro.Borrado = false then
       begin
        ListadoCondiciones.RowCount:= ListadoCondiciones.RowCount + 1;
        ListadoCondiciones.Cells[0,ListadoCondiciones.RowCount-1]:= Registro.Clave;
        ListadoCondiciones.Cells[1,ListadoCondiciones.RowCount-1]:= Registro.Descripcion;
       end;
      pos:= succ(pos);
    end;
end;

procedure TFCondicionesComerciales.BGuardarClick(Sender: TObject);
var
  Registro: Registro_CondicionesComerciales;
begin
  Registro.Descripcion:= EDescripcion.Text;

  if (EDescripcion.Text <> '') then
    begin
      if CondicionesComerciales.Buscar(clave,pos,true) = false then
        begin
          Registro.Clave:= clave;
          CondicionesComerciales.Insertar(Registro,pos);
          pos:= 0;
          EDescripcion.Clear;
          EDescripcion.Enabled:= false;
          ListadoCondiciones.RowCount:= 1;
          while pos < CondicionesComerciales.Ultimo do
            begin
              CondicionesComerciales.Capturar(Registro,pos);
              if Registro.Borrado = false then
               begin
                ListadoCondiciones.RowCount:= ListadoCondiciones.RowCount + 1;
                ListadoCondiciones.Cells[0,ListadoCondiciones.RowCount-1]:= Registro.Clave;
                ListadoCondiciones.Cells[1,ListadoCondiciones.RowCount-1]:= Registro.Descripcion;
               end;
              pos:= succ(pos);
            end;
        end
      else
        begin
          if MessageDlg('¿Desea modificar el registro?', mtWarning,[mbYes,mbNo], 0) = mrYes then
            begin
              CondicionesComerciales.Capturar(Registro,pos);
              Registro.Descripcion:= EDescripcion.Text;
              CondicionesComerciales.Modificar(Registro,pos);
              FCondicionesComerciales.FormActivate(Sender);
            end
          else
            begin
              FCondicionesComerciales.FormActivate(Sender);
            end;
        end;
    end
  else
    begin
      if (EDescripcion.Text = '') then
        begin
          showmessage('Ingrese una descripción');
          EDescripcion.Clear;
          EDescripcion.SetFocus;
        end;
    end;
end;

procedure TFCondicionesComerciales.BNuevoClick(Sender: TObject);
begin
  FCondicionesComerciales.FormActivate(Sender);
  clave:= IntToStr(CondicionesComerciales.Pos_Nueva + 1);
  EDescripcion.Enabled:= true;    
  EDescripcion.SetFocus;
end;

procedure TFCondicionesComerciales.BModificarClick(Sender: TObject);
var
  Registro: Registro_CondicionesComerciales;
begin
  if ListadoCondiciones.Row <> 0 then
    begin
      pos:= ListadoCondiciones.Row - 1;
      CondicionesComerciales.Capturar(Registro,pos);
      clave:= Registro.Clave;
      EDescripcion.Text:= Registro.Descripcion;       
      EDescripcion.Enabled:= true;
      EDescripcion.SetFocus;
    end
  else
    showmessage('Seleccione una cuenta para modificar');
end;

end.
