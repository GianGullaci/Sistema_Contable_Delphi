unit Unidad_Aud_Provincias;

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

  Registro_Aud_Provincia = Record
    id: Tipo_Posicion;
    Clave: Tipo_Clave;
    Borrado: boolean;
    Descripcion: String[35];
  end;

  Registro_Aud_Provincia_Nuevo = Record
    id_Aud_Provincia: Tipo_Posicion; 
    Borrado: boolean;
    Tipo_Operacion: string[1];
    Provincia: Registro_Aud_Provincia;
    Nick: Tipo_Posicion;
    Terminal: String[50];
    Fecha: string[15];
    Hora: string[15];
  end;


  Modelo_Aud_Provincia = Class
  Protected
    F: File of Registro_Aud_Provincia_Nuevo;
  Public
    Constructor Create (Ruta, Nombre: String); virtual;
    Procedure Abrir;
    Procedure Cerrar;
    Function Buscar (Clave: Tipo_Clave; var pos: Tipo_Posicion; Incluye_Eliminados: Boolean): boolean;
    Procedure Insertar (Reg: Registro_Aud_Provincia_Nuevo; pos: Tipo_Posicion);
    Procedure Eliminar (Pos: Tipo_Posicion);
    Procedure Modificar (Reg: Registro_Aud_Provincia_Nuevo; pos: Tipo_Posicion);
    Procedure Capturar (var Reg: Registro_Aud_Provincia_Nuevo; pos: Tipo_Posicion);
    Function Primero: Tipo_Posicion;
    Function Ultimo: Tipo_Posicion;
    Function Proximo (pos: Tipo_Posicion): Tipo_Posicion;
    Function Anterior (pos: Tipo_Posicion): Tipo_Posicion;
    Function Vacio: boolean;
    Function Borrado (Reg: Registro_Aud_Provincia_Nuevo): boolean;
    Function Pos_Nula: Tipo_Posicion;
    Function Clave_Nula: String;
    Function Id_Nulo: Tipo_Posicion;
    Destructor Destroy; override;
  end;

  Tipo_Aud_Provincia = Class (Modelo_Aud_Provincia)
  end;

implementation

{-----------------------------------------------------------------}
Constructor Modelo_Aud_Provincia.Create;
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
Procedure Modelo_Aud_Provincia.Abrir;
begin
  Reset (self.F);
end;

{-----------------------------------------------------------------}
Procedure Modelo_Aud_Provincia.Cerrar;
begin
  Close (self.F);
end;

{-----------------------------------------------------------------}
Function Modelo_Aud_Provincia.Buscar;
var
  Encontrado: boolean;
  ultimo: Tipo_Posicion;
  Reg: Registro_Aud_Provincia_Nuevo;
begin
  Encontrado:= False;
  Pos:= 0;
  ultimo:= FileSize (self.F);

  while (Encontrado = False) and (Pos < ultimo) do
    begin
      Seek (self.F, Pos);
      Read (self.F, Reg);
      if (Reg.Provincia.Clave = Clave) and ((Reg.Borrado = False) or (Incluye_Eliminados = True)) then
        Encontrado:= True
      else
        Pos:= succ(pos);
    end;
  Buscar:= Encontrado;
end;

{-----------------------------------------------------------------}
Procedure Modelo_Aud_Provincia.Insertar;
begin
  Reg.Borrado:= False;
  Reg.id_Aud_Provincia:= FileSize (self.F);
  Seek (self.F, FileSize (self.F));
  write (self.F, Reg);
end;

{-----------------------------------------------------------------}
Procedure Modelo_Aud_Provincia.Eliminar;
var
  Reg: Registro_Aud_Provincia_Nuevo;
begin
  Seek (Self.F, Pos);
  Read (Self.F, Reg);
  Reg.Borrado:= True;
  Seek (Self.F, Pos);
  write (Self.F, Reg);
end;

{-----------------------------------------------------------------}
Procedure Modelo_Aud_Provincia.Modificar;
begin
  Reg.Borrado:= False;
  Seek (self.F, pos);
  Write (self.F, reg);
end;

{-----------------------------------------------------------------}
Procedure Modelo_Aud_Provincia.Capturar;
begin
  Seek (self.F, pos);
  Read (self.F, Reg);
end;

{-----------------------------------------------------------------}
Function Modelo_Aud_Provincia.Borrado;
begin
  Borrado:= Reg.Borrado;
end;

{-----------------------------------------------------------------}
Function Modelo_Aud_Provincia.Primero;
begin
  if FileSize (self.F) = 0 then
    Primero:= _Pos_Nula
  else
    Primero:= 0;
end;

{-----------------------------------------------------------------}
Function Modelo_Aud_Provincia.Ultimo;
begin
  if FileSize (self.F) = 0 then
    Ultimo:= _Pos_Nula
  else
    Ultimo:= FileSize (self.F);
end;

{-----------------------------------------------------------------}
Function Modelo_Aud_Provincia.Proximo;
begin
  if Pos < Pred (FileSize (self.F)) then
    Proximo:= Succ (Pos)
  else
    Proximo:= _Pos_Nula;
end;

{-----------------------------------------------------------------}
Function Modelo_Aud_Provincia.Anterior;
begin
  if Pos > 0 then
    Anterior:= Pred (Pos)
  else
    Anterior:= _Pos_Nula;
end;

{-----------------------------------------------------------------}
Function Modelo_Aud_Provincia.Vacio;
begin
  Vacio:= FileSize (Self.F) = 0;
end;

{-----------------------------------------------------------------}
Function Modelo_Aud_Provincia.Pos_Nula;
begin
  Pos_Nula:= _Pos_Nula;
end;

{-----------------------------------------------------------------}
Function Modelo_Aud_Provincia.Clave_Nula;
begin
  Clave_Nula:= _Clave_Nula;
end;

{-----------------------------------------------------------------}
Function Modelo_Aud_Provincia.Id_Nulo;
begin
  Id_Nulo:= _Id_Nulo;
end;

{-----------------------------------------------------------------}
Destructor Modelo_Aud_Provincia.Destroy;
begin
  Inherited Destroy;
end;

end.
