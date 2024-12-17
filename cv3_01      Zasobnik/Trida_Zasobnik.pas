unit Trida_Zasobnik;
interface
 Type
   Tdata=char;
   Tu_prvek=^Tprvek;
   Tprvek=record
                dalsi:Tu_prvek;
                data:Tdata;
                end;
   Tstack=object
                private
                vrchol:Tu_prvek;
                public
                  Constructor Init_s();
                  Function Empty_s():boolean;
                  Procedure Push_s(d:Tdata);
                  Function Depth_s():integer;
                  Destructor  Destroy_s();
                  Function Pull_s():Tdata;
                  Function CteniVetyP(veta:string):string;
                end;


implementation
 Constructor Tstack.Init_s();
  begin
    vrchol:=nil;
  end;
 Function Tstack.Empty_s():boolean;
  begin
    empty_s:=(vrchol=nil);
  end;
 Procedure Tstack.Push_s(d:Tdata);
  var novy:Tu_prvek;
  begin
   New(novy);
   novy^.data:=D;
   novy^.dalsi:=vrchol;
   vrchol:=novy;
  end;
 Function Tstack.Depth_s():integer;
  var pocet:integer;
      pomoc:Tu_prvek;
  begin
   pocet:=0;
   while vrchol<>nil  do
    begin
      pocet:=pocet+1;
      pomoc:=vrchol^.dalsi;
      vrchol:=pomoc;
    end;
   Depth_s:=pocet;
  end;
 Destructor  Tstack.Destroy_s();
  var ukazatel:TU_prvek;
  begin
   while vrchol<>nil do
    begin
     ukazatel:=vrchol^.dalsi;
     dispose(vrchol);
     vrchol:=ukazatel;
    end;
   dispose(vrchol);
   vrchol:=nil;
  end;
 Function Tstack.Pull_s():Tdata;
  var data:Tdata;
      pomoc:Tu_prvek;
  begin
   pomoc:=nil;
   data:=vrchol^.data;
   pomoc:=vrchol^.dalsi;
   dispose(vrchol);
   vrchol:=pomoc;
   pomoc:=nil;
   Pull_s:=data;
  end;
 Function Tstack.CteniVetyP(veta:string):string;
  var I:integer;
      pozpatku:char;
      veticka:string;
  begin
   init_s();
   for I:=1 to length(veta) do
     push_s(veta[I]);
   for I:=1 to length(veta) do
     begin
     pozpatku:=Pull_s();
     veticka:=veticka + pozpatku;
     end;
   CteniVetyP:=veticka;
  end;

end.

