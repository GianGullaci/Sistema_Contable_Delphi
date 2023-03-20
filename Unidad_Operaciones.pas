unit Unidad_Operaciones;

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

  Registro_Operacion = Record
    id: Tipo_Posicion;  
    id_Asiento: Tipo_Posicion;
    Borrado: boolean;
    Pase: ShortInt;
    Cuenta: ShortInt;
    DV: ShortInt;
    Fecha_Op: string[10];
    Fecha_Vto: string[10];
    Comprob: string[100];
    Suc: ShortInt;
    Secc: ShortInt;
    DoH: 0..1;
    Importe: Real;
    Leyenda: String[100];
  end;

  Modelo_Operaciones = Class
  Protected
    F: File of Registro_Operacion;
  Public
    Constructor Create (Ruta, Nombre: String); virtual;
    Procedure Abrir;
    Procedure Cerrar;
    Function Buscar (pase: Tipo_Clave; id_Asiento: Tipo_Posicion; var pos: Tipo_Posicion; Incluye_Eliminados: Boolean): boolean;
    Function Buscar_Asiento (id_Asiento: Tipo_Posicion; var pos: Tipo_Posicion; Incluye_Eliminados: Boolean): boolean;
    Function Buscar_Cuenta (cuenta: ShortInt; var pos: Tipo_Posicion; Incluye_Eliminados: Boolean): boolean;
    Procedure Insertar (Reg: Registro_Operacion; pos: Tipo_Posicion);
    Procedure Eliminar (Pos: Tipo_Posicion);
    Procedure Modificar (Reg: Registro_Operacion; pos: Tipo_Posicion);
    Procedure Capturar (var Reg: Registro_Operacion; pos: Tipo_Posicion);
    Function Primero: Tipo_Posicion;
    Function Ultimo: Tipo_Posicion;
    Function Proximo (pos: Tipo_Posicion): Tipo_Posicion;
    Function Anterior (pos: Tipo_Posicion): Tipo_Posicion;
    Function Vacio: boolean;
    Function Borrado (Reg: Registro_Operacion): boolean;
    Function Pos_Nula: Tipo_Posicion;
    Function Clave_Nula: String;
    Function Id_Nulo: Tipo_Posicion;
    Destructor Destroy; override;
  end;

  Tipo_Operacion = Class (Modelo_Operaciones)
  end;

implementation

{-----------------------------------------------------------------}
Constructor Modelo_Operaciones.Create;
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
Procedure Modelo_Operaciones.Abrir;
begin
  Reset (self.F);
end;

{-----------------------------------------------------------------}
Procedure Modelo_Operaciones.Cerrar;
begin
  Close (self.F);
end;

{-----------------------------------------------------------------}
Function Modelo_Operaciones.Buscar;
var
  Encontrado: boolean;
  ultimo: Tipo_Posicion;
  Reg: Registro_Operacion;
begin
  Encontrado:= False;
  Pos:= 0;
  ultimo:= FileSize (self.F);

  while (Encontrado = False) and (Pos < ultimo) do
    begin
      Seek (self.F, Pos);
      Read (self.F, Reg);
      if (IntToStr(Reg.Pase) = Pase) and (Reg.id_Asiento = id_Asiento) and ((Reg.Borrado = False) or (Incluye_Eliminados = True)) then
        Encontrado:= True
      else
        Pos:= succ(pos);
    end;
  Buscar:= Encontrado;
end;

{-----------------------------------------------------------------}
Function Modelo_Operaciones.Buscar_Asiento;
var
  Encontrado: boolean;
  ultimo: Tipo_Posicion;
  Reg: Registro_Operacion;
begin
  Encontrado:= False;
  Pos:= 0;
  ultimo:= FileSize (self.F);

  while (Encontrado = False) and (Pos < ultimo) do
    begin
      Seek (self.F, Pos);
      Read (self.F, Reg);
      if (Reg.id_Asiento = id_Asiento) and ((Reg.Borrado = False) or (Incluye_Eliminados = True)) then
        Encontrado:= True
      else
        Pos:= succ(pos);
    end;
  if Encontrado = False then
    Pos := _Pos_Nula;
  Buscar_Asiento:= Encontrado;
end;

{-----------------------------------------------------------------}
Function Modelo_Operaciones.Buscar_Cuenta;
var
  Encontrado: boolean;
  ultimo: Tipo_Posicion;
  Reg: Registro_Operacion;
begin
  Encontrado:= False;
  Pos:= 0;
  ultimo:= FileSize (self.F);

  while (Encontrado = False) and (Pos < ultimo) do
    begin
      Seek (self.F, Pos);
      Read (self.F, Reg);
      if (Reg.Cuenta = Cuenta) and ((Reg.Borrado = False) or (Incluye_Eliminados = True)) then
        Encontrado:= True
      else
        Pos:= succ(pos);
    end;
  if Encontrado = False then
    Pos := _Pos_Nula;
  Buscar_Cuenta:= Encontrado;
end;

{-----------------------------------------------------------------}
Procedure Modelo_Operaciones.Insertar;
begin
  Reg.Borrado:= False;
  Reg.Id:= FileSize (self.F);
  Seek (self.F, FileSize (self.F));
  write (self.F, Reg);
end;

{-----------------------------------------------------------------}
Procedure Modelo_Operaciones.Eliminar;
var
  Reg: Registro_Operacion;
begin
  Seek (Self.F, Pos);
  Read (Self.F, Reg);
  Reg.Borrado:= True;
  Seek (Self.F, Pos);
  write (Self.F, Reg);
end;

{-----------------------------------------------------------------}
Procedure Modelo_Operaciones.Modificar;
begin
  Reg.Borrado:= False;
  Seek (self.F, pos);
  Write (self.F, reg);
end;

{-----------------------------------------------------------------}
Procedure Modelo_Operaciones.Capturar;
begin
  Seek (self.F, pos);
  Read (self.F, Reg);
end;

{-----------------------------------------------------------------}
Function Modelo_Operaciones.Borrado;
begin
  Borrado:= Reg.Borrado;
end;

{-----------------------------------------------------------------}
Function Modelo_Operaciones.Primero;
begin
  if FileSize (self.F) = 0 then
    Primero:= _Pos_Nula
  else
    Primero:= 0;
end;

{-----------------------------------------------------------------}
Function Modelo_Operaciones.Ultimo;
begin
  if FileSize (self.F) = 0 then
    Ultimo:= _Pos_Nula
  else
    Ultimo:= FileSize (self.F);
end;

{-----------------------------------------------------------------}
Function Modelo_Operaciones.Proximo;
begin
  if Pos < Pred (FileSize (self.F)) then
    Proximo:= Succ (Pos)
  else
    Proximo:= _Pos_Nula;
end;

{-----------------------------------------------------------------}
Function Modelo_Operaciones.Anterior;
begin
  if Pos > 0 then
    Anterior:= Pred (Pos)
  else
    Anterior:= _Pos_Nula;
end;

{-----------------------------------------------------------------}
Function Modelo_Operaciones.Vacio;
begin
  Vacio:= FileSize (Self.F) = 0;
end;

{-----------------------------------------------------------------}
Function Modelo_Operaciones.Pos_Nula;
begin
  Pos_Nula:= _Pos_Nula;
end;

{-----------------------------------------------------------------}
Function Modelo_Operaciones.Clave_Nula;
begin
  Clave_Nula:= _Clave_Nula;
end;

{-----------------------------------------------------------------}
Function Modelo_Operaciones.Id_Nulo;
begin
  Id_Nulo:= _Id_Nulo;
end;

{-----------------------------------------------------------------}
Destructor Modelo_Operaciones.Destroy;
begin
  Inherited Destroy;
end;

end.
