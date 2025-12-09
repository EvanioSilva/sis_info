import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sis_flutter/controller/pesquisar_pessoa_controller.dart';
import 'package:sis_flutter/model/pessoa_model.dart';
import 'package:sis_flutter/utils/utils.dart';
import 'package:sis_flutter/values/colors.dart';

class PesquisarPessoaPage extends StatelessWidget {
  const PesquisarPessoaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PesquisarPessoaController());

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Consulta Sintética'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildSearchSection(controller),
          Expanded(
            child: _buildResultsSection(controller),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSection(PesquisarPessoaController controller) {
    return GetBuilder<PesquisarPessoaController>(
      id: 'pesquisa',
      builder: (_) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Opções de pesquisa',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: controller.togglePesquisaExpandida,
                    icon: AnimatedRotation(
                      duration: const Duration(milliseconds: 300),
                      turns: controller.pesquisaExpandida ? 0 : 0.5,
                      child: Icon(
                        Icons.keyboard_arrow_up,
                        color: Colors.grey[700],
                      ),
                    ),
                    tooltip: controller.pesquisaExpandida
                        ? 'Recolher pesquisa'
                        : 'Expandir pesquisa',
                  ),
                ],
              ),
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 300),
                firstChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    GetBuilder<PesquisarPessoaController>(
                      id: 'tipo_pesquisa',
                      builder: (_) {
                        return Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _buildFilterChip(
                              label: 'Domicilio',
                              isSelected:
                                  controller.tipoPesquisa == 'Domicilio',
                              onSelected: () =>
                                  controller.setTipoPesquisa('Domicilio'),
                              icon: Icons.home,
                            ),
                            _buildFilterChip(
                              label: 'Nis',
                              isSelected: controller.tipoPesquisa == 'Nis',
                              onSelected: () =>
                                  controller.setTipoPesquisa('Nis'),
                              icon: Icons.badge,
                            ),
                            _buildFilterChip(
                              label: 'Cpf',
                              isSelected: controller.tipoPesquisa == 'Cpf',
                              onSelected: () =>
                                  controller.setTipoPesquisa('Cpf'),
                              icon: Icons.credit_card,
                            ),
                            _buildFilterChip(
                              label: 'Nome',
                              isSelected: controller.tipoPesquisa == 'Nome',
                              onSelected: () =>
                                  controller.setTipoPesquisa('Nome'),
                              icon: Icons.person,
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    GetBuilder<PesquisarPessoaController>(
                      id: 'checkbox_programa',
                      builder: (_) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CheckboxListTile(
                            title: Text(
                              'Somente famílias/Pessoas no programa',
                              style: TextStyle(color: Colors.grey[800]),
                            ),
                            value: controller.somentePrograma,
                            onChanged: controller.toggleSomentePrograma,
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: primaryColor,
                            checkColor: Colors.white,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
                secondChild: const SizedBox.shrink(),
                crossFadeState: controller.pesquisaExpandida
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: controller.pesquisaController,
                  decoration: InputDecoration(
                    hintText: 'Digite o valor para pesquisa',
                    prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor, width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                  ),
                  textCapitalization: TextCapitalization.characters,
                  onSubmitted: (_) => controller.pesquisar(),
                  enabled: !controller.isWaiting,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed:
                          controller.isWaiting ? null : controller.pesquisar,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      icon: controller.isWaiting
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Icon(Icons.search),
                      label: const Text(
                        'Localizar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed:
                        controller.isWaiting ? null : controller.limparPesquisa,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.grey[800],
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Icon(Icons.clear),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required VoidCallback onSelected,
    required IconData icon,
  }) {
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              size: 16, color: isSelected ? Colors.white : Colors.grey[700]),
          const SizedBox(width: 4),
          Text(label),
        ],
      ),
      selected: isSelected,
      onSelected: (_) => onSelected(),
      backgroundColor: Colors.grey[200],
      selectedColor: primaryColor,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.grey[700],
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      checkmarkColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? primaryColor : Colors.transparent,
          width: 1.5,
        ),
      ),
    );
  }

  Widget _buildResultsSection(PesquisarPessoaController controller) {
    return GetBuilder<PesquisarPessoaController>(
      id: 'resultado',
      builder: (_) {
        if (controller.pessoasEncontradas.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off,
                  size: 80,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'Nenhuma pessoa encontrada',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Realize uma pesquisa acima',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.people, color: Colors.grey[700]),
                  const SizedBox(width: 8),
                  Text(
                    '${controller.pessoasEncontradas.length} pessoa(s) encontrada(s)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: controller.pessoasEncontradas.length,
                itemBuilder: (context, index) {
                  final pessoa = controller.pessoasEncontradas[index];
                  return _buildPersonCard(pessoa, index);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPersonCard(Pessoa pessoa, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // Pode adicionar ação ao tocar no card
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person,
                        color: Colors.grey[700],
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pessoa.nomPessoa ?? 'Nome não informado',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (pessoa.numOrdemPessoa != null)
                            Text(
                              'Ordem: ${pessoa.numOrdemPessoa}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (pessoa.tipoResponsavel != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          pessoa.tipoResponsavel!,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(height: 1),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 16,
                  runSpacing: 12,
                  children: [
                    if (pessoa.dtaNascPessoa != null)
                      _buildInfoItem(
                        icon: Icons.cake,
                        label: 'Nascimento',
                        value: DateFormat('dd/MM/yyyy')
                            .format(pessoa.dtaNascPessoa!),
                      ),
                    if (pessoa.numNisPessoaAtual != null &&
                        pessoa.numNisPessoaAtual!.isNotEmpty)
                      _buildInfoItem(
                        icon: Icons.badge,
                        label: 'NIS',
                        value:
                            Utils.ofuscarDocumento(pessoa.numNisPessoaAtual!),
                      ),
                    if (pessoa.numCpfPessoa != null &&
                        pessoa.numCpfPessoa!.isNotEmpty)
                      _buildInfoItem(
                        icon: Icons.credit_card,
                        label: 'CPF',
                        value: Utils.ofuscarDocumento(pessoa.numCpfPessoa!),
                      ),
                    if (pessoa.codFamiliarFam != null &&
                        pessoa.codFamiliarFam!.isNotEmpty)
                      _buildInfoItem(
                        icon: Icons.home,
                        label: 'Domicílio',
                        value: pessoa.codFamiliarFam!,
                      ),
                  ],
                ),
                if (pessoa.nomCompletoMaePessoa != null &&
                    pessoa.nomCompletoMaePessoa!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  const Divider(height: 1),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.family_restroom,
                          size: 18, color: Colors.grey[600]),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Mãe: ${pessoa.nomCompletoMaePessoa}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 16),
                const Divider(height: 1),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.toNamed('/detalhes-pessoa', arguments: pessoa);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    icon: const Icon(Icons.visibility, size: 20),
                    label: const Text(
                      'Ver Detalhes',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
