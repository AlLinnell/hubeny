C
C     Parameters that specify dimensions of arrays
C
      IMPLICIT REAL*8 (A-H, O-Z)
      PARAMETER (MATEX = 10,   
     *           MIOEX = 20,
     *           MLEVEL= 500,
     *           MDEPTH= 200,
     *           MFREQ = 120,
     *           MMU   = 20,
     *           MCROSS= MLEVEL,
     *           MFIT  = 100,
     *           MFCRA =  1200,
     *           MATOM = 30,
     *           MATOMBIG = 92,
     *           MION  = 30,
     *           MION0 =  9,
     *           MMOLEC= 340,
     *           MPHOT = 10,
     *           MZZ   =  2,
     *           MMER  =  2,
     *           NLMX  = 80,
     *           MI1   = MION0-1)
C
C     Basic physical constants
C
      PARAMETER (H     = 6.6256D-27,      
     *           CL    = 2.997925D10,    
     *           BOLK  = 1.38054D-16,   
     *           HK    = 4.79928144D-11,
     *           EH    = 2.17853041D-11,
     *           BN    = 1.4743D-2,     
     *           SIGE  = 6.6516D-25,   
     *           PI4H  = 1.8966D27,   
     *           HMASS = 1.67333D-24)
C
C     Unit number
C
      PARAMETER (IBUFF=95)
C
C     Basic parameters
C
      COMMON/BASNUM/NATOM,
     *              NION, 
     *              NLEVEL,
     *              ND,    
     *              NFREQ,
     *              NMU 
      COMMON/INPPAR/TEFF, 
     *              GRAV,
     *              YTOT(MDEPTH),
     *              WMM(MDEPTH),
     *              WMY(MDEPTH) 
      COMMON/BASICM/IMODE,
     *              IFREQ,
     *              INLTE,
     *              IDSTD 
      COMMON/INTKEY/INMOD,INTRPL,ICHANG,ICHEMC,IATREF
C
C     Parameters for explicit atoms
C
      COMMON/ATOPAR/AMASS(MATEX),
     *              ABUND(MATEX,MDEPTH),
     *              RELAB(MATEX,MDEPTH),
     *              NUMAT(MATEX),
     *              N0A(MATEX), 
     *              NKA(MATEX) 
C
C     Parameters for explicit ions
C
      COMMON/IONPAR/FF(MIOEX), 
     *              NFIRST(MIOEX),
     *              NLAST(MIOEX),
     *              NNEXT(MIOEX),
     *              IZ(MIOEX),
     *              IUPSUM(MIOEX),
     *              IFREE(MIOEX),
     *              INBFCS(MIOEX)
C
C     Parameters for explicit levels
C
      COMMON/LEVPAR/ENION(MLEVEL),
     *              G(MLEVEL), 
     *              NQUANT(MLEVEL),
     *              IATM(MLEVEL), 
     *              IEL(MLEVEL), 
     *              ILK(MLEVEL),
     *              ifwop(mlevel) 
C
C     Parameters for all considered transitions
C
      COMMON/TRAPAR/IBF(MLEVEL),
     *              S0BF(MLEVEL),
     *              ALFBF(MLEVEL),
     *              BETBF(MLEVEL),
     *              GAMBF(MLEVEL)
C
      COMMON/MRGPAR/SGM0(MMER),
     *              FRCH(MMER),
     *              SGEXT1(MMER,MDEPTH),
     *              GMER(MMER,MDEPTH),
     *              SGMSUM(NLMX,MMER,MDEPTH),
     *              SGMG(MMER,MDEPTH),
     *              IMRG(MLEVEL),
     *              IIMER(MMER)
C
      COMMON/DWNPAR/ELEC23(MDEPTH),
     *              Z3(MZZ),
     *              DWC1(MZZ,MDEPTH),
     *              DWC2(MDEPTH)
C
C     Auxiliary parameters
C
      COMMON/AUXIND/IATH,IELH,IELHM,N0H,N1H,NKH,N0HN,N0M,
     *              IATHE,IELHE1,IELHE2
 
      COMMON/OPCPAR/IOPADD,IOPHMI,IOPH2P,IRSCT,IOPHLI,IOPHE1,IOPHE2 
      COMMON/MOLFLG/NMOLEC,IFMOL
C
C     Parameters for atoms considered in line blanketing opacity
C
      LOGICAL LGR(MATOM),LRM(MATOM)
      COMMON/PFSTDS/PFSTD(MION,MATOM),MODPF(MATOM)
      COMMON/ADDPOP/RR(MATOM,MION)
      COMMON/ATOBLN/ENEV(MATOM,MI1),AMAS(MATOM),ABND(MATOM),
     *       ABNDD(MATOM,MDEPTH),ABNREF(MDEPTH),TYPAT(MATOM),
     *       IATEX(MATOM)
      COMMON/ATOINI/NATOMS,IONIZ(MATOM),LGR,LRM
C
C     parameters for the macroscopic velocity field and angles
C
      COMMON/VELPAR/ANGL(MMU),WANGL(MMU),VELC(MDEPTH),NMU0,IFLUX
