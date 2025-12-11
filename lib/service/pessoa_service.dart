import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sis_flutter/model/pessoa_model.dart';
import 'package:sis_flutter/model/vw_familia_responsavel_nova_renda_model.dart';
import 'package:sis_flutter/model/vw_familia_pessoa_nova_renda_model.dart';
import 'package:sis_flutter/model/vw_pessoa_programa_nova_renda_model.dart';
import 'package:sis_flutter/model/vw_nova_renda_mes_model.dart';
import 'package:sis_flutter/model/vw_historico_familia_pessoa_model.dart';

class PessoaService extends GetxService {
  static const String baseUrl = 'https://unseraphic-nonselective-shantae.ngrok-free.dev/api/sis';

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
      // Construir a URL com query parameters
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

      final uri = Uri.parse('$baseUrl/PesquisarPessoas').replace(
        queryParameters: queryParams.isEmpty ? null : queryParams,
      );

      print(uri);

      // Fazer a requisição GET
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Tempo de requisição excedido');
        },
      );

      // Verificar se a requisição foi bem-sucedida
      if (response.statusCode == 200) {
        // Decodificar o JSON
        final List<dynamic> jsonList = json.decode(response.body);

        // Converter para lista de Pessoa
        final List<Pessoa> pessoas = jsonList
            .map((json) => Pessoa.fromMap(json as Map<String, dynamic>))
            .toList();

        return pessoas;
      } else {
        throw Exception(
            'Erro ao buscar pessoas: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Erro ao pesquisar pessoas: ${e.toString()}');
    }
  }

  /// Pesquisa dados de família responsável nova renda
  Future<List<VwFamiliaResponsavelNovaRendaModel>> pesquisarVwFamiliaResponsavelNovaRenda({
    int? idfamilia,
  }) async {
    try {
      final Map<String, String> queryParams = {};

      if (idfamilia != null) {
        queryParams['idfamilia'] = idfamilia.toString();
      }

      final uri = Uri.parse('$baseUrl/PesquisarVwFamiliaResponsavelNovaRenda').replace(
        queryParameters: queryParams.isEmpty ? null : queryParams,
      );

      print(uri);

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Tempo de requisição excedido');
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        final List<VwFamiliaResponsavelNovaRendaModel> dados = jsonList
            .map((json) => VwFamiliaResponsavelNovaRendaModel.fromJson(json as Map<String, dynamic>))
            .toList();
        return dados;
      } else {
        throw Exception(
            'Erro ao buscar dados: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Erro ao pesquisar família responsável nova renda: ${e.toString()}');
    }
  }

  /// Pesquisa dados de família pessoa nova renda
  Future<List<VwFamiliaPessoaNovaRendaModel>> pesquisarVwFamiliaPessoaNovaRenda({
    int? idfamilia,
  }) async {
    try {
      final Map<String, String> queryParams = {};

      if (idfamilia != null) {
        queryParams['idfamilia'] = idfamilia.toString();
      }

      final uri = Uri.parse('$baseUrl/PesquisarVwFamiliaPessoaNovaRenda').replace(
        queryParameters: queryParams.isEmpty ? null : queryParams,
      );

      print(uri);

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Tempo de requisição excedido');
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        final List<VwFamiliaPessoaNovaRendaModel> dados = jsonList
            .map((json) => VwFamiliaPessoaNovaRendaModel.fromJson(json as Map<String, dynamic>))
            .toList();
        return dados;
      } else {
        throw Exception(
            'Erro ao buscar dados: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Erro ao pesquisar família pessoa nova renda: ${e.toString()}');
    }
  }

  /// Pesquisa dados de pessoa programa nova renda
  Future<List<VwPessoaProgramaNovaRendaModel>> pesquisarVwPessoaProgramaNovaRenda({
    int? idfamilia,
  }) async {
    try {
      final Map<String, String> queryParams = {};

      if (idfamilia != null) {
        queryParams['idfamilia'] = idfamilia.toString();
      }

      final uri = Uri.parse('$baseUrl/PesquisarVwPessoaProgramaNovaRenda').replace(
        queryParameters: queryParams.isEmpty ? null : queryParams,
      );

      print(uri);

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Tempo de requisição excedido');
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        final List<VwPessoaProgramaNovaRendaModel> dados = jsonList
            .map((json) => VwPessoaProgramaNovaRendaModel.fromJson(json as Map<String, dynamic>))
            .toList();
        return dados;
      } else {
        throw Exception(
            'Erro ao buscar dados: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Erro ao pesquisar pessoa programa nova renda: ${e.toString()}');
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

      final uri = Uri.parse('$baseUrl/PesquisarVwNovaRendaMes').replace(
        queryParameters: queryParams.isEmpty ? null : queryParams,
      );

      print(uri);

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Tempo de requisição excedido');
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        final List<VwNovaRendaMesModel> dados = jsonList
            .map((json) => VwNovaRendaMesModel.fromJson(json as Map<String, dynamic>))
            .toList();
        return dados;
      } else {
        throw Exception(
            'Erro ao buscar dados: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Erro ao pesquisar nova renda mês: ${e.toString()}');
    }
  }

  /// Pesquisa dados de histórico família pessoa
  Future<List<VwHistoricoFamiliaPessoaModel>> pesquisarVwHistoricoFamiliaPessoa({
    int? idfamilia,
  }) async {
    try {
      final Map<String, String> queryParams = {};

      if (idfamilia != null) {
        queryParams['idfamilia'] = idfamilia.toString();
      }

      final uri = Uri.parse('$baseUrl/PesquisarVwHistoricoFamiliaPessoa').replace(
        queryParameters: queryParams.isEmpty ? null : queryParams,
      );

      print(uri);

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Tempo de requisição excedido');
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        final List<VwHistoricoFamiliaPessoaModel> dados = jsonList
            .map((json) => VwHistoricoFamiliaPessoaModel.fromJson(json as Map<String, dynamic>))
            .toList();
        return dados;
      } else {
        throw Exception(
            'Erro ao buscar dados: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Erro ao pesquisar histórico família pessoa: ${e.toString()}');
    }
  }
}
