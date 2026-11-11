     H*================================================================*
     H* PROGRAMA RPG : STC02RG
     H* FUNCAO       : MANUTENCAO DO CADASTRO DE CLIENTES
     H* DESCRICAO    : CONSULTA, INCLUSAO E ALTERACAO
     H*================================================================*
     FSTC02FM   CF   E             WORKSTN
     FANCLI01L  UF A E           K DISK
     D P_CDCLI         S             10A
     D P_RZSOC         S             30A
     D P_CPFCNPJ       S             14A
     D P_INSEST        S             15A
     C*
     C                   EXSR      INICIA
     C*
     C     *IN03         DOWEQ     *OFF
     C                   EXFMT     KEYREC
     C*
     C     *IN03         IFEQ      *ON
     C                   LEAVE
     C                   ENDIF
     C*
     C     *IN12         IFEQ      *ON
     C                   SETOFF                                       12
     C                   EXSR      INICIA
     C                   ITER
     C                   ENDIF
     C*
     C     *IN04         IFEQ      *ON
     C                   SETOFF                                       04
     C                   EXSR      CHAMAJNL
     C                   ENDIF
     C*
     C     W_CDCLI       IFNE      *BLANKS
     C                   EXSR      CONSCLI
     C                   EXSR      DETALHE
     C                   MOVE      *BLANKS       W_CDCLI
     C                   ENDIF
     C*
     C                   ENDDO
     C*
     C                   SETON                                        LR
     C                   RETURN
     C*
     C*================================================================*
     C* INICIALIZA A TELA
     C*================================================================*
     C     INICIA        BEGSR
     C                   MOVE      *BLANKS       W_CDCLI
     C                   MOVE      *BLANKS       W_RZSOC
     C                   MOVE      *BLANKS       W_FANT
     C                   MOVE      *BLANKS       W_INSEST
     C                   MOVE      *BLANKS       W_TPPES
     C                   MOVE      *BLANKS       W_CPF
     C                   MOVE      *BLANKS       W_CNPJ
     C                   MOVE      *BLANKS       W_MSG
     C                   SETON                                        30
     C                   SETON                                        31
     C                   SETOFF                                       04
     C                   SETOFF                                       06
     C                   SETOFF                                       12
     C                   SETOFF                                       90
     C                   SETOFF                                       95
     C                   ENDSR
     C*
     C*================================================================*
     C* CHAMA A JANELA DE PESQUISA DE CLIENTES - F4
     C*================================================================*
     C     CHAMAJNL      BEGSR
     C                   MOVE      *BLANKS       P_CDCLI
     C                   MOVE      *BLANKS       P_RZSOC
     C                   MOVE      *BLANKS       P_CPFCNPJ
     C                   MOVE      *BLANKS       P_INSEST
     C*
     C                   CALL      'STC01RG'
     C                   PARM                    P_CDCLI
     C                   PARM                    P_RZSOC
     C                   PARM                    P_CPFCNPJ
     C                   PARM                    P_INSEST
     C*
     C                   IF        P_CDCLI <> *BLANKS
     C                   MOVE      P_CDCLI       W_CDCLI
     C                   ENDIF
     C                   ENDSR
     C*
     C*================================================================*
     C* CONSULTA CLIENTE NO ARQUIVO LOGICO
     C*================================================================*
     C     CONSCLI       BEGSR
     C                   SETOFF                                       30
     C                   SETOFF                                       95
     C*
     C     W_CDCLI       CHAIN     ANCLI01L
     C*
     C                   IF        %FOUND(ANCLI01L)
     C                   MOVE      CLNOME        W_RZSOC
     C                   MOVE      CLFANT        W_FANT
     C                   MOVE      CLINSEST      W_INSEST
     C                   MOVE      CLTPPES       W_TPPES
     C                   MOVE      CLICPF        W_CPF
     C                   MOVE      CLINPJ        W_CNPJ
     C                   MOVE      *BLANKS       W_MSG
     C                   ELSE
     C                   MOVE      *BLANKS       W_RZSOC
     C                   MOVE      *BLANKS       W_FANT
     C                   MOVE      *BLANKS       W_INSEST
     C                   MOVE      *BLANKS       W_TPPES
     C                   MOVE      *BLANKS       W_CPF
     C                   MOVE      *BLANKS       W_CNPJ
     C                   EVAL      W_MSG = 'NOVO CLIENTE - INFORME OS DADOS'
     C                   ENDIF
     C                   ENDSR
     C*
     C*================================================================*
     C* DETALHES DO CLIENTE
     C*================================================================*
     C     DETALHE       BEGSR
     C     *IN03         DOWEQ     *OFF
     C                   EXFMT     DETREC
     C*
     C     *IN03         IFEQ      *ON
     C                   LEAVE
     C                   ENDIF
     C*
     C     *IN12         IFEQ      *ON
     C                   SETOFF                                       12
     C                   EXSR      INICIA
     C                   LEAVE
     C                   ENDIF
     C*
     C     *IN04         IFEQ      *ON
     C                   SETOFF                                       04
     C                   EXSR      CHAMAJNL
     C     P_CDCLI       IFNE      *BLANKS
     C                   EXSR      CONSCLI
     C                   ENDIF
     C                   ENDIF
     C*
     C     *IN06         IFEQ      *ON
     C                   SETOFF                                       06
     C                   EXSR      GRAVAALT
     C                   ENDIF
     C*
     C                   ENDDO
     C                   ENDSR
     C*
     C*================================================================*
     C* VALIDACAO E GRAVACAO DO CLIENTE
     C*================================================================*
     C     GRAVAALT      BEGSR
     C                   SETOFF                                       95
     C*
     C     W_CDCLI       IFEQ      *BLANKS
     C                   EVAL      W_MSG = 'INFORME O CODIGO DO CLIENTE'
     C                   SETON                                        95
     C                   ENDIF
     C*
     C     W_RZSOC       IFEQ      *BLANKS
     C                   EVAL      W_MSG = 'INFORME A RAZAO SOCIAL'
     C                   SETON                                        95
     C                   ENDIF
     C*
     C     W_TPPES       IFEQ      *BLANKS
     C                   EVAL      W_MSG = 'INFORME O TIPO DE PESSOA'
     C                   SETON                                        95
     C                   ENDIF
     C*
     C     W_TPPES       IFNE      'F'
     C     W_TPPES       ANDNE     'J'
     C                   EVAL      W_MSG = 'TIPO DE PESSOA INVALIDO'
     C                   SETON                                        95
     C                   ENDIF
     C*
     C     *IN95         IFEQ      *OFF
     C*
     C     W_CDCLI       CHAIN     ANCLI01L
     C*
     C                   MOVE      W_CDCLI       CLNCLI
     C                   MOVE      W_RZSOC       CLNOME
     C                   MOVE      W_FANT        CLFANT
     C                   MOVE      W_INSEST      CLINSEST
     C                   MOVE      W_TPPES       CLTPPES
     C                   MOVE      W_CPF         CLICPF
     C                   MOVE      W_CNPJ        CLINPJ
     C*
     C                   IF        %FOUND(ANCLI01L)
     C                   UPDATE    ANCLI00R
     C                   ELSE
     C                   WRITE     ANCLI00R
     C                   ENDIF
     C*
     C                   EVAL      W_MSG = 'CLIENTE GRAVADO COM SUCESSO'
     C                   SETOFF                                       95
     C                   ENDIF
     C                   ENDSR
