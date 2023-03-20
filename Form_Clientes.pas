unit Form_Clientes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Unidad_Clientes, Unidad_Provincias, Sistema_ABM, Grids, Unidad_Aud_Clientes,
  Unidad_Localidades, Unidad_Contribuyentes, Unidad_Documentos;

type
  TFClientes = class(TForm)
    BSalirClientes: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    EDni: TEdit;
    EDomicilio: TEdit;
    ENombre: TEdit;
    CBProvincia: TComboBox;
    BGuardarCliente: TButton;
    Label6: TLabel;
    Label7: TLabel;
    UsuarioRegistrado: TLabel;
    Label8: TLabel;
    NombreEmpresa: TLabel;
    ListadoClientes: TStringGrid;
    Label5: TLabel;
    EClave: TEdit;
    Label9: TLabel;
    CBLocalidad: TComboBox;
    Label10: TLabel;
    CBTipoDoc: TComboBox;
    Label11: TLabel;
    ETelefono: TEdit;
    Label12: TLabel;
    EMail: TEdit;
    Label13: TLabel;
    CBTipoContrib: TComboBox;
    BNuevo: TButton;
    BModificar: TButton;
    procedure BSalirClientesClick(Sender: TObject);
    procedure BGuardarClienteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CBProvinciaChange(Sender: TObject);
    procedure BNuevoClick(Sender: TObject);
    procedure BModificarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FClientes: TFClientes;
  Clientes: Modelo_Cliente;     
  Provincias: Modelo_Provincia;
  Localidades: Modelo_Localidad;
  Contribuyentes: Modelo_Contribuyente;
  Documentos: Modelo_Documento;
  pos_Provincia, pos_Cliente, pos_Localidad, pos_Contrib, pos_Doc: Tipo_Posicion;

implementation

uses Form_Ingreso;


{$R *.dfm}

procedure TFClientes.BSalirClientesClick(Sender: TObject);
begin
  Close;
  FPrincipal.Visible:= true;
end;


procedure TFClientes.FormActivate(Sender: TObject);
var
  Reg_Provincia: Registro_Provincia;
  Reg_Cliente: Registro_Cliente;
  Reg_Contribuyente: Registro_Contribuyente;
  Reg_Documento: Registro_Documento;
begin
  Provincias:= Modelo_Provincia.Create(FIngreso.c_Ruta,'Provincias');
  Clientes:= Modelo_Cliente.Create(FIngreso.c_Ruta,'Clientes');
  Provincias.Abrir;
  Clientes.Abrir;
  Localidades:= Modelo_Localidad.Create(FIngreso.c_Ruta,'Localidades');
  Localidades.Abrir;
  Contribuyentes:= Modelo_Contribuyente.Create(FIngreso.c_Ruta,'Contribuyentes');
  Contribuyentes.Abrir;
  Documentos:= Modelo_Documento.Create(FIngreso.c_Ruta,'Documentos');
  Documentos.Abrir;

  EClave.Clear;
  EClave.Enabled:= true;
  EClave.SetFocus;
  ENombre.Clear;
  EDomicilio.Clear;
  CBTipoDoc.ItemIndex:= -1;
  EDni.Clear;
  CBProvincia.ItemIndex:= -1;
  CBLocalidad.ItemIndex:= -1;
  ETelefono.Clear;
  EMail.Clear;
  CBTipoContrib.ItemIndex:= -1;

  ListadoClientes.RowCount:= 1;
  ListadoClientes.ColCount:= 5;
  ListadoClientes.Cells[0,0]:= 'Clave';
  ListadoClientes.Cells[1,0]:= 'Nombre';
  ListadoClientes.Cells[2,0]:= 'Domicilio';
  ListadoClientes.Cells[3,0]:= 'Documento';
  ListadoClientes.Cells[4,0]:= 'Sit. IVA';
  ListadoClientes.ColWidths[1]:= 150;
  ListadoClientes.ColWidths[2]:= 100;
  ListadoClientes.ColWidths[3]:= 100;   
  ListadoClientes.ColWidths[4]:= 150;
  pos_Cliente:= Clientes.Primero;
  while pos_Cliente <> Clientes.Pos_Nula do
    begin
      Clientes.Capturar(Reg_Cliente,pos_Cliente);
      pos_Contrib:= Reg_Cliente.id_TipoContribuyente;
      Contribuyentes.Capturar(Reg_Contribuyente,pos_Contrib);
      if Reg_Cliente.Borrado = false then
       begin
        ListadoClientes.RowCount:= ListadoClientes.RowCount + 1;
        ListadoClientes.Cells[0,ListadoClientes.RowCount-1]:= Reg_Cliente.Clave;
        ListadoClientes.Cells[1,ListadoClientes.RowCount-1]:= Reg_Cliente.Nombre;
        ListadoClientes.Cells[2,ListadoClientes.RowCount-1]:= Reg_Cliente.Domicilio;
        ListadoClientes.Cells[3,ListadoClientes.RowCount-1]:= Reg_Cliente.DNI;
        ListadoClientes.Cells[4,ListadoClientes.RowCount-1]:= Reg_Contribuyente.Descripcion;
       end;
      pos_Cliente:= Clientes.Proximo(pos_Cliente);
    end;

  pos_Provincia:= 0;
  while pos_Provincia < Provincias.Ultimo do
    begin
      Provincias.Capturar(Reg_Provincia,pos_Provincia);
      if Reg_Provincia.Borrado = false then
        CBProvincia.Items.Add(Reg_Provincia.Clave+' - '+Reg_Provincia.Descripcion);
      pos_Provincia:= succ(pos_Provincia);
    end;

  pos_Doc:= 0;
  while pos_Doc < Documentos.Ultimo do
    begin
      Documentos.Capturar(Reg_Documento,pos_Doc);
      if Reg_Documento.Borrado = false then
        CBTipoDoc.Items.Add(Reg_Documento.Clave+' - '+Reg_Documento.Descripcion);
      pos_Doc:= succ(pos_Doc);
    end;

  pos_Contrib:= 0;
  while pos_Contrib < Contribuyentes.Ultimo do
    begin
      Contribuyentes.Capturar(Reg_Contribuyente,pos_Contrib);
      if Reg_Contribuyente.Borrado = false then
        CBTipoContrib.Items.Add(Reg_Contribuyente.Clave+' - '+Reg_Contribuyente.Descripcion);
      pos_Contrib:= succ(pos_Contrib);
    end;
end;

procedure TFClientes.CBProvinciaChange(Sender: TObject);
var
  Reg_Localidad: Registro_Localidad;
begin
  CBLocalidad.Clear;
  pos_Provincia:= CBProvincia.ItemIndex;
  pos_Localidad:= 0;
  while pos_Localidad < Localidades.Ultimo do
    begin
      Localidades.Capturar(Reg_Localidad,pos_Localidad);
      if (Reg_Localidad.Borrado = false) and (Reg_Localidad.id_Provincia = pos_Provincia) then
        CBLocalidad.Items.Add(Reg_Localidad.CP+' - '+Reg_Localidad.Descripcion);
      pos_Localidad:= succ(pos_Localidad);
    end;
end;


procedure TFClientes.BGuardarClienteClick(Sender: TObject);
var
  Reg_Cliente: Registro_Cliente;
  Reg_Contribuyente: Registro_Contribuyente;
begin
  Reg_Cliente.Clave:= EClave.Text;
  Reg_Cliente.Nombre:= Enombre.Text;
  Reg_Cliente.Domicilio:= EDomicilio.Text;
  Reg_Cliente.id_TipoDocumento:= CBTipoDoc.ItemIndex;
  Reg_Cliente.DNI:= EDni.Text;
  Localidades.Buscar(Copy(CBLocalidad.Items[CBLocalidad.itemIndex],1,4),pos_Localidad,true);
  Reg_Cliente.id_Localidad:= pos_Localidad;
  Reg_Cliente.Telefono:= ETelefono.Text;
  Reg_Cliente.Email:= EMail.Text;
  Reg_Cliente.id_TipoContribuyente:= CBTipoContrib.ItemIndex;

  if ((EClave.Text <> '') and (Enombre.Text <> '') and (strtoint(EClave.Text) > 0)
          and (CBTipoContrib.ItemIndex <> -1)) then
    begin
      if Clientes.Buscar(Reg_Cliente.Clave,pos_Cliente,true) = false then
        begin
          Clientes.Insertar(Reg_Cliente,pos_Cliente);

          EClave.Clear;
          EClave.Enabled:= true;
          EClave.SetFocus;
          ENombre.Clear;  
          EDomicilio.Clear;
          CBTipoDoc.ItemIndex:= -1;
          EDni.Clear;
          CBProvincia.ItemIndex:= -1;
          CBLocalidad.ItemIndex:= -1;
          ETelefono.Clear;
          EMail.Clear;
          CBTipoContrib.ItemIndex:= -1;
          ListadoClientes.RowCount:= 1;
          pos_Cliente:= Clientes.Primero;
          while pos_Cliente <> Clientes.Pos_Nula do
            begin
              Clientes.Capturar(Reg_Cliente,pos_Cliente);
              pos_Contrib:= Reg_Cliente.id_TipoContribuyente;
              Contribuyentes.Capturar(Reg_Contribuyente,pos_Contrib);
              if Reg_Cliente.Borrado = false then
              begin
                ListadoClientes.RowCount:= ListadoClientes.RowCount + 1;
                ListadoClientes.Cells[0,ListadoClientes.RowCount-1]:= Reg_Cliente.Clave;
                ListadoClientes.Cells[1,ListadoClientes.RowCount-1]:= Reg_Cliente.Nombre;
                ListadoClientes.Cells[2,ListadoClientes.RowCount-1]:= Reg_Cliente.Domicilio;
                ListadoClientes.Cells[3,ListadoClientes.RowCount-1]:= Reg_Cliente.DNI;
                ListadoClientes.Cells[4,ListadoClientes.RowCount-1]:= Reg_Contribuyente.Descripcion;
              end;
              pos_Cliente:= Clientes.Proximo(pos_Cliente);
            end;
        end
      else
        begin
          if MessageDlg('¿Desea modificar el cliente?', mtWarning,[mbYes,mbNo], 0) = mrYes then
            begin
              Clientes.Capturar(Reg_Cliente,pos_Cliente);
              Reg_Cliente.Clave:= EClave.Text;
              Reg_Cliente.Nombre:= Enombre.Text;
              Reg_Cliente.Domicilio:= EDomicilio.Text;
              Reg_Cliente.id_TipoDocumento:= CBTipoDoc.ItemIndex;
              Reg_Cliente.DNI:= EDni.Text;
              Localidades.Buscar(Copy(CBLocalidad.Items[CBLocalidad.itemIndex],1,4),pos_Localidad,true);
              Reg_Cliente.id_Localidad:= pos_Localidad;
              Reg_Cliente.Telefono:= ETelefono.Text;
              Reg_Cliente.Email:= EMail.Text;
              Reg_Cliente.id_TipoContribuyente:= CBTipoContrib.ItemIndex;
              Clientes.Modificar(Reg_Cliente,pos_Cliente);
              FClientes.FormActivate(Sender);
            end
          else
            begin
              FClientes.FormActivate(Sender);
            end;
        end;
    end
  else
   if (EClave.Text = '') or (ENombre.Text = '') or (CBTipoContrib.ItemIndex = -1) then
    begin
      showmessage('Complete al menos los campos "Clave", "Nombre" y "Tipo de Contribuyente"');
    end;
end;


procedure TFClientes.BNuevoClick(Sender: TObject);
begin
  FClientes.FormActivate(Sender);
end;

procedure TFClientes.BModificarClick(Sender: TObject);
var
  Reg_Cliente: Registro_Cliente;
  Reg_Localidad: Registro_Localidad;
  i: Tipo_Posicion;
  corte: boolean;
begin
  if ListadoClientes.Row <> 0 then
    begin
      pos_Cliente:= ListadoClientes.Row - 1;
      Clientes.Capturar(Reg_Cliente,pos_Cliente);
      EClave.Text:= Reg_Cliente.Clave;
      ENombre.Text:= Reg_Cliente.Nombre;
      EDomicilio.Text:= Reg_Cliente.Domicilio;
      CBTipoDoc.ItemIndex:= Reg_Cliente.id_TipoDocumento;
      EDni.Text:= Reg_Cliente.DNI;
      Localidades.Capturar(Reg_Localidad,Reg_Cliente.id_Localidad);
      CBProvincia.ItemIndex:= Reg_Localidad.id_Provincia;

      pos_Provincia:= CBProvincia.ItemIndex;
      pos_Localidad:= 0;
      while pos_Localidad < Localidades.Ultimo do
        begin
          Localidades.Capturar(Reg_Localidad,pos_Localidad);
          if (Reg_Localidad.Borrado = false) and (Reg_Localidad.id_Provincia = pos_Provincia) then
            CBLocalidad.Items.Add(Reg_Localidad.CP+' - '+Reg_Localidad.Descripcion);
          pos_Localidad:= succ(pos_Localidad);
        end;

      i:= 0;
      corte:= false;
      while (i <= CBLocalidad.Items.Count - 1) and (corte = false) do
        begin
          if Reg_Localidad.CP = Copy(CBLocalidad.Items[i],1,4) then
            begin 
              CBLocalidad.ItemIndex:= i;
              corte:= true;
            end
          else
            i:= succ(i);
        end;
      ETelefono.Text:= Reg_Cliente.Telefono;
      EMail.Text:= Reg_Cliente.Email;
      CBTipoContrib.ItemIndex:= Reg_Cliente.id_TipoContribuyente;
      EClave.Enabled:= false;
    end
  else
    showmessage('Seleccione una cuenta para modificar');
end;

end.
