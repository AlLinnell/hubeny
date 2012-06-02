C
      INCLUDE 'fpvm3.h'
C
      PARAMETER (MHOST  =   30,
     &           MFRPAR = 2000)
      REAL*4 TIMNOD
      CHARACTER NODNAM*30
      COMMON/VMNODE/TIMNOD(MHOST),NODNAM(MHOST),
     &              KTID(MHOST),KTIDS(MHOST),IKH(MHOST),
     &              NIHOS(MHOST),
     &              NTASK,NHOST,NARCH,KENCOD,IPVMON
