unit number_generator;

interface
 uses modul_doublelinkedlist_B; // Vytahovani nahodnych cisel

 Procedure GenerujMnoziny(jmeno:string);
implementation

 Procedure GenerujMnoziny(jmeno:string);
 { Nacte do DLL cisla 1-500 a pote vytahne nahodnych 150 cisel a ulozi jej do
   souboru m1.dat, pote provede tuto samou operaci a ulozi vysledek do m2.dat }
 var SeznamCisel :T_DLL;
     I,Z,radek,d :integer;
     Data :text;

 begin
  SeznamCisel.InitL();
  radek:=0;
  For I:=1 to 500 do
   begin
     SeznamCisel.AddDalsi(I);
   end;

  Assign(data,jmeno);    //  Inicializace souboru
  rewrite(data);        //

  For I:=1 to 150 do              // Generovani nahodnych cisel do souboru
   begin
    SeznamCisel.SetActToRandom();
    Z:=SeznamCisel.ReadActive();
    If Z>99 then
      D:=3           // D = pocet cifer vkladaneho cisla
     else
      if Z>9 then
        D:=2
       else
        D:=1;
    if radek+D>65 then
      begin
       writeln(data,'');
       radek:=D;
      end
     else
      radek:=radek+D;
    write(data,Z);
    write(data,' ');
    inc(radek);
    SeznamCisel.DeleteActive();
   end;
  close(data);
 end;

end.

