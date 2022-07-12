        IDENTIFICATION DIVISION.
        PROGRAM-ID. MF47CB3.
        AUTHOR. SONALI.
        DATE-WRITTEN. 06/07/2022.
        ENVIRONMENT DIVISION.
        DATA DIVISION.
      ****************************************************************
      * REMARK     - THIS PROGRAM IS WRITTEN TO INTERACT WITH DB2   **
      *              TABLES & CICS SCREEN(RETREIVE/INSERT).         **
      * CALLED BY  - PROGRAM: MF47CB1                               **
      ***************************************************************

       WORKING-STORAGE SECTION.
      * 05 WS-CLAIMDATE     PIC X(10).
       01 WS-SQLCODE       PIC -9(03).
           EXEC SQL
               INCLUDE SQLCA
           END-EXEC.
           EXEC SQL
               INCLUDE MF47CP2
           END-EXEC.
       LINKAGE SECTION.
           COPY MF47BMS.
      ****************************************************************
      *                  PROCEDURE DIVISION                         **
      ****************************************************************
       PROCEDURE DIVISION USING MF47BMSI
                                MF47BMSO.
       0000-MAIN-PARA.
      *
           EVALUATE OPTIONI
               WHEN '1'
                    PERFORM 2000-SELECT-DATA
               WHEN '2'
                    PERFORM 3000-INSERT-DATA
               WHEN OTHER
                    CONTINUE
           END-EVALUATE
           GOBACK.
      ******************************************************************
      *                 FETCH DATA FROM CLAIMS TABLE                   *
      ******************************************************************
       2000-SELECT-DATA.
      *
           INITIALIZE WS-SQLCODE.
           INITIALIZE CAUSE.
           INITIALIZE OBSERVATIONS.
           INITIALIZE CAUSEO.
           INITIALIZE observO.

           MOVE claimNumI                TO CLAIMNUMBER
           DISPLAY 'CLAIM NUMBER:' claimNumI
           EXEC SQL
                SELECT  CLAIMDATE
                       ,PAID
                       ,VALUE1
                       ,CAUSE
                       ,OBSERVATIONS
                  INTO  :CLAIMDATE
                       ,:PAID
                       ,:VALUE1
                       ,:CAUSE
                       ,:OBSERVATIONS
                  FROM   MFTR47.CLAIMS6
                 WHERE  CLAIMNUMBER = :CLAIMNUMBER
            END-EXEC.
            EVALUATE SQLCODE
                WHEN 0
                     DISPLAY 'SQLCODE 0:'
      *               MOVE FUNCTION DISPLAY-OF(WS-CLAIMDATE) TO CLAIMDTO
      *              MOVE FUNCTION DISPLAY-OF(CAUSE)       TO CAUSEO
      *               MOVE FUNCTION DISPLAY-OF(OBSERVATIONS) TO OBSRVO
                      MOVE FUNCTION DISPLAY-OF(CLAIMDATE) TO dateO
                      MOVE FUNCTION DISPLAY-OF(CAUSE) TO CAUSEO
                      MOVE FUNCTION DISPLAY-OF(OBSERVATIONS) TO observO
                      MOVE PAID   OF CLAIMS6 TO PAIDO
                      MOVE VALUE1 OF CLAIMS6 TO tvalueO
                      MOVE 'CLAIM FOUND SUCCESSFULLY' TO MSGO
                WHEN 100
                     MOVE 'CLAIM NOT FOUND'        TO MSGO
                WHEN OTHER
                     MOVE SQLCODE                  TO WS-SQLCODE
                     STRING 'SQL ERROR IN FETCH - RC : ' WS-SQLCODE
                            DELIMITED BY SIZE INTO MSGO
                     END-STRING
            END-EVALUATE.
      ******************************************************************
      *                 UPDATE THE TABLE THRU SCREEN DATA              *
      ******************************************************************
       3000-INSERT-DATA.
      *
           INITIALIZE WS-SQLCODE.
           INITIALIZE CAUSE.
           INITIALIZE OBSERVATIONS.


           MOVE claimNumI  TO CLAIMNUMBER.
           MOVE paidI   TO PAID.
           MOVE tvalueI   TO VALUE1.
           MOVE dateI TO CLAIMDATE.
           MOVE CAUSEI   TO CAUSE.
      *     MOVE LENGTH OF CAUSEI   TO CAUSE-LEN.
           MOVE observI   TO OBSERVATIONS.
      *     MOVE LENGTH OF observI   TO OBSERVATIONS-LEN.
           EXEC SQL
                INSERT  INTO MFTR47.CLAIMS6
                       ( CLAIMNUMBER
                        ,CLAIMDATE
                        ,PAID
                        ,VALUE1
                        ,CAUSE
                        ,OBSERVATIONS)
                VALUES ( :CLAIMNUMBER
                        ,:CLAIMDATE
                        ,:PAID
                        ,:VALUE1
                        ,:CAUSE
                        ,:OBSERVATIONS)
            END-EXEC.
            EVALUATE SQLCODE
                WHEN 0
                     MOVE 'CLAIM ADDED SUCCESSFULLY'   TO MSGO
                WHEN -803
                     MOVE 'DUPLICATE RECORD. INSERT OPERATION FAILED'
                                                       TO MSGO
                WHEN OTHER
                     MOVE SQLCODE                      TO WS-SQLCODE
                     STRING 'SQL ERROR IN INSERT - RC : ' WS-SQLCODE
                            DELIMITED BY SIZE INTO MSGO
            END-EVALUATE.
      ***************************************************************
      ***************XXXXXXXXXXXXEOPXXXXXXXXXXXXXXX******************
      ***************************************************************