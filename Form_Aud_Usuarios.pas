unit Form_Aud_Usuarios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Unidad_Aud_Usuarios, Unidad_Usuarios, Printers, OleServer,
  ExcelXP, ComObj;

type
  TFAudUsuarios = class(TForm)
    ListadoAudUsuarios: TStringGrid;
    BSalirAudProvincias: TButton;
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
    procedure BSalirAudProvinciasClick(Sender: TObject);
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
  FAudUsuarios: TFAudUsuarios;
  Aud_Usuarios: Modelo_Aud_Usuario;    
  Usuarios: Modelo_Usuario;
  pos_Aud_Usuario: Tipo_Posicion;

implementation

uses Form_Ingreso, Form_Listados_Auditorias;

{$R *.dfm}

procedure TFAudUsuarios.FormActivate(Sender: TObject);
var
  Registro: Registro_Aud_Usuario_Nuevo;
  Reg_Usuario: Registro_Usuario;  
  Pos_Usuario: Tipo_Posicion;
begin
  Aud_Usuarios:= Modelo_Aud_Usuario.Create(FIngreso.c_Ruta,'Auditoria_Usuarios');
  Aud_Usuarios.Abrir;
  Usuarios:= Modelo_Usuario.Create(FIngreso.c_Ruta,'Usuarios');
  Usuarios.Abrir;
  ListadoAudUsuarios.RowCount:= 1;
  ListadoAudUsuarios.ColCount:= 8;
  ListadoAudUsuarios.Cells[0,0]:= 'Oper';
  ListadoAudUsuarios.Cells[1,0]:= 'Usuario';
  ListadoAudUsuarios.Cells[2,0]:= 'Contrasena';
  ListadoAudUsuarios.Cells[3,0]:= 'Perfil';
  ListadoAudUsuarios.Cells[4,0]:= 'Nick';
  ListadoAudUsuarios.Cells[5,0]:= 'Terminal';
  ListadoAudUsuarios.Cells[6,0]:= 'Fecha';
  ListadoAudUsuarios.Cells[7,0]:= 'Hora';
  ListadoAudUsuarios.ColWidths[0]:= 40;
  ListadoAudUsuarios.ColWidths[1]:= 210;
  ListadoAudUsuarios.ColWidths[2]:= 210;
  ListadoAudUsuarios.ColWidths[3]:= 40;
  ListadoAudUsuarios.ColWidths[4]:= 40;
  ListadoAudUsuarios.ColWidths[5]:= 100;
  ListadoAudUsuarios.ColWidths[6]:= 80;
  ListadoAudUsuarios.ColWidths[7]:= 80;
  Case CBOrdenar.ItemIndex of
    0:begin
        pos_Aud_Usuario:= pred(Aud_Usuarios.Ultimo);
        while pos_Aud_Usuario > Aud_Usuarios.Pos_Nula do
          begin
            Aud_Usuarios.Capturar(Registro,pos_Aud_Usuario);
            if Registro.Borrado = false then
            begin
              ListadoAudUsuarios.RowCount:= ListadoAudUsuarios.RowCount + 1;
              ListadoAudUsuarios.Cells[0,ListadoAudUsuarios.RowCount-1]:= Registro.Tipo_Operacion;
              ListadoAudUsuarios.Cells[1,ListadoAudUsuarios.RowCount-1]:= Registro.Usuario.Nick;
              ListadoAudUsuarios.Cells[2,ListadoAudUsuarios.RowCount-1]:= Registro.Usuario.Contrasena;
              ListadoAudUsuarios.Cells[3,ListadoAudUsuarios.RowCount-1]:= inttostr(Registro.Usuario.Perfil);
              ListadoAudUsuarios.Cells[4,ListadoAudUsuarios.RowCount-1]:= inttostr(Registro.Nick);
              ListadoAudUsuarios.Cells[5,ListadoAudUsuarios.RowCount-1]:= Registro.Terminal;
              ListadoAudUsuarios.Cells[6,ListadoAudUsuarios.RowCount-1]:= Registro.Fecha;
              ListadoAudUsuarios.Cells[7,ListadoAudUsuarios.RowCount-1]:= Registro.Hora;
            end;
            pos_Aud_Usuario:= pred(pos_Aud_Usuario);
          end;
      end;
    1:begin
        for pos_Usuario:= Usuarios.Primero to pred(Usuarios.Ultimo) do
          begin
            Usuarios.Capturar(Reg_Usuario,pos_Usuario);
            pos_Aud_Usuario:= pred(Aud_Usuarios.Ultimo);
            while (pos_Aud_Usuario >= Aud_Usuarios.Primero) do
              begin
                Aud_Usuarios.Capturar(Registro,pos_Aud_Usuario);
                if pos_Usuario = Registro.Usuario.id then
                  begin
                    ListadoAudUsuarios.RowCount:= ListadoAudUsuarios.RowCount + 1;
                    ListadoAudUsuarios.Cells[0,ListadoAudUsuarios.RowCount-1]:= Registro.Tipo_Operacion;
                    ListadoAudUsuarios.Cells[1,ListadoAudUsuarios.RowCount-1]:= Registro.Usuario.Nick;
                    ListadoAudUsuarios.Cells[2,ListadoAudUsuarios.RowCount-1]:= Registro.Usuario.Contrasena;
                    ListadoAudUsuarios.Cells[3,ListadoAudUsuarios.RowCount-1]:= inttostr(Registro.Usuario.Perfil);
                    ListadoAudUsuarios.Cells[4,ListadoAudUsuarios.RowCount-1]:= inttostr(Registro.Nick);
                    ListadoAudUsuarios.Cells[5,ListadoAudUsuarios.RowCount-1]:= Registro.Terminal;
                    ListadoAudUsuarios.Cells[6,ListadoAudUsuarios.RowCount-1]:= Registro.Fecha;
                    ListadoAudUsuarios.Cells[7,ListadoAudUsuarios.RowCount-1]:= Registro.Hora;
                  end;
                  pos_Aud_Usuario:= pred(pos_Aud_Usuario);
              end;
          end;
      end;
  end;
end;

procedure TFAudUsuarios.BSalirAudProvinciasClick(Sender: TObject);
begin
  Close;
  FListAuditorias.Visible:= true;
end;

procedure TFAudUsuarios.BImpresoraClick(Sender: TObject);
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
  Printer.Canvas.TextOut(1800,700,'Auditoria Usuarios');
  Printer.Canvas.Font.Size:= 10;
  j:= 1100;
  for i:= Aud_Usuarios.Primero to Aud_Usuarios.Ultimo do
    begin
      Printer.Canvas.TextOut(200,j,ListadoAudUsuarios.Cells[0,i]);
      Printer.Canvas.TextOut(500,j,ListadoAudUsuarios.Cells[1,i]);
      Printer.Canvas.TextOut(1500,j,ListadoAudUsuarios.Cells[2,i]);
      Printer.Canvas.TextOut(2700,j,ListadoAudUsuarios.Cells[3,i]);
      Printer.Canvas.TextOut(3000,j,ListadoAudUsuarios.Cells[4,i]);
      Printer.Canvas.TextOut(3300,j,ListadoAudUsuarios.Cells[5,i]);
      Printer.Canvas.TextOut(3900,j,ListadoAudUsuarios.Cells[6,i]);
      Printer.Canvas.TextOut(4500,j,ListadoAudUsuarios.Cells[7,i]);
      j:= j + 150;
    end;
  finally CloseFile(t); end
  end;
end;

procedure TFAudUsuarios.BExcelClick(Sender: TObject);
begin
  FAudUsuarios.ExportarExcel(Sender);
end;

Procedure TFAudUsuarios.ExportarExcel(Sender: TObject);
var
 Excel: Variant ;
 Fila: integer;
 pos: Tipo_Posicion;
begin
  Excel:= CreateOleObject('Excel.Application');
  Excel.WorkBooks.Add;

  Excel.Caption:= UpperCase(FIngreso.nombre_Empresa) + ' - Auditoría Usuarios';
  Excel.Visible:= True;

  // Se genera la hoja EXCEL con el nombre
  Excel.Sheets.Add;
  Excel.ActiveSheet.Name:= 'Auditoría Usuarios';

  // Titulares para la planilla
  Fila:= 1;
  Excel.Cells[Fila,1].Value:= 'Operación';
  Excel.Cells[Fila,2].Value:= 'Usuario';
  Excel.Cells[Fila,3].Value:= 'Contraseña';
  Excel.Cells[Fila,4].Value:= 'Perfil';
  Excel.Cells[Fila,5].Value:= 'Nick';
  Excel.Cells[Fila,6].Value:= 'Terminal';
  Excel.Cells[Fila,7].Value:= 'Fecha';
  Excel.Cells[Fila,8].Value:= 'Hora';

  for pos:= Aud_Usuarios.Primero to Aud_Usuarios.Ultimo do
    begin
      Fila:= succ(Fila);
      Excel.Cells[Fila,1]:= ListadoAudUsuarios.Cells[0,Fila-1];
      Excel.Cells[Fila,2]:= ListadoAudUsuarios.Cells[1,Fila-1];
      Excel.Cells[Fila,3]:= ListadoAudUsuarios.Cells[2,Fila-1];
      Excel.Cells[Fila,4]:= ListadoAudUsuarios.Cells[3,Fila-1];
      Excel.Cells[Fila,5]:= ListadoAudUsuarios.Cells[4,Fila-1];
      Excel.Cells[Fila,6]:= ListadoAudUsuarios.Cells[5,Fila-1];
      Excel.Cells[Fila,7]:= ListadoAudUsuarios.Cells[6,Fila-1];
      Excel.Cells[Fila,8]:= ListadoAudUsuarios.Cells[7,Fila-1];
    end;
end;

procedure TFAudUsuarios.CBOrdenarChange(Sender: TObject);
begin
  FAudUsuarios.FormActivate(Sender);
end;

end.
