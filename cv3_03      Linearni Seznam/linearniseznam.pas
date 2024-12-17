unit LinearniSeznam;

interface
 Type
   Tukaz=^Tprvek;
   Tseznam=object
                 private
                  active,first,free:^Tprvek;
                 public
                   Constructor InitS();
                   Function EmptyS():boolean;
                   Procedure AddS(D:char);
                   Function CopyS():char;
                   Destructor DeleteS();
                   Procedure SuccS();
                   Procedure PredS();
                   Procedure ShowS();
                 end;
   Tprvek=record
                 dalsi:Tukaz;
                 data:char;
   end;
implementation
 Constructor Tseznam.InitS();
  var pomoc:^Tprvek;
  begin
   new(pomoc);pomoc^.dalsi:=nil;pomoc^.data:=' ';
   free:=pomoc;
   active:=pomoc;
   first:=pomoc;
  end;
 Function Tseznam.EmptyS():boolean;
  begin
   EmptyS:=(active^.data='') and (first^.data='') and (free^.data='');
  end;
 Procedure Tseznam.AddS(D:char);
  var  pomoc:^Tprvek;
  begin
   new(pomoc);
   pomoc^.dalsi:=active^.dalsi;
   pomoc^.data:=active^.data;
   active^.data:=D;
   active^.dalsi:=pomoc;
   if (free=active) then free:=pomoc;
  end;
 Function Tseznam.CopyS() :char;
 begin
  if not EmptyS() then
  CopyS :=active^.data
 end;
 Destructor Tseznam.DeleteS();
  var smaz :^Tprvek;
 begin
  if active <> free then begin
   smaz :=active^.dalsi;
   active^ :=smaz^;
   if smaz = free then
    free :=active;
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
  if active <> first then begin
  pom :=first;
  while pom^.dalsi <> active do
   pom :=pom^.dalsi;
  active :=pom
  end
 end;
 Procedure Tseznam.ShowS();
 var pom, zar :^Tprvek;
begin
 zar :=active;
 active :=first;
 while (active <> free) do begin
   pom :=active;
   write(pom^.data);
   active :=pom^.dalsi
 end;
 writeln;
 active :=first;
 while (active <> zar) do begin
  pom :=active;
  write(' ');
  active :=pom^.dalsi
 end;
 write('^')
end;
end.



