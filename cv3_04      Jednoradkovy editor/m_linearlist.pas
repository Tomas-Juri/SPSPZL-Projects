unit M_LinearList;

interface
uses
  crt;
type
    T_data=char;
    TP_prvek=^T_prvek;
    T_prvek=record
      dalsi:^T_prvek;
      data:T_Data;
    end;
    T_list=object
          private
            first,active,free:^T_prvek;
          public
            constructor Init;
            function  Empty:boolean;
            function Copy:T_data;
            procedure Add(d:T_Data);
            procedure Delete;
            procedure Pred;
            procedure Succ;
            destructor Destroy;
            function  Length:integer;
            function  Search(D:T_Data):TP_prvek;
            function Show:string;
            procedure AddDalsi(data:T_Data);
            function IsFirst:boolean; // active je prvni - true
            function IsLast:boolean;  // active je posledni - true
    end;
implementation
constructor T_list.Init;
 var      novy:^T_prvek;
 begin
  new(novy);
  novy^.dalsi:=nil;
  novy^.data:=' ';
  first:=novy;
  active:=novy;
  free:=novy;
 end;
function T_List.Empty():boolean;   // prazdny = true
 begin
  Empty:=(first=free);
 end;
function T_List.Copy():T_Data;   //vyzvedne data z active
 begin
  if (T_List.Empty=false) then Copy:=active^.data;
 end;
procedure T_List.Add(d:T_Data); //pridej prvek pred active
 var pridany:^T_prvek;
     posun:boolean;
 begin
  new(pridany);
  if active<>free then
   begin
    pridany^.dalsi:=active^.dalsi;
    pridany^.data:=active^.data;
   end
  else begin
   free:=pridany;
   pridany^:=active^;
  end;

  active^.dalsi:=pridany;
  active^.data:=d;
  if active=free then Pred() else Succ();
 end;
procedure T_List.Delete;     // smaz prvek
 var      pomoc:^T_prvek;
 begin
  if (active<>free) then
                            begin
                             pomoc:=active^.dalsi;
                             active^.data:=pomoc^.data;
                             active^.dalsi:=pomoc^.dalsi;
                             If pomoc=free then free:=active;
                             dispose(pomoc)
                            end;
 end;
procedure T_List.Succ;        // dalsi
 begin
  If not(active=free) then active:=active^.dalsi;
 end;
procedure T_List.Pred;        // predchozi
 var pomoc:^T_prvek;

 begin
  if (active<>first) and (T_List.Empty<>true) then
     begin
      pomoc:=first;
      while pomoc^.dalsi<>active do pomoc:=pomoc^.dalsi;
      active:=pomoc;
     end;
 end;
destructor T_List.Destroy;    // včetně free
 var pomoc:^T_prvek;
 begin
  if not T_List.Empty then
  begin
   pomoc:=first;
  while pomoc<>free do
    begin
     pomoc:=first;
     first:=first^.dalsi;
     dispose(pomoc)
    end;
  free:=nil;
  active:=nil
  end
 end;
function  T_List.Length():integer;
 var pomoc:^T_prvek;
     pocet:integer;
 begin
 pocet:=0;
 pomoc:=first;
 while pomoc<>free do
                        begin
                         pomoc:=pomoc^.dalsi;
                         inc(pocet)
                        end;
 Length:=pocet;
 end;
function  T_List.Search(D:T_Data):TP_prvek;
 var pomoc:^T_prvek;

 begin
 pomoc:=first;
 free^.data:=D;
 while pomoc^.data<>D do pomoc:=pomoc^.dalsi;
 free^.data:=' ';
 If pomoc=free then pomoc:=nil;
 Search:=pomoc
 end;
function T_List.Show:string;
 var pomoc:^T_prvek;
     vypis:string;
     I:integer;
 begin
 pomoc:=first;
 vypis:='';
 I:=1;
   while pomoc<>free do
    begin
     vypis:=vypis+pomoc^.data;
     pomoc:=pomoc^.dalsi;
     I:=I+1;
    end;
   Show:=vypis;
 end;
procedure T_List.AddDalsi(data:T_Data);
 var novy:^T_prvek;

 begin
 if (NOT T_List.Empty) AND (active<>free) then
  begin
   new(novy);
   novy^.data:=data;
   novy^.dalsi:=active^.dalsi;
   active^.dalsi:=novy
  end
 end;

function T_List.IsLast:boolean;
 begin
  IsLast:=(active=free);
 end;
function T_List.IsFirst:boolean;
 begin
  Isfirst:=(active=first);
 end;
end.


