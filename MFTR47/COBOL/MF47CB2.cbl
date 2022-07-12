        IDENTIFICATION DIVISION.
        PROGRAM-ID. MF47CB2.
        AUTHOR. Sonali.
        DATE-WRITTEN. 05/07/2022.
        ENVIRONMENT DIVISION.
        DATA DIVISION.
      ****************************************************************
      * REMARK     - THIS PROGRAM IS WRITTEN TO VALIDATE BUSINESS   **
      *              LOGICS - NUMERIC FIELDS,AMOUNT & DATE FIELDS.  **
      * CALLED BY  - PROGRAM: MF47CB1                               **
      ****************************************************************
       WORKING-STORAGE SECTION.
       01 WS-VARIABLES.
           05 WS-CURR-DT        PIC X(16).
           05 WS-CLAIM-DT.
                10 WS-YYYY      PIC X(4).
                10 WS-MM        PIC X(2).
                10 WS-DD        PIC X(2).
       01 WS-CONSTANTS.
           05 W30-1             PIC 9(01) VALUE 1.
           05 W30-2             PIC 9(01) VALUE 2.
           05 W30-N             PIC X(01) VALUE 'N'.
           05 W30-Y             PIC X(01) VALUE 'Y'.
           05 W30-MSG-CLMVAL1   PIC X(60) VALUE
                         'ENTER A CLAIM NUMBER'.
           05 W30-MSG-CLMVAL2   PIC X(60) VALUE
                         'ENTER A VALID CLAIM NUMBER'.
           05 W30-MSG-paidAL1  PIC X(60) VALUE
                         'PAID AMT SHOULD BE LESS THAN TOTAL VALUE'.
           05 W30-MSG-paidAL2  PIC X(60) VALUE
                         'ENTER A VALID PAID AMOUNT'.
           05 W30-MSG-NOTNUM    PIC X(60) VALUE
                         'VALUE IS NOT NUMERIC'.
           05 W30-MSG-DATE      PIC X(60) VALUE
                         'CLAIM DATE NEEDS TO BE ON PAST'.
       LINKAGE SECTION.
         COPY MF47BMS.
       01 ERROR-FLAG            PIC X(01) VALUE SPACES.
      ****************************************************************
      *                  PROCEDURE DIVISION                         **
      ****************************************************************
       PROCEDURE DIVISION USING MF47BMSI
                                MF47BMSO
                                ERROR-FLAG.
      ****************************************************************
      *                      MAIN - PARA                            **
      ****************************************************************
       0000-MAIN-PARA.
           PERFORM 1000-VALIDATE-PARA.
           GOBACK.
      ****************************************************************
      *                    VALIDATION OF DATA                       **
      ****************************************************************
       1000-VALIDATE-PARA.
      *
           INITIALIZE ERROR-FLAG.
           EVALUATE OPTIONI
               WHEN W30-1
                    PERFORM 1000-VALIDT-CLAIM-NUM
               WHEN W30-2
                    PERFORM 1000-VALIDT-CLAIM-NUM
                    IF ERROR-FLAG = W30-N
                       PERFORM 2000-VALIDT-PAID
                    END-IF
                    IF ERROR-FLAG = W30-N
                       PERFORM 2500-VALIDT-PAID-NUM
                    END-IF
                    IF ERROR-FLAG = W30-N
                       PERFORM 3000-VALIDT-VALUE
                    END-IF
                    IF ERROR-FLAG = W30-N
                       PERFORM 4000-VALIDT-DATE
                    END-IF
           END-EVALUATE.
      ******************************************************************
      *                 VALIDATE CLAIM NUMBER                         **
      ******************************************************************
       1000-VALIDT-CLAIM-NUM.
      *
            IF claimNumI = 0
               MOVE W30-MSG-CLMVAL1       TO MSGO
               MOVE W30-Y                 TO ERROR-FLAG
            ELSE
                IF claimNumI IS NUMERIC
                   MOVE W30-N             TO ERROR-FLAG
                ELSE
                   MOVE W30-Y             TO ERROR-FLAG
                   MOVE W30-MSG-CLMVAL2   TO MSGO
                END-IF
            END-IF.
      ******************************************************************
      *      VALIDATE IF PAID IS LESS THAN OR EQUAL TO TOTAL VALUE    **
      ******************************************************************
       2000-VALIDT-PAID.
      *
           IF paidI < tvalueI
                MOVE W30-N             TO ERROR-FLAG
           ELSE
                DISPLAY 'PAID AMOUNT : ' paidI
                DISPLAY 'VALUE AMOUNT: ' tvalueI
                MOVE W30-MSG-paidAL1  TO MSGO
                MOVE W30-Y             TO ERROR-FLAG
           END-IF.
      ******************************************************************
      *               VALIDATE IF PAID IS NUMERIC                     **
      ******************************************************************
       2500-VALIDT-PAID-NUM.
      *
            IF paidI IS NUMERIC
               MOVE W30-N               TO ERROR-FLAG
            ELSE
               IF paidI = 0
                  MOVE W30-N            TO ERROR-FLAG
               ELSE
                  DISPLAY 'PAID VALUE: ' paidI
                  MOVE W30-MSG-paidAL2 TO MSGO
                  MOVE W30-Y            TO ERROR-FLAG
               END-IF
            END-IF.
      ******************************************************************
      *               VALIDATE IF VALUE IS NUMERIC                    **
      ******************************************************************
       3000-VALIDT-VALUE.
      *
             IF tvalueI IS NUMERIC
                   MOVE W30-N         TO ERROR-FLAG
             ELSE
                  DISPLAY 'VALUE :' tvalueI
                  MOVE W30-MSG-NOTNUM TO MSGO
                  MOVE W30-Y          TO ERROR-FLAG
             END-IF.
      ******************************************************************
      *                  CHECK DATES ARE IN PAST                      **
      ******************************************************************
       4000-VALIDT-DATE.
      *
           MOVE dateI(1:4)          TO WS-YYYY
           MOVE dateI(6:2)          TO WS-MM
           MOVE dateI(9:2)          TO WS-DD
           MOVE FUNCTION CURRENT-DATE  TO WS-CURR-DT
           IF WS-CLAIM-DT > WS-CURR-DT(1:8)
                MOVE W30-Y             TO ERROR-FLAG
                MOVE W30-MSG-DATE      TO MSGO
           ELSE
                MOVE W30-N             TO ERROR-FLAG
           END-IF.
      ***************************************************************
      ***************XXXXXXXXXXXXEOPXXXXXXXXXXXXXXX******************
      ***************************************************************