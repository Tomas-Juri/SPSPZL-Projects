unit LinearniSeznam;

interface
 uses GeoTvarD;
 Type
   Tukaz=^Tprvek;
   Tseznam=object
                 private
                  active,first,free:^Tprvek;
                 public
                   Constructor InitS();
                   Function EmptyS():boolean;
                   Procedure AddS(D:tucGeoTvar);
                   Function CopyS():tucGeoTvar;
                   Destructor DeleteS();
                   Procedure SuccS();
                   Procedure PredS();
                   Procedure SetFirst();
                 end;
   Tprvek=record
                 dalsi:Tukaz;
                 data:tucGeoTvar;
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
 Procedure Tseznam.AddS(D:tucGeoTvar);
  var  pomoc:^Tprvek;
  begin
   new(pomoc);
   pomoc^.dalsi:=active^.dalsi;
   pomoc^.data:=active^.data;
   active^.data:=D;
   active^.dalsi:=pomoc;
   if (free=active) then free:=pomoc;
  end;
 Function Tseznam.CopyS() :tucGeoTvar;
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
 Procedure Tseznam.SetFirst();
  begin
   active:=first;
  end;

end.



