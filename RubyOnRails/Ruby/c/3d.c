/* *********************** */
/* getT                    */
/*   sin = 0               */
/*   cos = 1               */
/* *********************** */
int getT(int f, int val) {
  val = 0;
  //int newEntry = 0;
  // sin
  if (f == 0) {
    //newEntry = 0; //Math.sin(val);
    //printf("sin for %d\n", val);
    return 0;
  }
  // cos
  else if (f == 1) {
    //newEntry = 1; //Math.cos(val);
    //printf("cos for %d\n", val);
    return 1;
  }
  else {
    return val;
  }
  //return newEntry;
} /* getT */
//
//
/* *********************** */
/* transform3Into2_NEW     */
/* *********************** */
void transform3Into2_NEW(unsigned char * rx, unsigned char * ry, int x, int y, int z, int cx, int cy, int cz, int th_x, int th_y, int th_z) {
  /* *********************** */
  /* DATA                    */
  /* *********************** */
  // floating point factor
  const int factor = 10;
  //
  // matM                    
  int p1,p2,p3,p4,p5,p6,p7,p8,p9 = 0;
  int matM[9] = {0,0,0,0,0,0,0,0,0};
  int matM2[9] = {0,0,0,0,0,0,0,0,0};
  //
  // getM                    
  int d1[9] = {
    1,               0,                0                  ,
    0,               100,              100                ,
    0,               100,              100                };
  int d2[9] = {
    100,             0,                100                ,
    0,               1,                0                  ,
    100,             0,                100                };
  int d3[9] = {
    100,            100,               0                  ,
    100,            100,               0                  ,
    0,              0,                 1                  };
  //
  // d4 AND d5
  int d4[3] = {0,0,0};
  int d5[3] = {0,0,0};
  //
  // matS
  int matS[9] = {0,0,0,0,0,0,0,0,0};
  //
  // matMV
  int matMV[3];
  //
  // getB
  int ezDivDz = 0;
  unsigned char newEntry_x = 0;
  unsigned char newEntry_y = 0;
  const unsigned char canvasWidthHalf = 160;
  //
  /* *********************** */
  /* PROGRAM                 */
  /* *********************** */
  //printf("\np  => %d %d %d\n", x, y, z);
  //printf("c  => %d %d %d\n", cx, cy, cz);
  //printf("th => %d %d %d\n", th_x, th_y, th_z);
  // getM
  // d1
  d1[4] = getT(1, th_x);
  d1[5] = -1 * getT(0, th_x);
  d1[7] = getT(0,th_x);
  d1[8] = getT(1,th_x);
  //printf("d1    => %d %d %d %d %d %d %d %d %d\n", d1[0],d1[1],d1[2],d1[3],d1[4],d1[5],d1[6],d1[7],d1[8]);
  // d2
  d2[0] = getT(1,th_y);
  d2[2] = getT(0,th_y);
  d2[6] = -1*getT(0,th_y);
  d2[8] = getT(1,th_y);
  //printf("d2    => %d %d %d %d %d %d %d %d %d\n", d2[0],d2[1],d2[2],d2[3],d2[4],d2[5],d2[6],d2[7],d2[8]);
  // d3
  d3[0] = getT(1,th_z);
  d3[1] = -1*getT(0,th_z);
  d3[3] = getT(0,th_z);
  d3[4] = getT(1,th_z);
  //printf("d3    => %d %d %d %d %d %d %d %d %d\n", d3[0],d3[1],d3[2],d3[3],d3[4],d3[5],d3[6],d3[7],d3[8]);
  // 
  //
  // matM
  p1 = d1[0]*d2[0] + d1[1]*d2[3] + d1[2]*d2[6];
  p2 = d1[0]*d2[1] + d1[1]*d2[4] + d1[2]*d2[7];
  p3 = d1[0]*d2[2] + d1[1]*d2[5] + d1[2]*d2[8];
  p4 = d1[3]*d2[0] + d1[4]*d2[3] + d1[5]*d2[6];
  p5 = d1[3]*d2[1] + d1[4]*d2[4] + d1[5]*d2[7];
  p6 = d1[3]*d2[2] + d1[4]*d2[5] + d1[5]*d2[8];
  p7 = d1[6]*d2[0] + d1[7]*d2[3] + d1[8]*d2[6];
  p8 = d1[6]*d2[1] + d1[7]*d2[4] + d1[8]*d2[7];
  p9 = d1[6]*d2[2] + d1[7]*d2[5] + d1[8]*d2[8];
  matM[0] = p1;
  matM[1] = p2;
  matM[2] = p3;
  matM[3] = p4;
  matM[4] = p5;
  matM[5] = p6;
  matM[6] = p7;
  matM[7] = p8;
  matM[8] = p9;
  //printf("matM  => %d %d %d %d %d %d %d %d %d\n", matM[0],matM[1],matM[2],matM[3],matM[4],matM[5],matM[6],matM[7],matM[8]);
  //
  // matM2
  p1 = matM[0]*d3[0] + matM[1]*d3[3] + matM[2]*d3[6];
  p2 = matM[0]*d3[1] + matM[1]*d3[4] + matM[2]*d3[7];
  p3 = matM[0]*d3[2] + matM[1]*d3[5] + matM[2]*d3[8];
  p4 = matM[3]*d3[0] + matM[4]*d3[3] + matM[5]*d3[6];
  p5 = matM[3]*d3[1] + matM[4]*d3[4] + matM[5]*d3[7];
  p6 = matM[3]*d3[2] + matM[4]*d3[5] + matM[5]*d3[8];
  p7 = matM[6]*d3[0] + matM[7]*d3[3] + matM[8]*d3[6];
  p8 = matM[6]*d3[1] + matM[7]*d3[4] + matM[8]*d3[7];
  p9 = matM[6]*d3[2] + matM[7]*d3[5] + matM[8]*d3[8];
  matM2[0] = p1;
  matM2[1] = p2;
  matM2[2] = p3;
  matM2[3] = p4;
  matM2[4] = p5;
  matM2[5] = p6;
  matM2[6] = p7;
  matM2[7] = p8;
  matM2[8] = p9;
  //printf("matM2 => %d %d %d %d %d %d %d %d %d\n",matM2[0],matM2[1],matM2[2],matM2[3],matM2[4],matM2[5],matM2[6],matM2[7],matM2[8]);
  //
  // d4 AND d5
  // d4
  d4[0] = x;
  d4[1] = y;
  d4[2] = z;
  // d5
  d5[0] = cx;
  d5[1] = cy;
  d5[2] = cz;
  //
  /* *********************** */
  /* matS                    */
  /* *********************** */
  matS[0] = d4[0]-d5[0];
  matS[1] = d4[1]-d5[1];
  matS[2] = d4[2]-d5[2];
  //printf("matS  => %d %d %d %d %d %d %d %d %d\n",matS[0],matS[1],matS[2],matS[3],matS[4],matS[5],matS[6],matS[7],matS[8]);
  //
  /* *********************** */
  /* matMV                   */
  /* *********************** */
  p1 = matM2[0]*matS[0] + matM2[1]*matS[1] + matM2[2]*matS[2];
  p2 = matM2[3]*matS[0] + matM2[4]*matS[1] + matM2[5]*matS[2];
  p3 = matM2[6]*matS[0] + matM2[7]*matS[1] + matM2[8]*matS[2];
  matMV[0] = p1;
  matMV[1] = p2;
  matMV[2] = p3;
  //printf("matMV => %d %d %d\n",matMV[0],matMV[1],matMV[2]);
  //
  /* *********************** */
  /* getB                    */
  /* *********************** */
  ezDivDz = (-700*factor) / matMV[2];
  //printf("matMV[2] => %d \n",matMV[2]);
  //printf("ezDivDz => [%d] \n",ezDivDz);
  newEntry_x = -1*(matMV[0]*ezDivDz)/factor + canvasWidthHalf;
  newEntry_y = (matMV[1]*ezDivDz)/factor;
  //printf("result => %d, %d\n", newEntry_x, newEntry_y);
  /* *********************** */
  /* return                  */
  /* *********************** */
  *rx = newEntry_x;
  *ry = newEntry_y;
  return;
} /* transform3Into2_NEW */

