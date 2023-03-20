unit Form_Aud_Provincias;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Unidad_Aud_Provincias, Unidad_Provincias, Printers, OleServer,
  ExcelXP, ComObj;

type
  TFAudProvincias = class(TForm)
    ListadoAudProvincias: TStringGrid;
    BSalirAudUsuarios: TButton;
    Label7: TLabel;
    UsuarioRegistrado: TLabel;
    BImpresora: TButton;
    PrintDialog1: TPrintDialog;
    BExcel: TButton;
    Label1: TLabel;
    CBOrdenar: TComboBox;
    Label8: TLabel;
    NombreEmpresa: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure BSalirAudUsuariosClick(Sender: TObject);
    procedure BImpresoraClick(Sender: TObject);    
    procedure BExcelClick(Sender: TObject);
    procedure ExportarExcel(Sender: TObject);
    procedure CBOrdenarChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FAudProvincias: TFAudProvincias;
  Aud_Provincias: Modelo_Aud_Provincia; 
  Provincias: Modelo_Provincia;
  pos_Aud_Provincia: Tipo_Posicion;

implementation

uses Form_Ingreso, Form_Listados_Auditorias;

{$R *.dfm}


procedure TFAudProvincias.FormActivate(Sender: TObject);
var
  Registro: Registro_Aud_Provincia_Nuevo;
  Reg_Provincia: Registro_Provincia;
  pos_Provincia: Tipo_Posicion;
begin
  Aud_Provincias:= Modelo_Aud_Provincia.Create(FIngreso.c_Ruta,'Auditoria_Provincias');
  Aud_Provincias.Abrir;
  Provincias:= Modelo_Provincia.Create(FIngreso.c_Ruta,'Provincias');
  Provincias.Abrir;
  ListadoAudProvincias.RowCount:= 1;
  ListadoAudProvincias.ColCount:= 7;
  ListadoAudProvincias.Cells[0,0]:= 'Oper';
  ListadoAudProvincias.Cells[1,0]:= 'Clave';
  ListadoAudProvincias.Cells[2,0]:= 'Descripcion';
  ListadoAudProvincias.Cells[3,0]:= 'Nick';
  ListadoAudProvincias.Cells[4,0]:= 'Terminal';
  ListadoAudProvincias.Cells[5,0]:= 'Fecha';
  ListadoAudProvincias.Cells[6,0]:= 'Hora';
  ListadoAudProvincias.ColWidths[0]:= 40;
  ListadoAudProvincias.ColWidths[1]:= 50;
  ListadoAudProvincias.ColWidths[2]:= 370;
  ListadoAudProvincias.ColWidths[3]:= 40;
  ListadoAudProvincias.ColWidths[4]:= 110;
  ListadoAudProvincias.ColWidths[5]:= 90;
  ListadoAudProvincias.ColWidths[6]:= 90;
  Case CBOrdenar.ItemIndex of
    0:begin
        pos_Aud_Provincia:= pred(Aud_Provincias.Ultimo);
        while pos_Aud_Provincia > Aud_Provincias.Pos_Nula do
          begin
            Aud_Provincias.Capturar(Registro,pos_Aud_Provincia);
            if Registro.Borrado = false then
              begin
                ListadoAudProvincias.RowCount:= ListadoAudProvincias.RowCount + 1;
                ListadoAudProvincias.Cells[0,ListadoAudProvincias.RowCount-1]:= Registro.Tipo_Operacion;
                ListadoAudProvincias.Cells[1,ListadoAudProvincias.RowCount-1]:= Registro.Provincia.Clave;
                ListadoAudProvincias.Cells[2,ListadoAudProvincias.RowCount-1]:= Registro.Provincia.Descripcion;
                ListadoAudProvincias.Cells[3,ListadoAudProvincias.RowCount-1]:= inttostr(Registro.Nick);
                ListadoAudProvincias.Cells[4,ListadoAudProvincias.RowCount-1]:= Registro.Terminal;
                ListadoAudProvincias.Cells[5,ListadoAudProvincias.RowCount-1]:= Registro.Fecha;
                ListadoAudProvincias.Cells[6,ListadoAudProvincias.RowCount-1]:= Registro.Hora;
              end;
            pos_Aud_Provincia:= pred(pos_Aud_Provincia);
          end;
      end;
    1:begin
        for pos_Provincia:= Provincias.Primero to pred(Provincias.Ultimo) do
          begin
            Provincias.Capturar(Reg_Provincia,pos_Provincia);
            pos_Aud_Provincia:= pred(Aud_Provincias.Ultimo);
            while (pos_Aud_Provincia >= Aud_Provincias.Primero) do
              begin
                Aud_Provincias.Capturar(Registro,pos_Aud_Provincia);
                if pos_Provincia = Registro.Provincia.id then
                  begin
                    ListadoAudProvincias.RowCount:= ListadoAudProvincias.RowCount + 1;
                    ListadoAudProvincias.Cells[0,ListadoAudProvincias.RowCount-1]:= Registro.Tipo_Operacion;
                    ListadoAudProvincias.Cells[1,ListadoAudProvincias.RowCount-1]:= Registro.Provincia.Clave;
                    ListadoAudProvincias.Cells[2,ListadoAudProvincias.RowCount-1]:= Registro.Provincia.Descripcion;
                    ListadoAudProvincias.Cells[3,ListadoAudProvincias.RowCount-1]:= inttostr(Registro.Nick);
                    ListadoAudProvincias.Cells[4,ListadoAudProvincias.RowCount-1]:= Registro.Terminal;
                    ListadoAudProvincias.Cells[5,ListadoAudProvincias.RowCount-1]:= Registro.Fecha;
                    ListadoAudProvincias.Cells[6,ListadoAudProvincias.RowCount-1]:= Registro.Hora;
                  end;
                  pos_Aud_Provincia:= pred(pos_Aud_Provincia);
              end;
          end;
      end;
  end;
end;

procedure TFAudProvincias.BSalirAudUsuariosClick(Sender: TObject);
begin
  Close;
  FListAuditorias.Visible:= true;
end;

procedure TFAudProvincias.BImpresoraClick(Sender: TObject);
var
  t: textfile;
  i: Tipo_Posicion;
  j: integer;
begin
  if PrintDialog1.Execute then
  begin
  AssignPrn(t);
  rewrite(t);
  try Printer.Canvas.Font.Name:= 'Montserrat SemiBold';
  Printer.Canvas.Font.Size:= 40;
  Printer.Canvas.TextOut(300,150,uppercase(FIngreso.nombre_Empresa));
  Printer.Canvas.Font.Size:= 8;
  Printer.Canvas.TextOut(3500,6250,'Fecha de impresión: '+DateTimeToStr(now));
  Printer.Canvas.Font.Size:= 18;
  Printer.Canvas.TextOut(1800,700,'Auditoria Provincias');
  Printer.Canvas.Font.Size:= 10;
  j:= 1100;
  for i:= Aud_Provincias.Primero to Aud_Provincias.Ultimo do
    begin
      Printer.Canvas.TextOut(200,j,ListadoAudProvincias.Cells[0,i]);
      Printer.Canvas.TextOut(450,j,ListadoAudProvincias.Cells[1,i]);
      Printer.Canvas.TextOut(900,j,ListadoAudProvincias.Cells[2,i]);
      Printer.Canvas.TextOut(2600,j,ListadoAudProvincias.Cells[3,i]);
      Printer.Canvas.TextOut(3000,j,ListadoAudProvincias.Cells[4,i]);
      Printer.Canvas.TextOut(3700,j,ListadoAudProvincias.Cells[5,i]);
      Printer.Canvas.TextOut(4300,j,ListadoAudProvincias.Cells[6,i]);
      j:= j + 150;
    end;
  finally CloseFile(t); end
  end;
end;

procedure TFAudProvincias.BExcelClick(Sender: TObject);
begin
  FAudProvincias.ExportarExcel(Sender);
end;

Procedure TFAudProvincias.ExportarExcel(Sender: TObject);
var
 Excel: Variant ;
 Fila: integer;
 pos: Tipo_Posicion;
begin
  Excel:= CreateOleObject('Excel.Application');
  Excel.WorkBooks.Add;

  Excel.Caption:= UpperCase(FIngreso.nombre_Empresa) + ' - Auditoría Provincias';
  Excel.Visible:= True;

  // Se genera la hoja EXCEL con el nombre
  Excel.Sheets.Add;
  Excel.ActiveSheet.Name:= 'Auditoría Provincias';

  // Titulares para la planilla
  Fila:= 1;
  Excel.Cells[Fila,1].Value:= 'Operación';
  Excel.Cells[Fila,2].Value:= 'Clave';
  Excel.Cells[Fila,3].Value:= 'Descripcion';
  Excel.Cells[Fila,4].Value:= 'Nick';
  Excel.Cells[Fila,5].Value:= 'Terminal';
  Excel.Cells[Fila,6].Value:= 'Fecha';
  Excel.Cells[Fila,7].Value:= 'Hora';

  for pos:= Aud_Provincias.Primero to Aud_Provincias.Ultimo do
    begin
      Fila:= succ(Fila);
      Excel.Cells[Fila,1]:= ListadoAudProvincias.Cells[0,Fila-1];
      Excel.Cells[Fila,2]:= ListadoAudProvincias.Cells[1,Fila-1];
      Excel.Cells[Fila,3]:= ListadoAudProvincias.Cells[2,Fila-1];
      Excel.Cells[Fila,4]:= ListadoAudProvincias.Cells[3,Fila-1];
      Excel.Cells[Fila,5]:= ListadoAudProvincias.Cells[4,Fila-1];
      Excel.Cells[Fila,6]:= ListadoAudProvincias.Cells[5,Fila-1];
      Excel.Cells[Fila,7]:= ListadoAudProvincias.Cells[6,Fila-1];
    end;
end;

procedure TFAudProvincias.CBOrdenarChange(Sender: TObject);
begin
  FAudProvincias.FormActivate(Sender);
end;

end.
