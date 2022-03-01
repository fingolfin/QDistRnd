#! @Chapter Examples
#! @Section The 5-qubit code

#! Generate the matrix of the 5-qubit code over GF(3) with the stabilizer group
#! generated by cyclic shifts of the operator $X_0Z_1 \bar Z_2 \bar
#! X_3$ which corresponds to the polynomial $h(x)=1+x^3-x^5-x^6$
#! (a factor $X_i^a$ corresponds to a monomial $a x^{2i}$, and a
#! factor $Z_i^b$ to a monomial $b x^{2i+1}$),  
#! calculate the distance, and save into the file.
#! @BeginExample
q:=3;; F:=GF(q);; 
x:=Indeterminate(F,"x");; poly:=One(F)*(1+x^3-x^5-x^6);;
n:=5;;
mat:=QDR_DoCirc(poly,n-1,2*n,F);; #construct circulant matrix with 4 rows 
Display(mat);
#!  1 . . 1 . 2 2 . . .
#!  . . 1 . . 1 . 2 2 .
#!  2 . . . 1 . . 1 . 2
#!  . 2 2 . . . 1 . . 1
d:=DistRandStab(mat,100,1,0 : field:=F,maxav:=20/n);
#! 3
AUTODOC_CreateDirIfMissing("tmp");;
WriteMTXE("tmp/n5_q3_complex.mtx",3,mat,
        "% The 5-qubit code [[5,1,3]]_3",
        "% Generated from h(x)=1+x^3-x^5-x^6",
        "% Example from the QDistRnd GAP package"   : field:=F);
#! File tmp/n5_q3_complex.mtx was created
#! @EndExample

#! Here is the contents of the resulting file which also illustrates
#! the `coordinate complex` data format.  Here a pair $(a_{i,j},b_{i,j})$
#! in row $i$ and column $j$ is written as a row of 4 integers, "$i$ $j$ $a_{i,j}$
#! $b_{i,j}$", e.g., "1 2 0 1" 
#! for the second entry in the 1st row, so that the matrix in the file
#! has $n$ columns, each containing a pair of integers.
#! @BeginLog
#! %%MatrixMarket matrix coordinate complex general
#! % Field: GF(3)
#! % The 5-qubit code [[5,1,3]]_3
#! % Generated from h(x)=1+x^3-x^5-x^6
#! % Example from the QDistRnd GAP package
#! % Values Z(3) are given
#! 4 5 20
#! 1 1 1 0
#! 1 2 0 1
#! 1 3 0 2
#! 1 4 2 0
#! 2 2 1 0
#! 2 3 0 1
#! 2 4 0 2
#! 2 5 2 0
#! 3 1 2 0
#! 3 3 1 0
#! 3 4 0 1
#! 3 5 0 2
#! 4 1 0 2
#! 4 2 2 0
#! 4 4 1 0
#! 4 5 0 1
#! @EndLog

#! And now let us read the matrix back from the file using the function `ReadMTXE`.   In the simplest
#! case, only the file name is needed.
#! Output is a list: `[field,pair,matrix,(list of comments)]`, where the `pair` parameter describes 
#! the ordering of columns in the matrix, see  <Ref Chap="Chapter_FileFormat"/>.  
#! Notice that a `pair=2` or `pair=3` matrix is always converted to `pair=1`, i.e., with $2n$
#! intercalated columns $(a_1,b_1,a_2,b_2,\ldots)$. 
#! @BeginExample
lis:=ReadMTXE("tmp/n5_q3_complex.mtx");;  
lis[1]; # the field 
#! GF(3)
lis[2]; # converted to `pair=1`
#! 1
Display(lis[3]);
#!  1 . . 1 . 2 2 . . .
#!  . . 1 . . 1 . 2 2 .
#!  2 . . . 1 . . 1 . 2
#!  . 2 2 . . . 1 . . 1
#! @EndExample
#! The remaining portion is the list of comments.  Notice that the 1st
#! and the last comment lines have been added automatically.
#! @BeginLog
#! gap> lis[4];
#! [ "% Field: GF(3)", "% The 5-qubit code [[5,1,3]]_3",
#!   "% Generated from h(x)=1+x^3-x^5-x^6",
#!   "% Example from the QDistRnd GAP package", "% Values Z(3) are given" ]
#! @EndLog

#! @Section Hyperbolic codes from a file

#! Here we read two CSS matrices from two different files which
#! correspond to a hyperbolic code $[[80,18,5]]$ with row weight $w=5$
#! and the asymptotic rate $1/5$.  Notice that `pair=0` is used for
#! both files (regular matrices).
#! @BeginExample
filedir:=DirectoriesPackageLibrary("QDistRnd","matrices");;
lisX:=ReadMTXE(Filename(filedir,"QX80.mtx"),0);;
GX:=lisX[3];;
lisZ:=ReadMTXE(Filename(filedir,"QZ80.mtx"),0);;
GZ:=lisZ[3];;
DistRandCSS(GX,GZ,100,1,2:field:=GF(2));
#! 5
#! @EndExample

#! Here are the matrices for a much bigger hyperbolic code
#! $[[900,182,8]]$ from the same family.  Note that the distance here
#! scales only logarithmically with the code length (this code takes
#! about 15 seconds on a typical notebook and will not actually be executed).   
#! @BeginLog

#! gap> lisX:=ReadMTXE(Filename(filedir,"QX900.mtx"),0);;
#! gap> GX:=lisX[3];;
#! gap> lisZ:=ReadMTXE(Filename(filedir,"QZ900.mtx"),0);;
#! gap> GZ:=lisZ[3];;
#! gap> DistRandCSS(GX,GZ,1000,1,0:field:=GF(2));
#! 8
#! @EndLog

#! @Section Randomly generated cyclic codes

#! As a final and hopefully somewhat useful example, the file 
#! "lib/cyclic.g" contains a piece of 
#! code searching for random one-generator cyclic codes of length
#! $n:=15$ over the field $\gf(8)$, and generator weight `wei:=6`.  
#! Note how the `mindist` parameter and the option `maxav` are used to
#! speed up the calculation.



#! @Chapter AllFunctions
#! @Section DistanceFunctions
#! @Subsection Examples

#! Here are a few simple examples illustrating the use of distance
#! functions.  In all examples, we use `DistRandCSS` and
#! `DistRandStab` with `debug=2` to ensure that row
#! orthogonality in the input matrices is verified.
#! @BeginExample
F:=GF(5);;
Hx:=One(F)*[[1,-1,0,0 ],[0,0,1,-1]];;
Hz:=One(F)*[[1, 1,1,1]];;
DistRandCSS(Hz,Hx,100,0,2 : field:=F);
#! 2
#! @EndExample
#! Now, if we set the minimum distance `mindist` parameter too large,
#! the function terminates immediately after a codeword with such a
#! weight is found; in such a case the result is returned with the
#! negative sign.
#! @BeginExample
DistRandCSS(Hz,Hx,100,2,2 : field:=F);
#! -2
#! @EndExample
#! The function `DistRandStab` takes 
#! only one matrix.  This example uses the same CSS code but written
#! into a single matrix.  Notice how the values from the previous example are
#! intercalated with zeros.
#! @BeginExample
F:=GF(5);;
H:=One(F)*[[1,0, -1,0,  0,0,  0,0 ], # original Hx in odd positions
           [0,0,  0,0,  1,0, -1,0 ],
           [0,1,  0,1,  0,1,  0,1 ]];; # original Hz in even positions
DistRandStab(H,100,0,2 : field:=F);
#! 2
#! @EndExample

#! @Section HelperFunctions
#! @Subsection Examples
#! @BeginExample
QDR_AverageCalc([2,3,4,5]);
#! 3.5
#! @EndExample

#! @BeginExample
F:=GF(3);; 
x:=Indeterminate(F,"x");; poly:=One(F)*(1-x);;
n:=5;;
mat:=QDR_DoCirc(poly,n,2*n,F);; # make a circulant matrix with 5 rows 
Display(mat);
#!  1 2 . . . . . . . .
#!  . . 1 2 . . . . . .
#!  . . . . 1 2 . . . .
#!  . . . . . . 1 2 . .
#!  . . . . . . . . 1 2
#! @EndExample

