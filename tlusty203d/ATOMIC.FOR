C
      PARAMETER (MPAG=MLEVEL/6+1)
C
      CHARACTER*40 FIDATA(MION),FIODF1(MION),FIODF2(MION),FIBFCS(MION)
      CHARACTER*10 TYPLEV(MLEVEL)
      CHARACTER*4 TYPION(MION)
C
      COMMON/ATOPAR/AMASS(MATOM),ABUND(MATOM,MDEPTH),NUMAT(MATOM),
     *              N0A(MATOM),NKA(MATOM),nref(matom),iatex(30),
     *              nrefs(matom,mdepth),
     *              iifix(matom),iatref,modref
      common/atomas/amas(100)
      COMMON/IONPAR/FF(MION),CHARG2(MION),
     *              NFIRST(MION),NLAST(MION),NNEXT(MION),
     *              IZ(MION),IUPSUM(MION),ICUP(MION),ilte(mion),
     *              iltion(mion)
      COMMON/LEVPAR/ENION(MLEVEL),G(MLEVEL),NQUANT(MLEVEL),
     *              IATM(MLEVEL),IEL(MLEVEL),ILK(MLEVEL),ilin(mlevel),
     *              iltlev(mlevel),indlev(mlevel),
     *              imodl(mlevel),iiexp(mlevel),iifor(mlevel),
     *              ipzert(mlevel),
     *              igzert(mlevel),indlgz(mlevel),iinonz(mlevel),
     *              NLVEXP,NLVFOR,NLVEXZ,LBPFX
      COMMON/TRAPAR/FR0(MTRANS),OSC0(MTRANS),CPAR(MTRANS),
     *              FRQMX(MTRANS),FR0PC(MTRANS),OMECOL(MLEVEL,MLEVEL),
     *              XGRAD,STRL1,STRL2,STRLX,
     *              ILOW(MTRANS),IUP(MTRANS),INDEXP(MTRANS),
     *              KFR0(MTRANS),KFR1(MTRANS),ILUCTR(MTRANS),
     *              IFC0(MTRANS),IFC1(MTRANS),
     *              IFR0(MTRANS),IFR1(MTRANS),ITRA(MLEVEL,MLEVEL),
     *              IPROF(MTRANS),ICOL(MTRANS),INTMOD(MTRANS),
     *              ITRCON(MTRANS),IDIEL(MTRANS),
     *              IJTF(MTRANS),LCOMP(MTRANS),LINE(MTRANS)
      COMMON/PHOSET/S0CS(MLEVEL),ALFCS(MLEVEL),BETCS(MLEVEL),
     *              GAMCS(MLEVEL),IBF(MLEVEL)
      COMMON/TOPCS/CTOP(MFIT,MCROSS), !sigma=alog10(sigma/10^-18) of fit point
     +             XTOP(MFIT,MCROSS)  ! x = alog10(nu/nu0) of fit point 
      COMMON/VOIPAR/GAMAR(MVOIGT),STARK1(MVOIGT),STARK2(MVOIGT),
     *              STARK3(MVOIGT),VDWH(MVOIGT)
      COMMON/HECRAT/COLHE1(19,19)
      COMMON/TRACOR/LEXP(MTRANS),LALI(MTRANS)
      COMMON/TRAALI/NFFIX,IFSUB,IFLEV
      COMMON/AUXIND/IATH,IATHE,IELH,IELHM,IELHE1,IELHE2,IOPADD
      COMMON/IONFIL/FIDATA,FIODF1,FIODF2,FIBFCS
      COMMON/IONDAT/IATI(MION),IZI(MION),NLEVS(MION),NLLIM(MION)
      COMMON/OSCHYD/OSH(20,20)
      COMMON/PRINTP/NPGPOP,IIPR(6,MPAG),TYPLEV,TYPION
c
      PARAMETER (MTRPRD=5)
      COMMON/PRDPAR/DOPTR(MTRPRD,MDEPTH),COHER(MTRPRD,MDEPTH),
     *              PJBAR(MTRPRD,MDEPTH),RJBAR(MTRPRD,MDEPTH),
     *              XPDIV,
     *              IPRD(MTRANS),ITRTOT(MTRPRD),NTRPRD,IFPRD
