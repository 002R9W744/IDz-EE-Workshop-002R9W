//MFTR471 JOB ,
// MSGCLASS=H,MSGLEVEL=(1,1),TIME=1140,REGION=144M,COND=(16,LT)
//*
//T0000 EXEC PROC=ELAXFCOT,
// PARM.COBTRAN=('COBOL3.APOST')
//COBTRAN.SYSLIB DD DSN=DFH540.CICS.SDFHCOB,DISP=SHR
//COBTRAN.SYSIN DD DISP=SHR,
//        DSN=MFTR47.SOURCE.COBOL(MF47CB1)
//*
//*
//STP0000 EXEC PROC=ELAXFCOC,
// CICS=,
// DB2=,
// COMP=,
// PARM.COBOL=('LIB','TEST(EJPD,SOURCE)','LIST','OFFSET','ADATA',)
//COBOL.SYSPRINT DD DISP=SHR,
//        DSN=MFTR47.SOURCE.LISTING(MF47CB1)
//COBOL.SYSDEBUG DD DISP=SHR,
//        DSN=MFTR47.COBOL.SYSDEBUG(MF47CB1)
//COBOL.SYSLIN DD DISP=SHR,
//        DSN=MFTR47.SOURCE.OBJLIB(MF47CB1)
//COBOL.DBRMLIB  DD  DISP=SHR,
//        DSN=MFTR47.DB2DBRM(MF47CB1)
//COBOL.SYSLIB DD DISP=SHR,
//        DSN=MFTR47.SOURCE.COPYLIB
//COBOL.SYSXMLSD DD DUMMY
//COBOL.SYSIN    DD  DISP=(OLD,DELETE),DSN=&&SYSCIN
//* FOR DEBUG
//*
//****** ADDITIONAL JCL FOR COMPILE HERE ******
//LKED EXEC PROC=ELAXFLNK
//LINK.SYSLIB DD DSN=MFTR47.SOURCE.OBJLIB,
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
//        DSN=MFTR47.SOURCE.OBJLIB(MF47CB1)
//LINK.SYSLIN DD *
     INCLUDE OBJ0000
/*
//LINK.SYSLMOD   DD  DISP=SHR,
//        DSN=ASHISSA.ZDEVOPS.LOADLIB(MF47CB1)
//*END