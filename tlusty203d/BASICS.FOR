C
C     Parameters that specify dimensions of arrays
C
      PARAMETER (MATOM  =   10, ! maximum number of explicit atoms
     *           MION   =   30, ! maximum number of explicit ions
     *           MLEVEL =  200, ! maximum number of explicit levels
     *           MLVEXP =  200, ! maximum number of explicit linearized levels
     *           MTRANS = 1300, ! maximum number of all transitions
     *                          ! which are somehow taken into account
     *           MDEPTH =  200, ! maximum number of depth points
     *           MDEPTC =    1, ! maximum number of depth points (Compton)
     *           MFREQ = 25000, ! maximum number of frequency points
c    *           MFREQ =  1480, ! maximum number of frequency points
     *           MFREQC=  2000, ! maximum number of freq.points in continuum
     *           MFREX =   130, ! maximum number of linearized frequencies
     *           MMU    =    3, ! maximum number of angle points
     *           MMUC   =    2, ! maximum number of angle points (Compton)
     *           MFRCOR =    1, ! maximum number of frequency points
     *                          ! in one line for correction weights
     *           MFETA =     1, ! maximum number of frequency points
     *                          ! in one line for ETA procedure (outdated)
     *           MCROSS=MLEVEL, ! maximum number of photoionization
     *                          ! cross-sections + related quantities
     *           MBF =  MLEVEL, ! maximum number of b-f transitions
     *           MFIT =    125, ! maximum number of fit points (OP b-f c.s)
     *           MITJ=     220, ! maximum number of overlapping transitions
     *           MMCDW =    14, ! maximum number of levels with pseudocont.
     *           MMER  =     2, ! maximum number of merged levels
     *           MZZ   =    10, ! maximum charge for occup.prob. ions
     *           MLINFR =   55, ! maximum number of lines at given freq.
     *           MFREQL = 5000, ! maximum number of frequencies per line
     *           MVOIGT=    75, ! maximum number of lines with Voigt
     *                          ! profile
     *           NLMX  =    80, ! highest hydrogenic level considered
     *           MSMX  =     1, ! size of largest matrix kept in memory in SOLVE
     *           MTOT  =   230, ! maximum number of model unknowns
     *                          ! (ie. maximum dimension of vector PSI)
c    *           MFREQ1=    1,  ! =1 for ISPLIN<5; =MFREQ otherwise
     *           MFREQ1=MFREQ,
     *           MFRTAB= 5000,  ! maximum number of freqeuncies in opac.table
     *           MCOND=     1,  ! dummy
     *           MLEVE3=    1,  ! =1 for diag.precond; =MLEVEL for tridia.prec.
     *           MLVEX3=MLVEXP, ! =1 for diag.oper.; =MLVEXP for tridiag.   .
     *           MTRAN3=MTRANS) ! =1 for diag.oper; =MTRANS for tridiag.
C
      PARAMETER (MAROWS = MFREX + 2,  ! maximum number of rows of matrix
     *                                ! A of complete linearization
     *           MCCOLS = MLEVEL+ 5)  ! maximum number of columns of
     *                                ! matrix C of compl. linearization
C
C     Basic physical constants
C
      PARAMETER (H     = 6.6256D-27,      ! Planck constant     h 
     *           BOLK  = 1.38054D-16,     ! Boltzmann constant  k
     *           HK    = 4.79928144D-11,  ! h/k
     *           CAS   = 2.997925D18,     ! light speed c (A/s)
     *           EH    = 2.17853041D-11,  ! ionizaton energy of hydrogen
     *           BN    = 1.4743D-2,       ! 2*h/c**3, c -light speed
     *           SIGE  = 6.6516D-25,      ! Thomson scattering c-s
     *           SIG4P = 4.5114062D-6,    ! Stefan-Boltzmann const/4pi
     *           PI4H  = 1.8966D27,       ! 4pi/h
     *           PCK   = 4.19168946D-10,  ! 4pi/c
     *           HMASS = 1.67333D-24)     ! mass of hydrogen atom
C
C     Basic mathematical constants
C
      PARAMETER (UN    = 1.0D0,
     *           HALF  = 0.5D0,
     *           TWO   = 2.0D0)
C
C     Unit number
C
      PARAMETER (IBUFF = 15)
C
C     Basic parameters
C
      COMMON/BASNUM/NATOM,NION,NLEVEL,NTRANS,ND,NFREQ,NFREQC,NFREQE,
     *              IOPTAB,IDISK,IZSCAL,IDMFIX,IHESO6,IFMOL,IFENTR,
     *              NFREQL,NLEV0,ICOLHN,IOSCOR,ILGDER,IFRYB,
     *              NFREAD,NELSC,NTRANC,IOVER,JALI,IBC,IUBC,
     *              IRDER,ILMCOR,IFDIEL,IFALIH,IFTENE,
     *              ILPSCT,ILASCT,IRTE,IDLTE,IBFINT,INTRPL,ICHANG,
     *              NATOMS,IPSLTE,ISPODF,ITLUCY,NRETC
      COMMON/INPPAR/TEFF,GRAV,
     *              YTOT(MDEPTH),WMM(MDEPTH),WMY(MDEPTH),
     *              xmstar,xmdot,rstar,alpha0,
     *		    QGRAV,EDISC,DZETA,RELDST,
     *		    visc,zeta0,zeta1,dmvisc,fractv,
     *              omeg32,wbarm,wbar,alphav,pgas0,
     *              bergfc,
     *              ISPLIN,IRSPLT,ivisc,ibche,LTE,LTGREY,LCHC,LRESC
      COMMON/MATKEY/NN,NN0,INHE,INRE,INPC,INSE,INZD,INMP,NDRE,insel
      COMMON/INVINT/XI2(NLMX),XI3(NLMX)
      COMMON/RUNKEY/CHMAX,ITER,NITER,NITZER,INIT,LAC2,LFIN
      COMMON/CONKEY/HMIX0,crflim,
     *              NCONIT,ICONV,INDL,IPRESS,ITEMP,ICBEG,
     *              itmcor,iconre,ideepc,ndcgap,IDCONZ
      COMMON/OPCKEY/NCON,IRSCT,IOPHMI,IOPH2P,IOPHE1,IOPHE2,
     *              IOPHL1,IOPHL2,IPHE2C,IFMOFF
      COMMON/PRINTS/IPRINT,IPRING,IPRIND,IPRINP,ICOOLP,ICHCKP,
     *              IPOPAC,IPRINI
      COMMON/PSILIM/DPSILG,DPSILT,DPSILN,DPSILD
      COMMON/CENTRL/ZND,IFZ0
c
      COMMON/ANGLES/AMU(MMU),WTMU(MMU),FMU(MMU),NMU
c
      common/comptn/amuc(mmuc),wtmuc(mmuc),
     *              amuc1(mmuc),amuc2(mmuc),amuc3(mmuc),
     *              amuj(mmuc),amuk(mmuc),amuh(mmuc),amun(mmuc),
     *              calph(mmuc,mmuc),cbeta(mmuc,mmuc),
     *              cgamm(mmuc,mmuc),RADZER,FRLCOM,
     *              SIGEC(MFREQ),ijorig(mfreq)
      common/angnum/nmuc
      common/compti/nedd,nsti,islab,ilbc,icompt,icomst,icomde,
     *              icombc,icmdra,knish,itcomp,icomve,icomrt,
     *              ichcoo,icomgr
      common/comite/ncfor1,ncfor2,nccoup,ncitot,ncfull
      common/mlcons/aconml,bconml,cconml
      common/taursl/taurs(mdepth)
