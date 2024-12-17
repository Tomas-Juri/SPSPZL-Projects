unit LinearniSeznam;

interface
 uses
   modul_serpa;
 Type
   Tukaz=^Tprvek;
   Tdata=P_Serpa;
   Tseznam=object
                 private
                  active,first,free:^Tprvek;
                 public
                   Constructor InitS();
                   Function    EmptyS():boolean;
                   Procedure   AddS(D:Tdata);
                   Function    CopyS():Tdata;
                   Procedure  DeleteS();
                   Procedure   SuccS();
                   Procedure   PredS();
                   Function    Length():integer;
                   Procedure   ActToFirst();
                   Function    IsActFree():Boolean;
                 end;
   Tprvek=record
                 dalsi:Tukaz;
                 data:Tdata;
   end;
implementation
 Constructor Tseznam.InitS();
  var pomoc:^Tprvek;
  begin
   new(pomoc);pomoc^.dalsi:=nil;pomoc^.data:=nil;
   free:=pomoc;
   active:=pomoc;
   first:=pomoc;
  end;
 Function Tseznam.EmptyS():boolean;
  begin
   EmptyS:=(active^.data=nil) and (first^.data=nil) and (free^.data=nil);
  end;
 Procedure Tseznam.AddS(D:Tdata);
  var  pomoc:^Tprvek;
  begin
   new(pomoc);
   pomoc^.dalsi:=active^.dalsi;
   pomoc^.data:=active^.data;
   active^.data:=D;
   active^.dalsi:=pomoc;
   if (free=active) then free:=pomoc;
  end;
 Function Tseznam.CopyS() :Tdata;
 begin
  if not EmptyS() then
  CopyS :=active^.data
 end;
 Procedure Tseznam.DeleteS();     // smazani prvku
  var smaz :^Tprvek;
 begin
  if active = first then
    begin
     active:=active^.dalsi;
     dispose(first);
     first:=active;
    end
   else
  if active <> free then begin
   PredS();
   smaz :=active^.dalsi;
   active^.dalsi:=smaz^.dalsi;
   if smaz = free then
    free :=active;
   dispose(smaz^.data);
   dispose(smaz)
  end
 end;
 Procedure Tseznam.SuccS();
 begin
  if active <> free then
   active :=active^.dalsi
 end;
 Procedure Tseznam.PredS();
  var pom :^Tprvek;
 begin
  if active <> first then
  begin
   pom :=first;
   while pom^.dalsi <> active do
    pom :=pom^.dalsi;
   active :=pom;
  end
 end;
 Function Tseznam.Length():integer;
  var pocet:integer;
      pomoc:Tukaz;
  begin
   pomoc:=first;
   pocet:=0;
   while pomoc<>free do
    begin
      pocet:=pocet+1;
      pomoc:=pomoc^.dalsi;
    end;
   Length:=pocet;
  end;
 Procedure Tseznam.ActToFirst();
  Begin
   active:=first;
  end;
 Function Tseznam.IsActFree():boolean;
  begin
   IsActFree:=(active=free);
  end;

end.



