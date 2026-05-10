**********************************************
* Advanced Digital IC Design (U18)           *
*                                            *
* Exercise: Phase/Frequency Detector         *
**********************************************

**********************************************
* Subckt Definition                          *
**********************************************

.SUBCKT DPA
+ IN
+ OUT
XBUF1  IN  BUF1_OUT                       BUFX1
XAND1  BUF1_OUT  IN AND1_OUT              AND2X1
XAND2  AND1_OUT  BUF1_OUT AND2_OUT        AND2X1
XAND3  AND2_OUT  AND1_OUT AND3_OUT        AND2X1
XAND4  AND3_OUT  AND2_OUT AND4_OUT        AND2X1
XAND5  AND4_OUT  AND3_OUT AND5_OUT        AND2X1
XAND6  AND5_OUT  AND4_OUT OUT             AND2X1
.ENDS

.SUBCKT PFD
+ RESET_ IN FB
+ flagU flagD PHASE_CLK
XDFFX1  IN  VDD  AND1_OUT  NO  QU         DFFRX4
XDFFX2  FB  VDD  AND1_OUT  NO  QD         DFFRX4

XNAND1  QU  QD  NAND1_OUT                 NAND2X1
XAND1  NAND1_OUT  RESET_  AND1_OUT        AND2X1

XINV1  QU  INV1_OUT                       INVX1
XINV2  QD  INV2_OUT                       INVX1

XNAND21  QU  INV2_OUT  OUTU               NAND2X1
XNAND22  QU  INV2_OUT  OUTU               NAND2X1
XNAND23  QU  INV2_OUT  OUTU               NAND2X1
XNAND24  QU  INV2_OUT  OUTU               NAND2X1
XNAND25  QU  INV2_OUT  OUTU               NAND2X1
XNAND26  QU  INV2_OUT  OUTU               NAND2X1

XNAND31  QD  INV1_OUT  OUTD               NAND2X1
XNAND32  QD  INV1_OUT  OUTD               NAND2X1
XNAND33  QD  INV1_OUT  OUTD               NAND2X1
XNAND34  QD  INV1_OUT  OUTD               NAND2X1
XNAND35  QD  INV1_OUT  OUTD               NAND2X1
XNAND36  QD  INV1_OUT  OUTD               NAND2X1

XDPA1  OUTU  OUTBU DPA
XDPA2  OUTD  OUTBD DPA

XDFFX3  IN  VDD  OUTBU  NO  flagU         DFFRX4
XDFFX4  FB  VDD  OUTBD  NO  flagD         DFFRX4

XANDCLK  flagU  flagD  PHASE_CLK          AND2X1
.ENDS

**********************************************
* TOP Circuit                               *
**********************************************
*PFD(RESET_ IN, FB, flagU, flagD, PHASE_CLK)
*XPFD1  RESET_  IN  FB  flagU  flagD  PHASE_CLK  PFD

.END
