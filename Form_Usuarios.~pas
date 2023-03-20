unit Form_Usuarios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Sistema_ABM, Unidad_Usuarios, Unidad_Perfiles, Unidad_Aud_Usuarios;

type
  TFUsuarios = class(TForm)
    Label4: TLabel;
    BSalirUsuarios: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    ENickUsuario: TEdit;
    EContrasenaUsuario: TEdit;
    BGuardarUsuario: TButton;
    BGuardarModUsuario: TButton;
    BCancelarUsuario: TButton;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    EModificarUsuario: TEdit;
    BModificarUsuario: TButton;
    BBorrarUsuario: TButton;
    ListadoUsuarios: TStringGrid;
    CBPerfil: TComboBox;
    Label5: TLabel;
    Label7: TLabel;
    UsuarioRegistrado: TLabel;
    Label8: TLabel;
    NombreEmpresa: TLabel;
    procedure BSalirUsuariosClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BGuardarUsuarioClick(Sender: TObject);
    procedure BModificarUsuarioClick(Sender: TObject);
    procedure BGuardarModUsuarioClick(Sender: TObject);
    procedure BCancelarUsuarioClick(Sender: TObject);
    procedure BBorrarUsuarioClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FUsuarios: TFUsuarios;
  Usuarios: Modelo_Usuario;
  Perfiles: Modelo_Perfil;
  Aud_Usuarios: Modelo_Aud_Usuario;
  Reg_Aud_Aux: Registro_Aud_Usuario_Nuevo;
  pos_Usuario, pos_Perfil: Tipo_Posicion;

implementation

uses Form_Ingreso;

{$R *.dfm}

procedure TFUsuarios.BSalirUsuariosClick(Sender: TObject);
begin
  Close;
  FPrincipal.Visible:= true;
end;


procedure TFUsuarios.FormActivate(Sender: TObject);
var
  Reg_Usuario: Registro_Usuario;
  Reg_Perfil: Registro_Perfil;
begin
  Perfiles:= Modelo_Perfil.Create(FIngreso.c_Ruta,'Perfiles');
  Usuarios:= Modelo_Usuario.Create(FIngreso.c_Ruta,'Usuarios');
  Perfiles.Abrir;
  Usuarios.Abrir;
  Aud_Usuarios:= Modelo_Aud_Usuario.Create(FIngreso.c_Ruta,'Auditoria_Usuarios');
  Aud_Usuarios.Abrir;
  ENickUsuario.Clear;
  EContrasenaUsuario.Clear;
  CBPerfil.Clear;
  ListadoUsuarios.RowCount:= 1;
  ListadoUsuarios.ColCount:= 4;
  ListadoUsuarios.Cells[0,0]:= 'Usuario';
  ListadoUsuarios.Cells[1,0]:= 'Contraseña';
  ListadoUsuarios.Cells[2,0]:= 'Perfil';
  ListadoUsuarios.Cells[3,0]:= 'ID';
  ListadoUsuarios.ColWidths[0]:= 125;
  ListadoUsuarios.ColWidths[1]:= 125;
  ListadoUsuarios.ColWidths[2]:= 100;
  ListadoUsuarios.ColWidths[3]:= 30;
  BGuardarModUsuario.Enabled:= False;
  BGuardarModUsuario.Visible:= False;
  BCancelarUsuario.Enabled:= False;
  BCancelarUsuario.Visible:= False;
  pos_Usuario:= 0;
  while pos_Usuario < Usuarios.Ultimo do
    begin
      Usuarios.Capturar(Reg_Usuario,pos_Usuario);
      pos_Perfil:= Reg_Usuario.Perfil;
      Perfiles.Capturar(Reg_Perfil,Reg_Usuario.Perfil);
      if Reg_Usuario.Borrado = false then
       begin
        ListadoUsuarios.RowCount:= ListadoUsuarios.RowCount + 1;
        ListadoUsuarios.Cells[0,ListadoUsuarios.RowCount-1]:= Reg_Usuario.Nick;
        ListadoUsuarios.Cells[1,ListadoUsuarios.RowCount-1]:= Reg_Usuario.Contrasena;
        ListadoUsuarios.Cells[2,ListadoUsuarios.RowCount-1]:= Reg_Perfil.Nombre;
        ListadoUsuarios.Cells[3,ListadoUsuarios.RowCount-1]:= inttostr(Reg_Usuario.id);
       end;
      pos_Usuario:= succ(pos_Usuario);
    end;

  pos_Perfil:= 0;
  while pos_Perfil < Perfiles.Ultimo do
    begin
      Perfiles.Capturar(Reg_Perfil,pos_Perfil);
      if Reg_Perfil.Borrado = false then
        CBPerfil.Items.Add(Reg_Perfil.Nombre);
      pos_Perfil:= succ(pos_Perfil);
    end;
end;

procedure TFUsuarios.BGuardarUsuarioClick(Sender: TObject);
var
  Reg_Usuario: Registro_Usuario;
  Reg_Aud: Registro_Aud_Usuario_Nuevo;
  Reg_Perfil: Registro_Perfil;
begin
  Reg_Usuario.Nick:= ENickUsuario.Text;
  Reg_Usuario.Contrasena:= EContrasenaUsuario.Text;
  Reg_Usuario.Perfil:= CBPerfil.ItemIndex;
  if ((ENickUsuario.Text <> '') and (EContrasenaUsuario.Text <> '')
          and (CBPerfil.ItemIndex <> -1)) then
    begin
      if Usuarios.Buscar(Reg_Usuario.Nick,pos_Usuario,true) = false then
        begin
          Usuarios.Insertar(Reg_Usuario,pos_Usuario);

          //Auditoria
          Reg_Aud.Usuario.id:= pos_Usuario;
          Reg_Aud.Usuario.Borrado:= Reg_Usuario.Borrado;
          Reg_Aud.Tipo_Operacion:= 'A';
          Reg_Aud.Usuario.Nick:= Reg_Usuario.Nick;
          Reg_Aud.Usuario.Contrasena:= Reg_Usuario.Contrasena;
          Reg_Aud.Usuario.Perfil:= Reg_Usuario.Perfil;
          Reg_Aud.id_Aud_Usuario:= Aud_Usuarios.Ultimo + 1;
          Reg_Aud.Borrado:= false;
          Reg_Aud.Nick:= FIngreso.usuario;
          Reg_Aud.Terminal:= FPrincipal.IP;
          Reg_Aud.Fecha:= datetostr(now);
          Reg_Aud.Hora:= timetostr(now);
          Aud_Usuarios.Insertar(Reg_Aud,Reg_Aud.id_Aud_Usuario);

          pos_Usuario:= 0;
          ENickUsuario.Clear;
          ENickUsuario.SetFocus;
          EContrasenaUsuario.Clear;
          CBPerfil.ItemIndex:= -1;
          ListadoUsuarios.RowCount:= 1;
          while pos_Usuario < Usuarios.Ultimo do
            begin
              Usuarios.Capturar(Reg_Usuario,pos_Usuario);
              pos_Perfil:= Reg_Usuario.Perfil;
              Perfiles.Capturar(Reg_Perfil,pos_Perfil);
              if Reg_Usuario.Borrado = false then
               begin
                ListadoUsuarios.RowCount:= ListadoUsuarios.RowCount + 1;
                ListadoUsuarios.Cells[0,ListadoUsuarios.RowCount-1]:= Reg_Usuario.Nick;
                ListadoUsuarios.Cells[1,ListadoUsuarios.RowCount-1]:= Reg_Usuario.Contrasena;
                ListadoUsuarios.Cells[2,ListadoUsuarios.RowCount-1]:= Reg_Perfil.Nombre;
                ListadoUsuarios.Cells[3,ListadoUsuarios.RowCount-1]:= inttostr(Reg_Usuario.id);
               end;
              pos_Usuario:= succ(pos_Usuario);
            end;
        end
      else
        begin
          showmessage('El nombre de usuario ya existe');
          ENickUsuario.Clear;
          ENickUsuario.SetFocus;
        end;
    end
  else
    begin
      if (ENickUsuario.Text = '') then
        begin
          showmessage('Ingrese un nombre de usuario');
          ENickUsuario.Clear;
          ENickUsuario.SetFocus;
        end
      else
        begin
          if (EContrasenaUsuario.Text = '') then
            begin
              showmessage('Ingrese una contraseña');
              EContrasenaUsuario.Clear;
              EContrasenaUsuario.SetFocus;
            end
          else
            begin
              if (CBPerfil.ItemIndex <> -1) then
                begin
                  showmessage('Ingrese un tipo de perfil');
                  CBPerfil.ItemIndex:= -1;
                  CBPerfil.SetFocus;
                end;
            end;
        end;
    end;
end;

procedure TFUsuarios.BModificarUsuarioClick(Sender: TObject);
var
  Reg_Usuario: Registro_Usuario;
begin
  if EModificarUsuario.Text <> '' then
    begin
      Reg_Usuario.Nick:= EModificarUsuario.Text;
      if Usuarios.Buscar(Reg_Usuario.Nick,pos_Usuario,true) then
        begin
          Usuarios.Capturar(Reg_Usuario,pos_Usuario);

          //Auditoria
          Reg_Aud_Aux.Usuario.id:= pos_Usuario;
          Reg_Aud_Aux.Usuario.Borrado:= Reg_Usuario.Borrado;
          Reg_Aud_Aux.Tipo_Operacion:= 'M';
          Reg_Aud_Aux.Usuario.Nick:= Reg_Usuario.Nick;
          Reg_Aud_Aux.Usuario.Contrasena:= Reg_Usuario.Contrasena;
          Reg_Aud_Aux.Usuario.Perfil:= Reg_Usuario.Perfil;
          Reg_Aud_Aux.id_Aud_Usuario:= Aud_Usuarios.Ultimo + 1;
          Reg_Aud_Aux.Borrado:= false;
          Reg_Aud_Aux.Nick:= FIngreso.usuario;
          Reg_Aud_Aux.Terminal:= FPrincipal.IP;

          ENickUsuario.Text:= Reg_Usuario.Nick;
          EContrasenaUsuario.Text:= Reg_Usuario.Contrasena;
          CBPerfil.ItemIndex:= Reg_Usuario.Perfil;
          BGuardarUsuario.Enabled:= false;
          BGuardarUsuario.Visible:= false;
          BGuardarModUsuario.Enabled:= True;
          BGuardarModUsuario.Visible:= True;
          BCancelarUsuario.Enabled:= True;
          BCancelarUsuario.Visible:= True;
        end
      else
        begin
          showmessage('Ingrese un nombre de usuario correcto');
          EModificarUsuario.Clear;
          EModificarUsuario.SetFocus;
        end;
    end
  else
    showmessage('Ingrese un nombre de usuario');
end;

procedure TFUsuarios.BGuardarModUsuarioClick(Sender: TObject);
var
  Reg_Usuario: Registro_Usuario;
  Reg_Perfil: Registro_Perfil;
  Reg_aux: Registro_Usuario;
  Reg_Aud: Registro_Aud_Usuario_Nuevo;
  pos_aux: Tipo_Posicion;
begin
  //Auditoria
  Reg_Aud_Aux.Fecha:= datetostr(now);
  Reg_Aud_Aux.Hora:= timetostr(now);
  Aud_Usuarios.Insertar(Reg_Aud_Aux,Aud_Usuarios.Ultimo+1);

  Usuarios.Capturar(Reg_aux,pos_Usuario);
  Reg_Usuario.Nick:= ENickUsuario.Text;
  Reg_Usuario.Contrasena:= EContrasenaUsuario.Text;
  Reg_Usuario.Perfil:= CBPerfil.ItemIndex;
  if ((ENickUsuario.Text <> '') and (EContrasenaUsuario.Text <> '')
          and (CBPerfil.ItemIndex <> -1)) then
    begin
      if Reg_Usuario.Nick = Reg_Aux.Nick then
        begin
          Usuarios.Modificar(Reg_Usuario,pos_Usuario);

          //Auditoria
          Reg_Aud.Usuario.id:= pos_Usuario;
          Reg_Aud.Usuario.Borrado:= Reg_Usuario.Borrado;
          Reg_Aud.Tipo_Operacion:= 'M';
          Reg_Aud.Usuario.Nick:= Reg_Usuario.Nick;
          Reg_Aud.Usuario.Contrasena:= Reg_Usuario.Contrasena;
          Reg_Aud.Usuario.Perfil:= Reg_Usuario.Perfil;
          Reg_Aud.id_Aud_Usuario:= Aud_Usuarios.Ultimo + 1;
          Reg_Aud.Borrado:= false;
          Reg_Aud.Nick:= FIngreso.usuario;
          Reg_Aud.Terminal:= FPrincipal.IP;
          Reg_Aud.Fecha:= datetostr(now);
          Reg_Aud.Hora:= timetostr(now);
          Aud_Usuarios.Insertar(Reg_Aud,Reg_Aud.id_Aud_Usuario);

          BGuardarUsuario.Enabled:= True;
          BGuardarUsuario.Visible:= True;
          BGuardarModUsuario.Enabled:= False;
          BGuardarModUsuario.Visible:= False;
          BCancelarUsuario.Enabled:= False;
          BCancelarUsuario.Visible:= False;
          ENickUsuario.Clear;
          EContrasenaUsuario.Clear;
          CBPerfil.ItemIndex:= -1;
          EModificarUsuario.Clear;
          pos_Usuario:= 0;
          ListadoUsuarios.RowCount:= 1;
          while pos_Usuario < Usuarios.Ultimo do
            begin
              Usuarios.Capturar(Reg_Usuario,pos_Usuario);
              pos_Perfil:= Reg_Usuario.Perfil;
              Perfiles.Capturar(Reg_Perfil,pos_Perfil);
              if Reg_Usuario.Borrado = false then
               begin
                ListadoUsuarios.RowCount:= ListadoUsuarios.RowCount + 1;
                ListadoUsuarios.Cells[0,ListadoUsuarios.RowCount-1]:= Reg_Usuario.Nick;
                ListadoUsuarios.Cells[1,ListadoUsuarios.RowCount-1]:= Reg_Usuario.Contrasena;
                ListadoUsuarios.Cells[2,ListadoUsuarios.RowCount-1]:= Reg_Perfil.Nombre;
                ListadoUsuarios.Cells[3,ListadoUsuarios.RowCount-1]:= inttostr(Reg_Usuario.id);
               end;
              pos_Usuario:= succ(pos_Usuario);
            end;
        end
      else
        begin
          if Usuarios.Buscar(Reg_Usuario.Nick,pos_aux,true) = false then
            begin
              Usuarios.Modificar(Reg_Usuario,pos_Usuario);

              //Auditoria
              Reg_Aud.Usuario.id:= pos_Usuario;
              Reg_Aud.Usuario.Borrado:= Reg_Usuario.Borrado;
              Reg_Aud.Tipo_Operacion:= 'M';
              Reg_Aud.Usuario.Nick:= Reg_Usuario.Nick;
              Reg_Aud.Usuario.Contrasena:= Reg_Usuario.Contrasena;
              Reg_Aud.Usuario.Perfil:= Reg_Usuario.Perfil;
              Reg_Aud.id_Aud_Usuario:= Aud_Usuarios.Ultimo + 1;
              Reg_Aud.Borrado:= false;
              Reg_Aud.Nick:= FIngreso.usuario;
              Reg_Aud.Terminal:= FPrincipal.IP;
              Reg_Aud.Fecha:= datetostr(now);
              Reg_Aud.Hora:= timetostr(now);
              Aud_Usuarios.Insertar(Reg_Aud,Reg_Aud.id_Aud_Usuario);

              BGuardarUsuario.Enabled:= True;
              BGuardarUsuario.Visible:= True;
              BGuardarModUsuario.Enabled:= False;
              BGuardarModUsuario.Visible:= False;
              BCancelarUsuario.Enabled:= False;
              BCancelarUsuario.Visible:= False;
              ENickUsuario.Clear;
              EContrasenaUsuario.Clear;
              CBPerfil.ItemIndex:= -1;
              EModificarUsuario.Clear;
              pos_Usuario:= 0;
              ListadoUsuarios.RowCount:= 1;
              while pos_Usuario < Usuarios.Ultimo do
                begin
                  Usuarios.Capturar(Reg_Usuario,pos_Usuario);
                  pos_Perfil:= Reg_Usuario.Perfil;
                  Perfiles.Capturar(Reg_Perfil,pos_Perfil);
                  if Reg_Usuario.Borrado = false then
                  begin
                    ListadoUsuarios.RowCount:= ListadoUsuarios.RowCount + 1;
                    ListadoUsuarios.Cells[0,ListadoUsuarios.RowCount-1]:= Reg_Usuario.Nick;
                    ListadoUsuarios.Cells[1,ListadoUsuarios.RowCount-1]:= Reg_Usuario.Contrasena;
                    ListadoUsuarios.Cells[2,ListadoUsuarios.RowCount-1]:= Reg_Perfil.Nombre;
                    ListadoUsuarios.Cells[3,ListadoUsuarios.RowCount-1]:= inttostr(Reg_Usuario.id);
                  end;
                  pos_Usuario:= succ(pos_Usuario);
                end;
            end
          else
            begin
              showmessage('El nombre de usuario ya existe');
              ENickUsuario.text:= Reg_Aux.Nick;
              ENickUsuario.SetFocus;
            end;
        end;
      end
    else
      begin
        if (ENickUsuario.Text = '') then
          begin
            showmessage('Ingrese un nombre de usuario');
            ENickUsuario.Clear;
            ENickUsuario.SetFocus;
          end
        else
          begin
            if (EContrasenaUsuario.Text = '') then
              begin
                showmessage('Ingrese una contraseña');
                EContrasenaUsuario.Clear;
                EContrasenaUsuario.SetFocus;
              end
            else
              begin
                if (CBPerfil.ItemIndex = -1) then
                  begin
                    showmessage('Seleccione un perfil');
                    CBPerfil.SetFocus;
                  end;
              end;
          end;
        end;
end;

procedure TFUsuarios.BCancelarUsuarioClick(Sender: TObject);
begin
  BGuardarUsuario.Enabled:= true;
  BGuardarUsuario.Visible:= true;
  BGuardarModUsuario.Enabled:= False;
  BGuardarModUsuario.Visible:= False;
  BCancelarUsuario.Enabled:= False;
  BCancelarUsuario.Visible:= False;
  ENickUsuario.Clear;
  EContrasenaUsuario.Clear;
  CBPerfil.ItemIndex:= -1;
  EModificarUsuario.Clear;
end;

procedure TFUsuarios.BBorrarUsuarioClick(Sender: TObject);
var
  Reg_Usuario: Registro_Usuario;
  Reg_Perfil: Registro_Perfil;
  Reg_Aud: Registro_Aud_Usuario_Nuevo;
begin
  if EModificarUsuario.Text <> '' then
    begin
      Reg_Usuario.Nick:= EModificarUsuario.Text;
      if Usuarios.Buscar(Reg_Usuario.Nick,pos_Usuario,false) then
        begin
          if messagedlg('¿Estas seguro de eliminar?',mtConfirmation,[mbYes, mbNo], 0) = mrYes then
            begin
              Usuarios.Eliminar(pos_Usuario);

              //Auditoria
              Usuarios.Capturar(Reg_Usuario,pos_Usuario);
              Reg_Aud.Usuario.id:= pos_Usuario;
              Reg_Aud.Usuario.Borrado:= Reg_Usuario.Borrado;
              Reg_Aud.Tipo_Operacion:= 'B';
              Reg_Aud.Usuario.Nick:= Reg_Usuario.Nick;
              Reg_Aud.Usuario.Contrasena:= Reg_Usuario.Contrasena;
              Reg_Aud.Usuario.Perfil:= Reg_Usuario.Perfil;
              Reg_Aud.id_Aud_Usuario:= Aud_Usuarios.Ultimo + 1;
              Reg_Aud.Borrado:= false;
              Reg_Aud.Nick:= FIngreso.usuario;
              Reg_Aud.Terminal:= FPrincipal.IP;
              Reg_Aud.Fecha:= datetostr(now);
              Reg_Aud.Hora:= timetostr(now);
              Aud_Usuarios.Insertar(Reg_Aud,Reg_Aud.id_Aud_Usuario);

              pos_Usuario:= 0;
              ListadoUsuarios.RowCount:= 1;
              EModificarUsuario.Clear;
              while pos_Usuario < Usuarios.Ultimo do
                begin
                  Usuarios.Capturar(Reg_Usuario,pos_Usuario);
                  pos_Perfil:= Reg_Usuario.Perfil;
                  Perfiles.Capturar(Reg_Perfil,pos_Perfil);
                  if Reg_Usuario.Borrado = false then
                   begin
                    ListadoUsuarios.RowCount:= ListadoUsuarios.RowCount + 1;
                    ListadoUsuarios.Cells[0,ListadoUsuarios.RowCount-1]:= Reg_Usuario.Nick;
                    ListadoUsuarios.Cells[1,ListadoUsuarios.RowCount-1]:= Reg_Usuario.Contrasena;
                    ListadoUsuarios.Cells[2,ListadoUsuarios.RowCount-1]:= Reg_Perfil.Nombre;
                    ListadoUsuarios.Cells[3,ListadoUsuarios.RowCount-1]:= inttostr(Reg_Usuario.id);
                   end;
                  pos_Usuario:= succ(pos_Usuario);
                end;
            end;
        end
      else
        begin
          showmessage('Ingrese un nombre de usuario correcto');
          EModificarUsuario.Clear;
          EModificarUsuario.SetFocus;
        end;
    end
  else
    showmessage('Ingrese un nombre de usuario');
end;

end.
