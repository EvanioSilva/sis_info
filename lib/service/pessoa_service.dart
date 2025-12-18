import 'package:get/get.dart';
import 'package:sis_flutter/model/pessoa_model.dart';
import 'package:sis_flutter/model/vw_familia_responsavel_nova_renda_model.dart';
import 'package:sis_flutter/model/vw_familia_pessoa_nova_renda_model.dart';
import 'package:sis_flutter/model/vw_pessoa_programa_nova_renda_model.dart';
import 'package:sis_flutter/model/vw_nova_renda_mes_model.dart';
import 'package:sis_flutter/model/vw_historico_familia_pessoa_model.dart';

class PessoaService extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    baseUrl = 'https://unseraphic-nonselective-shantae.ngrok-free.dev/api/sis';

    // Configurações de timeout e headers padrão
    timeout = const Duration(seconds: 30);
    httpClient.addRequestModifier<dynamic>((request) {
      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';
      return request;
    });
  }

  /// Trata resposta da API de forma segura
  dynamic _handleResponse(Response response, String operationName) {
    if (response.statusCode == 200) {
      return response.body;
    } else {
      final statusCode = response.statusCode ?? 'desconhecido';
      final body = response.body?.toString() ?? 'sem resposta';
      print('❌ Erro ao $operationName: Status $statusCode - $body');
      throw Exception('Erro ao $operationName: $statusCode - $body');
    }
  }

  /// Pesquisa pessoas na API
  /// Todos os parâmetros são opcionais
  Future<List<Pessoa>> pesquisarPessoas({
    String? codFamiliar,
    String? cpf,
    String? nis,
    String? nome,
    int? idFamilia,
    int? idPessoa,
    int? idEstadoCadastral,
    String? tipoResponsavel,
  }) async {
    try {
      // Construir query parameters
      final Map<String, String> queryParams = {};

      if (codFamiliar != null && codFamiliar.isNotEmpty) {
        queryParams['codFamiliar'] = codFamiliar;
      }
      if (cpf != null && cpf.isNotEmpty) {
        queryParams['cpf'] = cpf;
      }
      if (nis != null && nis.isNotEmpty) {
        queryParams['nis'] = nis;
      }
      if (nome != null && nome.isNotEmpty) {
        queryParams['nome'] = nome;
      }
      if (idFamilia != null) {
        queryParams['idFamilia'] = idFamilia.toString();
      }
      if (idPessoa != null) {
        queryParams['idPessoa'] = idPessoa.toString();
      }
      if (idEstadoCadastral != null) {
        queryParams['idEstadoCadastral'] = idEstadoCadastral.toString();
      }
      if (tipoResponsavel != null && tipoResponsavel.isNotEmpty) {
        queryParams['tipoResponsavel'] = tipoResponsavel;
      }

      final response = await get('/PesquisarPessoas', query: queryParams);
      final jsonList =
          _handleResponse(response, 'buscar pessoas') as List<dynamic>;
      return jsonList
          .map((json) => Pessoa.fromMap(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('❌ Erro ao pesquisar pessoas: $e');
      return [];
    }
  }

  /// Pesquisa dados de família responsável nova renda
  Future<List<VwFamiliaResponsavelNovaRendaModel>>
      pesquisarVwFamiliaResponsavelNovaRenda({
    int? idfamilia,
  }) async {
    try {
      final Map<String, String> queryParams = {};
      if (idfamilia != null) {
        queryParams['idfamilia'] = idfamilia.toString();
      }

      final response = await get('/PesquisarVwFamiliaResponsavelNovaRenda',
          query: queryParams);
      final jsonList = _handleResponse(response, 'buscar família responsável')
          as List<dynamic>;
      return jsonList
          .map((json) => VwFamiliaResponsavelNovaRendaModel.fromJson(
              json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('❌ Erro ao pesquisar família responsável nova renda: $e');
      return [];
    }
  }

  /// Pesquisa dados de família pessoa nova renda
  Future<List<VwFamiliaPessoaNovaRendaModel>>
      pesquisarVwFamiliaPessoaNovaRenda({
    int? idfamilia,
  }) async {
    try {
      final Map<String, String> queryParams = {};
      if (idfamilia != null) {
        queryParams['idfamilia'] = idfamilia.toString();
      }

      final response =
          await get('/PesquisarVwFamiliaPessoaNovaRenda', query: queryParams);
      final jsonList =
          _handleResponse(response, 'buscar família pessoa') as List<dynamic>;
      return jsonList
          .map((json) => VwFamiliaPessoaNovaRendaModel.fromJson(
              json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('❌ Erro ao pesquisar família pessoa nova renda: $e');
      return [];
    }
  }

  /// Pesquisa dados de pessoa programa nova renda
  Future<List<VwPessoaProgramaNovaRendaModel>>
      pesquisarVwPessoaProgramaNovaRenda({
    int? idfamilia,
  }) async {
    try {
      final Map<String, String> queryParams = {};
      if (idfamilia != null) {
        queryParams['idfamilia'] = idfamilia.toString();
      }

      final response =
          await get('/PesquisarVwPessoaProgramaNovaRenda', query: queryParams);
      final jsonList =
          _handleResponse(response, 'buscar pessoa programa') as List<dynamic>;
      return jsonList
          .map((json) => VwPessoaProgramaNovaRendaModel.fromJson(
              json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('❌ Erro ao pesquisar pessoa programa nova renda: $e');
      return [];
    }
  }

  /// Pesquisa dados de nova renda mês
  Future<List<VwNovaRendaMesModel>> pesquisarVwNovaRendaMes({
    int? idfamilia,
  }) async {
    try {
      final Map<String, String> queryParams = {};
      if (idfamilia != null) {
        queryParams['idfamilia'] = idfamilia.toString();
      }

      final response =
          await get('/PesquisarVwNovaRendaMes', query: queryParams);
      final jsonList =
          _handleResponse(response, 'buscar nova renda mês') as List<dynamic>;
      return jsonList
          .map((json) =>
              VwNovaRendaMesModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('❌ Erro ao pesquisar nova renda mês: $e');
      return [];
    }
  }

  /// Pesquisa dados de histórico família pessoa
  Future<List<VwHistoricoFamiliaPessoaModel>>
      pesquisarVwHistoricoFamiliaPessoa({
    int? idfamilia,
  }) async {
    try {
      final Map<String, String> queryParams = {};
      if (idfamilia != null) {
        queryParams['idfamilia'] = idfamilia.toString();
      }

      final response =
          await get('/PesquisarVwHistoricoFamiliaPessoa', query: queryParams);
      final jsonList = _handleResponse(response, 'buscar histórico família')
          as List<dynamic>;
      return jsonList
          .map((json) => VwHistoricoFamiliaPessoaModel.fromJson(
              json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('❌ Erro ao pesquisar histórico família pessoa: $e');
      return [];
    }
  }
}
