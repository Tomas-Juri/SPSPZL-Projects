program SifrovaniPosunem;
 uses    modul_doublelinkedlist_b,crt,sysutils;
 var    vstup:text;
        vystup:text;
        vystupninazev,vstupninazev,radek,str_mezera:string;
        volba:integer;

 Function Sifrovani(vs_radek:string):string;
     {
        Nacte vetu(radek), zasifruje pomoci posunu, viz zadani cv3_06
        Vraci String cisel oddelenych mezerami, mezera i na konci.
     }

   var Actznak:char;
      SeznamZnaku:T_DLL;
      I,mezera:integer;   //mezera = vysledny kod znaku
      vystup:string;
      smer:boolean;    // true=vpravo, false=vlevo
   begin
    smer:=true;
    SeznamZnaku.InitWithData('ABCDEFGHIJKLMNOPQRSTUVWXYZ ');
    vystup:='';

    for I:=1 to (length(vs_radek)) do              // cyklus pro radek
        begin
         Actznak:=vs_radek[I];
          mezera:=0;
          while actznak<>SeznamZnaku.Getactivedata() do    // cyklus pro pismeno
           begin                                           // sifrovani
             if smer then   //doprava
                 SeznamZnaku.activesucc()
             else            //doleva
                 SeznamZnaku.activepred();
              inc(mezera);
              if  SeznamZnaku.IsActiveheader then mezera:=mezera-1;
            end ;
         str(mezera,str_mezera);                           //prevod mezera[int] na string
         vystup:=vystup+str_mezera+' ';                    //kod pismena + mezera
         smer:=not(smer);                                  //obraceni smeru sifrovani
        end;

    Sifrovani:=vystup;
   end; {Konec funkce Sifrovani}
 Function Desifrovani(vs_radek:string):string;
  {
   Nacte vetu(radek), nacte z vety pouze cisla - do pole
   Pote odsifruje cisla v poli do znaku a ulozi do funkce
  }

 var    SeznamZnaku:T_DLL;
        X,I,kod:integer;
        vystup,znak:string;
        smer:boolean;    // true=vpravo, false=vlevo
  begin
   smer:=true;
   vystup:='';
   X:=0;
   I:=1;
   SeznamZnaku.InitWithData('ABCDEFGHIJKLMNOPQRSTUVWXYZ ');

   I:=0;
   while I<length(vs_radek) do              // desifrovani
    begin
     znak:='';
      while vs_radek[I]<>' ' do
       begin
        znak:=znak+vs_radek[I];
        inc(I);
        val(znak,kod);
       end;
      inc(i);
        For X:=1 to kod do
            begin
               if smer then
                 begin
                    SeznamZnaku.ActiveSucc();
                    if SeznamZnaku.IsActiveHeader then SeznamZnaku.ActiveSucc
                 end
               else
                 begin
                    SeznamZnaku.Activepred();
                    if SeznamZnaku.IsActiveHeader then SeznamZnaku.Activepred
                 end;
            end;
        vystup:=vystup+SeznamZnaku.GetActiveData();
       smer:=not(smer);
    end;

   Desifrovani:=vystup;
  end;  {konec funkce Desifrovani}

begin
  vstupninazev:= paramstr(1);
  vystupninazev:= paramstr(2);
  Assign(vstup,vstupninazev);
  Assign(vystup,vystupninazev);
  Reset(vstup);
  Rewrite(vystup);                           //inicializace souboru a promenych
  writeln('1:sifrovani    2:desifrovani');
  readln(volba);
  case volba of 1: while not(eof(vstup)) do                    //sifrovani po radcich
                    begin
                     Readln(vstup,radek);
                     radek:=Sifrovani(radek);
                     Writeln(vystup,radek);
                    end;
                 2: While not(eof(vstup)) do
                     begin
                      Readln(vstup,radek);
                      radek:=deSifrovani(radek);
                      Writeln(vystup,radek);
                     end;
   end;
  close(vstup);                 //zavreni souboru
  close(vystup);
  writeln('done');
  readln;
end.

