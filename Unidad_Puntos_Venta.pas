unit Unidad_Puntos_Venta;

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

  Registro_PuntosVenta = Record
    id: Tipo_Posicion;
    Clave: Tipo_Clave;
    Borrado: boolean;
    Descripcion: String[50];
  end;

  Modelo_PuntosVenta = Class
  Protected
    F: File of Registro_PuntosVenta;
  Public
    Constructor Create (Ruta, Nombre: String); virtual;
    Procedure Abrir;
    Procedure Cerrar;
    Function Buscar (Clave: Tipo_Clave; var pos: Tipo_Posicion; Incluye_Eliminados: Boolean): boolean;
    Procedure Insertar (Reg: Registro_PuntosVenta; pos: Tipo_Posicion);      
    Function Pos_Nueva: Tipo_Posicion;
    Procedure Eliminar (Pos: Tipo_Posicion);
    Procedure Modificar (Reg: Registro_PuntosVenta; pos: Tipo_Posicion);
    Procedure Capturar (var Reg: Registro_PuntosVenta; pos: Tipo_Posicion);
    Function Primero: Tipo_Posicion;
    Function Ultimo: Tipo_Posicion;
    Function Proximo (pos: Tipo_Posicion): Tipo_Posicion;
    Function Anterior (pos: Tipo_Posicion): Tipo_Posicion;
    Function Vacio: boolean;
    Function Borrado (Reg: Registro_PuntosVenta): boolean;
    Function Pos_Nula: Tipo_Posicion;
    Function Clave_Nula: String;
    Function Id_Nulo: Tipo_Posicion;
    Destructor Destroy; override;
  end;

  Tipo_PuntosVenta = Class (Modelo_PuntosVenta)
  end;

implementation

{-----------------------------------------------------------------}
Constructor Modelo_PuntosVenta.Create;
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
Procedure Modelo_PuntosVenta.Abrir;
begin
  Reset (self.F);
end;

{-----------------------------------------------------------------}
Procedure Modelo_PuntosVenta.Cerrar;
begin
  Close (self.F);
end;

{-----------------------------------------------------------------}
Function Modelo_PuntosVenta.Buscar;
var
  Encontrado: boolean;
  ultimo: Tipo_Posicion;
  Reg: Registro_PuntosVenta;
begin
  Encontrado:= False;
  Pos:= 0;
  ultimo:= FileSize (self.F);

  while (Encontrado = False) and (Pos < ultimo) do
    begin
      Seek (self.F, Pos);
      Read (self.F, Reg);
      if (Reg.Clave = Clave) and ((Reg.Borrado = False) or (Incluye_Eliminados = True)) then
        Encontrado:= True
      else
        Pos:= succ(pos);
    end;
  Buscar:= Encontrado;
end;

{-----------------------------------------------------------------}
Procedure Modelo_PuntosVenta.Insertar;
begin
  Reg.Borrado:= False;
  Reg.Id:= FileSize (self.F);
  Seek (self.F, FileSize (self.F));
  write (self.F, Reg);
end;

{-----------------------------------------------------------------}
Function Modelo_PuntosVenta.Pos_Nueva;
begin
  Pos_Nueva:= FileSize (Self.F);
end;

{-----------------------------------------------------------------}
Procedure Modelo_PuntosVenta.Eliminar;
var
  Reg: Registro_PuntosVenta;
begin
  Seek (Self.F, Pos);
  Read (Self.F, Reg);
  Reg.Borrado:= True;
  Seek (Self.F, Pos);
  write (Self.F, Reg);
end;

{-----------------------------------------------------------------}
Procedure Modelo_PuntosVenta.Modificar;
begin
  Reg.Borrado:= False;
  Seek (self.F, pos);
  Write (self.F, reg);
end;

{-----------------------------------------------------------------}
Procedure Modelo_PuntosVenta.Capturar;
begin
  Seek (self.F, pos);
  Read (self.F, Reg);
end;

{-----------------------------------------------------------------}
Function Modelo_PuntosVenta.Borrado;
begin
  Borrado:= Reg.Borrado;
end;

{-----------------------------------------------------------------}
Function Modelo_PuntosVenta.Primero;
begin
  if FileSize (self.F) = 0 then
    Primero:= _Pos_Nula
  else
    Primero:= 0;
end;

{-----------------------------------------------------------------}
Function Modelo_PuntosVenta.Ultimo;
begin
  if FileSize (self.F) = 0 then
    Ultimo:= _Pos_Nula
  else
    Ultimo:= FileSize (self.F);
end;

{-----------------------------------------------------------------}
Function Modelo_PuntosVenta.Proximo;
begin
  if Pos < Pred (FileSize (self.F)) then
    Proximo:= Succ (Pos)
  else
    Proximo:= _Pos_Nula;
end;

{-----------------------------------------------------------------}
Function Modelo_PuntosVenta.Anterior;
begin
  if Pos > 0 then
    Anterior:= Pred (Pos)
  else
    Anterior:= _Pos_Nula;
end;

{-----------------------------------------------------------------}
Function Modelo_PuntosVenta.Vacio;
begin
  Vacio:= FileSize (Self.F) = 0;
end;

{-----------------------------------------------------------------}
Function Modelo_PuntosVenta.Pos_Nula;
begin
  Pos_Nula:= _Pos_Nula;
end;

{-----------------------------------------------------------------}
Function Modelo_PuntosVenta.Clave_Nula;
begin
  Clave_Nula:= _Clave_Nula;
end;

{-----------------------------------------------------------------}
Function Modelo_PuntosVenta.Id_Nulo;
begin
  Id_Nulo:= _Id_Nulo;
end;

{-----------------------------------------------------------------}
Destructor Modelo_PuntosVenta.Destroy;
begin
  Inherited Destroy;
end;

end.
