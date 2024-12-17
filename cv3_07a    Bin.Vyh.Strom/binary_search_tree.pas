unit binary_search_tree;

interface
 uses m_fronta; // pruchod do sirky
 Type
      P_Uzel = ^T_Uzel;
      T_Klic = integer;
      T_Uzel = record
                Klic:T_Klic;
                Left,Right:P_Uzel;
               end;
      T_BST = record
                Koren:P_Uzel;
               end;
 Function   Find(Hledany:T_Klic;var Uzel:P_Uzel):P_Uzel;
 Procedure  Delete(var Uzel:P_Uzel; Hodnota:T_Klic);
 Procedure  Destroy(var Uzel:P_Uzel);
 Function   UzelDepth(var Strom:T_BST;Uzel:P_Uzel):integer;
 Procedure  Add(var Strom:T_BST;Klic:T_Klic);
 Procedure  MaxDepth(var Uzel:P_UzeL;var I,max:integer);
 Procedure  Init(var Strom:T_BST);
 Function   Empty(var Strom:T_BST):boolean;
 Procedure  ShowByLevels(var Strom:T_BST);
implementation
 Function    Find(Hledany:T_Klic;var Uzel:P_Uzel):P_Uzel;
  { Vraci adresu uzlu s hledanou hodnotou klice.Pokud nenajde, vraci nil }
  begin
   if Uzel=nil then
     Find:=nil
    else
     if Hledany=Uzel^.Klic then
       Find:=Uzel
      else
       begin
        If Hledany<Uzel^.Klic then
          Find:=Find(Hledany,Uzel^.Left)
         else
          if Hledany>Uzel^.Klic then
            Find:=Find(Hledany,Uzel^.Right)
    end;
  end;
 Procedure   Delete(var Uzel:P_Uzel; Hodnota:T_Klic);
 { Provede smazani uzlu s danou hodnotou.Pokud ma uzel podstrom(y) provede prislusne
   operace prepojeni podstromu.Tato procedura je private, nebot je vyzadovan vstup
   korene, ke kteremu uzivatel nema pristup. }
  var
    Predchozi:P_Uzel;
    Odebiratel:P_Uzel;
  begin
   if Find(Hodnota,Uzel)<>nil then
   if Hodnota<Uzel^.Klic then
     Delete(Uzel^.Left,Hodnota)
    else
     if Hodnota>Uzel^.Klic then
       Delete(Uzel^.Right,Hodnota)
       else

  begin
   Odebiratel:=nil;
   if Uzel^.Left=nil then
     Uzel:=Uzel^.Right
    else
     If Uzel^.Right=nil then
       Uzel:=Uzel^.Left
      else
       begin
        Predchozi:=nil;
        Odebiratel:=Uzel^.Left;
        while Odebiratel^.right<>nil do
         begin
          Predchozi:=Odebiratel;
          Odebiratel:=Odebiratel^.Right;
         end;
        Uzel^.Klic:=Odebiratel^.Klic;
        If Predchozi=nil then
          Uzel^.Left:=Odebiratel^.Left
         else
          Predchozi^.Right:=Odebiratel^.Left
      end;
    Dispose(Odebiratel);
   end;
  end;
 Procedure   Destroy(var Uzel:P_Uzel);
  { Provede Zruseni celeho stromu pomoci postupu postorder }
  begin
   if uzel <> nil then begin
   Destroy(uzel^.Left);
   Destroy(uzel^.Right);
   dispose(uzel);
   uzel:= nil;
   end;
  end;
 Function    UzelDepth(var Strom:T_BST;Uzel:P_Uzel):integer;
  { Vraci cislo hladiny, na ktere se uzel nachazi - koren se nachazi na hladine 0 }
  var
    I:integer;
    Hledac:P_Uzel;
  begin
   Hledac:=Strom.Koren;
   I:=0;
   while ((Hledac<>nil) and (Hledac^.Klic<>Uzel^.klic)) do
    begin
     if Uzel^.klic<Hledac^.Klic then
      Hledac:=Hledac^.Left
     else
      Hledac:=Hledac^.Right;
     Inc(I);
    end;
     UzelDepth:=I;
  end;
 Procedure   Add(var Strom:T_BST;Klic:T_Klic);
  { Prida prvek s klicem do stromu (pokud se zde jiz nenachazi) }
  var lokator,predchozi:P_Uzel;
  begin
   if empty(Strom) then
     begin
      new(Strom.Koren);
      Strom.koren^.Klic:=Klic;
      Strom.koren^.Left:=nil;
      Strom.koren^.Right:=nil;
     end
    else
     begin
      lokator:=Strom.Koren;
      while lokator<>nil do
       begin
        predchozi:=lokator;
        if lokator^.Klic>Klic then
          begin
           lokator:=lokator^.Left
          end
         else
          if lokator^.Klic<Klic then
            lokator:=lokator^.Right;
       end;
       if klic<predchozi^.klic then
         begin
          new(predchozi^.Left);
          predchozi^.Left^.klic:=klic;
          predchozi^.Left^.Left:=nil;
          predchozi^.Left^.Right:=nil
         end
        else
         begin
          new(predchozi^.Right);
          predchozi^.Right^.klic:=klic;
          predchozi^.Right^.Left:=nil;
          predchozi^.Right^.Right:=nil;
         end;
     end;
  end;
 Procedure   MaxDepth(var Uzel:P_UzeL;var I,Max:integer);
  { Treti parametr procedury vraci maximalni hloubku stromu }
  begin
   if Uzel^.Left<>nil then
     begin
      inc(i);
      MaxDepth(Uzel^.Left,I,Max)
     end;
   If Uzel^.Right<>nil then
     begin
      inc(i);
      MaxDepth(Uzel^.Right,I,Max);
     end;
   if Max<I then Max:=I;
   Dec(i);
  end;
 Function    Empty(var Strom:T_BST):boolean;
  {Pokud je strom prazdny, vraci true, v opacnem pripadne false}
  begin
   Empty:=(Strom.koren=nil);
  end;
 Procedure   Init(var Strom:T_BST);
 {Provede inicializaci binarniho vyhledavaciho stromu}
  begin
   Strom.koren:=nil;
  end;
 Procedure   ShowByLevels(var Strom:T_BST);
  { Vypise na obrazovku hodnoty klicu po hladinach, kazda hladina je na jednom
    radku. Vyuziva frontu }
  var Fronta:Cqueue;
      active:P_Uzel;
      convertor:pointer;
      nextlevel:integer; //aktualni hladina
  begin
   Fronta.init();
   Fronta.push(Strom.koren);
   nextlevel:=0;
   while not(Fronta.empty) do
    begin
     Fronta.Remove(convertor);    //vytahne prvek z fronty
     active:=convertor; // convertor obsahuje adresu uzlu, neni vsak ukazatelem na uzel
     if active^.Left<>nil then
       Fronta.Push(active^.Left);
     if active^.Right<>nil then
         Fronta.Push(active^.Right);
     if (nextlevel<>UzelDepth(Strom,active)) then
      begin           //posun na dalsi hladinu
       nextlevel:=UzelDepth(Strom,active);
       writeln();
      end;
     write(active^.klic,' ');
    end;
  end;
end.

