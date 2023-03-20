unit Form_TipoDocumento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Sistema_ABM, Unidad_Documentos;

type
  TFTiposDocumento = class(TForm)
    Label4: TLabel;
    Label7: TLabel;
    UsuarioRegistrado: TLabel;
    Label8: TLabel;
    NombreEmpresa: TLabel;
    BSalir: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    EClave: TEdit;
    EDescripcion: TEdit;
    BGuardar: TButton;
    ListadoDocumentos: TStringGrid;
    procedure BSalirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BGuardarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FTiposDocumento: TFTiposDocumento;
  Documentos: Modelo_Documento;
  pos: Tipo_Posicion;

implementation

uses Form_Ingreso;

{$R *.dfm}

procedure TFTiposDocumento.BSalirClick(Sender: TObject);
begin
  Close;
  FPrincipal.Visible:= true;
end;

procedure TFTiposDocumento.FormActivate(Sender: TObject);
var
  Registro: Registro_Documento;
begin
  Documentos:= Modelo_Documento.Create(FIngreso.c_Ruta,'Documentos');
  Documentos.Abrir;
  EClave.Text:= '';
  EDescripcion.Text:= '';
  ListadoDocumentos.RowCount:= 1;
  ListadoDocumentos.ColCount:= 2;
  ListadoDocumentos.Cells[0,0]:= 'Clave';
  ListadoDocumentos.Cells[1,0]:= 'Descripcion';
  ListadoDocumentos.ColWidths[1]:= 260;
  pos:= 0;
  while pos < Documentos.Ultimo do
    begin
      Documentos.Capturar(Registro,pos);
      if Registro.Borrado = false then
       begin
        ListadoDocumentos.RowCount:= ListadoDocumentos.RowCount + 1;
        ListadoDocumentos.Cells[0,ListadoDocumentos.RowCount-1]:= Registro.Clave;
        ListadoDocumentos.Cells[1,ListadoDocumentos.RowCount-1]:= Registro.Descripcion;
       end;
      pos:= succ(pos);
    end;
end;

procedure TFTiposDocumento.BGuardarClick(Sender: TObject);
var
  Registro: Registro_Documento;
begin
  Registro.Clave:= EClave.Text;
  Registro.Descripcion:= EDescripcion.Text;
  if ((EClave.Text <> '') and (EDescripcion.Text <> '') and (strtoint(EClave.Text)>=0) and (strtoint(EClave.Text)<100)) then
    begin
      if Documentos.Buscar(Registro.Clave,pos,true) = false then
        begin
          Documentos.Insertar(Registro,pos);
          pos:= 0;
          EClave.Clear;
          EClave.SetFocus;
          EDescripcion.Clear;
          ListadoDocumentos.RowCount:= 1;
          while pos < Documentos.Ultimo do
            begin
              Documentos.Capturar(Registro,pos);
              if Registro.Borrado = false then
               begin
                ListadoDocumentos.RowCount:= ListadoDocumentos.RowCount + 1;
                ListadoDocumentos.Cells[0,ListadoDocumentos.RowCount-1]:= Registro.Clave;
                ListadoDocumentos.Cells[1,ListadoDocumentos.RowCount-1]:= Registro.Descripcion;
               end;
              pos:= succ(pos);
            end;
        end
      else
        begin
          showmessage('La clave ya existe');
          EClave.Clear;
          EClave.SetFocus;
        end;
    end
  else
    begin
      if ((EClave.Text = '') or (strtoint(EClave.Text)<0) or (strtoint(EClave.Text)>99)) then
        begin
          showmessage('Ingrese una clave valida');
          EClave.Clear;
          EClave.SetFocus;
        end
      else
        if EDescripcion.Text = '' then
          begin
            showmessage('Ingrese el nombre del tipo de documento');
            EDescripcion.Clear;
            EDescripcion.SetFocus;
          end;
    end;
end;

end.
