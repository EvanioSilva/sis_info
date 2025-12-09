import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sis_flutter/controller/detalhes_pessoa_controller.dart';
import 'package:sis_flutter/model/pessoa_model.dart';
import 'package:sis_flutter/utils/utils.dart';
import 'package:sis_flutter/values/colors.dart';

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
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Detalhes da Pessoa'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeaderCard(),
            const SizedBox(height: 20),
            _buildInfoSection('Informações Pessoais', [
              _buildInfoRow('Nome', pessoa.nomPessoa ?? 'Não informado'),
              _buildInfoRow(
                'Data de Nascimento',
                pessoa.dtaNascPessoa != null
                    ? DateFormat('dd/MM/yyyy').format(pessoa.dtaNascPessoa!)
                    : 'Não informado',
              ),
              _buildInfoRow(
                  'Mãe', pessoa.nomCompletoMaePessoa ?? 'Não informado'),
            ]),
            const SizedBox(height: 20),
            _buildInfoSection('Documentos', [
              _buildInfoRow('CPF', Utils.ofuscarDocumento(pessoa.numCpfPessoa)),
              _buildInfoRow('NIS', Utils.ofuscarDocumento(pessoa.numNisPessoaAtual)),
            ]),
            const SizedBox(height: 20),
            _buildInfoSection('Família', [
              _buildInfoRow('Ordem',
                  pessoa.numOrdemPessoa?.toString() ?? 'Não informado'),
              _buildInfoRow(
                  'Código Familiar', pessoa.codFamiliarFam ?? 'Não informado'),
              _buildInfoRow('Tipo Responsável',
                  pessoa.tipoResponsavel ?? 'Não informado'),
              _buildInfoRow('ID Família',
                  pessoa.idfamilia?.toString() ?? 'Não informado'),
              _buildInfoRow(
                  'ID Pessoa', pessoa.idpessoa?.toString() ?? 'Não informado'),
            ]),
            if (pessoa.temCadunico != null) ...[
              const SizedBox(height: 20),
              _buildInfoSection('Cadastro Único', [
                _buildInfoRow(
                  'Tem CadÚnico',
                  pessoa.temCadunico == 'S' ? 'Sim' : 'Não',
                ),
              ]),
            ],
            const SizedBox(height: 20),
            _buildFamiliaResponsavelSection(controller),
            const SizedBox(height: 20),
            _buildFamiliaPessoaSection(controller),
            const SizedBox(height: 20),
            _buildPessoaProgramaSection(controller),
            const SizedBox(height: 20),
            _buildNovaRendaMesSection(controller),
            const SizedBox(height: 20),
            _buildHistoricoSection(controller),
          ],
        ),
      ),
    );
      },
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(24),
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
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person,
              color: primaryColor,
              size: 40,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pessoa.nomPessoa ?? 'Nome não informado',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (pessoa.tipoResponsavel != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      pessoa.tipoResponsavel!,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
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

  Widget _buildInfoSection(String title, List<Widget> children) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: primaryColor, size: 20),
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
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
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
          return _buildLoadingSection('Dados da Família Responsável');
        }

        if (ctrl.familiaResponsavelDados.isEmpty) {
          return _buildEmptySection('Dados da Família Responsável', 'Nenhum dado encontrado');
        }

        return _buildDataSection(
          'Dados da Família Responsável',
          ctrl.familiaResponsavelDados.first,
          {
            'EntidadeVwFamiliaResponsavelNovaRenda.cod_familiar_fam': 'codFamiliarFam',
            'EntidadeVwFamiliaResponsavelNovaRenda.num_nis_pessoa_atual': 'numNisPessoaAtual',
            'EntidadeVwFamiliaResponsavelNovaRenda.num_cpf_pessoa': 'numCpfPessoa',
            'EntidadeVwFamiliaResponsavelNovaRenda.vlrrenda': 'vlrrenda',
            'EntidadeVwFamiliaResponsavelNovaRenda.vl_renda_percapta_original': 'vlRendaPercaptaOriginal',
            'EntidadeVwFamiliaResponsavelNovaRenda.estado_cadastral': 'estadoCadastral',
            'EntidadeVwFamiliaResponsavelNovaRenda.dta_entrevista_fam': 'dtaEntrevistaFam',
            'EntidadeVwFamiliaResponsavelNovaRenda.dt_ult_atualizacao': 'dtUltAtualizacao',
            'EntidadeVwFamiliaResponsavelNovaRenda.dt_cdstr_atual_fmla': 'dtCdstrAtualFmla',
            'EntidadeVwFamiliaResponsavelNovaRenda.tem_menor_aprendiz': 'temMenorAprendiz',
            'EntidadeVwFamiliaResponsavelNovaRenda.dt_gradativo': 'dtGradativo',
          },
          controller,
        );
      },
    );
  }

  Widget _buildFamiliaPessoaSection(DetalhesPessoaController controller) {
    return GetBuilder<DetalhesPessoaController>(
      id: 'familia_pessoa',
      builder: (ctrl) {
        if (ctrl.isWaitingFamiliaPessoa) {
          return _buildLoadingSection('Dados da Família Pessoa');
        }

        if (ctrl.familiaPessoaDados.isEmpty) {
          return _buildEmptySection('Dados da Família Pessoa', 'Nenhum dado encontrado');
        }

        return _buildDataSection(
          'Dados da Família Pessoa',
          ctrl.familiaPessoaDados.first,
          {
            'EntidadeVwFamiliaPessoaNovaRenda.num_ordem_pessoa': 'numOrdemPessoa',
            'EntidadeVwFamiliaPessoaNovaRenda.num_nis_pessoa_atual': 'numNisPessoaAtual',
            'EntidadeVwFamiliaPessoaNovaRenda.num_cpf_pessoa': 'numCpfPessoa',
            'EntidadeVwFamiliaPessoaNovaRenda.vlrrenda': 'vlrrenda',
            'EntidadeVwFamiliaPessoaNovaRenda.vl_renda_percapta_original': 'vlRendaPercaptaOriginal',
            'EntidadeVwFamiliaPessoaNovaRenda.estado_cadastral': 'estadoCadastral',
            'EntidadeVwFamiliaPessoaNovaRenda.dta_entrevista_fam': 'dtaEntrevistaFam',
            'EntidadeVwFamiliaPessoaNovaRenda.dt_ult_atualizacao': 'dtUltAtualizacao',
            'EntidadeVwFamiliaPessoaNovaRenda.dt_cdstr_atual_fmla': 'dtCdstrAtualFmla',
            'EntidadeVwFamiliaPessoaNovaRenda.EdtStatusCadastro': 'edtStatusCadastro',
            'EntidadeVwFamiliaPessoaNovaRenda.tem_menor_aprendiz': 'temMenorAprendiz',
            'EntidadeVwFamiliaPessoaNovaRenda.dt_gradativo': 'dtGradativo',
          },
          controller,
        );
      },
    );
  }

  Widget _buildPessoaProgramaSection(DetalhesPessoaController controller) {
    return GetBuilder<DetalhesPessoaController>(
      id: 'pessoa_programa',
      builder: (ctrl) {
        if (ctrl.isWaitingPessoaPrograma) {
          return _buildLoadingSection('Programas Sociais');
        }

        if (ctrl.pessoaProgramaDados.isEmpty) {
          return _buildEmptySection('Programas Sociais', 'Nenhum programa encontrado');
        }

        return _buildInfoSection('Programas Sociais', [
          _buildInfoRow('Total de Programas', ctrl.pessoaProgramaDados.length.toString()),
          _buildInfoRow('ID Família', ctrl.pessoaProgramaDados.first.idfamilia?.toString() ?? 'Não informado'),
        ]);
      },
    );
  }

  Widget _buildNovaRendaMesSection(DetalhesPessoaController controller) {
    return GetBuilder<DetalhesPessoaController>(
      id: 'nova_renda_mes',
      builder: (ctrl) {
        if (ctrl.isWaitingNovaRendaMes) {
          return _buildLoadingSection('Renda Mensal');
        }

        if (ctrl.novaRendaMesDados.isEmpty) {
          return _buildEmptySection('Renda Mensal', 'Nenhum dado de renda encontrado');
        }

        return _buildInfoSection('Renda Mensal', [
          _buildInfoRow('Registros de Renda', ctrl.novaRendaMesDados.length.toString()),
          _buildInfoRow('ID Família', ctrl.novaRendaMesDados.first.idfamilia?.toString() ?? 'Não informado'),
        ]);
      },
    );
  }

  Widget _buildHistoricoSection(DetalhesPessoaController controller) {
    return GetBuilder<DetalhesPessoaController>(
      id: 'historico',
      builder: (ctrl) {
        if (ctrl.isWaitingHistorico) {
          return _buildLoadingSection('Histórico');
        }

        if (ctrl.historicoDados.isEmpty) {
          return _buildEmptySection('Histórico', 'Nenhum histórico encontrado');
        }

        return _buildInfoSection('Histórico', [
          _buildInfoRow('Total de Registros', ctrl.historicoDados.length.toString()),
          _buildInfoRow('ID Família', ctrl.historicoDados.first.idfamilia?.toString() ?? 'Não informado'),
        ]);
      },
    );
  }

  Widget _buildLoadingSection(String title) {
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
                Icon(Icons.info_outline, color: primaryColor, size: 20),
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

  Widget _buildEmptySection(String title, String message) {
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
                Icon(Icons.info_outline, color: primaryColor, size: 20),
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

  Widget _buildDataSection(String title, dynamic data, Map<String, String> fieldMapping, DetalhesPessoaController controller) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: primaryColor, size: 20),
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
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: fieldMapping.entries.map((entry) {
                final fieldName = entry.key;
                final propertyName = entry.value;
                final label = controller.getLabel(fieldName);

                // Usar reflection para acessar o valor da propriedade
                final value = _getPropertyValue(data, propertyName);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 160,
                        child: Text(
                          label,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          controller.formatarValor(value),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  dynamic _getPropertyValue(dynamic object, String propertyName) {
    // Implementação simples de reflection para acessar propriedades
    switch (propertyName) {
      case 'codFamiliarFam':
        return object.codFamiliarFam;
      case 'numNisPessoaAtual':
        return object.numNisPessoaAtual;
      case 'numCpfPessoa':
        return object.numCpfPessoa;
      case 'vlrrenda':
        return object.vlrrenda;
      case 'vlRendaPercaptaOriginal':
        return object.vlRendaPercaptaOriginal;
      case 'estadoCadastral':
        return object.estadoCadastral;
      case 'dtaEntrevistaFam':
        return object.dtaEntrevistaFam;
      case 'dtUltAtualizacao':
        return object.dtUltAtualizacao;
      case 'dtCdstrAtualFmla':
        return object.dtCdstrAtualFmla;
      case 'edtStatusCadastro':
        return object.edtStatusCadastro;
      case 'temMenorAprendiz':
        return object.temMenorAprendiz;
      case 'dtGradativo':
        return object.dtGradativo;
      case 'numOrdemPessoa':
        return object.numOrdemPessoa;
      default:
        return 'Não informado';
    }
  }
}
