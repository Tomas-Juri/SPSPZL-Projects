unit MorseUnit;

interface
 uses binary_search_tree_obj,sysutils;

 const PoleMorse:array [65 .. 90] of string[4]=
                    ('.-', '-...','-.-.','-..','.','..-.','--.','....',
                     '..','.---','-.-','.-..','--','-.','---','.--.','--.-','.-.',
                     '...','-','..-','...-','.--','-..-','-.--','--..');
                    {a,b,c,d,e,f,g,h
                     i,j,k,l,m,n,o,p,q,r
                     s,t,u,v,w,x,y,z}            // neobsahuje CH, reseno ifem

  Procedure Kodovani(nvstup,nvystup:string);
  Procedure DeKodovani(nvstup,nvystup:string);
implementation

  Procedure Kodovani(nvstup,nvystup:string);
  { Otevre vstupni textovy soubor, a zakoduje jej pomoci morseovy abecedy podle
    zpusobu popsanem v prilozenem zadani }
   var vstup,vystup :text;
       radek,kodzn  :string;
       I            :integer;
       znak         :char;

  begin
   Assign(vstup,nvstup);         //
   Assign(vystup,nvystup);       // Inicializace promenych
   Reset(vstup);                 //
   Rewrite(vystup);              //

   While EOF(vstup)=false do     // cyklus pro soubor
    begin
     ReadLn(vstup,radek);
     for I:= 1 to (Length(radek)) do    // cyklus pro radek
      begin
       znak:=radek[I];
       if (znak<>' ') then
         begin
          kodzn:=PoleMorse[ord(UpCase(znak))];    // Vybira znak z m. abecedy
          if upcase(radek[I])='C' then            // pokud nalezeno pismeno C je treba zjistit, zda se nejedna o CH
            if radek[I+1]='H' then
              kodzn:='----';
          write(vystup,kodzn);
          write(vystup,'/');
         end
        else
         write(vystup,'/');              // konec slova
      end;
     if length(radek)<1 then
       writeln(vystup,'')
      else
       writeln(vystup,'/');

    end;
   close(vstup);
   close(vystup);
  end;

 Procedure Dekodovani(nvstup,nvystup:string);
 {Dekoduje zpravu zapsanou v morseove abecede, ktera je ulozena v souboru, vyuziva
  BVS, koren je prazdny, posunem doleva ziskavame tecku, posunem doprava carku}
  var StromMorse   :T_BST;
      vstup,vystup :text;
      radek,kodzn  :string;
      I            :integer;
  begin
   StromMorse.Init();            //
   StromMorse.CreateMorse();     //
   Assign(vstup,nvstup);         //
   Assign(vystup,nvystup);       // Inicializace
   Reset(vstup);                 //
   Rewrite(vystup);              //
   kodzn:='';                    //
   I:=1;                         //

   While EOF(vstup)=false do        // Cyklus pro soubor
    begin
     Readln(vstup,radek);
     while I<length(radek) do   // Cyklus pro radek
      begin
       if radek[I]='/' then
           begin
            Write(vystup,StromMorse.GetMorseCode(kodzn)); // znak kodu precten
            kodzn:='';
            if radek[I+1]='/' then
              begin                //dalsi slovo
               Write(vystup,' ');
               inc(I);
              end
           end
        else
         kodzn:=kodzn+radek[I];   // dalsi '.'/'-'
       inc(I);
      end;
     writeln(vystup,'');         // dalsi radek
     I:=1;
    end;
   close(vstup);
   close(vystup);
  end;

end.

