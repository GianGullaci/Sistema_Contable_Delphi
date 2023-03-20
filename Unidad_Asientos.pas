unit Unidad_Asientos;

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

  Registro_Asiento = Record
    id: Tipo_Posicion;
    Borrado: boolean;
    Fecha_Asiento: string[10];
    Numero_Asiento: LongInt;
    Tipo: 1..9;
    Debe: Real;
    Haber: Real;
    Saldo: Real;
  end;

  Modelo_Asientos = Class
  Protected
    F: File of Registro_Asiento;
  Public
    Constructor Create (Ruta, Nombre: String); virtual;
    Procedure Abrir;
    Procedure Cerrar;
    Function Buscar (Num: Tipo_Clave; var pos: Tipo_Posicion; Incluye_Eliminados: Boolean): boolean;
    Function Pos_Nueva: Tipo_Posicion;
    Procedure Insertar (Reg: Registro_Asiento; pos: Tipo_Posicion);
    Procedure Eliminar (Pos: Tipo_Posicion);
    Procedure Modificar (Reg: Registro_Asiento; pos: Tipo_Posicion);
    Procedure Capturar (var Reg: Registro_Asiento; pos: Tipo_Posicion);
    Function Primero: Tipo_Posicion;
    Function Ultimo: Tipo_Posicion;
    Function Proximo (pos: Tipo_Posicion): Tipo_Posicion;
    Function Anterior (pos: Tipo_Posicion): Tipo_Posicion;
    Function Vacio: boolean;
    Function Borrado (Reg: Registro_Asiento): boolean;
    Function Pos_Nula: Tipo_Posicion;
    Function Clave_Nula: String;
    Function Id_Nulo: Tipo_Posicion;
    Destructor Destroy; override;
  end;

  Tipo_Asiento = Class (Modelo_Asientos)
  end;

implementation

{-----------------------------------------------------------------}
Constructor Modelo_Asientos.Create;
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
Procedure Modelo_Asientos.Abrir;
begin
  Reset (self.F);
end;

{-----------------------------------------------------------------}
Procedure Modelo_Asientos.Cerrar;
begin
  Close (self.F);
end;

{-----------------------------------------------------------------}
Function Modelo_Asientos.Buscar;
var
  Encontrado: boolean;
  ultimo: Tipo_Posicion;
  Reg: Registro_Asiento;
begin
  Encontrado:= False;
  Pos:= 0;
  ultimo:= FileSize (self.F);

  while (Encontrado = False) and (Pos < ultimo) do
    begin
      Seek (self.F, Pos);
      Read (self.F, Reg);
      if (IntToStr(Reg.Numero_Asiento) = Num) and ((Reg.Borrado = False) or (Incluye_Eliminados = True)) then
        Encontrado:= True
      else
        Pos:= succ(pos);
    end;
  Buscar:= Encontrado;
end;

{-----------------------------------------------------------------}
Function Modelo_Asientos.Pos_Nueva;
begin
  Pos_Nueva:= FileSize (Self.F);
end;

{-----------------------------------------------------------------}
Procedure Modelo_Asientos.Insertar;
begin
  Reg.Borrado:= False;
  Reg.Id:= FileSize (self.F);
  Seek (self.F, FileSize (self.F));
  write (self.F, Reg);
end;

{-----------------------------------------------------------------}
Procedure Modelo_Asientos.Eliminar;
var
  Reg: Registro_Asiento;
begin
  Seek (Self.F, Pos);
  Read (Self.F, Reg);
  Reg.Borrado:= True;
  Seek (Self.F, Pos);
  write (Self.F, Reg);
end;

{-----------------------------------------------------------------}
Procedure Modelo_Asientos.Modificar;
begin
  Reg.Borrado:= False;
  Seek (self.F, pos);
  Write (self.F, reg);
end;

{-----------------------------------------------------------------}
Procedure Modelo_Asientos.Capturar;
begin
  Seek (self.F, pos);
  Read (self.F, Reg);
end;

{-----------------------------------------------------------------}
Function Modelo_Asientos.Borrado;
begin
  Borrado:= Reg.Borrado;
end;

{-----------------------------------------------------------------}
Function Modelo_Asientos.Primero;
begin
  if FileSize (self.F) = 0 then
    Primero:= _Pos_Nula
  else
    Primero:= 0;
end;

{-----------------------------------------------------------------}
Function Modelo_Asientos.Ultimo;
begin
  if FileSize (self.F) = 0 then
    Ultimo:= _Pos_Nula
  else
    Ultimo:= FileSize (self.F);
end;

{-----------------------------------------------------------------}
Function Modelo_Asientos.Proximo;
begin
  if Pos < Pred (FileSize (self.F)) then
    Proximo:= Succ (Pos)
  else
    Proximo:= _Pos_Nula;
end;

{-----------------------------------------------------------------}
Function Modelo_Asientos.Anterior;
begin
  if Pos > 0 then
    Anterior:= Pred (Pos)
  else
    Anterior:= _Pos_Nula;
end;

{-----------------------------------------------------------------}
Function Modelo_Asientos.Vacio;
begin
  Vacio:= FileSize (Self.F) = 0;
end;

{-----------------------------------------------------------------}
Function Modelo_Asientos.Pos_Nula;
begin
  Pos_Nula:= _Pos_Nula;
end;

{-----------------------------------------------------------------}
Function Modelo_Asientos.Clave_Nula;
begin
  Clave_Nula:= _Clave_Nula;
end;

{-----------------------------------------------------------------}
Function Modelo_Asientos.Id_Nulo;
begin
  Id_Nulo:= _Id_Nulo;
end;

{-----------------------------------------------------------------}
Destructor Modelo_Asientos.Destroy;
begin
  Inherited Destroy;
end;

end.
