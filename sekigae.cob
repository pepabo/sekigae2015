       IDENTIFICATION DIVISION.
       PROGRAM-ID. sekigae.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT I-FILE ASSIGN TO "names.txt"
                   ORGANIZATION LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD I-FILE
           LABEL RECORDS ARE STANDARD.
       01 I-READ PIC X(16).

       WORKING-STORAGE SECTION.
       01 I-EOF PIC X(02) VALUE LOW-VALUE.
       01 I PIC 9(01) VALUE 0.
       01 J PIC 9(01).
       01 TEMP PIC X(16).
       01 N-REC.
               03 N-TABLE PIC X(16) OCCURS 6 TIMES.

       PROCEDURE DIVISION.
           OPEN INPUT I-FILE.
           INITIALIZE N-REC.
           PERFORM UNTIL I-EOF = HIGH-VALUE
                   MOVE I-READ TO N-TABLE(I)
                   ADD 1 TO I
                   READ I-FILE INTO I-READ
                           AT END MOVE HIGH-VALUE TO I-EOF END-READ
           END-PERFORM
           CLOSE I-FILE

           MOVE FUNCTION RANDOM(FUNCTION CURRENT-DATE (11:6)) TO I
           PERFORM VARYING I FROM 6 BY -1 UNTIL I = 0
                   COMPUTE J =
                   FUNCTION MOD(FUNCTION RANDOM * 10000, 6) + 1
                   MOVE N-TABLE(I) TO TEMP
                   MOVE N-TABLE(J) TO N-TABLE(I)
                   MOVE TEMP TO N-TABLE(J)
           END-PERFORM

           PERFORM VARYING I FROM 6 BY -1 UNTIL I = 4
                   DISPLAY N-TABLE(I) WITH NO ADVANCING
           END-PERFORM
           DISPLAY N-TABLE(I)

           PERFORM VARYING I FROM 3 BY -1 UNTIL I = 1
                   DISPLAY N-TABLE(I) WITH NO ADVANCING
           END-PERFORM
           DISPLAY N-TABLE(I)

           STOP RUN.
