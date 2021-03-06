//MFTR471 JOB ,
// MSGCLASS=H,MSGLEVEL=(1,1),TIME=(,4),REGION=144M,COND=(16,LT)
//*
//P0000 EXEC PROC=ELAXFCOP,
//        DBRMDSN=MFTR47.DB2DBRM,
//        DBRMMEM=MF47CB3,
// PARM.COBPRE=('APOSTSQL,APOST,COBOL3,DATE,HOST(ASM|SQLPL),SQL(ALL)')
//COBPRE.SYSLIB DD DSN=MFTR47.SOURCE.COPYLIB(MF47CP2),DISP=SHR
//COBPRE.SYSIN DD DISP=SHR,
//        DSN=MFTR47.SOURCE.COBOL(MF47CB3)
//*
//*
//STP0000 EXEC PROC=ELAXFCOC,
// CICS=,
// DB2=,
// COMP=
//COBOL.SYSPRINT DD DISP=SHR,
//        DSN=MFTR47.SOURCE.LISTING(MF47CB3)
//COBOL.SYSDEBUG DD DISP=SHR,
//        DSN=MFTR47.COBOL.SYSDEBUG(MF47CB3)
//COBOL.SYSLIN DD DISP=SHR,
//        DSN=MFTR47.COBOBJS.OBJ(MF47CB3)
//COBOL.SYSLIB DD DISP=SHR,
//        DSN=MFTR47.SOURCE.COPYLIB
//COBOL.SYSXMLSD DD DUMMY
//COBOL.SYSIN    DD  DISP=(OLD,DELETE),DSN=&&DSNHOUT
//******* ADDITIONAL JCL FOR COMPILE HERE ******
//LKED EXEC PROC=ELAXFLNK
//LINK.SYSLIB DD DSN=MFTR47.COBOBJS.OBJ,
//        DISP=SHR
//        DD DSN=CEE.SCEELKED,
//        DISP=SHR
//        DD DSN=DFH540.CICS.SDFHLOAD,
//        DISP=SHR
//        DD DSN=DSNB10.SDSNEXIT,
//        DISP=SHR
//        DD DSN=DSNB10.DBBG.SDSNEXIT,
//        DISP=SHR
//        DD DSN=DSNB10.SDSNLOAD,
//        DISP=SHR
//LINK.OBJ0000 DD DISP=SHR,
//        DSN=MFTR47.COBOBJS.OBJ(MF47CB3)
//LINK.SYSLIN DD *
     INCLUDE OBJ0000
/*
//LINK.SYSLMOD   DD  DISP=SHR,
//        DSN=ASHISSA.ZDEVOPS.LOADLIB(MF47CB3)
//*
//******* ADDITIONAL JCL FOR LINK HERE ******
//BIND EXEC PGM=IKJEFT01
//SYSPRINT DD SYSOUT=*
//SYSTSPRT DD SYSOUT=*
//DBRMLIB  DD  DSN=MFTR47.DB2DBRM,DISP=SHR
//STEPLIB DD DSN=DSNB10.SDSNLOAD,DISP=SHR
//*UNCOMMENT AND TAILOR THE FOLLOWING CODE IF YOUR SYSTSIN STATEMENT**
//*CONTAINS BIND INSTRUCTIONS:
//SYSTSIN   DD  *
      DSN SYSTEM(DBCG)
      BIND PACKAGE(DALLASC.MFTR47)-
          OWNER(MFTR47) -
          MEMBER(MF47CB3) -
          LIBRARY('MFTR47.DB2DBRM') -
          ACTION(REP) -
          VALIDATE(BIND)
         BIND PLAN(MF47CB3) -
         PKLIST(DALLASC.MFTR47.*)
       END
//*    OR
//*UNCOMMENT AND TAILOR THE FOLLOWING CODE IF YOUR SYSTSIN STATEMENT**
//*POINTS TO A DATA SET CONTAINING BIND INSTRUCTIONS
//*//SYSTSIN DD DSN=USERID.BIND(MEMBER),DISP=SHR
//*
/*
//
