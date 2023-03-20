unit Form_Perfiles;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Sistema_ABM, Unidad_Perfiles, Unidad_Aud_Perfiles;

type
  TFPerfiles = class(TForm)
    Label4: TLabel;
    BSalirPerfiles: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    ENombrePerfil: TEdit;
    BGuardarPerfil: TButton;
    BGuardarModPerfil: TButton;
    BCancelarPerfil: TButton;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    EModificarPerfil: TEdit;
    BModificarPerfil: TButton;
    BBorrarPerfil: TButton;
    ListadoPerfiles: TStringGrid;
    HabilitarClientes: TCheckBox;
    HabilitarProvincias: TCheckBox;
    HabilitarAuditoria: TCheckBox;
    HabilitarUsuarios: TCheckBox;
    HabilitarPerfiles: TCheckBox;
    Label2: TLabel;
    Label7: TLabel;
    UsuarioRegistrado: TLabel;
    Label8: TLabel;
    NombreEmpresa: TLabel;
    HabilitarBackUp: TCheckBox;
    HabilitarRestore: TCheckBox;
    procedure BSalirPerfilesClick(Sender: TObject);
    procedure BGuardarPerfilClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BModificarPerfilClick(Sender: TObject);
    procedure BGuardarModPerfilClick(Sender: TObject);
    procedure BCancelarPerfilClick(Sender: TObject);
    procedure BBorrarPerfilClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPerfiles: TFPerfiles;
  Perfiles: Modelo_Perfil;
  Aud_Perfiles: Modelo_Aud_Perfil;
  Reg_Aud_Aux: Registro_Aud_Perfil_Nuevo;
  pos_Perfil: Tipo_Posicion;

implementation

uses Form_Ingreso;

{$R *.dfm}



procedure TFPerfiles.BSalirPerfilesClick(Sender: TObject);
begin
  Close;
  FPrincipal.Visible:= true;
end;



procedure TFPerfiles.FormActivate(Sender: TObject);
var
  Registro: Registro_Perfil;
  chek: string[1];
begin
  Perfiles:= Modelo_Perfil.Create(FIngreso.c_Ruta,'Perfiles');
  Perfiles.Abrir;
  Aud_Perfiles:= Modelo_Aud_Perfil.Create(FIngreso.c_Ruta,'Auditoria_Perfiles');
  Aud_Perfiles.Abrir;
  ENombrePerfil.Clear;
  HabilitarClientes.Checked:= False;
  HabilitarPerfiles.Checked:= False;
  HabilitarProvincias.Checked:= False;
  HabilitarUsuarios.Checked:= False;
  HabilitarAuditoria.Checked:= False;
  ListadoPerfiles.RowCount:= 1;
  ListadoPerfiles.ColCount:= 8;
  ListadoPerfiles.Cells[0,0]:= 'Nombre';
  ListadoPerfiles.Cells[1,0]:= 'Cli';
  ListadoPerfiles.Cells[2,0]:= 'Prov';
  ListadoPerfiles.Cells[3,0]:= 'Aud';
  ListadoPerfiles.Cells[4,0]:= 'User';
  ListadoPerfiles.Cells[5,0]:= 'Perf';
  ListadoPerfiles.Cells[6,0]:= 'BU';
  ListadoPerfiles.Cells[7,0]:= 'Rest';
  ListadoPerfiles.ColWidths[0]:= 150;
  ListadoPerfiles.ColWidths[1]:= 30;
  ListadoPerfiles.ColWidths[2]:= 30;
  ListadoPerfiles.ColWidths[3]:= 30;
  ListadoPerfiles.ColWidths[4]:= 30;
  ListadoPerfiles.ColWidths[5]:= 30;
  ListadoPerfiles.ColWidths[6]:= 30;
  ListadoPerfiles.ColWidths[7]:= 30;
  BGuardarModPerfil.Enabled:= False;
  BGuardarModPerfil.Visible:= False;
  BCancelarPerfil.Enabled:= False;
  BCancelarPerfil.Visible:= False;
  pos_Perfil:= 0;
  while pos_Perfil < Perfiles.Ultimo do
    begin
      Perfiles.Capturar(Registro,pos_Perfil);
      if Registro.Borrado = false then
       begin
        ListadoPerfiles.RowCount:= ListadoPerfiles.RowCount + 1;
        ListadoPerfiles.Cells[0,ListadoPerfiles.RowCount-1]:= Registro.Nombre;
        if BoolToStr(Registro.Hab_Clientes) = '-1' then
                  chek:= 'T'
                else
                  chek:= 'F';
                ListadoPerfiles.Cells[1,ListadoPerfiles.RowCount-1]:= chek;
                if BoolToStr(Registro.Hab_Provincias) = '-1' then
                  chek:= 'T'
                else
                  chek:= 'F';
                ListadoPerfiles.Cells[2,ListadoPerfiles.RowCount-1]:= chek;
                if BoolToStr(Registro.Hab_Auditoria) = '-1' then
                  chek:= 'T'
                else
                  chek:= 'F';
                ListadoPerfiles.Cells[3,ListadoPerfiles.RowCount-1]:= chek;
                if BoolToStr(Registro.Hab_Usuarios) = '-1' then
                  chek:= 'T'
                else
                  chek:= 'F';
                ListadoPerfiles.Cells[4,ListadoPerfiles.RowCount-1]:= chek;
                if BoolToStr(Registro.Hab_Perfiles) = '-1' then
                  chek:= 'T'
                else
                  chek:= 'F';
                ListadoPerfiles.Cells[5,ListadoPerfiles.RowCount-1]:= chek;
                if BoolToStr(Registro.Hab_BackUp) = '-1' then
                  chek:= 'T'
                else
                  chek:= 'F';
                ListadoPerfiles.Cells[6,ListadoPerfiles.RowCount-1]:= chek;
                if BoolToStr(Registro.Hab_Restore) = '-1' then
                  chek:= 'T'
                else
                  chek:= 'F';
                ListadoPerfiles.Cells[7,ListadoPerfiles.RowCount-1]:= chek;
       end;
      pos_Perfil:= succ(pos_Perfil);
    end;
end;


procedure TFPerfiles.BGuardarPerfilClick(Sender: TObject);
var
  Registro: Registro_Perfil;
  Reg_Aud: Registro_Aud_Perfil_Nuevo;
  chek: string[1];
begin
  Registro.Nombre:= ENombrePerfil.Text;
  Registro.Hab_Clientes:= HabilitarClientes.Checked;
  Registro.Hab_Provincias:= HabilitarProvincias.Checked;
  Registro.Hab_Auditoria:= HabilitarAuditoria.Checked;
  Registro.Hab_Usuarios:= HabilitarUsuarios.Checked;
  Registro.Hab_Perfiles:= HabilitarPerfiles.Checked;
  Registro.Hab_BackUp:= HabilitarPerfiles.Checked;
  Registro.Hab_Restore:= HabilitarPerfiles.Checked;
  if (ENombrePerfil.Text <> '') then
    begin
      if Perfiles.Buscar(Registro.Nombre,pos_Perfil,true) = false then
        begin
          Perfiles.Insertar(Registro,pos_Perfil);

          //Auditoria
          Reg_Aud.Perfil.id:= pos_Perfil;
          Reg_Aud.Perfil.Borrado:= Registro.Borrado;
          Reg_Aud.Tipo_Operacion:= 'A';
          Reg_Aud.Perfil.Nombre:= Registro.Nombre;
          Reg_Aud.Perfil.Hab_CLientes:= Registro.Hab_Clientes;
          Reg_Aud.Perfil.Hab_Provincias:= Registro.Hab_Provincias;
          Reg_Aud.Perfil.Hab_Auditoria:= Registro.Hab_Auditoria;
          Reg_Aud.Perfil.Hab_Usuarios:= Registro.Hab_Usuarios;
          Reg_Aud.Perfil.Hab_Perfiles:= Registro.Hab_Perfiles;
          Reg_Aud.Perfil.Hab_BackUp:= Registro.Hab_BackUp;
          Reg_Aud.Perfil.Hab_Restore:= Registro.Hab_Restore;
          Reg_Aud.id_Aud_Perfil:= Aud_Perfiles.Ultimo + 1;
          Reg_Aud.Borrado:= false;
          Reg_Aud.Nick:= FIngreso.usuario;
          Reg_Aud.Terminal:= FPrincipal.IP;
          Reg_Aud.Fecha:= datetostr(now);
          Reg_Aud.Hora:= timetostr(now);
          Aud_Perfiles.Insertar(Reg_Aud,Reg_Aud.id_Aud_Perfil);

          pos_Perfil:= 0;
          ENombrePerfil.Clear;
          ENombrePerfil.SetFocus;
          HabilitarClientes.Checked:= false;
          HabilitarProvincias.Checked:= false;
          HabilitarAuditoria.Checked:= false;
          HabilitarUsuarios.Checked:= false;
          HabilitarPerfiles.Checked:= false;
          HabilitarBackUp.Checked:= false;
          HabilitarRestore.Checked:= false;
          ListadoPerfiles.RowCount:= 1;
          while pos_Perfil < Perfiles.Ultimo do
            begin
              Perfiles.Capturar(Registro,pos_Perfil);
              if Registro.Borrado = false then
               begin
                ListadoPerfiles.RowCount:= ListadoPerfiles.RowCount + 1;
                ListadoPerfiles.Cells[0,ListadoPerfiles.RowCount-1]:= Registro.Nombre;
                if BoolToStr(Registro.Hab_Clientes) = '-1' then
                  chek:= 'T'
                else
                  chek:= 'F';
                ListadoPerfiles.Cells[1,ListadoPerfiles.RowCount-1]:= chek;
                if BoolToStr(Registro.Hab_Provincias) = '-1' then
                  chek:= 'T'
                else
                  chek:= 'F';
                ListadoPerfiles.Cells[2,ListadoPerfiles.RowCount-1]:= chek;
                if BoolToStr(Registro.Hab_Auditoria) = '-1' then
                  chek:= 'T'
                else
                  chek:= 'F';
                ListadoPerfiles.Cells[3,ListadoPerfiles.RowCount-1]:= chek;
                if BoolToStr(Registro.Hab_Usuarios) = '-1' then
                  chek:= 'T'
                else
                  chek:= 'F';
                ListadoPerfiles.Cells[4,ListadoPerfiles.RowCount-1]:= chek;
                if BoolToStr(Registro.Hab_Perfiles) = '-1' then
                  chek:= 'T'
                else
                  chek:= 'F';
                ListadoPerfiles.Cells[5,ListadoPerfiles.RowCount-1]:= chek;
                if BoolToStr(Registro.Hab_BackUp) = '-1' then
                  chek:= 'T'
                else
                  chek:= 'F';
                ListadoPerfiles.Cells[6,ListadoPerfiles.RowCount-1]:= chek;
                if BoolToStr(Registro.Hab_Restore) = '-1' then
                  chek:= 'T'
                else
                  chek:= 'F';
                ListadoPerfiles.Cells[7,ListadoPerfiles.RowCount-1]:= chek;
               end;
              pos_Perfil:= succ(pos_Perfil);
            end;
        end
      else
        begin
          showmessage('El Nombre ya existe');
          ENombrePerfil.Clear;
          ENombrePerfil.SetFocus;
        end;
    end
  else
    begin
      if (ENombrePerfil.Text = '') then
        begin
          showmessage('Ingrese el nombre del perfil');
          ENombrePerfil.Clear;
          ENombrePerfil.SetFocus;
        end
    end;
end;


procedure TFPerfiles.BModificarPerfilClick(Sender: TObject);
var
  Registro: Registro_Perfil;
begin
  if EModificarPerfil.Text <> '' then
    begin
      Registro.Nombre:= EModificarPerfil.Text;
      if Perfiles.Buscar(Registro.Nombre,pos_Perfil,true) then
        begin
          Perfiles.Capturar(Registro,pos_Perfil);

          //Auditoria
          Reg_Aud_Aux.Perfil.id:= pos_Perfil;
          Reg_Aud_Aux.Perfil.Borrado:= Registro.Borrado;
          Reg_Aud_Aux.Tipo_Operacion:= 'M';
          Reg_Aud_Aux.Perfil.Nombre:= Registro.Nombre;
          Reg_Aud_Aux.Perfil.Hab_CLientes:= Registro.Hab_Clientes;
          Reg_Aud_Aux.Perfil.Hab_Provincias:= Registro.Hab_Provincias;
          Reg_Aud_Aux.Perfil.Hab_Auditoria:= Registro.Hab_Auditoria;
          Reg_Aud_Aux.Perfil.Hab_Usuarios:= Registro.Hab_Usuarios;
          Reg_Aud_Aux.Perfil.Hab_Perfiles:= Registro.Hab_Perfiles;
          Reg_Aud_Aux.Perfil.Hab_BackUp:= Registro.Hab_BackUp;
          Reg_Aud_Aux.Perfil.Hab_Restore:= Registro.Hab_Restore;
          Reg_Aud_Aux.id_Aud_Perfil:= Aud_Perfiles.Ultimo + 1;
          Reg_Aud_Aux.Borrado:= false;
          Reg_Aud_Aux.Nick:= FIngreso.usuario;
          Reg_Aud_Aux.Terminal:= FPrincipal.IP;

          ENombrePerfil.Text:= Registro.Nombre;
          HabilitarClientes.Checked:= Registro.Hab_Clientes;
          HabilitarProvincias.Checked:= Registro.Hab_Provincias;
          HabilitarAuditoria.Checked:= Registro.Hab_Auditoria;
          HabilitarUsuarios.Checked:= Registro.Hab_Usuarios;
          HabilitarPerfiles.Checked:= Registro.Hab_Perfiles;
          HabilitarBackUp.Checked:= Registro.Hab_BackUp;
          HabilitarRestore.Checked:= Registro.Hab_Restore;
          BGuardarPerfil.Enabled:= false;
          BGuardarPerfil.Visible:= false;
          BGuardarModPerfil.Enabled:= True;
          BGuardarModPerfil.Visible:= True;
          BCancelarPerfil.Enabled:= True;
          BCancelarPerfil.Visible:= True;
        end
      else
        begin
          showmessage('Ingrese un nombre correcto');
          EModificarPerfil.Clear;
          EModificarPerfil.SetFocus;
        end;
    end
  else
    showmessage('Ingrese un nombre');
end;

procedure TFPerfiles.BGuardarModPerfilClick(Sender: TObject);
var
  Registro: Registro_Perfil;
  Reg_aux: Registro_Perfil;
  Reg_Aud: Registro_Aud_Perfil_Nuevo;
  pos_aux: Tipo_Posicion;
  chek: string[1];
begin
  //Auditoria
  Reg_Aud_Aux.Fecha:= datetostr(now);
  Reg_Aud_Aux.Hora:= timetostr(now);
  Aud_Perfiles.Insertar(Reg_Aud_Aux,Aud_Perfiles.Ultimo+1);

  Perfiles.Capturar(Reg_aux,pos_Perfil);
  Registro.Nombre:= ENombrePerfil.Text;
  Registro.Hab_Clientes:= HabilitarClientes.Checked;
  Registro.Hab_Provincias:= HabilitarProvincias.Checked;
  Registro.Hab_Auditoria:= HabilitarAuditoria.Checked;
  Registro.Hab_Usuarios:= HabilitarUsuarios.Checked;
  Registro.Hab_Perfiles:= HabilitarPerfiles.Checked;
  Registro.Hab_BackUp:= HabilitarBackUp.Checked;
  Registro.Hab_Restore:= HabilitarRestore.Checked;
  if (ENombrePerfil.Text <> '') then
    begin
      if Registro.Nombre = Reg_Aux.Nombre then
        begin
          Perfiles.Modificar(Registro,pos_Perfil);

          //Auditoria
          Reg_Aud.Perfil.id:= pos_Perfil;
          Reg_Aud.Perfil.Borrado:= Registro.Borrado;
          Reg_Aud.Tipo_Operacion:= 'M';
          Reg_Aud.Perfil.Nombre:= Registro.Nombre;
          Reg_Aud.Perfil.Hab_CLientes:= Registro.Hab_Clientes;
          Reg_Aud.Perfil.Hab_Provincias:= Registro.Hab_Provincias;
          Reg_Aud.Perfil.Hab_Auditoria:= Registro.Hab_Auditoria;
          Reg_Aud.Perfil.Hab_Usuarios:= Registro.Hab_Usuarios;
          Reg_Aud.Perfil.Hab_Perfiles:= Registro.Hab_Perfiles;
          Reg_Aud.Perfil.Hab_BackUp:= Registro.Hab_BackUp;
          Reg_Aud.Perfil.Hab_Restore:= Registro.Hab_Restore;
          Reg_Aud.id_Aud_Perfil:= Aud_Perfiles.Ultimo + 1;
          Reg_Aud.Borrado:= false;
          Reg_Aud.Nick:= FIngreso.usuario;
          Reg_Aud.Terminal:= FPrincipal.IP;
          Reg_Aud.Fecha:= datetostr(now);
          Reg_Aud.Hora:= timetostr(now);
          Aud_Perfiles.Insertar(Reg_Aud,Reg_Aud.id_Aud_Perfil);

          BGuardarPerfil.Enabled:= true;
          BGuardarPerfil.Visible:= true;
          BGuardarModPerfil.Enabled:= False;
          BGuardarModPerfil.Visible:= False;
          BCancelarPerfil.Enabled:= False;
          BCancelarPerfil.Visible:= False;
          ENombrePerfil.Clear;
          ENombrePerfil.Enabled:= true;
          HabilitarClientes.Checked:= false;
          HabilitarProvincias.Checked:= false;
          HabilitarAuditoria.Checked:= false;
          HabilitarUsuarios.Checked:= false;
          HabilitarPerfiles.Checked:= false;
          HabilitarBackUp.Checked:= false;
          HabilitarRestore.Checked:= false;
          EModificarPerfil.Clear;
          ListadoPerfiles.RowCount:= 1;
          pos_Perfil:= 0;
          while pos_Perfil < Perfiles.Ultimo do
            begin
              Perfiles.Capturar(Registro,pos_Perfil);
              if Registro.Borrado = false then
               begin
                ListadoPerfiles.RowCount:= ListadoPerfiles.RowCount + 1;
                ListadoPerfiles.Cells[0,ListadoPerfiles.RowCount-1]:= Registro.Nombre;
                if BoolToStr(Registro.Hab_Clientes) = '-1' then
                  chek:= 'T'
                else
                  chek:= 'F';
                ListadoPerfiles.Cells[1,ListadoPerfiles.RowCount-1]:= chek;
                if BoolToStr(Registro.Hab_Provincias) = '-1' then
                  chek:= 'T'
                else
                  chek:= 'F';
                ListadoPerfiles.Cells[2,ListadoPerfiles.RowCount-1]:= chek;
                if BoolToStr(Registro.Hab_Auditoria) = '-1' then
                  chek:= 'T'
                else
                  chek:= 'F';
                ListadoPerfiles.Cells[3,ListadoPerfiles.RowCount-1]:= chek;
                if BoolToStr(Registro.Hab_Usuarios) = '-1' then
                  chek:= 'T'
                else
                  chek:= 'F';
                ListadoPerfiles.Cells[4,ListadoPerfiles.RowCount-1]:= chek;
                if BoolToStr(Registro.Hab_Perfiles) = '-1' then
                  chek:= 'T'
                else
                  chek:= 'F';
                ListadoPerfiles.Cells[5,ListadoPerfiles.RowCount-1]:= chek;
                if BoolToStr(Registro.Hab_BackUp) = '-1' then
                  chek:= 'T'
                else
                  chek:= 'F';
                ListadoPerfiles.Cells[6,ListadoPerfiles.RowCount-1]:= chek;
                if BoolToStr(Registro.Hab_Restore) = '-1' then
                  chek:= 'T'
                else
                  chek:= 'F';
                ListadoPerfiles.Cells[7,ListadoPerfiles.RowCount-1]:= chek;
               end;
              pos_Perfil:= succ(pos_Perfil);
            end;
        end
      else
        begin
          if Perfiles.Buscar(Registro.Nombre,pos_aux,true) = false then
            begin
              Perfiles.Modificar(Registro,pos_Perfil);

              //Auditoria
              Reg_Aud.Perfil.id:= pos_Perfil;
              Reg_Aud.Perfil.Borrado:= Registro.Borrado;
              Reg_Aud.Tipo_Operacion:= 'M';
              Reg_Aud.Perfil.Nombre:= Registro.Nombre;
              Reg_Aud.Perfil.Hab_CLientes:= Registro.Hab_Clientes;
              Reg_Aud.Perfil.Hab_Provincias:= Registro.Hab_Provincias;
              Reg_Aud.Perfil.Hab_Auditoria:= Registro.Hab_Auditoria;
              Reg_Aud.Perfil.Hab_Usuarios:= Registro.Hab_Usuarios;
              Reg_Aud.Perfil.Hab_Perfiles:= Registro.Hab_Perfiles;
              Reg_Aud.Perfil.Hab_BackUp:= Registro.Hab_BackUp;
              Reg_Aud.Perfil.Hab_Restore:= Registro.Hab_Restore;
              Reg_Aud.id_Aud_Perfil:= Aud_Perfiles.Ultimo + 1;
              Reg_Aud.Borrado:= false;
              Reg_Aud.Nick:= FIngreso.usuario;
              Reg_Aud.Terminal:= FPrincipal.IP;
              Reg_Aud.Fecha:= datetostr(now);
              Reg_Aud.Hora:= timetostr(now);
              Aud_Perfiles.Insertar(Reg_Aud,Reg_Aud.id_Aud_Perfil);

              BGuardarPerfil.Enabled:= true;
              BGuardarPerfil.Visible:= true;
              BGuardarModPerfil.Enabled:= False;
              BGuardarModPerfil.Visible:= False;
              BCancelarPerfil.Enabled:= False;
              BCancelarPerfil.Visible:= False;
              ENombrePerfil.Clear;
              ENombrePerfil.Enabled:= true;
              HabilitarClientes.Checked:= false;
              HabilitarProvincias.Checked:= false;
              HabilitarAuditoria.Checked:= false;
              HabilitarUsuarios.Checked:= false;
              HabilitarPerfiles.Checked:= false;
              HabilitarBackUp.Checked:= false;
              HabilitarRestore.Checked:= false;
              EModificarPerfil.Clear;
              ListadoPerfiles.RowCount:= 1;
              pos_Perfil:= 0;
              while pos_Perfil < Perfiles.Ultimo do
                begin
                  Perfiles.Capturar(Registro,pos_Perfil);
                  if Registro.Borrado = false then
                  begin
                    ListadoPerfiles.RowCount:= ListadoPerfiles.RowCount + 1;
                    ListadoPerfiles.Cells[0,ListadoPerfiles.RowCount-1]:= Registro.Nombre;
                    if BoolToStr(Registro.Hab_Clientes) = '-1' then
                      chek:= 'T'
                    else
                      chek:= 'F';
                    ListadoPerfiles.Cells[1,ListadoPerfiles.RowCount-1]:= chek;
                    if BoolToStr(Registro.Hab_Provincias) = '-1' then
                      chek:= 'T'
                    else
                      chek:= 'F';
                    ListadoPerfiles.Cells[2,ListadoPerfiles.RowCount-1]:= chek;
                    if BoolToStr(Registro.Hab_Auditoria) = '-1' then
                      chek:= 'T'
                    else
                      chek:= 'F';
                    ListadoPerfiles.Cells[3,ListadoPerfiles.RowCount-1]:= chek;
                    if BoolToStr(Registro.Hab_Usuarios) = '-1' then
                      chek:= 'T'
                    else
                      chek:= 'F';
                    ListadoPerfiles.Cells[4,ListadoPerfiles.RowCount-1]:= chek;
                    if BoolToStr(Registro.Hab_Perfiles) = '-1' then
                      chek:= 'T'
                    else
                      chek:= 'F';
                    ListadoPerfiles.Cells[5,ListadoPerfiles.RowCount-1]:= chek;
                    if BoolToStr(Registro.Hab_BackUp) = '-1' then
                      chek:= 'T'
                    else
                      chek:= 'F';
                    ListadoPerfiles.Cells[6,ListadoPerfiles.RowCount-1]:= chek;
                    if BoolToStr(Registro.Hab_Restore) = '-1' then
                      chek:= 'T'
                    else
                      chek:= 'F';
                    ListadoPerfiles.Cells[7,ListadoPerfiles.RowCount-1]:= chek;
                    end;
                  pos_Perfil:= succ(pos_Perfil);
                end;
            end
          else
            begin
              showmessage('El nombre ya existe');
              ENombrePerfil.Text:= reg_aux.Nombre;
              ENombrePerfil.SetFocus;
            end;
        end;
    end
  else
    begin
      if (ENombrePerfil.Text = '') then
        begin
          showmessage('Ingrese un nombre');
          ENombrePerfil.Clear;
          ENombrePerfil.SetFocus;
        end;
    end;
end;

procedure TFPerfiles.BCancelarPerfilClick(Sender: TObject);
begin
  BGuardarPerfil.Enabled:= true;
  BGuardarPerfil.Visible:= true;
  BGuardarModPerfil.Enabled:= False;
  BGuardarModPerfil.Visible:= False;
  BCancelarPerfil.Enabled:= False;
  BCancelarPerfil.Visible:= False;
  ENombrePerfil.Clear;
  HabilitarClientes.Checked:= false;
  HabilitarProvincias.Checked:= false;
  HabilitarAuditoria.Checked:= false;
  HabilitarUsuarios.Checked:= false;
  HabilitarPerfiles.Checked:= false;
  HabilitarBackUp.Checked:= false;
  HabilitarRestore.Checked:= false;
  EModificarPerfil.Clear;
end;

procedure TFPerfiles.BBorrarPerfilClick(Sender: TObject);
var
  Registro: Registro_Perfil;
  Reg_Aud: Registro_Aud_Perfil_Nuevo;
  pos_Usuario: Tipo_Posicion; 
  chek: string[1];
begin
  if EModificarPerfil.Text <> '' then
    begin
      Registro.Nombre:= EModificarPerfil.Text;
      if Perfiles.Buscar(Registro.Nombre,pos_Perfil,false) then
        begin
          if Usuarios.Buscar_Usuario_Perfil(pos_Perfil,pos_Usuario) = False then
           begin
            if messagedlg('¿Estas seguro de eliminar?',mtConfirmation,[mbYes, mbNo], 0) = mrYes then
              begin
                Perfiles.Eliminar(pos_Perfil);

                //Auditoria
                Perfiles.Capturar(Registro,pos_Perfil);
                Reg_Aud.Perfil.id:= pos_Perfil;
                Reg_Aud.Perfil.Borrado:= Registro.Borrado;
                Reg_Aud.Tipo_Operacion:= 'B';
                Reg_Aud.Perfil.Nombre:= Registro.Nombre;
                Reg_Aud.Perfil.Hab_CLientes:= Registro.Hab_Clientes;
                Reg_Aud.Perfil.Hab_Provincias:= Registro.Hab_Provincias;
                Reg_Aud.Perfil.Hab_Auditoria:= Registro.Hab_Auditoria;
                Reg_Aud.Perfil.Hab_Usuarios:= Registro.Hab_Usuarios;
                Reg_Aud.Perfil.Hab_Perfiles:= Registro.Hab_Perfiles;
                Reg_Aud.Perfil.Hab_BackUp:= Registro.Hab_BackUp;
                Reg_Aud.Perfil.Hab_Restore:= Registro.Hab_Restore;
                Reg_Aud.id_Aud_Perfil:= Aud_Perfiles.Ultimo + 1;
                Reg_Aud.Borrado:= false;
                Reg_Aud.Nick:= FIngreso.usuario;
                Reg_Aud.Terminal:= FPrincipal.IP;
                Reg_Aud.Fecha:= datetostr(now);
                Reg_Aud.Hora:= timetostr(now);
                Aud_Perfiles.Insertar(Reg_Aud,Reg_Aud.id_Aud_Perfil);

                pos_Perfil:= 0;
                ListadoPerfiles.RowCount:= 1;
                EModificarPerfil.Clear;
                while pos_Perfil < Perfiles.Ultimo do
                begin
                  Perfiles.Capturar(Registro,pos_Perfil);
                  if Registro.Borrado = false then
                   begin
                    ListadoPerfiles.RowCount:= ListadoPerfiles.RowCount + 1;
                    ListadoPerfiles.Cells[0,ListadoPerfiles.RowCount-1]:= Registro.Nombre;
                    if BoolToStr(Registro.Hab_Clientes) = '-1' then
                      chek:= 'T'
                    else
                      chek:= 'F';
                    ListadoPerfiles.Cells[1,ListadoPerfiles.RowCount-1]:= chek;
                    if BoolToStr(Registro.Hab_Provincias) = '-1' then
                      chek:= 'T'
                    else
                      chek:= 'F';
                    ListadoPerfiles.Cells[2,ListadoPerfiles.RowCount-1]:= chek;
                    if BoolToStr(Registro.Hab_Auditoria) = '-1' then
                      chek:= 'T'
                    else
                      chek:= 'F';
                    ListadoPerfiles.Cells[3,ListadoPerfiles.RowCount-1]:= chek;
                    if BoolToStr(Registro.Hab_Usuarios) = '-1' then
                      chek:= 'T'
                    else
                      chek:= 'F';
                    ListadoPerfiles.Cells[4,ListadoPerfiles.RowCount-1]:= chek;
                    if BoolToStr(Registro.Hab_Perfiles) = '-1' then
                      chek:= 'T'
                    else
                      chek:= 'F';
                    ListadoPerfiles.Cells[5,ListadoPerfiles.RowCount-1]:= chek;
                    if BoolToStr(Registro.Hab_BackUp) = '-1' then
                      chek:= 'T'
                    else
                      chek:= 'F';
                    ListadoPerfiles.Cells[6,ListadoPerfiles.RowCount-1]:= chek;
                    if BoolToStr(Registro.Hab_Restore) = '-1' then
                      chek:= 'T'
                    else
                      chek:= 'F';
                    ListadoPerfiles.Cells[7,ListadoPerfiles.RowCount-1]:= chek;
                   end;
                   pos_Perfil:= succ(pos_Perfil);
                  end;
              end;
             end
            else
              begin
                showmessage('El perfil tiene usuarios asociados. No es posible eliminar');
                EModificarPerfil.Clear;
              end;
        end
      else
        begin
          showmessage('Ingrese un nombre correcto');
          EModificarPerfil.Clear;
          EModificarPerfil.SetFocus;
        end;
    end
  else
    showmessage('Ingrese un nombre');
end;

end.
