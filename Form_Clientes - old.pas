unit Form_Clientes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Unidad_Clientes, Unidad_Provincias, Sistema_ABM, Grids, Unidad_Aud_Clientes;

type
  TFClientes = class(TForm)
    BSalirClientes: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    EDniCliente: TEdit;
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
    procedure BSalirClientesClick(Sender: TObject);
    procedure BGuardarClienteClick(Sender: TObject);
    procedure BModificarClienteClick(Sender: TObject);
    procedure BGuardarModClienteClick(Sender: TObject);
    procedure BCancelarClienteClick(Sender: TObject);
    procedure BBorrarClienteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FClientes: TFClientes;
  Provincias: Modelo_Provincia;
  Clientes: Modelo_Cliente;
  Aud_Clientes: Modelo_Aud_Cliente;
  Reg_Aud_Aux: Registro_Aud_Cliente_Nuevo;
  pos_Provincia, pos_Cliente: Tipo_Posicion;

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
begin
  Provincias:= Modelo_Provincia.Create(FIngreso.c_Ruta,'Provincias');
  Clientes:= Modelo_Cliente.Create(FIngreso.c_Ruta,'Clientes');
  Provincias.Abrir;
  Clientes.Abrir;
  Aud_Clientes:= Modelo_Aud_Cliente.Create(FIngreso.c_Ruta,'Auditoria_Clientes');
  Aud_Clientes.Abrir;
  EDniCliente.Clear;
  ENombreCliente.Clear;
  EApellidoCliente.Clear;
  CBClaveProvCliente.Clear;
  ListadoClientes.RowCount:= 1;
  ListadoClientes.ColCount:= 4;
  ListadoClientes.Cells[0,0]:= 'DNI';
  ListadoClientes.Cells[1,0]:= 'Apellido';
  ListadoClientes.Cells[2,0]:= 'Nombre';
  ListadoClientes.Cells[3,0]:= 'Provincia';
  ListadoClientes.ColWidths[1]:= 100;
  ListadoClientes.ColWidths[2]:= 100;
  ListadoClientes.ColWidths[3]:= 250;
  BGuardarModCliente.Enabled:= False;
  BGuardarModCliente.Visible:= False;
  BCancelarCliente.Enabled:= False;
  BCancelarCliente.Visible:= False;
  pos_Cliente:= 0;
  while pos_Cliente < Clientes.Ultimo do
    begin
      Clientes.Capturar(Reg_Cliente,pos_Cliente);
      pos_Provincia:= Reg_Cliente.id_Provincia;
      Provincias.Capturar(Reg_Provincia,Reg_Cliente.id_Provincia);
      if Reg_Cliente.Borrado = false then
       begin
        ListadoClientes.RowCount:= ListadoClientes.RowCount + 1;
        ListadoClientes.Cells[0,ListadoClientes.RowCount-1]:= Reg_Cliente.DNI;
        ListadoClientes.Cells[1,ListadoClientes.RowCount-1]:= Reg_Cliente.Apellido;
        ListadoClientes.Cells[2,ListadoClientes.RowCount-1]:= Reg_Cliente.Nombre;
        ListadoClientes.Cells[3,ListadoClientes.RowCount-1]:= Reg_Provincia.Descripcion;
       end;
      pos_Cliente:= succ(pos_Cliente);
    end;

  pos_Provincia:= 0;
  while pos_Provincia < Provincias.Ultimo do
    begin
      Provincias.Capturar(Reg_Provincia,pos_Provincia);
      if Reg_Provincia.Borrado = false then
        CBClaveProvCliente.Items.Add(Reg_Provincia.Clave+' - '+Reg_Provincia.Descripcion);
      pos_Provincia:= succ(pos_Provincia);
    end;
end;


procedure TFClientes.BGuardarClienteClick(Sender: TObject);
var
  Reg_Cliente: Registro_Cliente;
  Reg_Aud: Registro_Aud_Cliente_Nuevo;
  Reg_Provincia: Registro_Provincia;
begin
  Reg_Cliente.DNI:= EDniCliente.Text;
  Reg_Cliente.Apellido:= EApellidoCliente.Text;
  Reg_Cliente.Nombre:= ENombreCliente.Text;
  Reg_Cliente.id_Provincia:= CBClaveProvCliente.ItemIndex;
  if ((EDniCliente.Text <> '') and (EApellidoCliente.Text <> '') and (ENombreCliente.Text <> '')
          and (strtoint(EDniCliente.Text)>0) and (strtoint(EDniCliente.Text)<99999999) and (CBClaveProvCliente.ItemIndex <> -1)) then
    begin
      if Clientes.Buscar(Reg_Cliente.DNI,pos_Cliente,true) = false then
        begin
          Clientes.Insertar(Reg_Cliente,pos_Cliente);

          //Auditoria
          Reg_Aud.Cliente.id:= pos_Cliente;
          Reg_Aud.Cliente.Borrado:= Reg_Cliente.Borrado;
          Reg_Aud.Tipo_Operacion:= 'A';
          Reg_Aud.Cliente.DNI:= Reg_Cliente.DNI;
          Reg_Aud.Cliente.Apellido:= Reg_Cliente.Apellido;
          Reg_Aud.Cliente.Nombre:= Reg_Cliente.Nombre;
          Reg_Aud.Cliente.id_Provincia:= Reg_Cliente.id_Provincia;
          Reg_Aud.id_Aud_Cliente:= Aud_Clientes.Ultimo + 1;
          Reg_Aud.Borrado:= false;
          Reg_Aud.Nick:= FIngreso.usuario;
          Reg_Aud.Terminal:= FPrincipal.IP;
          Reg_Aud.Fecha:= datetostr(now);
          Reg_Aud.Hora:= timetostr(now);
          Aud_Clientes.Insertar(Reg_Aud,Reg_Aud.id_Aud_Cliente);

          pos_Cliente:= 0;
          EDniCliente.Clear;
          EDniCliente.SetFocus;
          EApellidoCliente.Clear;
          ENombreCliente.Clear;
          CBClaveProvCliente.ItemIndex:= -1;
          ListadoClientes.RowCount:= 1;
          while pos_Cliente < Clientes.Ultimo do
            begin
              Clientes.Capturar(Reg_Cliente,pos_Cliente);
              pos_Provincia:= Reg_Cliente.id_Provincia;
              Provincias.Capturar(Reg_Provincia,pos_Provincia);
              if Reg_Cliente.Borrado = false then
               begin
                ListadoClientes.RowCount:= ListadoClientes.RowCount + 1;
                ListadoClientes.Cells[0,ListadoClientes.RowCount-1]:= Reg_Cliente.DNI;
                ListadoClientes.Cells[1,ListadoClientes.RowCount-1]:= Reg_Cliente.Apellido;
                ListadoClientes.Cells[2,ListadoClientes.RowCount-1]:= Reg_Cliente.Nombre;
                ListadoClientes.Cells[3,ListadoClientes.RowCount-1]:= Reg_Provincia.Descripcion;
               end;
              pos_Cliente:= succ(pos_Cliente);
            end;
        end
      else
        begin
          showmessage('El DNI ya existe');
          EDniCliente.Clear;
          EDniCliente.SetFocus;
        end;
    end
  else
    begin
      if ((EDniCliente.Text = '') or (strtoint(EDniCliente.Text)<0) or (strtoint(EDniCliente.Text)>99999999)) then
        begin
          showmessage('Ingrese un DNI valido');
          EDniCliente.Clear;
          EDniCliente.SetFocus;
        end
      else
        begin
          if (EApellidoCliente.Text = '') then
            begin
              showmessage('Ingrese un Apellido');
              EApellidoCliente.Clear;
              EApellidoCliente.SetFocus;
            end
          else
            begin
              if (ENombreCliente.Text = '') then
                begin
                  showmessage('Ingrese un Nombre');
                  ENombreCliente.Clear;
                  ENombreCliente.SetFocus;
                end
              else
                begin
                  showmessage('Seleccione una provincia');
                  CBClaveProvCliente.SetFocus;
                end;
            end;
        end;
    end;
end;

procedure TFClientes.BModificarClienteClick(Sender: TObject);
var
  Reg_Cliente: Registro_Cliente;
begin
  if EModificarCliente.Text <> '' then
    begin
      Reg_Cliente.DNI:= EModificarCliente.Text;
      if Clientes.Buscar(Reg_Cliente.DNI,pos_Cliente,true) then
        begin
          Clientes.Capturar(Reg_Cliente,pos_Cliente);

          //Auditoria
          Reg_Aud_Aux.Cliente.id:= pos_Cliente;
          Reg_Aud_Aux.Cliente.Borrado:= Reg_Cliente.Borrado;
          Reg_Aud_Aux.Tipo_Operacion:= 'M';
          Reg_Aud_Aux.Cliente.DNI:= Reg_Cliente.DNI;
          Reg_Aud_Aux.Cliente.Apellido:= Reg_Cliente.Apellido;
          Reg_Aud_Aux.Cliente.Nombre:= Reg_Cliente.Nombre;
          Reg_Aud_Aux.Cliente.id_Provincia:= Reg_Cliente.id_Provincia;
          Reg_Aud_Aux.id_Aud_Cliente:= Aud_Clientes.Ultimo + 1;
          Reg_Aud_Aux.Borrado:= false;
          Reg_Aud_Aux.Nick:= FIngreso.usuario;
          Reg_Aud_Aux.Terminal:= FPrincipal.IP;

          EDniCliente.Text:= Reg_Cliente.DNI;
          EApellidoCliente.Text:= Reg_Cliente.Apellido;
          ENombreCliente.Text:= Reg_Cliente.Nombre;
          CBClaveProvCliente.ItemIndex:= Reg_Cliente.id_Provincia;
          BGuardarCliente.Enabled:= false;
          BGuardarCliente.Visible:= false;
          BGuardarModCliente.Enabled:= True;
          BGuardarModCliente.Visible:= True;
          BCancelarCliente.Enabled:= True;
          BCancelarCliente.Visible:= True;
        end
      else
        begin
          showmessage('Ingrese un DNI correcto');
          EModificarCliente.Clear;
          EModificarCliente.SetFocus;
        end;
    end
  else
    showmessage('Ingrese un DNI');
end;

procedure TFClientes.BGuardarModClienteClick(Sender: TObject);
var
  Reg_Cliente: Registro_Cliente;
  Reg_Provincia: Registro_Provincia;
  Reg_aux: Registro_Cliente;
  Reg_Aud: Registro_Aud_Cliente_Nuevo;
  pos_aux: Tipo_Posicion;
begin
  //Auditoria     
  Reg_Aud_Aux.Fecha:= datetostr(now);
  Reg_Aud_Aux.Hora:= timetostr(now);
  Aud_Clientes.Insertar(Reg_Aud_Aux,Aud_Clientes.Ultimo+1);

  Clientes.Capturar(Reg_aux,pos_Cliente);
  Reg_Cliente.DNI:= EDniCliente.Text;
  Reg_Cliente.Apellido:= EApellidoCliente.Text;
  Reg_Cliente.Nombre:= ENombreCliente.Text;
  Reg_Cliente.id_Provincia:= CBClaveProvCliente.ItemIndex;
  if ((EDniCliente.Text <> '') and (EApellidoCliente.Text <> '') and (ENombreCliente.Text <> '')
          and (strtoint(EDniCliente.Text)>0) and (strtoint(EDniCliente.Text)<99999999) and (CBClaveProvCliente.ItemIndex <> -1)) then
    begin
      if Reg_Cliente.DNI = Reg_Aux.DNI then
        begin
          Clientes.Modificar(Reg_Cliente,pos_Cliente);

          //Auditoria
          Reg_Aud.Cliente.id:= pos_Cliente;
          Reg_Aud.Cliente.Borrado:= Reg_Cliente.Borrado;
          Reg_Aud.Tipo_Operacion:= 'M';
          Reg_Aud.Cliente.DNI:= Reg_Cliente.DNI;
          Reg_Aud.Cliente.Apellido:= Reg_Cliente.Apellido;
          Reg_Aud.Cliente.Nombre:= Reg_Cliente.Nombre;
          Reg_Aud.Cliente.id_Provincia:= Reg_Cliente.id_Provincia;
          Reg_Aud.id_Aud_Cliente:= Aud_Clientes.Ultimo + 1;
          Reg_Aud.Borrado:= false;
          Reg_Aud.Nick:= FIngreso.usuario;
          Reg_Aud.Terminal:= FPrincipal.IP;
          Reg_Aud.Fecha:= datetostr(now);
          Reg_Aud.Hora:= timetostr(now);
          Aud_Clientes.Insertar(Reg_Aud,Reg_Aud.id_Aud_Cliente);

          BGuardarCliente.Enabled:= true;
          BGuardarCliente.Visible:= true;
          BGuardarModCliente.Enabled:= False;
          BGuardarModCliente.Visible:= False;
          BCancelarCliente.Enabled:= False;
          BCancelarCliente.Visible:= False;
          EDniCliente.Clear;
          EApellidoCliente.Clear;
          ENombreCliente.Clear;
          CBClaveProvCliente.ItemIndex:= -1;
          EModificarCliente.Clear;
          pos_Cliente:= 0;
          ListadoClientes.RowCount:= 1;
          while pos_Cliente < Clientes.Ultimo do
            begin
              Clientes.Capturar(Reg_Cliente,pos_Cliente);
              pos_Provincia:= Reg_Cliente.id_Provincia;
              Provincias.Capturar(Reg_Provincia,pos_Provincia);
              if Reg_Cliente.Borrado = false then
               begin
                ListadoClientes.RowCount:= ListadoClientes.RowCount + 1;
                ListadoClientes.Cells[0,ListadoClientes.RowCount-1]:= Reg_Cliente.DNI;
                ListadoClientes.Cells[1,ListadoClientes.RowCount-1]:= Reg_Cliente.Apellido;
                ListadoClientes.Cells[2,ListadoClientes.RowCount-1]:= Reg_Cliente.Nombre;
                ListadoClientes.Cells[3,ListadoClientes.RowCount-1]:= Reg_Provincia.Descripcion;
               end;
              pos_Cliente:= succ(pos_Cliente);
            end;
        end
      else
        begin
          if Clientes.Buscar(Reg_Cliente.DNI,pos_aux,true) = false then
            begin
              Clientes.Modificar(Reg_Cliente,pos_Cliente);

              //Auditoria
              Reg_Aud.Cliente.id:= pos_Cliente;
              Reg_Aud.Cliente.Borrado:= Reg_Cliente.Borrado;
              Reg_Aud.Tipo_Operacion:= 'M';
              Reg_Aud.Cliente.DNI:= Reg_Cliente.DNI;
              Reg_Aud.Cliente.Apellido:= Reg_Cliente.Apellido;
              Reg_Aud.Cliente.Nombre:= Reg_Cliente.Nombre;
              Reg_Aud.Cliente.id_Provincia:= Reg_Cliente.id_Provincia;
              Reg_Aud.id_Aud_Cliente:= Aud_Clientes.Ultimo + 1;
              Reg_Aud.Borrado:= false;
              Reg_Aud.Nick:= FIngreso.usuario;
              Reg_Aud.Terminal:= FPrincipal.IP;
              Reg_Aud.Fecha:= datetostr(now);
              Reg_Aud.Hora:= timetostr(now);
              Aud_Clientes.Insertar(Reg_Aud,Reg_Aud.id_Aud_Cliente);

              BGuardarCliente.Enabled:= true;
              BGuardarCliente.Visible:= true;
              BGuardarModCliente.Enabled:= False;
              BGuardarModCliente.Visible:= False;
              BCancelarCliente.Enabled:= False;
              BCancelarCliente.Visible:= False;
              EDniCliente.Clear;
              EApellidoCliente.Clear;
              ENombreCliente.Clear;
              CBClaveProvCliente.ItemIndex:= -1;
              pos_Cliente:= 0;
              ListadoClientes.RowCount:= 1;
              while pos_Cliente < Clientes.Ultimo do
                begin
                  Clientes.Capturar(Reg_Cliente,pos_Cliente);
                  pos_Provincia:= Reg_Cliente.id_Provincia;
                  Provincias.Capturar(Reg_Provincia,pos_Provincia);
                  if Reg_Cliente.Borrado = false then
                   begin
                    ListadoClientes.RowCount:= ListadoClientes.RowCount + 1;
                    ListadoClientes.Cells[0,ListadoClientes.RowCount-1]:= Reg_Cliente.DNI;
                    ListadoClientes.Cells[1,ListadoClientes.RowCount-1]:= Reg_Cliente.Apellido;
                    ListadoClientes.Cells[2,ListadoClientes.RowCount-1]:= Reg_Cliente.Nombre;
                    ListadoClientes.Cells[3,ListadoClientes.RowCount-1]:= Reg_Provincia.Descripcion;
                   end;
                  pos_Cliente:= succ(pos_Cliente);
                end;
            end
          else
            begin
              showmessage('El DNI ya existe');
              EDniCliente.text:= Reg_Aux.DNI;
              EDniCliente.SetFocus;
            end;
        end;
      end
    else
      begin
        if ((EDniCliente.Text = '') or (strtoint(EDniCliente.Text)<0) or (strtoint(EDniCliente.Text)>99999999)) then
          begin
            showmessage('Ingrese un DNI valido');
            EDniCliente.Clear;
            EDniCliente.SetFocus;
          end
        else
          begin
            if (EApellidoCliente.Text = '') then
              begin
                showmessage('Ingrese un Apellido');
                EApellidoCliente.Clear;
                EApellidoCliente.SetFocus;
              end
            else
              begin
                if (ENombreCliente.Text = '') then
                  begin
                    showmessage('Ingrese un Nombre');
                    ENombreCliente.Clear;
                    ENombreCliente.SetFocus;
                  end
                else
                  if (CBClaveProvCliente.ItemIndex = -1) then
                    begin
                      showmessage('Seleccione una provincia');
                      CBClaveProvCliente.SetFocus;
                    end;
              end;
            end;
        end;
end;

procedure TFClientes.BCancelarClienteClick(Sender: TObject);
begin
  BGuardarCliente.Enabled:= true;
  BGuardarCliente.Visible:= true;
  BGuardarModCliente.Enabled:= False;
  BGuardarModCliente.Visible:= False;
  BCancelarCliente.Enabled:= False;
  BCancelarCliente.Visible:= False;
  EDniCliente.Clear;
  EApellidoCliente.Clear;
  ENombreCliente.Clear;
  CBClaveProvCliente.ItemIndex:= -1;
  EModificarCliente.Clear;
end;

procedure TFClientes.BBorrarClienteClick(Sender: TObject);
var
  Reg_Cliente: Registro_Cliente;
  Reg_Provincia: Registro_Provincia; 
  Reg_Aud: Registro_Aud_Cliente_Nuevo;
begin
  if EModificarCliente.Text <> '' then
    begin
      Reg_Cliente.DNI:= EModificarCliente.Text;
      if Clientes.Buscar(Reg_Cliente.DNI,pos_Cliente,false) then
        begin
          if messagedlg('¿Estas seguro de eliminar?',mtConfirmation,[mbYes, mbNo], 0) = mrYes then
            begin
              Clientes.Eliminar(pos_Cliente);

              //Auditoria
              Clientes.Capturar(Reg_Cliente,pos_Cliente);
              Reg_Aud.Cliente.id:= pos_Cliente;
              Reg_Aud.Cliente.Borrado:= Reg_Cliente.Borrado;
              Reg_Aud.Tipo_Operacion:= 'B';
              Reg_Aud.Cliente.DNI:= Reg_Cliente.DNI;
              Reg_Aud.Cliente.Apellido:= Reg_Cliente.Apellido;
              Reg_Aud.Cliente.Nombre:= Reg_Cliente.Nombre;
              Reg_Aud.Cliente.id_Provincia:= Reg_Cliente.id_Provincia;
              Reg_Aud.id_Aud_Cliente:= Aud_Clientes.Ultimo + 1;
              Reg_Aud.Borrado:= false;
              Reg_Aud.Nick:= FIngreso.usuario;
              Reg_Aud.Terminal:= FPrincipal.IP;
              Reg_Aud.Fecha:= datetostr(now);
              Reg_Aud.Hora:= timetostr(now);
              Aud_Clientes.Insertar(Reg_Aud,Reg_Aud.id_Aud_Cliente);
              
              pos_Cliente:= 0;
              ListadoClientes.RowCount:= 1;
              EModificarCliente.Clear;
              while pos_Cliente < Clientes.Ultimo do
                begin
                  Clientes.Capturar(Reg_Cliente,pos_Cliente);
                  pos_Provincia:= Reg_Cliente.id_Provincia;
                  Provincias.Capturar(Reg_Provincia,pos_Provincia);
                  if Reg_Cliente.Borrado = false then
                   begin
                    ListadoClientes.RowCount:= ListadoClientes.RowCount + 1;
                    ListadoClientes.Cells[0,ListadoClientes.RowCount-1]:= Reg_Cliente.DNI;
                    ListadoClientes.Cells[1,ListadoClientes.RowCount-1]:= Reg_Cliente.Apellido;
                    ListadoClientes.Cells[2,ListadoClientes.RowCount-1]:= Reg_Cliente.Nombre;
                    ListadoClientes.Cells[3,ListadoClientes.RowCount-1]:= Reg_Provincia.Descripcion;
                   end;
                  pos_Cliente:= succ(pos_Cliente);
                end;
            end;
        end
      else
        begin
          showmessage('Ingrese un DNI correcto');
          EModificarCliente.Clear;
          EModificarCliente.SetFocus;
        end;
    end
  else
    showmessage('Ingrese un DNI');
end;



end.
