unit Sistema_ABM;

interface

uses
  Windows, Winsock, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Unidad_Clientes, Unidad_Provincias, Unidad_Modelo_BackUp, ShlObj, ActiveX, Masks, ShellApi, DateUtils,
  Menus, Unidad_Facturas, Unidad_Remitos, Unidad_Puntos_Venta,
  Unidad_Comprobantes, Unidad_Productos, Unidad_Impuestos,
  Unidad_Contribuyentes, Unidad_CondicionesComerciales;

type
  TFPrincipal = class(TForm)
    BSalir: TButton;
    Titulo_Empresa: TLabel;
    Label2: TLabel;
    UsuarioRegistrado: TLabel;
    OpenDialog1: TOpenDialog;
    MainMenu1: TMainMenu;
    Clientes1: TMenuItem;
    Provincias1: TMenuItem;
    Localidades1: TMenuItem;
    Auditorias1: TMenuItem;
    Respaldo1: TMenuItem;
    BackUp1: TMenuItem;
    Restore1: TMenuItem;
    GestinContable1: TMenuItem;
    PlandeCuentas1: TMenuItem;
    Asientos1: TMenuItem;
    ABMUsuarios1: TMenuItem;
    Usuarios1: TMenuItem;
    Perfiles1: TMenuItem;
    Label1: TLabel;
    MenAuxiliar1: TMenuItem;
    iposDocumento1: TMenuItem;
    TiposComprobante1: TMenuItem;
    CondicionesComerciales1: TMenuItem;
    iposImpuesto1: TMenuItem;
    iposContribuyente1: TMenuItem;
    PuntosVenta1: TMenuItem;
    Productos1: TMenuItem;
    Comprobante1: TMenuItem;
    NuevoComprobante1: TMenuItem;
    ConsultaComprobantes1: TMenuItem;
    procedure BSalirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function GetIPLocal: string;
    function SelectDirectory(Wnd: HWND; const Caption: string; var Directory: String): boolean;
    function CopiaTodo(Origen,Destino : String): LongInt;
    procedure FormActivate(Sender: TObject);
    procedure Clientes1Click(Sender: TObject);
    procedure Provincias1Click(Sender: TObject);
    procedure Auditorias1Click(Sender: TObject);
    procedure BackUp1Click(Sender: TObject);
    procedure Restore1Click(Sender: TObject);
    procedure PlandeCuentas1Click(Sender: TObject);
    procedure Asientos1Click(Sender: TObject);
    procedure Usuarios1Click(Sender: TObject);
    procedure Perfiles1Click(Sender: TObject);
    procedure Localidades1Click(Sender: TObject);
    procedure iposDocumento1Click(Sender: TObject);
    procedure TiposComprobante1Click(Sender: TObject);
    procedure iposContribuyente1Click(Sender: TObject);
    procedure iposImpuesto1Click(Sender: TObject);
    procedure PuntosVenta1Click(Sender: TObject);
    procedure CondicionesComerciales1Click(Sender: TObject);
    procedure Productos1Click(Sender: TObject);
    procedure NuevoComprobante1Click(Sender: TObject);
    procedure ConsultaComprobantes1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    IP: string;
    Direccion_BackUp: string;
    Direccion_Restore: string;
  end;

var
  FPrincipal: TFPrincipal;
  BackUp: Modelo_BackUp;

implementation

uses Form_Clientes, Form_Provincias, Form_Usuarios, Form_Perfiles,
  Form_Ingreso, Form_Aud_Perfiles, Form_Listados_Auditorias,
  Form_Plan_de_Cuentas, Form_Asientos, Form_Localidades,
  Form_TipoDocumento, Form_TipoComprobante, Form_TipoContribuyente,
  Form_TipoImpuesto, Form_Puntos_Venta, Form_CondicionesComerciales,
  Form_Productos, Form_Comprobantes, Form_Consulta_Comprobantes;

{$R *.dfm}


function TFPrincipal.CopiaTodo(Origen,Destino : String): LongInt;
var
  F : TShFileOpStruct;
  sOrigen, sDestino : String;
begin
    Result := 0;
    sOrigen := Origen + #0;
    sDestino := Destino + #0;
 
    with F do 
    begin 
      Wnd   := Application.Handle;
      wFunc := FO_COPY;
      pFrom := @sOrigen[1];
      pTo   := @sDestino[1];
      fFlags := FOF_ALLOWUNDO or FOF_NOCONFIRMATION
    end; 

    Result := ShFileOperation(F);
end;


function TFPrincipal.SelectDirectory(Wnd: HWND; const Caption: string; var Directory: String): boolean;
var
  BrowseInfo:  TBrowseInfo;
  ItemIDList:  PItemIDList;
  ShellMalloc: IMalloc;
  Buffer:      array [0..MAX_PATH] of CHAR;
begin
  ZeroMemory(@BrowseInfo, sizeof(BrowseInfo));
  if(SHGetMalloc(ShellMalloc) = S_OK) and (ShellMalloc <> nil) then
  begin
    BrowseInfo.hwndOwner:= Wnd;
    BrowseInfo.pidlRoot:= 0;
    BrowseInfo.pszDisplayName:= Buffer;
    BrowseInfo.lpszTitle:= PCHAR(Caption);
    BrowseInfo.ulFlags:= BIF_RETURNONLYFSDIRS;
    ItemIDList:= SHBrowseForFolder(BrowseInfo);
    if(ItemIDList <> nil) then
    begin
      SHGetPathFromIDList(ItemIDList, Buffer);
      ShellMalloc.Free(ItemIDList);
      Directory:= Buffer;
    end;
  end;
  Result:= ItemIDList <> nil;
end;

function TFPrincipal.GetIPLocal: string;
type
  TaPInAddr = array [0..10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  phe: PHostEnt;
  pptr: PaPInAddr;
  Buffer: array [0..63] of Ansichar;
  i: Integer;
  GInitData: TWSADATA;
begin
  WSAStartup($101, GInitData);
  Result := '';
  GetHostName(Buffer, SizeOf(Buffer));
  phe := GetHostByName(Buffer);
  if phe = nil then
    Exit;
  pptr := PaPInAddr(phe^.h_addr_list);
  i := 0;
  while pptr^[i] <> nil do
  begin
    Result := StrPas(inet_ntoa(pptr^[i]^));
    Inc(i);
  end;
  WSACleanup;
end;

procedure TFPrincipal.BSalirClick(Sender: TObject);
begin
  FIngreso.Show;
  FPrincipal.Visible:= False;
end;

procedure TFPrincipal.FormCreate(Sender: TObject);
begin
  IP:= GetIpLocal;
end;

procedure TFPrincipal.FormActivate(Sender: TObject);
begin
  Titulo_Empresa.Caption:= FIngreso.nombre_Empresa;
end;

procedure TFPrincipal.Clientes1Click(Sender: TObject);
begin
  FClientes.Show;
  FPrincipal.Visible:= False;
end;

procedure TFPrincipal.Provincias1Click(Sender: TObject);
begin
  FProvincias.Show;
  FPrincipal.Visible:= False;
end;

procedure TFPrincipal.Auditorias1Click(Sender: TObject);
begin
  FListAuditorias.Show;
  FPrincipal.Visible:= False;
end;

procedure TFPrincipal.BackUp1Click(Sender: TObject);
var
  fecha_BackUp: String;
  RC: Tipo_Reg_BackUp;
begin
  fecha_BackUp:= FormatDateTime ('YY-MM-DD',Date);
  if SelectDirectory(Handle, 'Seleccione Carpeta', Direccion_BackUp) then
    begin
      if messagedlg('�Estas seguro que desea hacer la copia de seguridad?',mtConfirmation,[mbYes, mbNo], 0) = mrYes then
        begin
          BackUp:= Modelo_BackUp.Create(Direccion_BackUp,fecha_BackUp+'_'+FIngreso.nombre_Empresa+'_BackUp');
          BackUp.Abrir;
          RC.Ruta_Archivos:= FIngreso.c_Ruta;
          RC.Ruta_BackUp:= FIngreso.c_Ruta+'_BackUp';
          RC.Nombre_Empresa:= FIngreso.nombre_Empresa;
          RC.Fecha:= fecha_BackUp;
          BackUp.Modificar(RC);
          BackUp.Capturar(RC);
          if not DirectoryExists(FIngreso.c_Ruta+'_BackUp') then
            ForceDirectories(FIngreso.c_Ruta+'_BackUp');
          CopiaTodo(FIngreso.c_Ruta+'\*.*',FIngreso.c_Ruta+'_BackUp');
          showmessage('BackUp realizado correctamente');
        end;
    end;
end;

procedure TFPrincipal.Restore1Click(Sender: TObject);
var
  Archivo_BackUp: File of Tipo_Reg_BackUp;
  RC: Tipo_Reg_BackUp;
begin
  OpenDialog1.Execute;
  Direccion_Restore:= OpenDialog1.FileName;
  if FileExists(Direccion_Restore) then
    begin
      AssignFile(Archivo_BackUp,Direccion_Restore);
      Reset(Archivo_BackUp);
      Seek(Archivo_BackUp,0);
      Read(Archivo_BackUp,RC);
      if RC.Nombre_Empresa = FIngreso.nombre_Empresa then
        begin
          if messagedlg('�Estas seguro que desea restaurar?',mtConfirmation,[mbYes, mbNo], 0) = mrYes then
            begin
              CopiaTodo(RC.Ruta_BackUp+'\*.*',RC.Ruta_Archivos);
              showmessage('Restauraci�n realizada correctamente');
            end;
        end
      else
        ShowMessage('El BackUp no corresponde a la empresa');
    end;
end;

procedure TFPrincipal.PlandeCuentas1Click(Sender: TObject);
begin
  FPlanCuentas.Show;
  FPrincipal.Visible:= False;
end;

procedure TFPrincipal.Asientos1Click(Sender: TObject);
begin
  FAsientos.Show;
  FPrincipal.Visible:= False;
end;

procedure TFPrincipal.Usuarios1Click(Sender: TObject);
begin
  FUsuarios.Show;
  FPrincipal.Visible:= False;
end;

procedure TFPrincipal.Perfiles1Click(Sender: TObject);
begin
  FPerfiles.Show;
  FPrincipal.Visible:= False;
end;

procedure TFPrincipal.Localidades1Click(Sender: TObject);
begin
  FLocalidades.Show;
  FPrincipal.Visible:= False;
end;

procedure TFPrincipal.iposDocumento1Click(Sender: TObject);
begin
  FTiposDocumento.Show;
  FPrincipal.Visible:= False;
end;

procedure TFPrincipal.TiposComprobante1Click(Sender: TObject);
begin
  FTiposComprobante.Show;
  FPrincipal.Visible:= False;
end;

procedure TFPrincipal.iposContribuyente1Click(Sender: TObject);
begin
  FTiposContribuyente.Show;
  FPrincipal.Visible:= False;
end;

procedure TFPrincipal.iposImpuesto1Click(Sender: TObject);
begin
  FTiposImpuesto.Show;
  FPrincipal.Visible:= False;
end;

procedure TFPrincipal.PuntosVenta1Click(Sender: TObject);
begin
  FPuntosVenta.Show;
  FPrincipal.Visible:= False;
end;

procedure TFPrincipal.CondicionesComerciales1Click(Sender: TObject);
begin
  FCondicionesComerciales.Show;
  FPrincipal.Visible:= False;
end;

procedure TFPrincipal.Productos1Click(Sender: TObject);
begin
  FProductos.Show;
  FPrincipal.Visible:= False;
end;

procedure TFPrincipal.NuevoComprobante1Click(Sender: TObject);
var
  Reg_TComp: Registro_Comprobante;
  Reg_PtoVta: Registro_PuntosVenta;
  Reg_Cliente: Registro_Cliente;
  Reg_Producto: Registro_Producto;
  Reg_Condicion: Registro_CondicionesComerciales;
  pos_TComp, pos_PtoVta, pos_Cliente, pos_Producto, pos_Cond: Tipo_Posicion;
begin
  FComprobante.EFecha.Text:= datetostr(now);
  FComprobante.CBPtoVta.Clear;
  FComprobante.CBPtoVta.ItemIndex:= -1;
  FComprobante.CBComp.Clear;
  FComprobante.CBComp.ItemIndex:= -1;
  FComprobante.ENumComp.Clear;
  FComprobante.CBClientes.Clear;
  FComprobante.CBClientes.ItemIndex:= -1;
  FComprobante.ECuit.Clear;
  FComprobante.EDomicilio.Clear;
  FComprobante.CBCondComerc.Clear;
  FComprobante.CBCondComerc.ItemIndex:= -1;
  FComprobante.EResp.Clear;
  FComprobante.CBProducto.Clear;
  FComprobante.CBProducto.ItemIndex:= -1;
  FComprobante.ECantidad.Clear;
  FComprobante.EPrecioUnit.Clear;
  FComprobante.ESubtotal.Clear;
  FComprobante.EImpuesto.Clear;
  FComprobante.EImpInt.Clear;
  FComprobante.ESubtotalImp.Clear;
  FComprobante.GBDetalle.Enabled:= false;
  FComprobante.GBComp.Enabled:= true;

  pos_PtoVta:= 0;
  while pos_PtoVta < FComprobante.PuntosVenta.Ultimo do
    begin
      FComprobante.PuntosVenta.Capturar(Reg_PtoVta,pos_PtoVta);
      if Reg_PtoVta.Borrado = false then
       begin
        FComprobante.CBPtoVta.Items.Add(Reg_PtoVta.Clave+'-'+Reg_PtoVta.Descripcion);
       end;
      pos_PtoVta:= succ(pos_PtoVta);
    end;

  pos_TComp:= 0;
  while pos_TComp < FComprobante.TiposComprobantes.Ultimo do
    begin
      FComprobante.TiposComprobantes.Capturar(Reg_TComp,pos_TComp);
      if Reg_TComp.Borrado = false then
       begin
        FComprobante.CBComp.Items.Add(Reg_TComp.Clave+'-'+Reg_TComp.Descripcion);
       end;
      pos_TComp:= succ(pos_TComp);
    end;

  pos_Cliente:= FComprobante.Clientes.Primero;
  while pos_Cliente <> FComprobante.Clientes.Pos_Nula do
    begin
      FComprobante.Clientes.Capturar(Reg_Cliente,pos_Cliente);
      if Reg_Cliente.Borrado = false then
       begin
        FComprobante.CBClientes.Items.Add(Reg_Cliente.Nombre);
       end;
      pos_Cliente:= FComprobante.Clientes.Proximo(pos_Cliente);
    end;

  pos_Cond:= FComprobante.CondicionesComerciales.Primero;
  while pos_Cond <> FComprobante.CondicionesComerciales.Pos_Nula do
    begin
      FComprobante.CondicionesComerciales.Capturar(Reg_Condicion,pos_Cond);
      if Reg_Condicion.Borrado = false then
       begin
        FComprobante.CBCondComerc.Items.Add(Reg_Condicion.Clave+'-'+Reg_Condicion.Descripcion);
       end;
      pos_Cond:= FComprobante.CondicionesComerciales.Proximo(pos_Cond);
    end;

  pos_Producto:= 0;
  while pos_Producto < FComprobante.Productos.Ultimo do
    begin
      FComprobante.Productos.Capturar(Reg_Producto,pos_Producto);
      if Reg_Producto.Borrado = false then
       begin
        FComprobante.CBProducto.Items.Add(Reg_Producto.Clave+'-'+Reg_Producto.Nombre);
       end;
      pos_Producto:= succ(pos_Producto);
    end;

  FComprobante.ListadoDetalles.RowCount:= 1;
  FComprobante.ListadoDetalles.ColCount:= 8;
  FComprobante.ListadoDetalles.Cells[0,0]:= 'Cod';
  FComprobante.ListadoDetalles.Cells[1,0]:= 'Producto';
  FComprobante.ListadoDetalles.Cells[2,0]:= 'Cant';
  FComprobante.ListadoDetalles.Cells[3,0]:= 'Precio Unit.';
  FComprobante.ListadoDetalles.Cells[4,0]:= 'Subtotal';
  FComprobante.ListadoDetalles.Cells[5,0]:= 'Alicuota';
  FComprobante.ListadoDetalles.Cells[6,0]:= 'Otros Imp';
  FComprobante.ListadoDetalles.Cells[7,0]:= 'Subtotal c/Imp';
  FComprobante.ListadoDetalles.ColWidths[0]:= 40;
  FComprobante.ListadoDetalles.ColWidths[1]:= 200;
  FComprobante.ListadoDetalles.ColWidths[2]:= 40;
  FComprobante.ListadoDetalles.ColWidths[3]:= 100;
  FComprobante.ListadoDetalles.ColWidths[4]:= 100;
  FComprobante.ListadoDetalles.ColWidths[5]:= 100;
  FComprobante.ListadoDetalles.ColWidths[6]:= 100;
  FComprobante.ListadoDetalles.ColWidths[7]:= 125;

  FComprobante.Show;
  FPrincipal.Visible:= False;
end;

procedure TFPrincipal.ConsultaComprobantes1Click(Sender: TObject);
begin
  FConsultaComprobantes.Show;
  FPrincipal.Visible:= False;
end;

end.
