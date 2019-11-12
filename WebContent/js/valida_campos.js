function validaSenha (input){ 
   if (input.value != document.getElementById('txtSenha').value) {
    input.setCustomValidity('Digite a confirmacao da senha corretamente');
  } else {
    input.setCustomValidity('');
  }
}

function validaTamanhoEstoque (input){ 
   if (input.value == "0" ) {
    input.setCustomValidity('Tamanho do estoque deve ser maior que zero');
  } else {
    input.setCustomValidity('');
  }
}

function validaValorProduto (input){
	if ((input.value == "0") || (input.value == "0,00") || (input.value == "0.00")){
		input.setCustomValidity('Valor do produto deve ser maior que zero');
	}else {
		input.setCustomValidity('');
	}
}

function validaUnidadesProduto (input){ 
	if (input.value == "0" ) {
		input.setCustomValidity('As unidades devem ser maior que zero.');
	}else {
	    input.setCustomValidity('');
	}
}

function validaCodigo (input){ 
	if (input.value == "0" ) {
		input.setCustomValidity('Nao e permitido codigo zero');
	}else {
	    input.setCustomValidity('');
	}
}

function validaCpf (input){ 
	if (input.value == "0" ) {
		input.setCustomValidity('Nao e permitido CPF zero');
	}else if (input.length < "11"){
		input.setCustomValidity('CPF menor que 11 caracteres.');
	}else {
	    input.setCustomValidity('');
	}
}
