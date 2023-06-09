unit Form_Aud_Perfiles;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Unidad_Aud_Perfiles, Unidad_Perfiles, Grids, StdCtrls, Printers, OleServer,
  ExcelXP, ComObj;

type
  TFAudPerfiles = class(TForm)
    ListadoAudPerfiles: TStringGrid;
    BSalirAudPerfiles: TButton;
    Label7: TLabel;
    UsuarioRegistrado: TLabel;
    PrintDialog1: TPrintDialog;
    BExcel: TButton;
    BImpresora: TButton;
    Label1: TLabel;
    CBOrdenar: TComboBox;
    Label8: TLabel;
    NombreEmpresa: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure BSalirAudPerfilesClick(Sender: TObject);
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
  FAudPerfiles: TFAudPerfiles;
  Aud_Perfiles: Modelo_Aud_Perfil;     
  Perfiles: Modelo_Perfil;
  pos_Aud_Perfil: Tipo_Posicion;

implementation

uses Form_Ingreso, Sistema_ABM, Form_Listados_Auditorias;

{$R *.dfm}


procedure TFAudPerfiles.FormActivate(Sender: TObject);
var
  Registro: Registro_Aud_Perfil_Nuevo;
  Reg_Perfil: Registro_Perfil;
  pos_Perfil: Tipo_Posicion;
  chek: string[1];
begin
  Aud_Perfiles:= Modelo_Aud_Perfil.Create(FIngreso.c_Ruta,'Auditoria_Perfiles');
  Aud_Perfiles.Abrir;
  Perfiles:= Modelo_Perfil.Create(FIngreso.c_Ruta,'Perfiles');
  Perfiles.Abrir;
  ListadoAudPerfiles.RowCount:= 1;
  ListadoAudPerfiles.ColCount:= 13;
  ListadoAudPerfiles.Cells[0,0]:= 'Oper';
  ListadoAudPerfiles.Cells[1,0]:= 'Perfil';
  ListadoAudPerfiles.Cells[2,0]:= 'Cli';
  ListadoAudPerfiles.Cells[3,0]:= 'Prov';
  ListadoAudPerfiles.Cells[4,0]:= 'Aud';
  ListadoAudPerfiles.Cells[5,0]:= 'User';
  ListadoAudPerfiles.Cells[6,0]:= 'Perf';
  ListadoAudPerfiles.Cells[7,0]:= 'BU';
  ListadoAudPerfiles.Cells[8,0]:= 'Rest';
  ListadoAudPerfiles.Cells[9,0]:= 'Nick';
  ListadoAudPerfiles.Cells[10,0]:= 'Terminal';
  ListadoAudPerfiles.Cells[11,0]:= 'Fecha';
  ListadoAudPerfiles.Cells[12,0]:= 'Hora';
  ListadoAudPerfiles.ColWidths[0]:= 40;
  ListadoAudPerfiles.ColWidths[1]:= 200;
  ListadoAudPerfiles.ColWidths[2]:= 40;
  ListadoAudPerfiles.ColWidths[3]:= 40;
  ListadoAudPerfiles.ColWidths[4]:= 40;
  ListadoAudPerfiles.ColWidths[5]:= 40;
  ListadoAudPerfiles.ColWidths[6]:= 40;
  ListadoAudPerfiles.ColWidths[7]:= 40;
  ListadoAudPerfiles.ColWidths[8]:= 40;
  ListadoAudPerfiles.ColWidths[9]:= 40;
  ListadoAudPerfiles.ColWidths[10]:= 110;
  ListadoAudPerfiles.ColWidths[11]:= 95;
  ListadoAudPerfiles.ColWidths[12]:= 95;
  Case CBOrdenar.ItemIndex of
    0:begin
        pos_Aud_Perfil:= pred(Aud_Perfiles.Ultimo);
        while pos_Aud_Perfil > Aud_Perfiles.Pos_Nula do
          begin
            Aud_Perfiles.Capturar(Registro,pos_Aud_Perfil);
            if Registro.Borrado = false then
              begin
                ListadoAudPerfiles.RowCount:= ListadoAudPerfiles.RowCount + 1;
                ListadoAudPerfiles.Cells[0,ListadoAudPerfiles.RowCount-1]:= Registro.Tipo_Operacion;
                ListadoAudPerfiles.Cells[1,ListadoAudPerfiles.RowCount-1]:= Registro.Perfil.Nombre;
                if BoolToStr(Registro.Perfil.Hab_Clientes) = '-1' then
                  chek:= 'T'
                else
                  chek:= 'F';
                ListadoAudPerfiles.Cells[2,ListadoAudPerfiles.RowCount-1]:= chek;
                if BoolToStr(Registro.Perfil.Hab_Provincias) = '-1' then
                  chek:= 'T'
                else
                  chek:= 'F';
                ListadoAudPerfiles.Cells[3,ListadoAudPerfiles.RowCount-1]:= chek;
                if BoolToStr(Registro.Perfil.Hab_Auditoria) = '-1' then
                  chek:= 'T'
                else
                  chek:= 'F';
                ListadoAudPerfiles.Cells[4,ListadoAudPerfiles.RowCount-1]:= chek;
                if BoolToStr(Registro.Perfil.Hab_Usuarios) = '-1' then
                  chek:= 'T'
                else
                  chek:= 'F';
                ListadoAudPerfiles.Cells[5,ListadoAudPerfiles.RowCount-1]:= chek;
                if BoolToStr(Registro.Perfil.Hab_Perfiles) = '-1' then
                  chek:= 'T'
                else
                  chek:= 'F';
                ListadoAudPerfiles.Cells[6,ListadoAudPerfiles.RowCount-1]:= chek;
                if BoolToStr(Registro.Perfil.Hab_BackUp) = '-1' then
                  chek:= 'T'
                else
                  chek:= 'F';
                ListadoAudPerfiles.Cells[7,ListadoAudPerfiles.RowCount-1]:= chek;
                if BoolToStr(Registro.Perfil.Hab_Restore) = '-1' then
                  chek:= 'T'
                else
                  chek:= 'F';
                ListadoAudPerfiles.Cells[8,ListadoAudPerfiles.RowCount-1]:= chek;
                ListadoAudPerfiles.Cells[9,ListadoAudPerfiles.RowCount-1]:= inttostr(Registro.Nick);
                ListadoAudPerfiles.Cells[10,ListadoAudPerfiles.RowCount-1]:= Registro.Terminal;
                ListadoAudPerfiles.Cells[11,ListadoAudPerfiles.RowCount-1]:= Registro.Fecha;
                ListadoAudPerfiles.Cells[12,ListadoAudPerfiles.RowCount-1]:= Registro.Hora;
              end;
            pos_Aud_Perfil:= pred(pos_Aud_Perfil);
          end;
      end;
    1:begin
        for pos_Perfil:= Perfiles.Primero to pred(Perfiles.Ultimo) do
          begin
            Perfiles.Capturar(Reg_Perfil,pos_Perfil);
            pos_Aud_Perfil:= pred(Aud_Perfiles.Ultimo);
            while (pos_Aud_Perfil >= Aud_Perfiles.Primero) do
              begin
                Aud_Perfiles.Capturar(Registro,pos_Aud_Perfil);
                if pos_Perfil = Registro.Perfil.id then
                  begin
                    ListadoAudPerfiles.RowCount:= ListadoAudPerfiles.RowCount + 1;
                    ListadoAudPerfiles.Cells[0,ListadoAudPerfiles.RowCount-1]:= Registro.Tipo_Operacion;
                    ListadoAudPerfiles.Cells[1,ListadoAudPerfiles.RowCount-1]:= Registro.Perfil.Nombre;
                    if BoolToStr(Registro.Perfil.Hab_Clientes) = '-1' then
                      chek:= 'T'
                    else
                      chek:= 'F';
                    ListadoAudPerfiles.Cells[2,ListadoAudPerfiles.RowCount-1]:= chek;
                    if BoolToStr(Registro.Perfil.Hab_Provincias) = '-1' then
                      chek:= 'T'
                    else
                      chek:= 'F';
                    ListadoAudPerfiles.Cells[3,ListadoAudPerfiles.RowCount-1]:= chek;
                    if BoolToStr(Registro.Perfil.Hab_Auditoria) = '-1' then
                      chek:= 'T'
                    else
                      chek:= 'F';
                    ListadoAudPerfiles.Cells[4,ListadoAudPerfiles.RowCount-1]:= chek;
                    if BoolToStr(Registro.Perfil.Hab_Usuarios) = '-1' then
                      chek:= 'T'
                    else
                      chek:= 'F';
                    ListadoAudPerfiles.Cells[5,ListadoAudPerfiles.RowCount-1]:= chek;
                    if BoolToStr(Registro.Perfil.Hab_Perfiles) = '-1' then
                      chek:= 'T'
                    else
                      chek:= 'F';
                    ListadoAudPerfiles.Cells[6,ListadoAudPerfiles.RowCount-1]:= chek;
                    if BoolToStr(Registro.Perfil.Hab_BackUp) = '-1' then
                      chek:= 'T'
                    else
                      chek:= 'F';
                    ListadoAudPerfiles.Cells[7,ListadoAudPerfiles.RowCount-1]:= chek;
                    if BoolToStr(Registro.Perfil.Hab_Restore) = '-1' then
                      chek:= 'T'
                    else
                      chek:= 'F';
                    ListadoAudPerfiles.Cells[8,ListadoAudPerfiles.RowCount-1]:= chek;
                    ListadoAudPerfiles.Cells[9,ListadoAudPerfiles.RowCount-1]:= inttostr(Registro.Nick);
                    ListadoAudPerfiles.Cells[10,ListadoAudPerfiles.RowCount-1]:= Registro.Terminal;
                    ListadoAudPerfiles.Cells[11,ListadoAudPerfiles.RowCount-1]:= Registro.Fecha;
                    ListadoAudPerfiles.Cells[12,ListadoAudPerfiles.RowCount-1]:= Registro.Hora;
                  end;
                  pos_Aud_Perfil:= pred(pos_Aud_Perfil);
              end;
          end;
      end;
  end;
end;

procedure TFAudPerfiles.BSalirAudPerfilesClick(Sender: TObject);
begin
  Close;
  FListAuditorias.Visible:= true;
end;

procedure TFAudPerfiles.BImpresoraClick(Sender: TObject);
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
  Printer.Canvas.TextOut(3500,6250,'Fecha de impresi�n: '+DateTimeToStr(now));
  Printer.Canvas.Font.Size:= 18;
  Printer.Canvas.TextOut(1800,700,'Auditoria Perfiles');
  Printer.Canvas.Font.Size:= 10;
  j:= 1100;
  for i:= Aud_Perfiles.Primero to Aud_Perfiles.Ultimo do
    begin
      Printer.Canvas.TextOut(200,j,ListadoAudPerfiles.Cells[0,i]);
      Printer.Canvas.TextOut(450,j,ListadoAudPerfiles.Cells[1,i]);
      Printer.Canvas.TextOut(1050,j,ListadoAudPerfiles.Cells[2,i]);
      Printer.Canvas.TextOut(1300,j,ListadoAudPerfiles.Cells[3,i]);
      Printer.Canvas.TextOut(1600,j,ListadoAudPerfiles.Cells[4,i]);
      Printer.Canvas.TextOut(1900,j,ListadoAudPerfiles.Cells[5,i]);
      Printer.Canvas.TextOut(2200,j,ListadoAudPerfiles.Cells[6,i]);
      Printer.Canvas.TextOut(2500,j,ListadoAudPerfiles.Cells[7,i]);
      Printer.Canvas.TextOut(2800,j,ListadoAudPerfiles.Cells[8,i]);
      Printer.Canvas.TextOut(3100,j,ListadoAudPerfiles.Cells[9,i]);
      Printer.Canvas.TextOut(3400,j,ListadoAudPerfiles.Cells[10,i]);
      Printer.Canvas.TextOut(4000,j,ListadoAudPerfiles.Cells[11,i]);
      Printer.Canvas.TextOut(4550,j,ListadoAudPerfiles.Cells[12,i]);
      j:= j + 150;
    end;
  finally CloseFile(t); end
  end;
end;

procedure TFAudPerfiles.BExcelClick(Sender: TObject);
begin
  FAudPerfiles.ExportarExcel(Sender);
end;

Procedure TFAudPerfiles.ExportarExcel(Sender: TObject);
var
 Excel: Variant ;
 Fila: integer;
 pos: Tipo_Posicion;
begin
  Excel:= CreateOleObject('Excel.Application');
  Excel.WorkBooks.Add;

  Excel.Caption:= UpperCase(FIngreso.nombre_Empresa) + ' - Auditor�a Perfiles';
  Excel.Visible:= True;

  // Se genera la hoja EXCEL con el nombre
  Excel.Sheets.Add;
  Excel.ActiveSheet.Name:= 'Auditor�a Perfiles';

  // Titulares para la planilla
  Fila:= 1;
  Excel.Cells[Fila,1].Value:= 'Operaci�n';
  Excel.Cells[Fila,2].Value:= 'Perfil';
  Excel.Cells[Fila,3].Value:= 'Cliente';
  Excel.Cells[Fila,4].Value:= 'Provincia';
  Excel.Cells[Fila,5].Value:= 'Auditor�a';
  Excel.Cells[Fila,6].Value:= 'Usuario';
  Excel.Cells[Fila,7].Value:= 'BackUp';
  Excel.Cells[Fila,8].Value:= 'Restore';
  Excel.Cells[Fila,9].Value:= 'Perfil';
  Excel.Cells[Fila,10].Value:= 'Nick';
  Excel.Cells[Fila,11].Value:= 'Terminal';
  Excel.Cells[Fila,12].Value:= 'Fecha';
  Excel.Cells[Fila,13].Value:= 'Hora';

  for pos:= Aud_Perfiles.Primero to Aud_Perfiles.Ultimo do
    begin
      Fila:= succ(Fila);
      Excel.Cells[Fila,1]:= ListadoAudPerfiles.Cells[0,Fila-1];
      Excel.Cells[Fila,2]:= ListadoAudPerfiles.Cells[1,Fila-1];
      Excel.Cells[Fila,3]:= ListadoAudPerfiles.Cells[2,Fila-1];
      Excel.Cells[Fila,4]:= ListadoAudPerfiles.Cells[3,Fila-1];
      Excel.Cells[Fila,5]:= ListadoAudPerfiles.Cells[4,Fila-1];
      Excel.Cells[Fila,6]:= ListadoAudPerfiles.Cells[5,Fila-1];
      Excel.Cells[Fila,7]:= ListadoAudPerfiles.Cells[6,Fila-1];
      Excel.Cells[Fila,8]:= ListadoAudPerfiles.Cells[7,Fila-1];
      Excel.Cells[Fila,9]:= ListadoAudPerfiles.Cells[8,Fila-1];
      Excel.Cells[Fila,10]:= ListadoAudPerfiles.Cells[9,Fila-1];
      Excel.Cells[Fila,11]:= ListadoAudPerfiles.Cells[10,Fila-1];
      Excel.Cells[Fila,12]:= ListadoAudPerfiles.Cells[11,Fila-1];
      Excel.Cells[Fila,13]:= ListadoAudPerfiles.Cells[12,Fila-1];
    end;
end;

procedure TFAudPerfiles.CBOrdenarChange(Sender: TObject);
begin
  FAudPerfiles.FormActivate(Sender);
end;

end.
