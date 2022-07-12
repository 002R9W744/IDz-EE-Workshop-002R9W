         IDENTIFICATION DIVISION.
         PROGRAM-ID. MF47CB1.
         AUTHOR. SONALI.
         DATE-WRITTEN. 07/06/2022.
      ****************************************************************
      * REMARK     - THIS PROGRAM IS WRITTEN TO INTERACT WITH        *
      *              FRONT-END AND CALLS BELOW PROGRAMS:             *
      * MF47CB2  - Business logic VALIDATION                       *
      * MF47CB3  - Data interaction                                *
      ****************************************************************
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-ERROR-FLAG         PIC X(01) VALUE SPACES.
           88 ERROR-TRUE                  VALUE 'Y'.
           88 ERROR-FALSE                 VALUE 'N'.
       01 WS-DATE-ERROR-FLAG    PIC X(01) VALUE SPACES.
           88 DATE-ERROR-TRUE             VALUE 'Y'.
           88 DATE-ERROR-FALSE            VALUE 'N'.
       01 WS-MF47CB2            PIC X(08) VALUE 'MF47CB2'.
       01 WS-MF47CB3            PIC X(08) VALUE 'MF47CB3'.
       01 WS-MSG                PIC X(24) VALUE 'TRANSACTION ENDED'.
       01 WS-INIT               PIC X(01) VALUE 'Y'.
      ****************************************************************
        COPY MF47BMS.
      ****************************************************************
       LINKAGE SECTION.
       01 DFHCOMMAREA    PIC X(6000).
      ****************************************************************
      *                  PROCEDURE DIVISION                         **
      ****************************************************************
       PROCEDURE DIVISION.
       0000-MAIN-PARA.
               MOVE LOW-VALUES TO MF47BMSI
               MOVE LOW-VALUES TO MF47BMSO.
               PERFORM 1000-SEND-MAP-PARA.
               PERFORM 2000-RECEIVE-MAP-PARA.
               PERFORM 3000-PROCESS-PARA.
               PERFORM 8000-EXIT-PARA.
      ****************************************************************
      *                SEND MAP TO CICS SCREEN                      **
      ****************************************************************
       1000-SEND-MAP-PARA.
            EXEC CICS SEND
               MAP('MF47BMS')
               MAPSET('MF47BMS')
               FROM(MF47BMSO)
               ERASE
           END-EXEC.
      *    IF WS-INIT = 'Y'
      *       MOVE 'N' TO WS-INIT
      *       EXEC CICS RETURN
      *          TRANSID ('MF47')
      *       END-EXEC
      *    END-IF.
      ****************************************************************
      *             RECEIVE DATA FROM CICS SCREEN                   **
      ****************************************************************
       2000-RECEIVE-MAP-PARA.
           EXEC CICS RECEIVE
               MAP('MF47BMS')
               MAPSET('MF47BMS')
               INTO(MF47BMSI)
           END-EXEC.
      ****************************************************************
      *                     PROCESS PARA                            **
      ****************************************************************
       3000-PROCESS-PARA.
           EVALUATE OPTIONI
               WHEN 1
               WHEN 2
                    CALL WS-MF47CB2 USING MF47BMSI
                                          MF47BMSO
                                          WS-ERROR-FLAG
                    IF ERROR-TRUE
                       CONTINUE
                    ELSE
                       CALL WS-MF47CB3 USING MF47BMSI
                                         MF47BMSO
                    END-IF
                    PERFORM 1000-SEND-MAP-PARA
               WHEN OTHER
                    MOVE 'INCORRECT OPTION SELECTED' TO MSGO
                    PERFORM 1000-SEND-MAP-PARA
           END-EVALUATE.
      ***************************************************************
      *                      EXIT PARA                             **
      ***************************************************************
       8000-EXIT-PARA.
            EXEC CICS RETURN
                 TRANSID ('MF47')
            END-EXEC.
      ***************************************************************
      ***************XXXXXXXXXXXXEOPXXXXXXXXXXXXXXX******************
      ***************************************************************