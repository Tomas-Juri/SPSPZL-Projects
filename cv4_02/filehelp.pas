unit filehelp;

{$mode objfpc}{$H+}

interface
 function souborJe(cesta:string):boolean;
implementation
 function souborJe(cesta:string):boolean;
 // testuje existenci souboru
  var pomoc : file;
      kontrola: boolean;

  begin
     assign(pomoc,cesta);
     {$I-} reset(pomoc); {$I+} (* vypne/zapne kontrolu IO operaci *)
     kontrola := (IORESULT = 0) and ( cesta<>'');
     if kontrola then
       close(pomoc);

     souborJe := kontrola;
     end; {souborJe }

end.

