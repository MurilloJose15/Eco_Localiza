bool validarCNPJ(String cnpj) {
  if (cnpj.isEmpty) return false;

  // Remove caracteres não numéricos
  cnpj = cnpj.replaceAll(RegExp(r'[^\d]'), '');

  // Verifica se o CNPJ possui 14 dígitos após remover caracteres não numéricos
  if (cnpj.length != 14) return false;

  // Verifica se todos os dígitos são iguais, o que tornaria o CNPJ inválido
  if (RegExp(r'^(\d)\1+$').hasMatch(cnpj)) return false;

  // Calcula o primeiro dígito verificador
  int soma = 0;
  List<int> pesos = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
  for (int i = 0; i < 12; i++) {
    soma += int.parse(cnpj[i]) * pesos[i];
  }
  int primeiroDigito = (soma % 11 < 2) ? 0 : (11 - (soma % 11));

  // Calcula o segundo dígito verificador
  soma = 0;
  pesos.insert(0, 6);
  for (int i = 0; i < 13; i++) {
    soma += int.parse(cnpj[i]) * pesos[i];
  }
  int segundoDigito = (soma % 11 < 2) ? 0 : (11 - (soma % 11));

  // Verifica se os dígitos calculados são iguais aos dígitos do CNPJ original
  return (int.parse(cnpj[12]) == primeiroDigito && int.parse(cnpj[13]) == segundoDigito);
}
