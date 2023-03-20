unit Unidad_Modelo_Indice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,  Dialogs;

Const
  _Pos_Nula = -1;
  _Clave_Nula = '';
  _Id_Nulo = 0;

Type
  Tipo_Clave = string[60];
  Tipo_Posicion = longint;
  Tipo_Cadena = string[100];

  Tipo_Reg_Indice = record
                      Clave: Tipo_Clave;
                      Pos: Tipo_Posicion;
                      Borrado: boolean;
                    end;

  Tipo_Reg_Control = record
                      Ultimo: Tipo_Posicion;
                      Ruta, Nombre: Tipo_Cadena;
                     end;

  Tipo_Indice = Class
  Protected
    I: File of Tipo_Reg_Indice;
    C: File of Tipo_Reg_Control;
  Public
    Constructor Create (cRuta, cNombre: string); virtual;
    Procedure Abrir;
    Procedure Cerrar;
    Function Buscar (clave: Tipo_Clave; var Pos: Tipo_Posicion; var Borrado: boolean): boolean;   
    Function Buscar_Asiento (clave: Tipo_Clave; var Pos: Tipo_Posicion; var Borrado: boolean): boolean;
    Procedure Insertar (Reg: Tipo_Reg_Indice; Pos: Tipo_Posicion);
    Procedure Eliminar (Pos: Tipo_Posicion);
    Procedure Capturar (Pos: Tipo_Posicion; var Reg: Tipo_Reg_Indice);
    Procedure Modificar (Pos: Tipo_Posicion; var Reg: Tipo_Reg_Indice);
    Function Primero: Tipo_Posicion;
    Function Proximo (pos: Tipo_Posicion): Tipo_Posicion;
    Function Anterior (pos: Tipo_Posicion): Tipo_Posicion;
    Function Ultimo: Tipo_Posicion;
    Function Vacio: boolean;
    Function Borrado (Reg: Tipo_Reg_Indice): boolean;
    Function Pos_Nula: Tipo_Posicion;
    Function Clave_Nula: Tipo_Clave;
    Function Id_Nulo: Tipo_Posicion;
    Procedure Vaciar;
    Destructor Destroy; override;
  end;

implementation

//--------------------------------------------------
Constructor Tipo_Indice.Create;
var
  Ruta: string;
  RC: Tipo_Reg_Control;
begin
  Inherited Create;
  Ruta:= cRuta + '\' + cNombre;
  Assign (Self.C, Ruta + '.CON');
  Assign (Self.I, Ruta + '.NTX');
  if (FileExists (Ruta + '.CON') = false)
      or (FileExists (Ruta + '.NTX') = false) then
    begin
      //Genero Indice
      Rewrite (Self.I);
      Close (Self.I);

      //Genero Control
      Rewrite (Self.C);
      RC.Ultimo:= _Pos_Nula;
      RC.Ruta:= cRuta;
      RC.Nombre:= cNombre;
      Write (Self.C, RC);
      Close (Self.C);
    end;
end;

//--------------------------------------------------
Procedure Tipo_Indice.Abrir;
begin
  Reset (Self.I);
  Reset (Self.C);
end;

//--------------------------------------------------
Procedure Tipo_Indice.Cerrar;
begin
  Close (Self.I);
  Close (Self.C);
end;

//--------------------------------------------------
Function Tipo_Indice.Buscar;
var
  bEncontrado: boolean;
  inicio, final, medio: Tipo_Posicion;
  RI: Tipo_Reg_Indice;
  RC: Tipo_Reg_Control;
begin
  // Busqueda binaria
  // Si la clave existe (activa o borrada) devuelve TRUE y la posición (del Indice) donde se encuentra
  // ----> En el parámetro pbEsBorrado indica si es clave Activa (false) o Borrada  (true)
  // Si la clave no existe devuelve TRUE y la posición (del Indice) donde debería estar

  // Leo archivo de Control
  Seek (self.C,0);
  Read (self.C,RC);

  bEncontrado:= false;
  borrado:= false;

  if RC.Ultimo = _Pos_Nula then
    pos:= 0
  else
    begin
      inicio:= 0;
      medio:= 0;
      final:= pred(FileSize(Self.I));
      while (inicio <= final) and (bEncontrado = false) do
        begin
          medio:= (inicio + final) div 2;
          Seek (Self.I,medio);
          Read (Self.I,RI);
          if clave = RI.Clave then
            bEncontrado:= true
          else
            begin
              if Clave > RI.Clave then
                Inicio:= succ (Medio)
              else
                final:= pred(Medio);
            end;
        end;
      if bEncontrado then
        begin
          pos:= medio;
          borrado:= RI.Borrado;
        end
      else
        if Clave > RI.Clave then
          pos:= succ (Medio)
        else
          pos:= Medio;
    end;
  Buscar:= bEncontrado;
end;

//--------------------------------------------------
Function Tipo_Indice.Buscar_Asiento;
var
  bEncontrado: boolean;
  inicio, final, medio: Tipo_Posicion;
  RI: Tipo_Reg_Indice;
  RC: Tipo_Reg_Control;
begin
  // Busqueda binaria
  // Si la clave existe (activa o borrada) devuelve TRUE y la posición (del Indice) donde se encuentra
  // ----> En el parámetro pbEsBorrado indica si es clave Activa (false) o Borrada  (true)
  // Si la clave no existe devuelve TRUE y la posición (del Indice) donde debería estar

  // Leo archivo de Control
  Seek (self.C,0);
  Read (self.C,RC);

  bEncontrado:= false;
  borrado:= false;

  if RC.Ultimo = _Pos_Nula then
    pos:= 0
  else
    begin
      inicio:= 0;
      medio:= 0;
      final:= pred(FileSize(Self.I));
      while (inicio <= final) and (bEncontrado = false) do
        begin
          medio:= (inicio + final) div 2;
          Seek (Self.I,medio);
          Read (Self.I,RI);
          if StrToDate(clave) = StrToDate(RI.Clave) then
            bEncontrado:= true
          else
            begin
              if StrToDate(Clave) > StrToDate(RI.Clave) then
                Inicio:= succ (Medio)
              else
                final:= pred(Medio);
            end;
        end;
      if bEncontrado then
        begin
          pos:= medio;
          borrado:= RI.Borrado;
        end
      else
        if StrToDate(Clave) > StrToDate(RI.Clave) then
          pos:= succ (Medio)
        else
          pos:= Medio;
    end;
  Buscar_Asiento:= bEncontrado;
end;

//--------------------------------------------------
Procedure Tipo_Indice.Eliminar;
var
  Reg: Tipo_Reg_Indice;
begin
  Seek (Self.I, Pos);
  Read (Self.I, Reg);
  Reg.Borrado:= True;
  Seek (Self.I, Pos);
  Write (Self.I, Reg);
end;

//--------------------------------------------------
Procedure Tipo_Indice.Insertar;
var
  Reg_Actual: Tipo_Reg_Indice;
  RC: Tipo_Reg_Control;
  i: Tipo_Posicion;
begin
  // La rutina inserta en orden, haciendo un desplazamiento de
  // todos los registros por debajo de la <Pos>

  // Leo archivo de Control
  Seek (self.C, 0);
  Read (Self.C, RC);

  for i:= RC.Ultimo downto Pos do
    begin
      Seek (Self.I, i);
      Read (Self.I, Reg_Actual);
      Seek (Self.I, succ(i));
      Write (Self.I, Reg_Actual);
    end;

  // Agrego el nuevo registro en el Indice
  Reg.Borrado:= false;
  Seek (Self.I, Pos);
  Write (Self.I, Reg);

  // Actualizo el archivo de Control
  RC.Ultimo:= succ(RC.Ultimo);
  Seek (self.C, 0);
  Write (Self.C, RC);
end;

//--------------------------------------------------
Procedure Tipo_Indice.Capturar;
begin
  Seek (Self.I, Pos);
  Read (Self.I, Reg);
end;

//--------------------------------------------------
Procedure Tipo_Indice.Modificar;
begin
  Reg.Borrado:= False;
  Seek (Self.I, Pos);
  Write (Self.I, Reg);
end;

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
end;

//--------------------------------------------------
Procedure Tipo_Indice.Vaciar;
var
  RC: Tipo_Reg_Control;
begin
  Close (Self.I);
  Rewrite (Self.I);
  Reset (Self.I);

  Seek (Self.C, 0);
  Read (Self.C, RC);
  RC.Ultimo:= _Pos_Nula;
  Seek (Self.C, 0);
  Write (Self.C, RC);
End;

//--------------------------------------------------
Destructor Tipo_Indice.Destroy;
begin
  Inherited Destroy;
end;


end.
