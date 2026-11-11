     H*================================================================*
     H* PROGRAMA : STC01RG
     H* FUNCAO   : PESQUISA E SELECAO DE CLIENTES
     H* TECLA    : F4 - PESQUISAR
     H*================================================================*
     FSTC01FM   CF   E             WORKSTN SFILE(SFLREC:RRN)
     FANCLI01L  IF   E           K DISK
     D RRN             S              4S 0
     D P_CDCLI         S             10A
     D P_RZSOC         S             30A
     D P_CPFCNPJ       S             14A
     D P_INSEST        S             15A
     C     *ENTRY        PLIST
     C                   PARM                    P_CDCLI
     C                   PARM                    P_RZSOC
     C                   PARM                    P_CPFCNPJ
     C                   PARM                    P_INSEST
     C*
     C                   MOVE      *BLANKS       P_CDCLI
     C                   MOVE      *BLANKS       P_RZSOC
     C                   MOVE      *BLANKS       P_CPFCNPJ
     C                   MOVE      *BLANKS       P_INSEST
     C                   SETOFF                                       12
     C                   EXSR      CARREGA
     C*
     C     *IN12         DOWEQ     *OFF
     C                   EXFMT     SFLCTL
     C*
     C     *IN12         IFEQ      *ON
     C                   LEAVE
     C                   ENDIF
     C*
     C                   READC     SFLREC                                 90
     C     *IN90         DOWEQ     *OFF
     C*
     C     W_OPZ         IFEQ      '1'
     C     W_OPZ         OREQ      'X'
     C                   MOVE      W_CDCLI       P_CDCLI
     C                   MOVE      W_RZSOC       P_RZSOC
     C                   LEAVE
     C                   ENDIF
     C*
     C                   READC     SFLREC                                 90
     C                   ENDDO
     C*
     C     P_CDCLI       IFNE      *BLANKS
     C                   LEAVE
     C                   ENDIF
     C                   ENDDO
     C*
     C                   SETON                                        LR
     C                   RETURN
     C*
     C*================================================================*
     C* CARREGA SUBFILE COM OS CLIENTES
     C*================================================================*
     C     CARREGA       BEGSR
     C                   SETON                                        83
     C                   WRITE     SFLCTL
     C                   SETOFF                                       83
     C*
     C                   Z-ADD     0             RRN
     C     *LOVAL        SETLL     ANCLI01L
     C                   READ      ANCLI01L                               90
     C*
     C     *IN90         DOWEQ     *OFF
     C                   MOVE      *BLANKS       W_OPZ
     C                   MOVE      CLNCLI        W_CDCLI
     C                   MOVE      CLNOME        W_RZSOC
     C                   ADD       1             RRN
     C                   WRITE     SFLREC
     C                   READ      ANCLI01L                               90
     C                   ENDDO
     C*
     C     RRN           IFGT      0
     C                   SETON                                        81
     C                   ELSE
     C                   SETOFF                                       81
     C                   ENDIF
     C                   SETON                                        82
     C                   ENDSR

