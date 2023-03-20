unit Unidad_Modelo_BackUp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,  Dialogs;

Const
  _Pos_Nula = -1;
  _Clave_Nula = '';
  _Id_Nulo = 0;

Type
  Tipo_Clave = string[20];
  Tipo_Posicion = longint;
  Tipo_Cadena = string[100];

  Tipo_Reg_BackUp = record
                      Ruta_Archivos, Ruta_BackUp, Nombre_Empresa, Fecha: Tipo_Cadena;
                     end;

  Modelo_BackUp = Class
  Protected
    C: File of Tipo_Reg_BackUp;
  Public
    Constructor Create (cRuta, cNombre: string); virtual;
    Procedure Abrir;
    Procedure Cerrar;
    Procedure Capturar (var Reg: Tipo_Reg_BackUp);
    Procedure Modificar (var Reg: Tipo_Reg_BackUp);
    {Function Ultimo: Tipo_Posicion;
    Function Vacio: boolean;
    Function Pos_Nula: Tipo_Posicion;
    Function Clave_Nula: Tipo_Clave;
    Function Id_Nulo: Tipo_Posicion;  }
    Destructor Destroy; override;
  end;

implementation

//--------------------------------------------------
Constructor Modelo_BackUp.Create;
var
  Ruta: string;
  RC: Tipo_Reg_BackUp;
begin
  Inherited Create;
  Ruta:= cRuta + '\' + cNombre;
  Assign (Self.C, Ruta + '.bck');
  if (FileExists (Ruta + '.bck') = false) then
    begin
      //Genero Control
      Rewrite (Self.C);
      Close (Self.C);
    end;
end;

//--------------------------------------------------
Procedure Modelo_BackUp.Abrir;
begin
  Reset (Self.C);
end;

//--------------------------------------------------
Procedure Modelo_BackUp.Cerrar;
begin
  Close (Self.C);
end;

//--------------------------------------------------
Procedure Modelo_BackUp.Capturar;
begin
  Seek (Self.C, 0);
  Read (Self.C, Reg);
end;

//--------------------------------------------------
Procedure Modelo_BackUp.Modificar;
begin
  Seek (Self.C, 0);
  Write (Self.C, Reg);
end;
{
//--------------------------------------------------
Function Tipo_Indice.Borrado;
begin
  Borrado:= Reg.Borrado;
end;

//--------------------------------------------------
Function Tipo_Indice.Primero;
var
  RC: Tipo_Reg_Control;
begin
  // Leo archivo de Control
  Seek (Self.C, 0);
  Read (Self.C, RC);

  if RC.Ultimo = _Pos_Nula then
    Primero:= _Pos_Nula
  else
    Primero:= 0;
end;

//--------------------------------------------------
Function Tipo_Indice.Ultimo;
var
  RC: Tipo_Reg_Control;
begin
  // Leo archivo de Control
  Seek (Self.C, 0);
  Read (Self.C, RC);

  Ultimo:= RC.Ultimo;
end;

//--------------------------------------------------
Function Tipo_Indice.Proximo;
begin
  if Pos < Pred (FileSize (self.I)) then
    Proximo:= Succ (Pos)
  else
    Proximo:= _Pos_Nula;
end;

//--------------------------------------------------
Function Tipo_Indice.Anterior;
begin
  if Pos > 0 then
    Anterior:= Pred (Pos)
  else
    Anterior:= _Pos_Nula;
end;

//--------------------------------------------------
Function Tipo_Indice.Pos_Nula;
begin
  Pos_Nula:= _Pos_Nula;
end;

//--------------------------------------------------
Function Tipo_Indice.Vacio;
begin
  Vacio:= FileSize (Self.I) = 0;
end;

//--------------------------------------------------
Function Tipo_Indice.Clave_Nula;
begin
  Clave_Nula:= _Clave_Nula;
end;

//--------------------------------------------------
Function Tipo_Indice.Id_Nulo;
begin
  Id_Nulo:= _Id_Nulo;
end; }

//--------------------------------------------------
Destructor Modelo_BackUp.Destroy;
begin
  Inherited Destroy;
end;


end.
