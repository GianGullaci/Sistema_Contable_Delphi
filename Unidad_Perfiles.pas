unit Unidad_Perfiles;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,  Dialogs;

Const
  _Pos_Nula = -1;
  _Clave_Nula = '';
  _Id_Nulo = 0;

Type
  Tipo_Posicion = LongInt;
  Tipo_Clave = String[20];

  Registro_Perfil = Record
    id: Tipo_Posicion;
    Borrado: boolean;
    Nombre: String[35];
    Hab_Clientes: boolean;
    Hab_Provincias: boolean;
    Hab_Auditoria: boolean;
    Hab_Usuarios: boolean;
    Hab_Perfiles: boolean;
    Hab_BackUp: boolean;
    Hab_Restore: boolean;
  end;

  Modelo_Perfil = Class
  Protected
    F: File of Registro_Perfil;
  Public
    Constructor Create (Ruta, Nombre: String); virtual;
    Procedure Abrir;
    Procedure Cerrar;
    Function Buscar (Clave: Tipo_Clave; var pos: Tipo_Posicion; Incluye_Eliminados: Boolean): boolean;
    Procedure Insertar (Reg: Registro_Perfil; pos: Tipo_Posicion);
    Procedure Eliminar (Pos: Tipo_Posicion);
    Procedure Modificar (Reg: Registro_Perfil; pos: Tipo_Posicion);
    Procedure Capturar (var Reg: Registro_Perfil; pos: Tipo_Posicion);
    Function Primero: Tipo_Posicion;
    Function Ultimo: Tipo_Posicion;
    Function Proximo (pos: Tipo_Posicion): Tipo_Posicion;
    Function Anterior (pos: Tipo_Posicion): Tipo_Posicion;
    Function Vacio: boolean;
    Function Borrado (Reg: Registro_Perfil): boolean;
    Function Pos_Nula: Tipo_Posicion;
    Function Clave_Nula: String;
    Function Id_Nulo: Tipo_Posicion;
    Destructor Destroy; override;
  end;

  Tipo_Perfil = Class (Modelo_Perfil)
  end;

implementation

{-----------------------------------------------------------------}
Constructor Modelo_Perfil.Create;
var
  Ruta_Modelo:String;
begin
  Inherited Create;
  Ruta_Modelo:= Ruta + '/' + Nombre +'.DAT';
  Assign (self.F, Ruta_Modelo);
  if FileExists (Ruta_Modelo) = False then
    begin
      Rewrite (self.F);
      Close (self.F);
    end;
end;

{-----------------------------------------------------------------}
Procedure Modelo_Perfil.Abrir;
begin
  Reset (self.F);
end;

{-----------------------------------------------------------------}
Procedure Modelo_Perfil.Cerrar;
begin
  Close (self.F);
end;

{-----------------------------------------------------------------}
Function Modelo_Perfil.Buscar;
var
  Encontrado: boolean;
  ultimo: Tipo_Posicion;
  Reg: Registro_Perfil;
begin
  Encontrado:= False;
  Pos:= 0;
  ultimo:= FileSize (self.F);

  while (Encontrado = False) and (Pos < ultimo) do
    begin
      Seek (self.F, Pos);
      Read (self.F, Reg);
      if (Reg.Nombre = Clave) and ((Reg.Borrado = False) or (Incluye_Eliminados = True)) then
        Encontrado:= True
      else
        Pos:= succ(pos);
    end;
  Buscar:= Encontrado;
end;

{-----------------------------------------------------------------}
Procedure Modelo_Perfil.Insertar;
begin
  Reg.Borrado:= False;
  Reg.Id:= FileSize (self.F);
  Seek (self.F, FileSize (self.F));
  write (self.F, Reg);
end;

{-----------------------------------------------------------------}
Procedure Modelo_Perfil.Eliminar;
var
  Reg: Registro_Perfil;
begin
  Seek (Self.F, Pos);
  Read (Self.F, Reg);
  Reg.Borrado:= True;
  Seek (Self.F, Pos);
  write (Self.F, Reg);
end;

{-----------------------------------------------------------------}
Procedure Modelo_Perfil.Modificar;
begin
  Reg.Borrado:= False;
  Seek (self.F, pos);
  Write (self.F, reg);
end;

{-----------------------------------------------------------------}
Procedure Modelo_Perfil.Capturar;
begin
  Seek (self.F, pos);
  Read (self.F, Reg);
end;

{-----------------------------------------------------------------}
Function Modelo_Perfil.Borrado;
begin
  Borrado:= Reg.Borrado;
end;

{-----------------------------------------------------------------}
Function Modelo_Perfil.Primero;
begin
  if FileSize (self.F) = 0 then
    Primero:= _Pos_Nula
  else
    Primero:= 0;
end;

{-----------------------------------------------------------------}
Function Modelo_Perfil.Ultimo;
begin
  if FileSize (self.F) = 0 then
    Ultimo:= _Pos_Nula
  else
    Ultimo:= FileSize (self.F);
end;

{-----------------------------------------------------------------}
Function Modelo_Perfil.Proximo;
begin
  if Pos < Pred (FileSize (self.F)) then
    Proximo:= Succ (Pos)
  else
    Proximo:= _Pos_Nula;
end;

{-----------------------------------------------------------------}
Function Modelo_Perfil.Anterior;
begin
  if Pos > 0 then
    Anterior:= Pred (Pos)
  else
    Anterior:= _Pos_Nula;
end;

{-----------------------------------------------------------------}
Function Modelo_Perfil.Vacio;
begin
  Vacio:= FileSize (Self.F) = 0;
end;

{-----------------------------------------------------------------}
Function Modelo_Perfil.Pos_Nula;
begin
  Pos_Nula:= _Pos_Nula;
end;

{-----------------------------------------------------------------}
Function Modelo_Perfil.Clave_Nula;
begin
  Clave_Nula:= _Clave_Nula;
end;

{-----------------------------------------------------------------}
Function Modelo_Perfil.Id_Nulo;
begin
  Id_Nulo:= _Id_Nulo;
end;

{-----------------------------------------------------------------}
Destructor Modelo_Perfil.Destroy;
begin
  Inherited Destroy;
end;

end.
