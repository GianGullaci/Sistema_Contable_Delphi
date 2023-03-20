unit Form_Aud_Clientes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Unidad_Aud_Clientes, Unidad_Clientes, StdCtrls, Grids, Printers, OleServer,
  ExcelXP, ComObj;

type
  TFAudClientes = class(TForm)
    ListadoAudClientes: TStringGrid;
    BSalirAudClientes: TButton;
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
    procedure BSalirAudClientesClick(Sender: TObject);
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
  FAudClientes: TFAudClientes;
  Aud_Clientes: Modelo_Aud_Cliente; 
  Clientes: Modelo_Cliente;
  pos_Aud_Cliente: Tipo_Posicion;

implementation

uses Form_Ingreso, Form_Listados_Auditorias;

{$R *.dfm}


procedure TFAudClientes.FormActivate(Sender: TObject);
var
  Registro: Registro_Aud_Cliente_Nuevo;
  Reg_Cliente: Registro_Cliente;   
  pos_Cliente: Tipo_Posicion;
begin
  Aud_Clientes:= Modelo_Aud_Cliente.Create(FIngreso.c_Ruta,'Auditoria_Clientes');
  Aud_Clientes.Abrir;
  Clientes:= Modelo_Cliente.Create(FIngreso.c_Ruta,'Clientes');
  Clientes.Abrir;
  ListadoAudClientes.RowCount:= 1;
  ListadoAudClientes.ColCount:= 9;
  ListadoAudClientes.Cells[0,0]:= 'Oper';
  ListadoAudClientes.Cells[1,0]:= 'DNI';
  ListadoAudClientes.Cells[2,0]:= 'Apellido';
  ListadoAudClientes.Cells[3,0]:= 'Nombre';
  ListadoAudClientes.Cells[4,0]:= 'Prov';
  ListadoAudClientes.Cells[5,0]:= 'Nick';
  ListadoAudClientes.Cells[6,0]:= 'Terminal';
  ListadoAudClientes.Cells[7,0]:= 'Fecha';
  ListadoAudClientes.Cells[8,0]:= 'Hora';
  ListadoAudClientes.ColWidths[0]:= 40;
  ListadoAudClientes.ColWidths[1]:= 90;
  ListadoAudClientes.ColWidths[2]:= 190;
  ListadoAudClientes.ColWidths[3]:= 190;
  ListadoAudClientes.ColWidths[4]:= 40;
  ListadoAudClientes.ColWidths[5]:= 40;
  ListadoAudClientes.ColWidths[6]:= 100;
  ListadoAudClientes.ColWidths[7]:= 80;
  ListadoAudClientes.ColWidths[8]:= 80;
  Case CBOrdenar.ItemIndex of
    0:begin
        pos_Aud_Cliente:= pred(Aud_Clientes.Ultimo);
        while pos_Aud_Cliente > Aud_Clientes.Pos_Nula do
          begin
            Aud_Clientes.Capturar(Registro,pos_Aud_Cliente);
            if Registro.Borrado = false then
              begin
                ListadoAudClientes.RowCount:= ListadoAudClientes.RowCount + 1;
                ListadoAudClientes.Cells[0,ListadoAudClientes.RowCount-1]:= Registro.Tipo_Operacion;
                ListadoAudClientes.Cells[1,ListadoAudClientes.RowCount-1]:= Registro.Cliente.DNI;
                ListadoAudClientes.Cells[2,ListadoAudClientes.RowCount-1]:= Registro.Cliente.Apellido;
                ListadoAudClientes.Cells[3,ListadoAudClientes.RowCount-1]:= Registro.Cliente.Nombre;
                ListadoAudClientes.Cells[4,ListadoAudClientes.RowCount-1]:= inttostr(Registro.Cliente.id_Provincia);
                ListadoAudClientes.Cells[5,ListadoAudClientes.RowCount-1]:= inttostr(Registro.Nick);
                ListadoAudClientes.Cells[6,ListadoAudClientes.RowCount-1]:= Registro.Terminal;
                ListadoAudClientes.Cells[7,ListadoAudClientes.RowCount-1]:= Registro.Fecha;
                ListadoAudClientes.Cells[8,ListadoAudClientes.RowCount-1]:= Registro.Hora;
              end;
              pos_Aud_Cliente:= pred(pos_Aud_Cliente);
          end;
      end;
    1:begin
        for pos_Cliente:= Clientes.Primero to pred(Clientes.Ultimo) do
          begin
            Clientes.Capturar(Reg_Cliente,pos_Cliente);
            pos_Aud_Cliente:= pred(Aud_Clientes.Ultimo);
            while (pos_Aud_Cliente >= Aud_Clientes.Primero) do
              begin
                Aud_Clientes.Capturar(Registro,pos_Aud_Cliente);
                if pos_Cliente = Registro.Cliente.id then
                  begin
                    ListadoAudClientes.RowCount:= ListadoAudClientes.RowCount + 1;
                    ListadoAudClientes.Cells[0,ListadoAudClientes.RowCount-1]:= Registro.Tipo_Operacion;
                    ListadoAudClientes.Cells[1,ListadoAudClientes.RowCount-1]:= Registro.Cliente.DNI;
                    ListadoAudClientes.Cells[2,ListadoAudClientes.RowCount-1]:= Registro.Cliente.Apellido;
                    ListadoAudClientes.Cells[3,ListadoAudClientes.RowCount-1]:= Registro.Cliente.Nombre;
                    ListadoAudClientes.Cells[4,ListadoAudClientes.RowCount-1]:= inttostr(Registro.Cliente.id_Provincia);
                    ListadoAudClientes.Cells[5,ListadoAudClientes.RowCount-1]:= inttostr(Registro.Nick);
                    ListadoAudClientes.Cells[6,ListadoAudClientes.RowCount-1]:= Registro.Terminal;
                    ListadoAudClientes.Cells[7,ListadoAudClientes.RowCount-1]:= Registro.Fecha;
                    ListadoAudClientes.Cells[8,ListadoAudClientes.RowCount-1]:= Registro.Hora;
                  end;
                  pos_Aud_Cliente:= pred(pos_Aud_Cliente);
              end;
          end;
      end;
  end;
end;

procedure TFAudClientes.BSalirAudClientesClick(Sender: TObject);
begin
  Close;
  FListAuditorias.Visible:= true;
end;



procedure TFAudClientes.BImpresoraClick(Sender: TObject);
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
  Printer.Canvas.Font.Size:= 28;
  Printer.Canvas.TextOut(1800,700,'Auditoria Clientes');
  Printer.Canvas.Font.Size:= 10;
  j:= 1100;
  for i:= Aud_Clientes.Primero to Aud_Clientes.Ultimo do
    begin
      Printer.Canvas.TextOut(200,j,ListadoAudClientes.Cells[0,i]);
      Printer.Canvas.TextOut(450,j,ListadoAudClientes.Cells[1,i]);
      Printer.Canvas.TextOut(1000,j,ListadoAudClientes.Cells[2,i]);
      Printer.Canvas.TextOut(2000,j,ListadoAudClientes.Cells[3,i]);
      Printer.Canvas.TextOut(3000,j,ListadoAudClientes.Cells[4,i]);
      Printer.Canvas.TextOut(3250,j,ListadoAudClientes.Cells[5,i]);
      Printer.Canvas.TextOut(3500,j,ListadoAudClientes.Cells[6,i]);
      Printer.Canvas.TextOut(4100,j,ListadoAudClientes.Cells[7,i]);
      Printer.Canvas.TextOut(4550,j,ListadoAudClientes.Cells[8,i]);
      j:= j + 150;
    end;
  finally CloseFile(t); end
  end;
end;

procedure TFAudClientes.BExcelClick(Sender: TObject);
begin
  FAudClientes.ExportarExcel(Sender);
end;

Procedure TFAudClientes.ExportarExcel(Sender: TObject);
var
 Excel: Variant ;
 Fila: integer;
 pos: Tipo_Posicion;
begin
  Excel:= CreateOleObject('Excel.Application');
  Excel.WorkBooks.Add;

  Excel.Caption:= UpperCase(FIngreso.nombre_Empresa) + ' - Auditoría Clientes';
  Excel.Visible:= True;

  // Se genera la hoja EXCEL con el nombre
  Excel.Sheets.Add;
  Excel.ActiveSheet.Name:= 'Auditoría Clientes';

  // Titulares para la planilla
  Fila:= 1;
  Excel.Cells[Fila,1].Value:= 'Operación';
  Excel.Cells[Fila,2].Value:= 'DNI';
  Excel.Cells[Fila,3].Value:= 'Apellido';
  Excel.Cells[Fila,4].Value:= 'Nombre';
  Excel.Cells[Fila,5].Value:= 'Provincia';
  Excel.Cells[Fila,6].Value:= 'Nick';
  Excel.Cells[Fila,7].Value:= 'Terminal';
  Excel.Cells[Fila,8].Value:= 'Fecha';
  Excel.Cells[Fila,9].Value:= 'Hora';

  for pos:= Aud_Clientes.Primero to Aud_Clientes.Ultimo do
    begin
      Fila:= succ(Fila);
      Excel.Cells[Fila,1]:= ListadoAudClientes.Cells[0,fila-1];
      Excel.Cells[Fila,2]:= ListadoAudClientes.Cells[1,fila-1];
      Excel.Cells[Fila,3]:= ListadoAudClientes.Cells[2,fila-1];
      Excel.Cells[Fila,4]:= ListadoAudClientes.Cells[3,fila-1];
      Excel.Cells[Fila,5]:= ListadoAudClientes.Cells[4,fila-1];
      Excel.Cells[Fila,6]:= ListadoAudClientes.Cells[5,fila-1];
      Excel.Cells[Fila,7]:= ListadoAudClientes.Cells[6,fila-1];
      Excel.Cells[Fila,8]:= ListadoAudClientes.Cells[7,fila-1];
      Excel.Cells[Fila,9]:= ListadoAudClientes.Cells[8,fila-1];
    end;
end;

procedure TFAudClientes.CBOrdenarChange(Sender: TObject);
begin
  FAudClientes.FormActivate(Sender);
end;

end.
