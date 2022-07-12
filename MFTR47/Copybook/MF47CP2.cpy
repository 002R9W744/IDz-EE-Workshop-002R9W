      ******************************************************************
      * DCLGEN TABLE(MFTR47.CLAIMS6)                                   *
      *        LIBRARY(MFTR47.DCLGEN.COPYLIB(CLAIMS6))                 *
      *        ACTION(REPLACE)                                         *
      *        LANGUAGE(COBOL)                                         *
      *        STRUCTURE(CLAIMS6)                                      *
      *        APOST                                                   *
      *        LABEL(YES)                                              *
      *        DBCSDELIM(NO)                                           *
      *        COLSUFFIX(YES)                                          *
      *        INDVAR(YES)                                             *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE MFTR47.CLAIMS6 TABLE
           ( CLAIMNUMBER                    INTEGER NOT NULL,
             CLAIMDATE                      DATE,
             PAID                           INTEGER,
             VALUE1                         INTEGER,
             CAUSE                          VARCHAR(255),
             OBSERVATIONS                   VARCHAR(255)
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE MFTR47.CLAIMS6                     *
      ******************************************************************
       01  CLAIMS6.
      *    *************************************************************
           10 CLAIMNUMBER          PIC S9(9) USAGE COMP-5.
      *    *************************************************************
           10 CLAIMDATE            PIC N(10) USAGE NATIONAL.
      *    *************************************************************
           10 PAID                 PIC S9(9) USAGE COMP-5.
      *    *************************************************************
           10 VALUE1               PIC S9(9) USAGE COMP-5.
      *    *************************************************************
           10 CAUSE                PIC N(255) USAGE NATIONAL.
      *        49 CAUSE-LEN         PIC S9(4) USAGE COMP-5.
      *        49 CAUSE-TEXT        PIC X(255).
      *    *************************************************************
           10 OBSERVATIONS         PIC N(255) USAGE NATIONAL.
      *        49 OBSERVATIONS-LEN
      *           PIC S9(4) USAGE COMP-5.
      *        49 OBSERVATIONS-TEXT
      *           PIC X(255).
      ******************************************************************
      * INDICATOR VARIABLE STRUCTURE                                   *
      ******************************************************************
       01  ICLAIMS6.
           10 INDSTRUC           PIC S9(4) USAGE COMP-5 OCCURS 6 TIMES.
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 6       *
      ******************************************************************