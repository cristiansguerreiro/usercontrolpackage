unit UCConsts;

interface

const
  // new consts version 2 a 5 =========================================
  // Form Select Controls (design-time)
  Const_Contr_TitleLabel     = 'Sele��o de Componentes do Form. :';
  Const_Contr_GroupLabel     = 'Grupo :';
  Const_Contr_CompDispLabel  = 'Componentes Dispon�veis :';
  Const_Contr_CompSelLabel   = 'Componentes Selecionados :';
  Const_Contr_BtOK           = '&OK';
  Const_Contr_BTCancel       = '&Cancelar';
  Const_Contr_DescCol        = 'Descri��o';
  Const_Contr_BtSellAllHint  = 'Selecionar Todos';
  Const_Contr_BtSelHint      = 'Selecionar';
  Const_Contr_BtUnSelHint    = 'Desmarcar';
  Const_Contr_BtUnSelAllHint = 'Desmarcar Todos';
                                               //===================================================================

  // group property Settins.AppMsgsForm
  Const_Msgs_BtNew                            = '&Nova Mensagem';
  Const_Msgs_BtReplay                         = '&Responder';
  Const_Msgs_BtForward                        = 'E&ncaminhar';
  Const_Msgs_BtDelete                         = '&Excluir';
  Const_Msgs_BtClose                          = '&Fechar';
  Const_Msgs_WindowCaption                    = 'Mensagens do Sistema';
  Const_Msgs_ColFrom                          = 'Remetente';
  Const_Msgs_ColSubject                       = 'Assunto';
  Const_Msgs_ColDate                          = 'Data';
  Const_Msgs_PromptDelete                     = 'Confirma excluir as mensagens selecionadas ?';
  Const_Msgs_PromptDelete_WindowCaption       = 'Apagar mensagens';
  Const_Msgs_NoMessagesSelected               = 'N�o existem mensagens selecionadas';
  Const_Msgs_NoMessagesSelected_WindowCaption = 'Informa��o';


  // group property Settins.AppMsgsRec
  Const_MsgRec_BtClose       = '&Fechar';
  Const_MsgRec_WindowCaption = 'Mensagem';
  Const_MsgRec_Title         = 'Mensagem Recebida';
  Const_MsgRec_LabelFrom     = 'De :';
  Const_MsgRec_LabelDate     = 'Data';
  Const_MsgRec_LabelSubject  = 'Assunto';
  Const_MsgRec_LabelMessage  = 'Mensagem';

  // group property Settins.AppMsgsSend
  Const_MsgSend_BtSend           = '&Enviar';
  Const_MsgSend_BtCancel         = '&Cancelar';
  Const_MsgSend_WindowCaption    = 'Mensagem';
  Const_MsgSend_Title            = 'Enviar Nova Mensagem';
  Const_MsgSend_GroupTo          = 'Para';
  Const_MsgSend_RadioUser        = 'Usu�rio :';
  Const_MsgSend_RadioAll         = 'Todos';
  Const_MsgSend_GroupMessage     = 'Mensagem';
  Const_MsgSend_LabelSubject     = 'Assunto';
  Const_MsgSend_LabelMessageText = 'Texto da mensagem';


  // Run errors
  MsgExceptConnection    = 'N�o informado o Connection, Transaction ou Database do componente %s';
  MsgExceptTransaction   = 'N�o informado o Transaction do componente %s';
  MsgExceptDatabase      = 'N�o informado o Database do componente %s';
  MsgExceptPropriedade   = 'Favor informar a propriedade %s';
  MsgExceptUserMngMenu   = 'Informe na propriedade UsersForm.MenuItem ou UsersForm.Action o Item respons�vel pelo controle de usu�rios';
  MsgExceptUserProfile   = 'Informe na propriedade UsersProfile.MenuItem ou UsersProfile.Action o Item respons�vel pelo controle de Perfil de usu�rios';
  MsgExceptChagePassMenu = 'Informe na propriedade ChangePasswordForm.MenuItem or .Action o Item que permite ao usu�rio alterar sua senha';
  MsgExceptAppID         = 'Na propriedade ApplicationID informe um nome para identificar a aplica��o na tabela de permiss�es';
  MsgExceptUsersTable    = 'Na propriedade TableUsers informe o nome da tabela que ser� criada para armazenar os dados dos usu�rios';
  MsgExceptRightsTable   = 'Na propriedade TableRights informe o nome da tabela que ser� criada para armazenar as permiss�es dos usu�rios';
  MsgExceptConnector     = 'Propriedade DataConnector n�o definida!';

  // group property Settings.Mensagens
  Const_Men_AutoLogonError  = 'Falha de Auto Logon!' + #13 + #10 + 'Informe um usu�rio e senha v�lidos.';
  Const_Men_SenhaDesabitada = 'Retirada senha do Login %s';
  Const_Men_SenhaAlterada   = 'Senha alterada com sucesso!';
  Const_Men_MsgInicial      = 'ATEN��O Login Inicial:' + #13 + #10 + #13 + #10 + 'Usu�rio : :user' + #13 + #10 + 'Senha : :password' + #13 + #10 + #13 + #10 + 'Defina as permiss�es para este usu�rio.';
  Const_Men_MaxTentativas   = '%d Tentativas de login inv�lido. Por motivos de segun�a o ' + #13 + #10 + 'sistema ser� fechado.';
  Const_Men_LoginInvalido   = 'Usu�rio ou Senha inv�lidos!';
  Const_Men_UsuarioExiste   = 'O Usu�rio "%s" j� est� cadastrado no sistema !!'; // Luiz Benevenuto 20/04/06

  Const_Men_PasswordExpired = 'Aten��o, sua senha expirou, favor troca-la'; { By vicente barros leonel }


  //group property Settings.Login
  Const_Log_BtCancelar     = '&Cancelar';
  Const_Log_BtOK           = '&OK';
  Const_Log_LabelSenha     = 'Senha :';
  Const_Log_LabelUsuario   = 'Usu�rio :';
  Const_Log_WindowCaption  = 'Login';
  Const_Log_LbEsqueciSenha = 'Esqueci a senha';                       //new
  Const_Log_MsgMailSend    = 'A senha foi enviada para o seu email.'; //new
  Const_Log_LabelTentativa = 'Tentativa : ';
  Const_Log_LabelTentativas = 'M�ximo de Tentativas : ';

  //group property Settings.Log //new
  Const_LogC_WindowCaption                = 'Seguran�a';
  Const_LogC_LabelDescricao               = 'Log do Sistema';
  Const_LogC_LabelUsuario                 = 'Usu�rio :';
  Const_LogC_LabelData                    = 'Data :';
  Const_LogC_LabelNivel                   = 'N�vel m�nimo :';
  Const_LogC_ColunaAppID                  = 'AppID';
  Const_LogC_ColunaNivel                  = 'N�vel';
  Const_LogC_ColunaMensagem               = 'Mensagem';
  Const_LogC_ColunaUsuario                = 'Usu�rio';
  Const_LogC_ColunaData                   = 'Data';
  Const_LogC_BtFiltro                     = '&Aplicar Filtro';
  Const_LogC_BtExcluir                    = '&Excluir Log';
  Const_LogC_BtFechar                     = '&Fechar';
  Const_LogC_ConfirmaExcluir              = 'Confirma excluir todos os registros de log selecionados ?';
  Const_LogC_ConfirmaDelete_WindowCaption = 'Confirma exclus�o';   //added by fduenas
  Const_LogC_Todos                        = 'Todos';                   //BGM
  Const_LogC_Low                          = 'Baixo';                 //BGM
  Const_LogC_Normal                       = 'Normal';                //BGM
  Const_LogC_High                         = 'Alto';                  //BGM
  Const_LogC_Critic                       = 'Cr�tico';              //BGM
  Const_LogC_ExcluirEfectuada             = 'Exclus�o de log�s do sistema : Usu�rio = "%s" | Data = %s a %s | N�vel <= %s'; //added by fduenas


  //group property Settings.CadastroUsuarios
  Const_Cad_WindowCaption                = 'Seguran�a';
  Const_Cad_LabelDescricao               = 'Cadastro de Usu�rios';
  Const_Cad_ColunaNome                   = 'Nome';
  Const_Cad_ColunaLogin                  = 'Login';
  Const_Cad_ColunaEmail                  = 'Email';
  Const_Cad_BtAdicionar                  = '&Adicionar';
  Const_Cad_BtAlterar                    = 'A&lterar';
  Const_Cad_BtExcluir                    = '&Excluir';
  Const_Cad_BtPermissoes                 = 'A&cessos';
  Const_Cad_BtSenha                      = '&Senha';
  Const_Cad_BtFechar                     = '&Fechar';
  Const_Cad_ConfirmaExcluir              = 'Confirma excluir o usu�rio "%s" ?';
  Const_Cad_ConfirmaDelete_WindowCaption = 'Excluir usu�rio'; //added by fduenas

  //group property Settings.PerfilUsuarios
  Const_Prof_WindowCaption                = 'Seguran�a';
  Const_Prof_LabelDescricao               = 'Perfil de Usu�rios';
  Const_Prof_ColunaNome                   = 'Perfil';
  Const_Prof_BtAdicionar                  = '&Adicionar';
  Const_Prof_BtAlterar                    = 'A&lterar';
  Const_Prof_BtExcluir                    = '&Excluir';
  Const_Prof_BtPermissoes                 = 'A&cessos';
  Const_Prof_BtSenha                      = '&Senha';
  Const_Prof_BtFechar                     = '&Fechar';
  Const_Prof_ConfirmaExcluir              = 'Existem usu�rios com o perfil "%s". Confirma excluir?';
  Const_Prof_ConfirmaDelete_WindowCaption = 'Delete profile'; //added by fduenas

  //group property Settings.IncAltUsuario
  Const_Inc_WindowCaption     = 'Cadastro de Usu�rios';
  Const_Inc_LabelAdicionar    = 'Adicionar Usu�rio';
  Const_Inc_LabelAlterar      = 'Alterar Usu�rio';
  Const_Inc_LabelNome         = 'Nome :';
  Const_Inc_LabelLogin        = 'Login :';
  Const_Inc_LabelEmail        = 'Email :';
  Const_Inc_LabelPerfil       = 'Perfil :';
  Const_Inc_CheckPrivilegiado = 'Usu�rio privilegiado';
  Const_Inc_BtGravar          = '&Gravar';
  Const_Inc_BtCancelar        = 'Cancelar';
  Const_Inc_CheckEspira       = 'Senha do usu�rio n�o expira';
  Const_Inc_Dia               = 'Dias';
  Const_Inc_ExpiraEm          = 'Expira em';

  //group property Settings.IncAltPerfil
  Const_PInc_WindowCaption  = 'Perfil de Usu�rios';
  Const_PInc_LabelAdicionar = 'Adicionar Perfil';
  Const_PInc_LabelAlterar   = 'Alterar Perfil';
  Const_PInc_LabelNome      = 'Descri��o :';
  Const_PInc_BtGravar       = '&Gravar';
  Const_PInc_BtCancelar     = 'Cancelar';

  //group property Settings.Permissao
  Const_Perm_WindowCaption = 'Seguran�a';
  Const_Perm_LabelUsuario  = 'Permiss�es do Usu�rio :';
  Const_Perm_LabelPerfil   = 'Permiss�es do Perfil :';
  Const_Perm_PageMenu      = 'Itens do Menu';
  Const_Perm_PageActions   = 'A��es';
  Const_Perm_PageControls  = 'Controles'; // by vicente barros leonel  
  Const_Perm_BtLibera      = '&Liberar';
  Const_Perm_BtBloqueia    = '&Bloquear';
  Const_Perm_BtGravar      = '&Gravar';
  Const_Perm_BtCancelar    = '&Cancelar';

  //group property Settings.TrocaSenha do begin
  Const_Troc_WindowCaption   = 'Seguran�a';
  Const_Troc_LabelDescricao  = 'Trocar Senha';
  Const_Troc_LabelSenhaAtual = 'Senha Atual :';
  Const_Troc_LabelNovaSenha  = 'Nova Senha :';
  Const_Troc_LabelConfirma   = 'Confirma��o :';
  Const_Troc_BtGravar        = '&Gravar';
  Const_Troc_BtCancelar      = 'Cancelar';

  //group property Settings.Mensagens.ErroTrocaSenha
  Const_ErrPass_SenhaAtualInvalida = 'Senha Atual n�o confere!';
  Const_ErrPass_ErroNovaSenha      = 'Os campos: Nova Senha e Confirma��o devem ser iguais.';
  Const_ErrPass_NovaIgualAtual     = 'Nova senha igual a senha atual';
  Const_ErrPass_SenhaObrigatoria   = 'A Senha � obrigat�ria';
  Const_ErrPass_SenhaMinima        = 'A senha deve conter no m�nimo %d caracteres';
  Const_ErrPass_SenhaInvalida      = 'Proibido utilizar senhas obvias!';
  Const_ErrPass_ForcaTrocaSenha    = 'Mudan�a de senha obrigat�ria';

  //group property Settings.DefineSenha
  Const_DefPass_WindowCaption = 'Definir senha do usu�rio : "%s"';
  Const_DefPass_LabelSenha    = 'Senha :';

  //Group das tabelas do UC
  Const_TableUsers_FieldUserID      = 'UCIdUser';
  Const_TableUsers_FieldUserName    = 'UCUserName';
  Const_TableUsers_FieldLogin       = 'UCLogin';
  Const_TableUsers_FieldPassword    = 'UCPassword';
  Const_TableUsers_FieldEmail       = 'UCEmail';
  Const_TableUsers_FieldPrivileged  = 'UCPrivileged';
  Const_TableUsers_FieldTypeRec     = 'UCTypeRec';
  Const_TableUsers_FieldProfile     = 'UCProfile';
  Const_TableUsers_FieldKey         = 'UCKey';
  Const_TableUsers_TableName        = 'UCTabUsers';
  Const_TableUsers_FieldDateExpired = 'UCPASSEXPIRED'; { By Vicente Barros Leonel }
  Const_TableUser_FieldUserExpired  = 'UCUserExpired'; { By Vicente Barros Leonel }
  Const_TableUser_FieldUserDaysSun  = 'UCUserDaysSun'; { By Vicente Barros Leonel }

  Const_TableRights_FieldUserID        = 'UCIdUser';
  Const_TableRights_FieldModule        = 'UCModule';
  Const_TableRights_FieldComponentName = 'UCCompName';
  Const_TableRights_FieldFormName      = 'UCFormName';
  Const_TableRights_FieldKey           = 'UCKey';
  Const_TableRights_TableName          = 'UCTabRights';

  Const_TableUsersLogged_FieldLogonID       = 'UCIdLogon';
  Const_TableUsersLogged_FieldUserID        = 'UCIdUser';
  Const_TableUsersLogged_FieldApplicationID = 'UCApplicationId';
  Const_TableUsersLogged_FieldMachineName   = 'UCMachineName';
  Const_TableUsersLogged_FieldData          = 'UCData';
  Const_TableUsersLogged_TableName          = 'UCTabUsersLogged';


implementation

end.

