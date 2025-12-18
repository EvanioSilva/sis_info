import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sis_flutter/controller/detalhes_pessoa_controller.dart';
import 'package:sis_flutter/model/pessoa_model.dart';
import 'package:sis_flutter/model/vw_familia_responsavel_nova_renda_model.dart';
import 'package:sis_flutter/model/vw_familia_pessoa_nova_renda_model.dart';
import 'package:sis_flutter/utils/utils.dart';
import 'package:sis_flutter/values/colors.dart';
import 'package:sis_flutter/utils/windows_responsive.dart';

class DetalhesPessoaPage extends StatelessWidget {
  final Pessoa pessoa;

  const DetalhesPessoaPage({
    super.key,
    required this.pessoa,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(DetalhesPessoaController(pessoa));

    return GetBuilder<DetalhesPessoaController>(
      builder: (controller) {
        final isDesktop = WindowsResponsive.isDesktopLayout(context);
        final padding = WindowsResponsive.getResponsivePadding(context);
        final spacing = WindowsResponsive.getResponsiveSpacing(context);
        
        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            title: Text(
              'Detalhes da Pessoa',
              style: TextStyle(
                fontSize: WindowsResponsive.getResponsiveFontSize(context, 20),
              ),
            ),
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            elevation: 0,
            toolbarHeight: isDesktop ? 70 : null,
          ),
          body: WindowsResponsive.centerContent(
            context: context,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(padding.horizontal * 0.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                _buildHeaderCard(context),
                SizedBox(height: spacing),
                _buildInfoSection(context, 'Informações Pessoais', Icons.person, [
                  _buildInfoRow(context, 'Nome', pessoa.nomPessoa ?? 'Não informado'),
                  _buildInfoRow(
                    context,
                    'Data de Nascimento',
                    pessoa.dtaNascPessoa != null
                        ? DateFormat('dd/MM/yyyy').format(pessoa.dtaNascPessoa!)
                        : 'Não informado',
                  ),
                  _buildInfoRow(
                      context, 'Mãe', pessoa.nomCompletoMaePessoa ?? 'Não informado'),
                ]),
                SizedBox(height: spacing),
                _buildInfoSection(context, 'Documentos', Icons.badge, [
                  _buildInfoRow(
                      context, 'CPF', Utils.ofuscarDocumento(pessoa.numCpfPessoa)),
                  _buildInfoRow(
                      context, 'NIS', Utils.ofuscarDocumento(pessoa.numNisPessoaAtual)),
                ]),
                SizedBox(height: spacing),
                _buildInfoSection(context, 'Família', Icons.family_restroom, [
                  _buildInfoRow(context, 'Ordem',
                      pessoa.numOrdemPessoa?.toString() ?? 'Não informado'),
                  _buildInfoRow(context, 'Código Familiar',
                      pessoa.codFamiliarFam ?? 'Não informado'),
                  _buildInfoRow(context, 'Tipo Responsável',
                      pessoa.tipoResponsavel ?? 'Não informado'),
                  _buildInfoRow(context, 'ID Família',
                      pessoa.idfamilia?.toString() ?? 'Não informado'),
                  _buildInfoRow(context, 'ID Pessoa',
                      pessoa.idpessoa?.toString() ?? 'Não informado'),
                ]),
                if (pessoa.temCadunico != null) ...[
                  SizedBox(height: spacing),
                  _buildInfoSection(context, 'Cadastro Único', Icons.assignment, [
                    _buildInfoRow(
                      context,
                      'Tem CadÚnico',
                      pessoa.temCadunico == 'S' ? 'Sim' : 'Não',
                    ),
                  ]),
                ],
                SizedBox(height: spacing),
                _buildFamiliaResponsavelSection(controller),
                SizedBox(height: spacing),
                _buildFamiliaPessoaSection(controller),
                SizedBox(height: spacing),
                _buildPessoaProgramaSection(controller),
                SizedBox(height: spacing),
                _buildNovaRendaMesSection(controller),
                SizedBox(height: spacing),
                _buildHistoricoSection(controller),
              ],
            ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeaderCard(BuildContext context) {
    final isDesktop = WindowsResponsive.isDesktopLayout(context);
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: EdgeInsets.all(isDesktop ? 32 : 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryColor.withOpacity(0.9),
            primaryColor.withOpacity(0.7)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(isDesktop ? 28 : 24),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.3),
            blurRadius: isDesktop ? 25 : 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: isDesktop ? 100 : 80,
            height: isDesktop ? 100 : 80,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: isDesktop ? 3 : 2,
              ),
            ),
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: isDesktop ? 50 : 40,
            ),
          ),
          SizedBox(width: isDesktop ? 24 : 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pessoa.nomPessoa ?? 'Nome não informado',
                  style: TextStyle(
                    fontSize: WindowsResponsive.getResponsiveFontSize(context, 24),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: isDesktop ? 6 : 4),
                if (pessoa.tipoResponsavel != null) ...[
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isDesktop ? 16 : 12,
                      vertical: isDesktop ? 8 : 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(isDesktop ? 24 : 20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      pessoa.tipoResponsavel!,
                      style: TextStyle(
                        fontSize: WindowsResponsive.getResponsiveFontSize(context, 12),
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, String title, IconData icon, List<Widget> children) {
    final isDesktop = WindowsResponsive.isDesktopLayout(context);
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isDesktop ? 24 : 20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: isDesktop ? 20 : 15,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.grey[100]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 28 : 20,
              vertical: isDesktop ? 20 : 16,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primaryColor.withOpacity(0.1),
                  primaryColor.withOpacity(0.05)
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(isDesktop ? 24 : 20),
                topRight: Radius.circular(isDesktop ? 24 : 20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(isDesktop ? 10 : 8),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(isDesktop ? 12 : 10),
                  ),
                  child: Icon(
                    icon,
                    color: primaryColor,
                    size: isDesktop ? 22 : 18,
                  ),
                ),
                SizedBox(width: isDesktop ? 16 : 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: WindowsResponsive.getResponsiveFontSize(context, 16),
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey[400],
                  size: isDesktop ? 24 : 20,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(isDesktop ? 28 : 20),
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    final isDesktop = WindowsResponsive.isDesktopLayout(context);
    
    return Container(
      margin: EdgeInsets.only(bottom: isDesktop ? 12 : 8),
      padding: EdgeInsets.symmetric(
        vertical: isDesktop ? 16 : 12,
        horizontal: isDesktop ? 20 : 16,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(isDesktop ? 16 : 12),
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: WindowsResponsive.getResponsiveFontSize(context, 13),
                color: Colors.grey[700],
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Container(
            width: 1,
            height: isDesktop ? 24 : 20,
            color: Colors.grey[300],
            margin: EdgeInsets.symmetric(horizontal: isDesktop ? 16 : 12),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: WindowsResponsive.getResponsiveFontSize(context, 14),
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                height: 1.3,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFamiliaResponsavelSection(DetalhesPessoaController controller) {
    return GetBuilder<DetalhesPessoaController>(
      id: 'familia_responsavel',
      builder: (ctrl) {
        if (ctrl.isWaitingFamiliaResponsavel) {
          return _buildLoadingSection(
              'Dados da Família Responsável', Icons.supervisor_account);
        }

        if (ctrl.familiaResponsavelDados.isEmpty) {
          return _buildEmptySection('Dados da Família Responsável',
              'Nenhum dado encontrado', Icons.supervisor_account);
        }

        return _buildFamiliaResponsavelDataSection(
            Get.context!, ctrl.familiaResponsavelDados.first, controller);
      },
    );
  }

  Widget _buildFamiliaResponsavelDataSection(
      BuildContext context,
      VwFamiliaResponsavelNovaRendaModel data,
      DetalhesPessoaController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.grey[100]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primaryColor.withOpacity(0.1),
                  primaryColor.withOpacity(0.05)
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.supervisor_account,
                      color: Colors.blue, size: 18),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Dados da Família Responsável',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Primeira linha: Documentos
                Row(
                  children: [
                    Expanded(
                      child: _buildModernInfoCard(
                        context,
                        'Código Familiar',
                        data.codFamiliarFam ?? 'Não informado',
                        Icons.family_restroom,
                        Colors.purple,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildModernInfoCard(
                        context,
                        'Estado Cadastral',
                        data.estadoCadastral ?? 'Não informado',
                        Icons.verified_user,
                        Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Segunda linha: Documentos pessoais
                Row(
                  children: [
                    Expanded(
                      child: _buildModernInfoCard(
                        context,
                        'CPF',
                        Utils.ofuscarDocumento(data.numCpfPessoa),
                        Icons.credit_card,
                        Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildModernInfoCard(
                        context,
                        'NIS',
                        Utils.ofuscarDocumento(data.numNisPessoaAtual),
                        Icons.badge,
                        Colors.teal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Terceira linha: Rendas
                Row(
                  children: [
                    Expanded(
                      child: _buildModernInfoCard(
                        context,
                        'RPC Calculada',
                        controller.formatarValor(data.vlrrenda),
                        Icons.trending_up,
                        Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildModernInfoCard(
                        context,
                        'RPC Original',
                        controller.formatarValor(data.vlRendaPercaptaOriginal),
                        Icons.account_balance_wallet,
                        Colors.indigo,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Quarta linha: Status e programas
                Row(
                  children: [
                    Expanded(
                      child: _buildModernInfoCard(
                        context,
                        'Jovem Aprendiz',
                        (data.temMenorAprendiz == 'S') ? 'Sim' : 'Não',
                        Icons.school,
                        Colors.amber,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildModernInfoCard(
                        context,
                        'Data Entrevista',
                        controller.formatarValor(data.dtaEntrevistaFam),
                        Icons.calendar_today,
                        Colors.cyan,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Quinta linha: Datas importantes
                _buildModernInfoCard(
                  context,
                  'Última Atualização',
                  controller.formatarValor(data.dtUltAtualizacao),
                  Icons.update,
                  Colors.grey,
                  isFullWidth: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFamiliaPessoaDataSection(
      BuildContext context,
      VwFamiliaPessoaNovaRendaModel data, DetalhesPessoaController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.grey[100]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primaryColor.withOpacity(0.1),
                  primaryColor.withOpacity(0.05)
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:
                      const Icon(Icons.people, color: Colors.green, size: 18),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Dados da Família Pessoa',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Primeira linha: Ordem e Estado Cadastral
                Row(
                  children: [
                    Expanded(
                      child: _buildModernInfoCard(
                        context,
                        'Ordem',
                        data.numOrdemPessoa?.toString() ?? 'Não informado',
                        Icons.format_list_numbered,
                        Colors.purple,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildModernInfoCard(
                        context,
                        'Estado Cadastral',
                        data.estadoCadastral ?? 'Não informado',
                        Icons.verified_user,
                        Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Segunda linha: Documentos pessoais
                Row(
                  children: [
                    Expanded(
                      child: _buildModernInfoCard(
                        context,
                        'CPF',
                        Utils.ofuscarDocumento(data.numCpfPessoa),
                        Icons.credit_card,
                        Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildModernInfoCard(
                        context,
                        'NIS',
                        Utils.ofuscarDocumento(data.numNisPessoaAtual),
                        Icons.badge,
                        Colors.teal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Terceira linha: Rendas
                Row(
                  children: [
                    Expanded(
                      child: _buildModernInfoCard(
                        context,
                        'RPC Calculada',
                        controller.formatarValor(data.vlrrenda),
                        Icons.trending_up,
                        Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildModernInfoCard(
                        context,
                        'RPC Original',
                        controller.formatarValor(data.vlRendaPercaptaOriginal),
                        Icons.account_balance_wallet,
                        Colors.indigo,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Quarta linha: Status e programas
                Row(
                  children: [
                    Expanded(
                      child: _buildModernInfoCard(
                        context,
                        'Status Cadastro',
                        data.edtStatusCadastro ?? 'Não informado',
                        Icons.assignment_turned_in,
                        Colors.amber,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildModernInfoCard(
                        context,
                        'Jovem Aprendiz',
                        (data.temMenorAprendiz == 'S') ? 'Sim' : 'Não',
                        Icons.school,
                        Colors.pink,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Quinta linha: Datas importantes
                Row(
                  children: [
                    Expanded(
                      child: _buildModernInfoCard(
                        context,
                        'Data Entrevista',
                        controller.formatarValor(data.dtaEntrevistaFam),
                        Icons.calendar_today,
                        Colors.cyan,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildModernInfoCard(
                        context,
                        'Última Atualização',
                        controller.formatarValor(data.dtUltAtualizacao),
                        Icons.update,
                        Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernInfoCard(
      BuildContext context, String label, String value, IconData icon, Color color,
      {bool isFullWidth = false}) {
    final isDesktop = WindowsResponsive.isDesktopLayout(context);
    
    return Container(
      width: isFullWidth ? double.infinity : null,
      padding: EdgeInsets.all(isDesktop ? 20 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isDesktop ? 20 : 16),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: isDesktop ? 12 : 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(isDesktop ? 8 : 6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(isDesktop ? 10 : 8),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: isDesktop ? 20 : 16,
                ),
              ),
              SizedBox(width: isDesktop ? 12 : 8),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: WindowsResponsive.getResponsiveFontSize(context, 12),
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isDesktop ? 12 : 8),
          Text(
            value,
            style: TextStyle(
              fontSize: WindowsResponsive.getResponsiveFontSize(context, 14),
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildFamiliaPessoaSection(DetalhesPessoaController controller) {
    return GetBuilder<DetalhesPessoaController>(
      id: 'familia_pessoa',
      builder: (ctrl) {
        if (ctrl.isWaitingFamiliaPessoa) {
          return _buildLoadingSection('Dados da Família Pessoa', Icons.people);
        }

        if (ctrl.familiaPessoaDados.isEmpty) {
          return _buildEmptySection('Dados da Família Pessoa',
              'Nenhum dado encontrado', Icons.people);
        }

        return _buildFamiliaPessoaDataSection(
            Get.context!, ctrl.familiaPessoaDados.first, controller);
      },
    );
  }

  Widget _buildPessoaProgramaSection(DetalhesPessoaController controller) {
    return GetBuilder<DetalhesPessoaController>(
      id: 'pessoa_programa',
      builder: (ctrl) {
        if (ctrl.isWaitingPessoaPrograma) {
          return _buildLoadingSection(
              'Programas Sociais', Icons.business_center);
        }

        if (ctrl.pessoaProgramaDados.isEmpty) {
          return _buildEmptySection('Programas Sociais',
              'Nenhum programa encontrado', Icons.business_center);
        }

        return _buildInfoSection(Get.context!, 'Programas Sociais', Icons.business_center, [
          _buildInfoRow(
              Get.context!, 'Total de Programas', ctrl.pessoaProgramaDados.length.toString()),
          _buildInfoRow(
              Get.context!,
              'ID Família',
              ctrl.pessoaProgramaDados.first.idfamilia?.toString() ??
                  'Não informado'),
        ]);
      },
    );
  }

  Widget _buildNovaRendaMesSection(DetalhesPessoaController controller) {
    return GetBuilder<DetalhesPessoaController>(
      id: 'nova_renda_mes',
      builder: (ctrl) {
        if (ctrl.isWaitingNovaRendaMes) {
          return _buildLoadingSection('Renda Mensal', Icons.attach_money);
        }

        if (ctrl.novaRendaMesDados.isEmpty) {
          return _buildEmptySection('Renda Mensal',
              'Nenhum dado de renda encontrado', Icons.attach_money);
        }

        return _buildInfoSection(Get.context!, 'Renda Mensal', Icons.attach_money, [
          _buildInfoRow(
              Get.context!, 'Registros de Renda', ctrl.novaRendaMesDados.length.toString()),
          _buildInfoRow(
              Get.context!,
              'ID Família',
              ctrl.novaRendaMesDados.first.idfamilia?.toString() ??
                  'Não informado'),
        ]);
      },
    );
  }

  Widget _buildHistoricoSection(DetalhesPessoaController controller) {
    return GetBuilder<DetalhesPessoaController>(
      id: 'historico',
      builder: (ctrl) {
        if (ctrl.isWaitingHistorico) {
          return _buildLoadingSection('Histórico', Icons.history);
        }

        if (ctrl.historicoDados.isEmpty) {
          return _buildEmptySection(
              'Histórico', 'Nenhum histórico encontrado', Icons.history);
        }

        return _buildInfoSection(Get.context!, 'Histórico', Icons.history, [
          _buildInfoRow(
              Get.context!, 'Total de Registros', ctrl.historicoDados.length.toString()),
          _buildInfoRow(
              Get.context!,
              'ID Família',
              ctrl.historicoDados.first.idfamilia?.toString() ??
                  'Não informado'),
        ]);
      },
    );
  }

  Widget _buildLoadingSection(String title, [IconData? icon]) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon, color: primaryColor, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptySection(String title, String message, [IconData? icon]) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon, color: primaryColor, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
