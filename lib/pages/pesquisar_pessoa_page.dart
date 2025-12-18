import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sis_flutter/controller/pesquisar_pessoa_controller.dart';
import 'package:sis_flutter/model/pessoa_model.dart';
import 'package:sis_flutter/utils/utils.dart';
import 'package:sis_flutter/values/colors.dart';
import 'package:sis_flutter/utils/windows_responsive.dart';

class PesquisarPessoaPage extends StatelessWidget {
  const PesquisarPessoaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PesquisarPessoaController());

    final isDesktop = WindowsResponsive.isDesktopLayout(context);
    
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Consulta Sintética',
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
        child: Column(
          children: [
            _buildSearchSection(context, controller),
            Expanded(
              child: _buildResultsSection(context, controller),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSection(BuildContext context, PesquisarPessoaController controller) {
    final isDesktop = WindowsResponsive.isDesktopLayout(context);
    final padding = WindowsResponsive.getResponsivePadding(context);
    final spacing = WindowsResponsive.getResponsiveSpacing(context);
    
    return GetBuilder<PesquisarPessoaController>(
      id: 'pesquisa',
      builder: (_) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(isDesktop ? 24 : 20),
              bottomRight: Radius.circular(isDesktop ? 24 : 20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: isDesktop ? 15 : 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: EdgeInsets.all(isDesktop ? padding.horizontal * 0.5 : 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Opções de pesquisa',
                      style: TextStyle(
                        fontSize: WindowsResponsive.getResponsiveFontSize(context, 18),
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
                        size: isDesktop ? 32 : 24,
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
                    SizedBox(height: spacing),
                    GetBuilder<PesquisarPessoaController>(
                      id: 'tipo_pesquisa',
                      builder: (_) {
                        return Wrap(
                          spacing: isDesktop ? 12 : 8,
                          runSpacing: isDesktop ? 12 : 8,
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
                    SizedBox(height: spacing),
                    GetBuilder<PesquisarPessoaController>(
                      id: 'checkbox_programa',
                      builder: (_) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(isDesktop ? 12 : 8),
                          ),
                          child: CheckboxListTile(
                            title: Text(
                              'Somente famílias/Pessoas no programa',
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: WindowsResponsive.getResponsiveFontSize(context, 14),
                              ),
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
                    SizedBox(height: spacing),
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
                  style: TextStyle(
                    fontSize: WindowsResponsive.getResponsiveFontSize(context, 16),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Digite o valor para pesquisa',
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey[600],
                      size: isDesktop ? 28 : 24,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(isDesktop ? 16 : 12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(isDesktop ? 16 : 12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(isDesktop ? 16 : 12),
                      borderSide: BorderSide(color: primaryColor, width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: isDesktop ? 24 : 20,
                      vertical: isDesktop ? 20 : 16,
                    ),
                  ),
                  textCapitalization: TextCapitalization.characters,
                  onSubmitted: (_) => controller.pesquisar(),
                  enabled: !controller.isWaiting,
                ),
              ),
              SizedBox(height: spacing),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed:
                          controller.isWaiting ? null : controller.pesquisar,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          vertical: isDesktop ? 20 : 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(isDesktop ? 16 : 12),
                        ),
                        elevation: 2,
                      ),
                      icon: controller.isWaiting
                          ? SizedBox(
                              width: isDesktop ? 24 : 20,
                              height: isDesktop ? 24 : 20,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Icon(Icons.search, size: isDesktop ? 24 : 20),
                      label: Text(
                        'Localizar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: WindowsResponsive.getResponsiveFontSize(context, 16),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: isDesktop ? 16 : 12),
                  ElevatedButton(
                    onPressed:
                        controller.isWaiting ? null : controller.limparPesquisa,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.grey[800],
                      padding: EdgeInsets.all(isDesktop ? 20 : 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(isDesktop ? 16 : 12),
                      ),
                      elevation: 0,
                    ),
                    child: Icon(Icons.clear, size: isDesktop ? 24 : 20),
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

  Widget _buildResultsSection(BuildContext context, PesquisarPessoaController controller) {
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
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isDesktop = WindowsResponsive.isDesktopLayout(context);
                  final padding = WindowsResponsive.getResponsivePadding(context);
                  
                  if (isDesktop && constraints.maxWidth > 1200) {
                    // Layout em grid para telas grandes
                    return GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: padding.horizontal * 0.5),
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 600,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 1.2,
                      ),
                      itemCount: controller.pessoasEncontradas.length,
                      itemBuilder: (context, index) {
                        final pessoa = controller.pessoasEncontradas[index];
                        return _buildPersonCard(context, pessoa, index);
                      },
                    );
                  }
                  
                  // Layout em lista para telas menores
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: isDesktop ? padding.horizontal * 0.5 : 16),
                    itemCount: controller.pessoasEncontradas.length,
                    itemBuilder: (context, index) {
                      final pessoa = controller.pessoasEncontradas[index];
                      return _buildPersonCard(context, pessoa, index);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPersonCard(BuildContext context, Pessoa pessoa, int index) {
    final isDesktop = WindowsResponsive.isDesktopLayout(context);
    
    return Container(
      margin: EdgeInsets.only(bottom: isDesktop ? 16 : 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isDesktop ? 20 : 16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: isDesktop ? 15 : 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(isDesktop ? 20 : 16),
          onTap: () {
            // Pode adicionar ação ao tocar no card
          },
          child: Padding(
            padding: EdgeInsets.all(isDesktop ? 24 : 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: isDesktop ? 60 : 48,
                      height: isDesktop ? 60 : 48,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person,
                        color: Colors.grey[700],
                        size: isDesktop ? 34 : 28,
                      ),
                    ),
                    SizedBox(width: isDesktop ? 16 : 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pessoa.nomPessoa ?? 'Nome não informado',
                            style: TextStyle(
                              fontSize: WindowsResponsive.getResponsiveFontSize(context, 18),
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
                                fontSize: WindowsResponsive.getResponsiveFontSize(context, 12),
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
                SizedBox(height: isDesktop ? 20 : 16),
                const Divider(height: 1),
                SizedBox(height: isDesktop ? 16 : 12),
                Wrap(
                  spacing: isDesktop ? 20 : 16,
                  runSpacing: isDesktop ? 16 : 12,
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
                      padding: EdgeInsets.symmetric(
                        vertical: isDesktop ? 16 : 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(isDesktop ? 16 : 12),
                      ),
                      elevation: 2,
                    ),
                    icon: Icon(Icons.visibility, size: isDesktop ? 24 : 20),
                    label: Text(
                      'Ver Detalhes',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: WindowsResponsive.getResponsiveFontSize(context, 15),
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
