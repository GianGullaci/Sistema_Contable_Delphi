unit Form_Provincias;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Unidad_Clientes, Unidad_Provincias, Sistema_ABM, Grids, Unidad_Aud_Provincias;

type
  TFProvincias = class(TForm)
    BSalirProvincias: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    EClaveProvincia: TEdit;
    EDescripcionProvincia: TEdit;
    BGuardarProvincia: TButton;
    BModificarProvincia: TButton;
    BBorrarProvincia: TButton;
    BGuardarModProvincia: TButton;
    BCancelarProvincia: TButton;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    EModificarProvincia: TEdit;
    ListadoProvincias: TStringGrid;
    Label4: TLabel;
    Label7: TLabel;
    UsuarioRegistrado: TLabel;
    Label8: TLabel;
    NombreEmpresa: TLabel;
    procedure BSalirProvinciasClick(Sender: TObject);
    procedure BGuardarProvinciaClick(Sender: TObject);
    procedure BModificarProvinciaClick(Sender: TObject);
    procedure BCancelarProvinciaClick(Sender: TObject);
    procedure BGuardarModProvinciaClick(Sender: TObject);
    procedure BBorrarProvinciaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private

  public

  end;

var
  FProvincias: TFProvincias;
  Provincias: Modelo_Provincia;
  Clientes: Modelo_Cliente;
  Aud_Provincias: Modelo_Aud_Provincia;
  Reg_Aud_Aux: Registro_Aud_Provincia_Nuevo;
  pos: Tipo_Posicion;

implementation

uses Form_Ingreso;

{$R *.dfm}

procedure TFProvincias.BSalirProvinciasClick(Sender: TObject);
begin
  Close;
  FPrincipal.Visible:= true;
end;


procedure TFProvincias.FormActivate(Sender: TObject);
var
  Registro: Registro_Provincia;
begin
  Provincias:= Modelo_Provincia.Create(FIngreso.c_Ruta,'Provincias');
  Provincias.Abrir;
  Clientes:= Modelo_Cliente.Create(FIngreso.c_Ruta,'Clientes');
  Clientes.Abrir;
  Aud_Provincias:= Modelo_Aud_Provincia.Create(FIngreso.c_Ruta,'Auditoria_Provincias');
  Aud_Provincias.Abrir;
  EClaveProvincia.Text:= '';
  EDescripcionProvincia.Text:= '';
  ListadoProvincias.RowCount:= 1;
  ListadoProvincias.ColCount:= 2;
  ListadoProvincias.Cells[0,0]:= 'Clave';
  ListadoProvincias.Cells[1,0]:= 'Descripcion';
  ListadoProvincias.ColWidths[1]:= 260;
  BGuardarModProvincia.Enabled:= False;
  BGuardarModProvincia.Visible:= False;
  BCancelarProvincia.Enabled:= False;
  BCancelarProvincia.Visible:= False;
  pos:= 0;
  while pos < Provincias.Ultimo do
    begin
      Provincias.Capturar(Registro,pos);
      if Registro.Borrado = false then
       begin
        ListadoProvincias.RowCount:= ListadoProvincias.RowCount + 1;
        ListadoProvincias.Cells[0,ListadoProvincias.RowCount-1]:= Registro.Clave;
        ListadoProvincias.Cells[1,ListadoProvincias.RowCount-1]:= Registro.Descripcion;
       end;
      pos:= succ(pos);
    end;
end;


procedure TFProvincias.BGuardarProvinciaClick(Sender: TObject);
var
  Registro: Registro_Provincia;
  Reg_Aud: Registro_Aud_Provincia_Nuevo;
begin
  Registro.Clave:= EClaveProvincia.Text;
  Registro.Descripcion:= EDescripcionProvincia.Text;
  if ((EClaveProvincia.Text <> '') and (EDescripcionProvincia.Text <> '') and (strtoint(EClaveProvincia.Text)>=0) and (strtoint(EClaveProvincia.Text)<99)) then
    begin
      if Provincias.Buscar(Registro.Clave,pos,true) = false then
        begin
          Provincias.Insertar(Registro,pos);

          //Auditoria
          Reg_Aud.Provincia.id:= pos;
          Reg_Aud.Provincia.Borrado:= Registro.Borrado;
          Reg_Aud.Tipo_Operacion:= 'A';
          Reg_Aud.Provincia.Clave:= Registro.Clave;
          Reg_Aud.Provincia.Descripcion:= Registro.Descripcion;
          Reg_Aud.id_Aud_Provincia:= Aud_Provincias.Ultimo + 1;
          Reg_Aud.Borrado:= false;
          Reg_Aud.Nick:= FIngreso.usuario;
          Reg_Aud.Terminal:= FPrincipal.IP;
          Reg_Aud.Fecha:= datetostr(now);
          Reg_Aud.Hora:= timetostr(now);
          Aud_Provincias.Insertar(Reg_Aud,Reg_Aud.id_Aud_Provincia);

          pos:= 0;
          EClaveProvincia.Clear;
          EClaveProvincia.SetFocus;
          EDescripcionProvincia.Clear;
          ListadoProvincias.RowCount:= 1;
          while pos < Provincias.Ultimo do
            begin
              Provincias.Capturar(Registro,pos);
              if Registro.Borrado = false then
               begin
                ListadoProvincias.RowCount:= ListadoProvincias.RowCount + 1;
                ListadoProvincias.Cells[0,ListadoProvincias.RowCount-1]:= Registro.Clave;
                ListadoProvincias.Cells[1,ListadoProvincias.RowCount-1]:= Registro.Descripcion;
               end;
              pos:= succ(pos);
            end;
        end
      else
        begin
          showmessage('La clave ya existe');
          EClaveProvincia.Clear;
          EClaveProvincia.SetFocus;
        end;
    end
  else
    begin
      if ((EClaveProvincia.Text = '') or (strtoint(EClaveProvincia.Text)<0) or (strtoint(EClaveProvincia.Text)>99)) then
        begin
          showmessage('Ingrese una clave valida');
          EClaveProvincia.Clear;
          EClaveProvincia.SetFocus;
        end
      else
        if EDescripcionProvincia.Text = '' then
          begin
            showmessage('Ingrese el nombre de la Provincia');
            EDescripcionProvincia.Clear;
            EDescripcionProvincia.SetFocus;
          end;
    end;
end;

procedure TFProvincias.BModificarProvinciaClick(Sender: TObject);
var
  Registro: Registro_Provincia;
begin
  if EModificarProvincia.Text <> '' then
    begin
      Registro.Clave:= EModificarProvincia.Text;
      if Provincias.Buscar(Registro.Clave,pos,true) then
        begin
          Provincias.Capturar(Registro,pos);

          //Auditoria
          Reg_Aud_Aux.Provincia.id:= pos;
          Reg_Aud_Aux.Provincia.Borrado:= Registro.Borrado;
          Reg_Aud_Aux.Tipo_Operacion:= 'M';
          Reg_Aud_Aux.Provincia.Clave:= Registro.Clave;
          Reg_Aud_Aux.Provincia.Descripcion:= Registro.Descripcion;
          Reg_Aud_Aux.id_Aud_Provincia:= Aud_Provincias.Ultimo + 1;
          Reg_Aud_Aux.Borrado:= false;
          Reg_Aud_Aux.Nick:= FIngreso.usuario;
          Reg_Aud_Aux.Terminal:= FPrincipal.IP;

          EClaveProvincia.Text:= Registro.Clave;
          EDescripcionProvincia.Text:= Registro.Descripcion;
          BGuardarProvincia.Enabled:= false;
          BGuardarProvincia.Visible:= false;
          BGuardarModProvincia.Enabled:= True;
          BGuardarModProvincia.Visible:= True;
          BCancelarProvincia.Enabled:= True;
          BCancelarProvincia.Visible:= True;
        end
      else
        begin
          showmessage('Ingrese una clave correcta');
          EModificarProvincia.Clear;
          EModificarProvincia.SetFocus;
        end;
    end
  else
    showmessage('Ingrese una clave');
end;

procedure TFProvincias.BGuardarModProvinciaClick(Sender: TObject);
var
  Registro: Registro_Provincia;
  Reg_aux: Registro_Provincia;
  Reg_Aud: Registro_Aud_Provincia_Nuevo;
  pos_aux: Tipo_Posicion;
begin
  //Auditoria
  Reg_Aud_Aux.Fecha:= datetostr(now);
  Reg_Aud_Aux.Hora:= timetostr(now);
  Aud_Provincias.Insertar(Reg_Aud_Aux,Aud_Provincias.Ultimo+1);

  Provincias.Capturar(Reg_aux,pos);
  Registro.Clave:= EClaveProvincia.Text;
  Registro.Descripcion:= EDescripcionProvincia.Text;
  if ((EClaveProvincia.Text <> '') and (EDescripcionProvincia.Text <> '') and (strtoint(EClaveProvincia.Text)>=0) and (strtoint(EClaveProvincia.Text)<99)) then
    begin
      if Registro.Clave = Reg_Aux.Clave then
        begin
          Provincias.Modificar(Registro,pos);

          //Auditoria
          Reg_Aud.Provincia.id:= pos;
          Reg_Aud.Provincia.Borrado:= Registro.Borrado;
          Reg_Aud.Tipo_Operacion:= 'M';
          Reg_Aud.Provincia.Clave:= Registro.Clave;
          Reg_Aud.Provincia.Descripcion:= Registro.Descripcion;
          Reg_Aud.id_Aud_Provincia:= Aud_Provincias.Ultimo + 1;
          Reg_Aud.Borrado:= false;
          Reg_Aud.Nick:= FIngreso.usuario;
          Reg_Aud.Terminal:= FPrincipal.IP;
          Reg_Aud.Fecha:= datetostr(now);
          Reg_Aud.Hora:= timetostr(now);
          Aud_Provincias.Insertar(Reg_Aud,Reg_Aud.id_Aud_Provincia);

          BGuardarProvincia.Enabled:= true;
          BGuardarProvincia.Visible:= true;
          BGuardarModProvincia.Enabled:= False;
          BGuardarModProvincia.Visible:= False;
          BCancelarProvincia.Enabled:= False;
          BCancelarProvincia.Visible:= False;
          EClaveProvincia.Clear;
          EClaveProvincia.Enabled:= true;
          EDescripcionProvincia.Clear;
          EModificarProvincia.Clear;
          ListadoProvincias.RowCount:= 1;
          pos:= 0;
          while pos < Provincias.Ultimo do
            begin
              Provincias.Capturar(Registro,pos);
              if Registro.Borrado = false then
               begin
                ListadoProvincias.RowCount:= ListadoProvincias.RowCount + 1;
                ListadoProvincias.Cells[0,ListadoProvincias.RowCount-1]:= Registro.Clave;
                ListadoProvincias.Cells[1,ListadoProvincias.RowCount-1]:= Registro.Descripcion;
               end;
              pos:= succ(pos);
            end;
        end
      else
        begin
          if Provincias.Buscar(Registro.Clave,pos_aux,true) = false then
            begin
              Provincias.Modificar(Registro,pos);

              //Auditoria
              Reg_Aud.Provincia.id:= pos;
              Reg_Aud.Provincia.Borrado:= Registro.Borrado;
              Reg_Aud.Tipo_Operacion:= 'M';
              Reg_Aud.Provincia.Clave:= Registro.Clave;
              Reg_Aud.Provincia.Descripcion:= Registro.Descripcion;
              Reg_Aud.id_Aud_Provincia:= Aud_Provincias.Ultimo + 1;
              Reg_Aud.Borrado:= false;
              Reg_Aud.Nick:= FIngreso.usuario;
              Reg_Aud.Terminal:= FPrincipal.IP;
              Reg_Aud.Fecha:= datetostr(now);
              Reg_Aud.Hora:= timetostr(now);
              Aud_Provincias.Insertar(Reg_Aud,Reg_Aud.id_Aud_Provincia);

              BGuardarProvincia.Enabled:= true;
              BGuardarProvincia.Visible:= true;
              BGuardarModProvincia.Enabled:= False;
              BGuardarModProvincia.Visible:= False;
              BCancelarProvincia.Enabled:= False;
              BCancelarProvincia.Visible:= False;
              EClaveProvincia.Clear;
              EDescripcionProvincia.Clear;
              ListadoProvincias.RowCount:= 1;
              pos:= 0;
              while pos < Provincias.Ultimo do
                begin
                  Provincias.Capturar(Registro,pos);
                  if Registro.Borrado = false then
                   begin
                    ListadoProvincias.RowCount:= ListadoProvincias.RowCount + 1;
                    ListadoProvincias.Cells[0,ListadoProvincias.RowCount-1]:= Registro.Clave;
                    ListadoProvincias.Cells[1,ListadoProvincias.RowCount-1]:= Registro.Descripcion;
                   end;
                  pos:= succ(pos);
                end;
            end
          else
            begin
              showmessage('La clave ya existe');
              EClaveProvincia.Text:= reg_aux.Clave;
              EClaveProvincia.SetFocus;
            end;
        end;
    end
  else
    begin
      if ((EClaveProvincia.Text = '') or (strtoint(EClaveProvincia.Text)<0) or (strtoint(EClaveProvincia.Text)>99)) then
        begin
          showmessage('Ingrese una clave valida');
          EClaveProvincia.Clear;
          EClaveProvincia.SetFocus;
        end
      else
        if EDescripcionProvincia.Text = '' then
          begin
            showmessage('Ingrese el nombre de la Provincia');
            EDescripcionProvincia.Clear;
            EDescripcionProvincia.SetFocus;
          end;
    end;
end;

procedure TFProvincias.BCancelarProvinciaClick(Sender: TObject);
begin
  BGuardarProvincia.Enabled:= true;
  BGuardarProvincia.Visible:= true;
  BGuardarModProvincia.Enabled:= False;
  BGuardarModProvincia.Visible:= False;
  BCancelarProvincia.Enabled:= False;
  BCancelarProvincia.Visible:= False;
  EClaveProvincia.Clear;
  EDescripcionProvincia.Clear;
  EModificarProvincia.Clear;
end;

procedure TFProvincias.BBorrarProvinciaClick(Sender: TObject);
var
  Registro: Registro_Provincia; 
  Reg_Aud: Registro_Aud_Provincia_Nuevo;
  pos_Cliente: Tipo_Posicion;
begin
  if EModificarProvincia.Text <> '' then
    begin
      Registro.Clave:= EModificarProvincia.Text;
      if Provincias.Buscar(Registro.Clave,pos,false) then
        begin
          if Clientes.Buscar_Cliente_Provincia(pos,pos_Cliente) = False then
           begin
            if messagedlg('¿Estas seguro de eliminar?',mtConfirmation,[mbYes, mbNo], 0) = mrYes then
              begin
                Provincias.Eliminar(pos);

                //Auditoria      
                Provincias.Capturar(Registro,pos);
                Reg_Aud.Provincia.id:= pos;
                Reg_Aud.Provincia.Borrado:= Registro.Borrado;
                Reg_Aud.Tipo_Operacion:= 'B';
                Reg_Aud.Provincia.Clave:= Registro.Clave;
                Reg_Aud.Provincia.Descripcion:= Registro.Descripcion;
                Reg_Aud.id_Aud_Provincia:= Aud_Provincias.Ultimo + 1;
                Reg_Aud.Borrado:= false;
                Reg_Aud.Nick:= FIngreso.usuario;
                Reg_Aud.Terminal:= FPrincipal.IP;
                Reg_Aud.Fecha:= datetostr(now);
                Reg_Aud.Hora:= timetostr(now);
                Aud_Provincias.Insertar(Reg_Aud,Reg_Aud.id_Aud_Provincia);

                pos:= 0;
                ListadoProvincias.RowCount:= 1;
                EModificarProvincia.Clear;
                while pos < Provincias.Ultimo do
                  begin
                    Provincias.Capturar(Registro,pos);
                    if Registro.Borrado = false then
                     begin
                      ListadoProvincias.RowCount:= ListadoProvincias.RowCount + 1;
                      ListadoProvincias.Cells[0,ListadoProvincias.RowCount-1]:= Registro.Clave;
                      ListadoProvincias.Cells[1,ListadoProvincias.RowCount-1]:= Registro.Descripcion;
                     end;
                    pos:= succ(pos);
                  end;
              end;
             end
            else
              begin
                showmessage('La Provincia tiene clientes asociados. No es posible eliminar');
                EModificarProvincia.Clear;
              end;
        end
      else
        begin
          showmessage('Ingrese una clave correcta');
          EModificarProvincia.Clear;
          EModificarProvincia.SetFocus;
        end;
    end
  else
    showmessage('Ingrese una clave');
end;



end.
