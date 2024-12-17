program SimulaceVypravy;

 uses class_vyprava, modul_serpa, LinearniSeznam, crt;


 var
   Vyprava                   :C_Vyprava;
   PocetVypadnuti            :Integer;
   Menu                      :1..5;
   PointHelp,PocetKroku      :integer;
   konec                     :boolean;
   Vypadlo                   :integer;           // Pocita kolik vypadlo serpu
 Function  GetVypadnuti():boolean;
  { Vraci,zda v danem kroku vypadne serpas }
  var nahoda:integer;
  begin
   nahoda:=random(3);
   if (nahoda mod 3) = 0 then
     GetVypadnuti:=true
    else
     GetVypadnuti:=false;
  end;
 Function  GetPocetVypadnuti(pocet:integer):integer;
  { Vraci, kolik celkove odpadne serpu za celou cestu}
  var procento:real;
  begin
   procento:=(random(10)+30)/100;
   GetPocetVypadnuti:=trunc(procento*pocet);   // 30-40% serpu vypadne
   if frac(procento*pocet)>=0.5 then           // Zaokrouhleni
    Inc(GetPocetVypadnuti);
  end;
 Procedure StartVyprava(var Pocatek:C_Vyprava);
  { Provede inicializaci vypravy, vytvori serpy (1-20) podle procedury a urci
    kolik serpu vypadne za celou cestu (30-40%) }
  begin
   Pocatek.InitS();
   Pocatek.VytvorVypravu();
   PocetVypadnuti:=GetPocetVypadnuti(Pocatek.Length());
  end;
 Procedure ShowVyprava(var Vyprava:C_Vyprava);
 { Vypis serpu vypravy s vlastnostmi serpu }
  var I,X    :integer;
      Pomoc  :P_Serpa;
  begin
   Vyprava.ActToFirst();
   For I:=1 to Vyprava.Length() do
    begin
     Pomoc:=Vyprava.CopyS();
     Write('|',Pomoc^.Jmeno);
     For X:=1 to(6-length(Pomoc^.Jmeno)) do  // uprava sloupce
      begin
       Write(' ');
      end;
     Write('|');
     Write('   ',Pomoc^.Naklad);
     if Pomoc^.Naklad<10 then     // uprava sloupce
      write(' ');
     Write('   |');
     If Pomoc^.Puvodni then
       Writeln('  ANO    |')
      else
       Writeln('  NE     |');
     Vyprava.SuccS();
    end;
  end;
 Procedure PridejSerpuUzivatel();
  { Uzivatelske pridani serpy pomoci, nelze generovat serpy kteri jsou jiz ve vyprave
    - male a velka pismena jsou rozlisena (case sensitive), nelze generovat serpu s
    nakladem vetsi nez 75 }
  var NoveJmeno   :T_Jmeno;
      NovyNaklad  :integer;
      PointHelpB  :integer;
      NovyS       :P_Serpa;
  begin
   PointHelpB:=WhereY;
   write('Zadejte jmeno serpy (maximalne 6 znaku) : ');
   Readln(NoveJmeno);
   While Vyprava.JePritomen(NoveJmeno) do    // Uzivatel zadal jmeno serpy ktery je jiz ve vyprave
    begin
     GotoXY(1,PointHelpB);
     DelLine;
     write('Zadejte jmeno serpy ktery jiz neni ve vyprave : ');
     Readln(NoveJmeno);
    end;
   PointHelpB:=WhereY;
   write('Zadejte naklad, ktery ponese (0-75) : ');
   Readln(NovyNaklad);
   While NovyNaklad>75 do         // Uzivatel zadal naklad vetsi nez 75
    begin
     GotoXY(1,PointHelpB);
     DelLine;
     write('Zadejte prosim naklad v rozmezi 0-75kg: ');
     Readln(NovyNaklad);
    end;
   NovyS:=ZavolejNoveho();            // Vytvoreni noveho serpy, puvodni=false
   NovyS^.Jmeno:=NoveJmeno;
   NovyS^.Naklad:=NovyNaklad;
   Vyprava.AddS(NovyS);
   Writeln('Byl vytvoren novy serpa, pokracujte stisknutim [ENTER] ');
  end;
 Procedure OdeberSerpuUzivatel();
  { Uzivatelske odebrani serpy, uzivatel zada jmeno serpy, ktere jednoznacne urcuje
    o ktereho se jedna, posune na nej active a provede smazani bez prerozdeleni nakladu
    pomoci pravidel v zadani }
  var OdebererJmeno:string;
      PointHelpB:integer;
  begin
   PointHelpB:=WhereY;
   write('Zadejte jmeno serpy (maximalne 6 znaku) : ');
   Readln(OdebererJmeno);
   While Vyprava.JePritomen(OdebererJmeno)=false do    // Uzivatel zadal jmeno serpy,ktery neni pritomen
    begin
     GotoXY(1,PointHelpB);
     DelLine;
     write('Zadejte jmeno serpy ktery je ve vyprave : ');
     Readln(OdebererJmeno);
    end;
   Vyprava.SetActToJmeno(OdebererJmeno);               // Posun active na daneho serpu
   Vyprava.DeleteS();                                  // Smazani
   Writeln('Serpa byl smazan, pokracujte stisknutim [ENTER] ');
  end;
 Procedure ZmenaZatezeUzivatel();
  var ZmenJmeno:string;
      NovyNaklad:integer;
      PointHelpB:integer;
  begin
   PointHelpB:=WhereY;
   write('Zadejte jmeno serpy (maximalne 6 znaku) : ');
   Readln(ZmenJmeno);
   While Vyprava.JePritomen(ZmenJmeno)=false do    // Uzivatel zadal jmeno serpy,ktery neni pritomen
    begin
     GotoXY(1,PointHelpB);
     DelLine;
     write('Zadejte jmeno serpy ktery je ve vyprave : ');
     Readln(ZmenJmeno);
    end;
   PointHelpB:=WhereY;
   write('Zadejte novy naklad, ktery ponese (0-75) : ');
   Readln(NovyNaklad);
   While NovyNaklad>75 do         // Uzivatel zadal naklad vetsi nez 75
    begin
     GotoXY(1,PointHelpB);
     DelLine;
     write('Zadejte prosim naklad v rozmezi 0-75kg: ');
     Readln(NovyNaklad);
    end;
  Vyprava.SetActToJmeno(ZmenJmeno);
  Vyprava.CopyS()^.Naklad:=NovyNaklad;
  WriteLn('Serpovi byla pozmenena zatez, pokracujte stisknutim [ENTER]');
  end;
 Procedure ZobrazKonec();
  { Vypis pri skonceni vypravy }
  begin
   Writeln('Byla ukoncena vyprava');
   Writeln('Pocet kroku: ',PocetKroku);
   Writeln('Vypadlo serpu: ',Vypadlo);
   Writeln('Konec po [ENTER]');
  end;

 begin
  clrscr;
  Vypadlo:=0;
  konec:=false;
  randomize;
  StartVyprava(Vyprava);
  PocetKroku:=0;
  Writeln('Byla Zapocnuta vyprava');                    // Uvodni vypis
  Writeln('-------------------------------');           //
  Writeln('Pocet Serpu:     ', Vyprava.Length());       //
  Writeln('Celkovy naklad:  ',Vyprava.CelkovyNaklad);   //
  Writeln('Za cestu vypadne:',PocetVypadnuti);          //
  Writeln('-------------------------------');           //
  Writeln('Pokracovani po [ENTER]');                    // Tento vypis se objevi pouze jednou
  ReadLn;

 repeat
  ClrScr;
  Writeln('|Jmeno | Naklad | Puvodni |');               // Vypis Jmen serpu
  Writeln('|------|--------|---------|');               //
  ShowVyprava(Vyprava);                                 //
  Writeln('|------|--------|---------|');               //
  PointHelp:=crt.WhereY;                                // Zarazka kde ma pokracovat vypis

  GotoXY(30,1);                                         // Uspora mista - zacne se psat vedle tabulky
  Write('Moznosti:');                                   //
  GotoXY(30,2);                                         //
  Writeln('1.Pokracovat v ceste');                      //
  GotoXY(30,3);                                         //
  Writeln('2.Pridani serpy');                           //
  GotoXY(30,4);                                         //
  Writeln('3.Odebrani serpy');                          //
  GotoXY(30,5);                                         //
  Writeln('4.Upravit Zatez Serpy');                     //
  GotoXY(30,6);                                         //
  Writeln('5.Ukoncit vypravu');                         //
  GotoXY(1,PointHelp);                                  // Vraceni zpet pod tabulku
  PointHelp:=WhereY;
  While PointHelp<7 do        // Prilis kratka vyprava dela chyby ve vypisu
   begin                      // Osetreno posunutim kurzoru
    GotoXY(1,PointHelp+1);
    PointHelp:=WhereY;
   end;

  If PocetVypadnuti=0 then
    Writeln('Zadni dalsi serpove jiz nevypadnou');

  Readln(Menu);                                         // Vyber moznosti
  Case Menu of  1:begin    // Pokracovani v ceste
                   if PocetVypadnuti>0 then
                    if GetVypadnuti()=true then
                      begin
                       Dec(PocetVypadnuti);
                       Vyprava.SmazSerpu();
                       inc(Vypadlo);
                      end
                     else
                      writeln('V tomto kroku nevypadl zadny serpa');
                   inc(PocetKroku);
                  end;
                2:begin    // Pridani serpy
                   PridejSerpuUzivatel();
                   PocetVypadnuti:=GetPocetVypadnuti(Vyprava.Length());
                  end;
                3:begin    // Odebrani serpy
                   OdeberSerpuUzivatel();
                   If Vyprava.GetPocetPuvodnich()<PocetVypadnuti then
                    { Pokud by ve vyprave uzivatel smazal dostatek serpu, doslo by k
                      zacykleni pri generovani serpy ktery ma vypadnout }
                    dec(PocetVypadnuti);
                  end;
                4:begin    // Zmena zateze serpy
                   ZmenaZatezeUzivatel();
                  end;
                5:begin    // Konec vypravy
                   konec:=true;
                   ZobrazKonec();
                  end;

   end;
  Readln;
 until konec

 end.

