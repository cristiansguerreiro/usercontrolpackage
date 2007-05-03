{

  Unit criada por Vicente Barros Leonel
  Ultima Revisão - 30/04/2007 Por Vicente Barros Leonel
  
}

unit UCConsts;

interface

const
  // new consts version 2 a 5 =========================================
  // Form Select Controls (design-time)
  Const_Contr_TitleLabel     = 'Team of Components of the Form. :';
  Const_Contr_GroupLabel     = 'Group:';
  Const_Contr_CompDispLabel  = 'Available components:';
  Const_Contr_CompSelLabel   = 'Selected components:';
  Const_Contr_BtOK           = '&OK';
  Const_Contr_BTCancel       = '&Cancel';
  Const_Contr_DescCol        = 'Description';
  Const_Contr_BtSellAllHint  = 'Select All';
  Const_Contr_BtSelHint      = 'Select';
  Const_Contr_BtUnSelHint    = 'Unselect';
  Const_Contr_BtUnSelAllHint = 'Unselect All';
                                               //===================================================================

  // group property Settins.AppMsgsForm
  Const_Msgs_BtNew                            = '&New Message';
  Const_Msgs_BtReplay                         = '&Replay';
  Const_Msgs_BtForward                        = 'F&orward';
  Const_Msgs_BtDelete                         = '&Delete';
  Const_Msgs_BtClose                          = '&Close';
  Const_Msgs_WindowCaption                    = 'Messages of the System';
  Const_Msgs_ColFrom                          = 'From';
  Const_Msgs_ColSubject                       = 'Subject';
  Const_Msgs_ColDate                          = 'Date';
  Const_Msgs_PromptDelete                     = 'It confirms exclusion of the selected messages?';
  Const_Msgs_PromptDelete_WindowCaption       = 'Delete messages';
  Const_Msgs_NoMessagesSelected               = 'No Messages selected';
  Const_Msgs_NoMessagesSelected_WindowCaption = 'Information';


  // group property Settins.AppMsgsRec
  Const_MsgRec_BtClose       = '&Close';
  Const_MsgRec_WindowCaption = 'Message';
  Const_MsgRec_Title         = 'Received message';
  Const_MsgRec_LabelFrom     = 'From:';
  Const_MsgRec_LabelDate     = 'Date';
  Const_MsgRec_LabelSubject  = 'Subject';
  Const_MsgRec_LabelMessage  = 'Message';

  // group property Settins.AppMsgsSend
  Const_MsgSend_BtSend           = '&Send';
  Const_MsgSend_BtCancel         = '&Cancel';
  Const_MsgSend_WindowCaption    = 'Message';
  Const_MsgSend_Title            = 'Send New Message';
  Const_MsgSend_GroupTo          = 'To';
  Const_MsgSend_RadioUser        = 'User:';
  Const_MsgSend_RadioAll         = 'All';
  Const_MsgSend_GroupMessage     = 'Message';
  Const_MsgSend_LabelSubject     = 'Subject';
  Const_MsgSend_LabelMessageText = 'Message text';


  // Run errors
  MsgExceptConnection    = 'Done not informed the Connection, Transaction or Database component %s';
  MsgExceptTransaction   = 'Done not informed the Transaction component %s';
  MsgExceptDatabase      = 'Done not informed the Database do component %s';
  MsgExceptUserMngMenu   = 'Inform in the property UsersForm.MenuItem or UsersForm.Action the item responsible for the users control';
  MsgExceptUserProfile   = 'Inform in the property UsersProfile.MenuItem or UsersProfile.Action the Item  responsible for the control of users Profile ';
  MsgExceptChagePassMenu = 'Inform in the property ChangePasswordForm.MenuItem or .Action the Item that allows to a user to alter his password';
  MsgExceptAppID         = 'In the property "ApplicationID" inform a name to identify the application in the chart of permissions';
  MsgExceptUsersTable    = 'In the property "TableUsers" inform the name of the chart that will be created to store the data of the users ';
  MsgExceptRightsTable   = 'In the property "TableRights" inform the name of the chart that will be created to store the permissions of the users ';
  MsgExceptConnector     = 'The property DataConnector not defined!';

  // group property Settings.Mensagens
  Const_Men_AutoLogonError  = 'Fault of Car Logon !' + #13 + #10 + 'Inform a valid user and password.';
  Const_Men_SenhaDesabitada = 'Retired password of the Login %s';
  Const_Men_SenhaAlterada   = 'Password altered with success!';
  Const_Men_MsgInicial      = 'ATTENTION, Inicial Login :' + #13 + #10 + #13 + #10 + 'User: :user' + #13 + #10 + 'Password : :password' + #13 + #10 + #13 + #10 + 'Define the permissions for this user.';
  Const_Men_MaxTentativas   = '%d Attempts of login invalid. By reasons of segunça the system will be closed.';
  Const_Men_LoginInvalido   = 'User invalids or password !';
  Const_Men_UsuarioExiste   = 'The User "%s" is already set up in the system !!';
  Const_Men_PasswordExpired = 'Attention, his sign died, favor exchanges it ';


  //group property Settings.Login
  Const_Log_BtCancelar      = '&Cancel';
  Const_Log_BtOK            = '&OK';
  Const_Log_LabelSenha      = 'Password :';
  Const_Log_LabelUsuario    = 'User :';
  Const_Log_WindowCaption   = 'Login';
  Const_Log_LbEsqueciSenha  = 'I forgot the password';
  Const_Log_MsgMailSend     = 'The password was sent for his email .';
  Const_Log_LabelTentativa  = 'Attempt : ';
  Const_Log_LabelTentativas = 'Max of Attempts: ';

  //group property Settings.Log //new
  Const_LogC_WindowCaption                = 'Security';
  Const_LogC_LabelDescricao               = 'Log of system';
  Const_LogC_LabelUsuario                 = 'User :';
  Const_LogC_LabelData                    = 'Date :';
  Const_LogC_LabelNivel                   = 'Least level:';
  Const_LogC_ColunaAppID                  = 'AppID';
  Const_LogC_ColunaNivel                  = 'Level ';
  Const_LogC_ColunaMensagem               = 'Message';
  Const_LogC_ColunaUsuario                = 'User';
  Const_LogC_ColunaData                   = 'Date';
  Const_LogC_BtFiltro                     = '&Apply Filter';
  Const_LogC_BtExcluir                    = '&Erase Log';
  Const_LogC_BtFechar                     = '&Close';
  Const_LogC_ConfirmaExcluir              = 'It confirms to exclude all the registers of log selected ?';
  Const_LogC_ConfirmaDelete_WindowCaption = 'Delete confirmation';
  Const_LogC_Todos                        = 'All';
  Const_LogC_Low                          = 'Low';
  Const_LogC_Normal                       = 'Normal';
  Const_LogC_High                         = 'High';
  Const_LogC_Critic                       = 'Critic';
  Const_LogC_ExcluirEfectuada             = 'Deletion of system log done: User = "%s" | Date = %s a %s | Level <= %s';

  //group property Settings.CadastroUsuarios
  Const_Cad_WindowCaption                = 'Security';
  Const_Cad_LabelDescricao               = 'Users register ';
  Const_Cad_ColunaNome                   = 'Name';
  Const_Cad_ColunaLogin                  = 'Login';
  Const_Cad_ColunaEmail                  = 'Email';
  Const_Cad_BtAdicionar                  = '&Add';
  Const_Cad_BtAlterar                    = 'A&lter';
  Const_Cad_BtExcluir                    = '&Erase';
  Const_Cad_BtPermissoes                 = 'A&ccesses';
  Const_Cad_BtSenha                      = '&Password';
  Const_Cad_BtFechar                     = '&Close';
  Const_Cad_ConfirmaExcluir              = 'Confirm erase the user "%s" ?';
  Const_Cad_ConfirmaDelete_WindowCaption = 'Delete user'; //added by fduenas

  //group property Settings.PerfilUsuarios
  Const_Prof_WindowCaption                = 'Security';
  Const_Prof_LabelDescricao               = 'Users profile ';
  Const_Prof_ColunaNome                   = 'Profile';
  Const_Prof_BtAdicionar                  = '&Add';
  Const_Prof_BtAlterar                    = 'A&lter';
  Const_Prof_BtExcluir                    = '&Delete';
  Const_Prof_BtPermissoes                 = 'A&ccesses';
  Const_Prof_BtSenha                      = '&Password';
  Const_Prof_BtFechar                     = '&Close';
  Const_Prof_ConfirmaExcluir              = 'There are users with the profile  "%s". Confirm erase ?';
  Const_Prof_ConfirmaDelete_WindowCaption = 'Delete profile'; //added by fduenas

  //group property Settings.IncAltUsuario
  Const_Inc_WindowCaption     = 'Users register ';
  Const_Inc_LabelAdicionar    = 'Add User';
  Const_Inc_LabelAlterar      = 'Change User';
  Const_Inc_LabelNome         = 'Name :';
  Const_Inc_LabelLogin        = 'Login :';
  Const_Inc_LabelEmail        = 'Email :';
  Const_Inc_LabelPerfil       = 'Profile :';
  Const_Inc_CheckPrivilegiado = 'Privileged user ';
  Const_Inc_BtGravar          = '&Save';
  Const_Inc_BtCancelar        = 'Cancel';

  //group property Settings.IncAltPerfil
  Const_PInc_WindowCaption  = 'Profile the Users';
  Const_PInc_LabelAdicionar = 'Add Profile';
  Const_PInc_LabelAlterar   = 'Change Profile ';
  Const_PInc_LabelNome      = 'Description :';
  Const_PInc_BtGravar       = '&Save';
  Const_PInc_BtCancelar     = 'Cancel';

  //group property Settings.Permissao
  Const_Perm_WindowCaption = 'Security';
  Const_Perm_LabelUsuario  = 'Permissions of the User :';
  Const_Perm_LabelPerfil   = 'Permissions of the Profile  :';
  Const_Perm_PageMenu      = 'Items of the Menu';
  Const_Perm_PageActions   = 'Actions';
  Const_Perm_PageControls  = 'Controls'; // by vicente barros leonel
  Const_Perm_BtLibera      = '&Release';
  Const_Perm_BtBloqueia    = '&Block';
  Const_Perm_BtGravar      = '&Save';
  Const_Perm_BtCancelar    = '&Cancel';

  //group property Settings.TrocaSenha do begin
  Const_Troc_WindowCaption   = 'Security';
  Const_Troc_LabelDescricao  = 'Change Password';
  Const_Troc_LabelSenhaAtual = 'Password :';
  Const_Troc_LabelNovaSenha  = 'New Password :';
  Const_Troc_LabelConfirma   = 'Confirmation :';
  Const_Troc_BtGravar        = '&Save';
  Const_Troc_BtCancelar      = 'Cancel';

  //group property Settings.Mensagens.ErroTrocaSenha
  Const_ErrPass_SenhaAtualInvalida = 'Current password does not tally!';
  Const_ErrPass_ErroNovaSenha      = 'The Field: New Password and Confirmation must be the same.';
  Const_ErrPass_NovaIgualAtual     = 'New equal password to current password ';
  Const_ErrPass_SenhaObrigatoria   = 'The password is compulsory ';
  Const_ErrPass_SenhaMinima        = 'The password must contain at least %d characters ';
  Const_ErrPass_SenhaInvalida      = 'When to use password was prohibited you obviate !';

  //group property Settings.DefineSenha
  Const_DefPass_WindowCaption = 'Define Password of the user  : "%s"';
  Const_DefPass_LabelSenha    = 'Password :';

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
  Const_TableUsers_FieldDateExpired = 'UCPassExpired';
  Const_TableUser_FieldUserExpired  = 'UCUserExpired';
  Const_TableUser_FieldUserDaysSun  = 'UCUserDaysSun';  
  
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

