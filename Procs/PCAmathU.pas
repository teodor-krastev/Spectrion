unit PCAmathU;

interface
uses Dialogs, SysUtils, Forms, Math;

type adouble =  array of double;
    aadouble =  array of adouble;

function AssignMat(Amat: aadouble): aadouble;
function TransMat(Amat: aadouble): aadouble;
function MultMat(Amat, Bmat: aadouble): aadouble;
function InvertMat(Amat: aadouble): aadouble;

function NIPALS(mat: aadouble; var mat1: aadouble; var evl: adouble;
  var evec, score: aadouble; f: integer): boolean;
procedure MahalMatrix(mat: aadouble; f: integer; var mm: aadouble;
  var scoreM: adouble; var RcM, RMSG: double);
procedure DecompByEvec(f, n: integer; unk: adouble; evec: aadouble; RcM: double;
  var scoreU: adouble);
function MahalDist(mm: aadouble; f: integer; scoreU: adouble;
  RMSG: double): double;

var
  CalcPrec: double;

implementation

function AssignMat(Amat: aadouble): aadouble;
var i,j,k,l: integer;
begin k:= length(Amat);
SetLength(Result,k);
for i:=0 to k-1 do
    begin l:= length(Amat[i]);
    SetLength(Result[i],l);
    for j:=0 to l-1 do Result[i,j]:= Amat[i,j];
    end;
end;

function TransMat(Amat: aadouble): aadouble;
var i,j,k,l: integer;
begin k:= length(Amat[0]); l:= length(Amat);
SetLength(Result,k);
for i:=0 to k-1 do
    begin SetLength(Result[i],l);
    for j:=0 to l-1 do Result[i,j]:= Amat[j,i];
    end;
end;

function MultMat(Amat, Bmat: aadouble): aadouble;
var i,j,k,l,m,n: integer; a: double; bb: boolean;
begin bb:= true;
try
m:= length(Bmat);
k:= length(Bmat[0]);
for i:=0 to k-1 do bb:= bb and (length(Amat[i])=m);
for i:=1 to m-1 do bb:= bb and (length(Bmat[i])=k);
if not bb then begin ShowMessage('Wrong matrix dim'); exit;
               end;
SetLength(Result,length(Amat));
for i:=0 to length(Amat)-1 do
    begin SetLength(Result[i],k);
    for j:=0 to k-1 do
        begin a:= 0;
        for n:=0 to m-1 do a:= a+Amat[i,n]*Bmat[n,j];
        Result[i,j]:= a;
        end;
    end;
finally
//ShowMessage(IntTostr(i)+'/'+IntTostr(j));
end;
end;

function InvertMat(Amat: aadouble): aadouble;
VAR
   big,dum,pivinv: real;
   i,icol,irow,j,k,l,ll, n: integer;
   indxc,indxr,ipiv: array of integer;
   a: aadouble;
BEGIN
a:= AssignMat(Amat);
n:= length(a);
SetLength(indxc,n); SetLength(indxr,n); SetLength(ipiv,n);

   FOR j := 0 TO n-1 DO BEGIN
      ipiv[j] := 0
   END;
   FOR i := 0 TO n-1 DO BEGIN
      big := 0.0;
      FOR j := 0 TO n-1 DO BEGIN
         IF (ipiv[j] <> 1) THEN BEGIN
            FOR k := 0 TO n-1 DO BEGIN
               IF (ipiv[k] = 0) THEN BEGIN
                  IF (abs(a[j,k]) >= big) THEN BEGIN
                     big := abs(a[j,k]);
                     irow := j;
                     icol := k
                  END
               END ELSE IF (ipiv[k] > 1) THEN BEGIN
                  ShowMessage('pause 1 in GAUSSJ - singular matrix'); exit;
               END
            END
         END
      END;
      ipiv[icol] := ipiv[icol]+1;
      IF (irow <> icol) THEN BEGIN
         FOR l := 0 TO n-1 DO BEGIN
            dum := a[irow,l];
            a[irow,l] := a[icol,l];
            a[icol,l] := dum
         END;
      END;
      indxr[i] := irow;
      indxc[i] := icol;
      IF (a[icol,icol] = 0.0) THEN BEGIN
         ShowMessage('pause 2 in GAUSSJ - singular matrix'); exit;
      END;
      pivinv := 1.0/a[icol,icol];
      a[icol,icol] := 1.0;
      FOR l := 0 TO n-1 DO BEGIN
         a[icol,l] := a[icol,l]*pivinv
      END;
      FOR ll := 0 TO n-1 DO BEGIN
         IF (ll <> icol) THEN BEGIN
            dum := a[ll,icol];
            a[ll,icol] := 0.0;
            FOR l := 0 TO n-1 DO BEGIN
               a[ll,l] := a[ll,l]-a[icol,l]*dum
            END;
         END
      END
   END;
   FOR l := n-1 DOWNTO 0 DO BEGIN
      IF (indxr[l] <> indxc[l]) THEN BEGIN
         FOR k := 0 TO n-1 DO BEGIN
            dum := a[k,indxr[l]];
            a[k,indxr[l]] := a[k,indxc[l]];
            a[k,indxc[l]] := dum
         END
      END
   END;
Result:= AssignMat(a);
END;

function NIPALS(mat: aadouble; var mat1: aadouble; var evl: adouble;
  var evec, score: aadouble; f: integer): boolean;
var
  i, j, k, l: integer;
  a, b, c: double;
  firstpass: boolean;
  n, // number of samples (spectra)
  p: // number of points
  // f  number of PC
    integer;
  score1: aadouble;
label step1, step2, step8;
begin
  // ini arrays                                                  || mat [n X p]
  n := length(mat);
  p := length(mat[0]);
  if f > n then
    exit;
  SetLength(mat1, n);
  for i := 0 to n - 1 do
    SetLength(mat1[i], p); // mat1 [n X p]
  for j := 0 to n - 1 do
    for k := 0 to p - 1 do
      mat1[j, k] := mat[j, k];
  SetLength(evl, f); // evl [f]
  SetLength(evec, f);
  for i := 0 to f - 1 do
    SetLength(evec[i], p); // evec [f X p]
  SetLength(score, n);
  for i := 0 to n - 1 do
    SetLength(score[i], f); // score [n X f]
  SetLength(score1, n);
  for i := 0 to n - 1 do
    SetLength(score1[i], f); // score1 [n X f]
  // NIPALS
  // from http://vw.tci.uni-hannover.de/hitzmann/peke/pekelerbrit.html
  i := 0; // ini PC number
step1: // 1
  for j := 0 to n - 1 do
    score[j, i] := mat1[j, 0];
step2: // 2
  for j := 0 to n - 1 do
    score1[j, i] := score[j, i]; // remmember score
  a := 0;
  for j := 0 to n - 1 do
    a := a + score[j, i] * score[j, i];
  evl[i] := a;
  for j := 0 to p - 1 do
  begin
    a := 0;
    for k := 0 to n - 1 do
      a := a + score[k, i] * mat1[k, j] / evl[i];
    evec[i, j] := a;
  end;
  // 3
  a := 0;
  for j := 0 to p - 1 do
    a := a + evec[i, j] * evec[i, j];
  a := sqrt(a);
  for j := 0 to p - 1 do
    evec[i, j] := evec[i, j] / a;
  // 4
  a := 0;
  for j := 0 to p - 1 do
    a := a + evec[i, j] * evec[i, j];

  for j := 0 to n - 1 do
  begin
    b := 0;
    for k := 0 to p - 1 do
      b := b + mat1[j, k] * evec[i, k] / a;
    score[j, i] := b;
  end;
  // 5
  a := 0;
  for j := 0 to n - 1 do
    a := a + (score1[j, i] - score[j, i]) * (score1[j, i] - score[j, i]);
  if a > CalcPrec then
    goto step2;
  // 6
  if i = f - 1 then
    exit
  else
  begin
    for j := 0 to n - 1 do
      for k := 0 to p - 1 do
        mat1[j, k] := mat1[j, k] - score[j, i] * evec[i, k];
  end;
  i := i + 1;
  // frmPCAprep.StatusBar1.SimpleText:= ' '+IntToStr(i)+'/'+IntToStr(f)+' factors done';
  Application.ProcessMessages;
  goto step1;
end; { NIPALS }

procedure MahalMatrix(mat: aadouble; f: integer; var mm: aadouble;
  var scoreM: adouble; var RcM, RMSG: double);
var
  mat1, buff, evec, score: aadouble;
  evl, Rc, MD: adouble;
  a: double;
  i, j, k, n, p: integer;
begin
  // mat [n X p] - samples matrix
  // mat1 - residual matrix
  // f - factors number
  // mm [f X f] - Mahal. matrix
  // evec [f X p] - eigen vectors
  // score [n X f]
  // RcM - Resuduals Center Mean
  // RMSG - Root Mean Squared Group
  NIPALS(mat, mat1, evl, evec, score, f);
  n := length(mat1);
  SetLength(Rc, n);
  for i := 0 to n - 1 do // Residuals Center
  begin
    Rc[i] := 0;
    for j := 0 to length(mat1[i]) - 1 do // p
      Rc[i] := Rc[i] + mat1[i, j] * mat1[i, j];
  end;
  RcM := 0; // Resuduals Center Mean
  for i := 0 to n - 1 do
    RcM := RcM + Rc[i];
  RcM := RcM / n;
  for i := 0 to n - 1 do
  begin
    k := length(score[i]);
    SetLength(score[i], k + 1);
    score[i, k] := Rc[i] - RcM;
  end;
  mm := MultMat(TransMat(score), score);
  for i := 0 to length(mm) - 1 do
    for j := 0 to length(mm[i]) - 1 do
      mm[i, j] := mm[i, j] / (n - 1);
  SetLength(buff, n);
  for i := 0 to n - 1 do
  begin
    SetLength(buff[i], f + 1);
    for j := 0 to f do
    begin
      a := 0;
      for k := 0 to f do
        a := a + score[i, k] * InvertMat(mm)[k, j];
      buff[i, j] := a;
    end;
  end;
  SetLength(MD, n);
  for i := 0 to n - 1 do
  begin
    a := 0;
    for j := 0 to f do
      a := a + buff[i, j] * score[i, j];
    MD[i] := a;
  end;
  RMSG := 0; // Root Mean Squared Group
  for i := 0 to n - 1 do
    RMSG := RMSG + MD[i] * MD[i];
  RMSG := RMSG / (n - 1);
  SetLength(scoreM, f);
  for i := 0 to f - 1 do
  // mean score - initial approx. to unknown score (scoreU)
  begin
    a := 0;
    for j := 0 to n - 1 do
      a := a + score[j, i];
    scoreM[i] := a / n;
  end;
end; { MahalMatrix }

procedure DecompByEvec(f, n: integer; unk: adouble; evec: aadouble; RcM: double;
  var scoreU: adouble);
var
  MD, buffU: adouble;
  partRes: adouble;
  score: aadouble;
  a, b: double;
  x, fx: array [1 .. 3] of double;
  i, j, k, p, iEvec: integer;

  function func(coeff: double): double;
  var
    i, j: integer;
    a: double;
  begin
    a := 0;
    for i := 0 to length(evec[iEvec]) - 1 do
      a := a + (coeff * evec[iEvec, i] - partRes[i]) *
        (coeff * evec[iEvec, i] - partRes[i]);
    result := a;
  end;

FUNCTION golden(ax,bx,cx,tol: double; VAR xmin: double): double;
(* Programs using routine GOLDEN must supply an external
function func(x:real):real whose minimum is to be found. *)
CONST
   r=0.61803399;
VAR
   f0,f1,f2,f3,c: double;
   x0,x1,x2,x3: double;
BEGIN
   c := 1.0-r;
   x0 := ax;
   x3 := cx;
   IF (abs(cx-bx) > abs(bx-ax)) THEN BEGIN
      x1 := bx;
      x2 := bx+c*(cx-bx)
   END ELSE BEGIN
      x2 := bx;
      x1 := bx-c*(bx-ax)
   END;
   f1 := func(x1);
   f2 := func(x2);
   WHILE (abs(x3-x0) > tol*(abs(x1)+abs(x2))) DO BEGIN
      IF (f2 < f1) THEN BEGIN
         x0 := x1;
         x1 := x2;
         x2 := r*x1+c*x3;
         f0 := f1;
         f1 := f2;
         f2 := func(x2)
      END ELSE BEGIN
         x3 := x2;
         x2 := x1;
         x1 := r*x2+c*x0;
         f3 := f2;
         f2 := f1;
         f1 := func(x1)
      END
   END;
   IF (f1 < f2) THEN BEGIN
      golden := f1;
      xmin := x1
   END ELSE BEGIN
      golden := f2;
      xmin := x2
   END
END;

PROCEDURE mnbrak(VAR ax,bx,cx,fa,fb,fc: double);
(* Programs using routine MNBRAK must supply an external
function func(x:real):real for which a minimum is to be found *)
LABEL 1;
CONST
   gold=1.618034;
   glimit=100.0;
   tiny=1.0e-20;
VAR
   ulim,u,r,q,fu,dum: double;
FUNCTION max(a,b: double): double;
   BEGIN
      IF (a > b) THEN max := a ELSE max := b
   END;
FUNCTION sign(a,b: double): double;
   BEGIN
      IF (b > 0.0) THEN sign := abs(a) ELSE sign := -abs(a)
   END;
BEGIN
   fa := func(ax);
   fb := func(bx);
   IF (fb > fa) THEN BEGIN
      dum := ax;
      ax := bx;
      bx := dum;
      dum := fb;
      fb := fa;
      fa := dum
   END;
   cx := bx+gold*(bx-ax);
   fc := func(cx);
1:   IF (fb >= fc) THEN BEGIN
      r := (bx-ax)*(fb-fc);
      q := (bx-cx)*(fb-fa);
      u := bx-((bx-cx)*q-(bx-ax)*r)/
         (2.0*sign(max(abs(q-r),tiny),q-r));
      ulim := bx+glimit*(cx-bx);
      IF ((bx-u)*(u-cx) > 0.0) THEN BEGIN
         fu := func(u);
         IF (fu < fc) THEN BEGIN
            ax := bx;
            fa := fb;
            bx := u;
            fb := fu;
            GOTO 1 END
         ELSE IF (fu > fb) THEN BEGIN
            cx := u;
            fc := fu;
            GOTO 1
         END;
         u := cx+gold*(cx-bx);
         fu := func(u)
      END ELSE IF  ((cx-u)*(u-ulim) > 0.0) THEN BEGIN
         fu := func(u);
         IF (fu < fc) THEN BEGIN
            bx := cx;
            cx := u;
            u := cx+gold*(cx-bx);
            fb := fc;
            fc := fu;
            fu := func(u)
         END
      END ELSE IF  ((u-ulim)*(ulim-cx) >= 0.0) THEN BEGIN
         u := ulim;
         fu := func(u)
      END ELSE BEGIN
         u := cx+gold*(cx-bx);
         fu := func(u)
      END;
      ax := bx;
      bx := cx;
      cx := u;
      fa := fb;
      fb := fc;
      fc := fu;
      GOTO 1
   END
END;

begin
  // Mahalanobis matrix
  // MahalMatrix(mat,f,mm,evec,score,RcM,RMSG);

  // decomposition of the unknown by evec
  p := length(unk);
  SetLength(scoreU, f);
  SetLength(partRes, p);
  for j := 0 to p - 1 do
    partRes[j] := unk[j];
  for i := 0 to f - 1 do
  begin
    iEvec := i;
    if scoreU[i] = 0 then
    begin
      x[1] := 0;
      x[2] := 1E5;
    end
    else
    begin
      x[1] := scoreU[i] - 10 * abs(scoreU[i]);
      x[2] := scoreU[i] + 10 * abs(scoreU[i]);
    end;
    mnbrak(x[1], x[2], x[3], fx[1], fx[2], fx[3]);
    if (fx[1] < fx[2]) or (fx[2] > fx[3]) then
    begin
      ShowMessage('Problem with init. conditions ' + #10 + FloatToStr(fx[1]) +
        '  ' + FloatToStr(fx[2]) + '  ' + FloatToStr(fx[3]));
      exit;
    end;
    golden(x[1], x[2], x[3], 1E-3, scoreU[i]);
    for j := 0 to p - 1 do
      partRes[j] := partRes[j] - scoreU[i] * evec[i, j];
  end;
  a := 0;
  for j := 0 to p - 1 do
    a := a + partRes[j] * partRes[j];
  SetLength(scoreU, f + 1);
  scoreU[f] := a - RcM;
end; { DecompByEvec }

function MahalDist(mm: aadouble; f: integer; scoreU: adouble;
  RMSG: double): double;
var
  i, j, k: integer;
  buffU: adouble;
  a: double;
begin
  // DecompByEvec(mat,f,unk,mm,scoreU,RMSG);
  // get MD calculated
  SetLength(buffU, f + 1);
  for j := 0 to f do
  begin
    a := 0;
    for k := 0 to f do
      a := a + scoreU[k] * InvertMat(mm)[k, j];
    buffU[j] := a;
  end;
  a := 0;
  for j := 0 to f do
    a := a + buffU[j] * scoreU[j];
  result := a / RMSG;
end; { MahalDist }

end. // PCA
