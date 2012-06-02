C
C     Basic parameters of the model atmosphere
C
      COMMON/MODELP/DM(MDEPTH),
     *              TEMP(MDEPTH),
     *              ELEC(MDEPTH),
     *              DENS(MDEPTH),
     *              ZD(MDEPTH),
     *              VTURB(MDEPTH),VTB,
     *              ABSTD(MDEPTH),
     *              POPUL(MLEVEL,MDEPTH),
     *              SBF(MLEVEL),
     *              USUM(MIOEX),
     *              WOP(MLEVEL,MDEPTH),
     *              WNHINT(NLMX,MDEPTH),
     *              WNHE2(NLMX,MDEPTH),
     *              RRR(MDEPTH,MION,MATOMBIG),
     *              JT(MDEPTH),
     *              TI0(MDEPTH),
     *              TI1(MDEPTH),
     *              TI2(MDEPTH)
      COMMON/MOLPAR/RRMOL(MMOLEC,MDEPTH),
     *              DOPMOL(MMOLEC,MDEPTH),
     *              AMMOL(MMOLEC),
     *              CMOL(MMOLEC)
