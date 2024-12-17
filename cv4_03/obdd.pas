unit ObdD;

interface

uses GeoTvarD;

type tucObd =^cObd;
     cObd = OBJECT (cGeoTvar)
               private
                 a, b :real;
               public
                 constructor init(aa, ab :real);
                 function urciObvod :real; VIRTUAL;
                 destructor done; VIRTUAL;
             end;

implementation

constructor cObd.init(aa, ab :real);
begin
  a :=aa;
  b :=ab
end;

function cObd.urciObvod :real;
begin
  urciObvod :=2 * (a + b)
end;

destructor cObd.done;
begin
  a :=0;
  b :=0
end;

end.

