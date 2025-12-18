import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sis_flutter/app_controller.dart';
import 'package:sis_flutter/model/pessoa_model.dart';
import 'package:sis_flutter/model/vw_familia_responsavel_nova_renda_model.dart';
import 'package:sis_flutter/model/vw_familia_pessoa_nova_renda_model.dart';
import 'package:sis_flutter/model/vw_pessoa_programa_nova_renda_model.dart';
import 'package:sis_flutter/model/vw_nova_renda_mes_model.dart';
import 'package:sis_flutter/model/vw_historico_familia_pessoa_model.dart';
import 'package:sis_flutter/service/pessoa_service.dart';
import 'package:sis_flutter/utils/utils.dart';

class DetalhesPessoaController extends GetxController {
  final AppController appController = Get.find<AppController>();
  final PessoaService pessoaService = Get.find<PessoaService>();

  final Pessoa pessoa;

  DetalhesPessoaController(this.pessoa);

  bool isWaiting = false;
  bool isWaitingFamiliaResponsavel = false;
  bool isWaitingFamiliaPessoa = false;
  bool isWaitingPessoaPrograma = false;
  bool isWaitingNovaRendaMes = false;
  bool isWaitingHistorico = false;

  List<VwFamiliaResponsavelNovaRendaModel> familiaResponsavelDados = [];
  List<VwFamiliaPessoaNovaRendaModel> familiaPessoaDados = [];
  List<VwPessoaProgramaNovaRendaModel> pessoaProgramaDados = [];
  List<VwNovaRendaMesModel> novaRendaMesDados = [];
  List<VwHistoricoFamiliaPessoaModel> historicoDados = [];
  final Map<String, String> deParaLabels = Utils.getDeParaLabelsViews();

  @override
  void onInit() {
    super.onInit();
    _carregarDadosAdicionais();
  }

  Future<void> _carregarDadosAdicionais() async {
    if (pessoa.idfamilia != null) {
      await Future.wait([
        _carregarFamiliaResponsavel(),
        _carregarFamiliaPessoa(),
        _carregarPessoaPrograma(),
        _carregarNovaRendaMes(),
        _carregarHistorico(),
      ]);
    }
  }

  Future<void> _carregarFamiliaResponsavel() async {
    try {
      isWaitingFamiliaResponsavel = true;
      update(['familia_responsavel']);

      familiaResponsavelDados =
          await pessoaService.pesquisarVwFamiliaResponsavelNovaRenda(
        idfamilia: pessoa.idfamilia,
      );

      update(['familia_responsavel']);
    } catch (e) {
      appController.showSnackbar(
        'Erro',
        'Erro ao carregar dados da família responsável: ${e.toString()}',
        cor: Colors.red,
      );
    } finally {
      isWaitingFamiliaResponsavel = false;
      update(['familia_responsavel']);
    }
  }

  Future<void> _carregarFamiliaPessoa() async {
    try {
      isWaitingFamiliaPessoa = true;
      update(['familia_pessoa']);

      familiaPessoaDados =
          await pessoaService.pesquisarVwFamiliaPessoaNovaRenda(
        idfamilia: pessoa.idfamilia,
      );

      update(['familia_pessoa']);
    } catch (e) {
      appController.showSnackbar(
        'Erro',
        'Erro ao carregar dados da família pessoa: ${e.toString()}',
        cor: Colors.red,
      );
    } finally {
      isWaitingFamiliaPessoa = false;
      update(['familia_pessoa']);
    }
  }

  Future<void> _carregarPessoaPrograma() async {
    try {
      isWaitingPessoaPrograma = true;
      update(['pessoa_programa']);

      pessoaProgramaDados =
          await pessoaService.pesquisarVwPessoaProgramaNovaRenda(
        idfamilia: pessoa.idfamilia,
      );

      update(['pessoa_programa']);
    } catch (e) {
      appController.showSnackbar(
        'Erro',
        'Erro ao carregar dados de programas: ${e.toString()}',
        cor: Colors.red,
      );
    } finally {
      isWaitingPessoaPrograma = false;
      update(['pessoa_programa']);
    }
  }

  Future<void> _carregarNovaRendaMes() async {
    try {
      isWaitingNovaRendaMes = true;
      update(['nova_renda_mes']);

      novaRendaMesDados = await pessoaService.pesquisarVwNovaRendaMes(
        idfamilia: pessoa.idfamilia,
      );

      update(['nova_renda_mes']);
    } catch (e) {
      appController.showSnackbar(
        'Erro',
        'Erro ao carregar dados de renda mensal: ${e.toString()}',
        cor: Colors.red,
      );
    } finally {
      isWaitingNovaRendaMes = false;
      update(['nova_renda_mes']);
    }
  }

  Future<void> _carregarHistorico() async {
    try {
      isWaitingHistorico = true;
      update(['historico']);

      historicoDados = await pessoaService.pesquisarVwHistoricoFamiliaPessoa(
        idfamilia: pessoa.idfamilia,
      );

      update(['historico']);
    } catch (e) {
      appController.showSnackbar(
        'Erro',
        'Erro ao carregar dados do histórico: ${e.toString()}',
        cor: Colors.red,
      );
    } finally {
      isWaitingHistorico = false;
      update(['historico']);
    }
  }

  String formatarValor(dynamic valor) {
    if (valor == null) return 'Não informado';

    if (valor is DateTime) {
      return DateFormat('dd/MM/yyyy').format(valor);
    }

    if (valor is double) {
      return 'R\$ ${valor.toStringAsFixed(2).replaceAll('.', ',')}';
    }

    if (valor is int) {
      return valor.toString();
    }

    if (valor is String) {
      if (valor.toLowerCase() == 's') return 'Sim';
      if (valor.toLowerCase() == 'n') return 'Não';
      return valor;
    }

    return valor.toString();
  }

  String getLabel(String chave) {
    return deParaLabels[chave] ?? chave;
  }
}
