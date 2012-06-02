      PARAMETER (MLIN0   = 100000,
     *           MGRIEM  =     10,
     *           MNLT    =   2000,
     *           MSPHE2  =     20,
     *           MLIN    =   1500,
     *           MPRF    =  MLIN0)
C
      PARAMETER (MLINM0  = 2000000,
     *           MLINM   =  25000)
C
      COMMON/LINTOT/FREQ0(MLIN0),
     *              EXCL0(MLIN0),
     *              EXCU0(MLIN0),
     *              GF0(MLIN0),
     *              EXTIN(MLIN0),
     *              BNUL(MLIN0),
     *              INDAT(MLIN0),
     *              INDNLT(MLIN0),
     *              ILOWN(MLIN0),
     *              IUPN(MLIN0),
     *              INDLIN(MLIN),
     *              INDLIP(MLIN),
     *              NLIN0,NLIN,
     *              NNLT,NGRIEM
C
      COMMON/MOLTOT/FREQM(MLINM0),
     *              EXCLM(MLINM0),
     *              GFM(MLINM0),
     *              EXTINM(MLINM0),
     *              GRM(MLINM0),
     *              GSM(MLINM0),
     *              GWM(MLINM0),
     *              INDATM(MLINM0),
     *              INMLIN(MLINM),
     *              INMLIP(MLINM),
     *              NLINM0,NLINM
C
      COMMON/LINPRF/GAMR0(MPRF),
     *              GS0(MPRF),
     *              GW0(MPRF),
     *              WGR0(4,MGRIEM),
     *              IPRF0(MPRF),
     *              ISPRF(MPRF),
     *              IGRIEM(MPRF),
     *              ISP0(MSPHE2),NSP
C
      COMMON/LINNLT/ABCENT(MNLT,MDEPTH),
     *              SLIN(MNLT,MDEPTH)
C
      COMMON/LINDEP/PLAN(MDEPTH),
     *              STIM(MDEPTH),
     *              EXHK(MDEPTH)
