unit M_Fronta;



interface

type tdata=pointer;
     tu_prvek=^Tprvek;
     tprvek=record
                  dalsi:tu_prvek;
                  data:tdata
                  end;

     Cqueue=object
              private
                celo,konec:tu_prvek;
              public
                constructor init;
                function empty:boolean;
                procedure push(d:tdata);
                procedure remove(var d:tdata);
                destructor destroy;
                function length:word;
            end;

implementation
constructor Cqueue.init;
Begin
  celo:=nil;
  konec:=nil;
end;

function Cqueue.empty:boolean;
Begin
  empty:=(celo=nil)and(konec=nil)
end;

procedure Cqueue.push(d:tdata);
var novy:tu_prvek;
Begin
  new(novy);
  novy^.data:=d;
  novy^.dalsi:=nil;
  if celo = nil then
    celo:=novy
  else
    konec^.dalsi:=novy;
  konec:=novy
end;

procedure Cqueue.remove(var d:tdata);
var smaz:tu_prvek;
Begin
  if empty<>true then begin
    d:=celo^.data;
    smaz:=celo;
    celo:=smaz^.dalsi;
    if celo=nil then
    konec:=nil;
    dispose(smaz)
    end
end;
destructor Cqueue.destroy;
var smaz:tu_prvek;
Begin
  while celo<>nil do begin
    smaz:=celo;
    celo:=smaz^.dalsi;
    dispose(smaz)
  end;
  konec:=nil
end;

function Cqueue.length:word;
var pom:tu_prvek;
    pocetPrvku:word;
Begin
  pocetPrvku:=0;
  pom:=celo;
  while pom<>nil do begin
    inc(pocetPrvku);
    pom:=pom^.dalsi
  end;
  length:=pocetPrvku
end;
end.

