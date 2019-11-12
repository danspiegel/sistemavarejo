(function($) {
	
	$( document ).ready(function() {
	
		// BOTAO EDITAR - CLICK
		$( ".bt_editar_estoque" ).each(function() {
			
			$(this).click(function() {
				
				var row = $(this).closest("tr")
			    var tds = row.find("td");
				
				$.each(tds, function(index) {
				    
				    //CODIGO
					if(index == 0){
				    	$('#idestoque').val($(this).text());
				    }
					//DESCRICAO
				    else if(index == 1){
				    	$('#descricaoestoque').val($(this).text());
				    }
					//TAMANHO
				    else if(index == 2){
				    	$('#tamanhoestoque').val($(this).text());
				    }
				    
				});
				
			});
		});
		
		// BOTAO EDITAR - CLICK
		$( ".bt_editar_cliente" ).each(function() {
			
			$(this).click(function() {
				
				var row = $(this).closest("tr")
			    var tds = row.find("td");
				
				$.each(tds, function(index) {
				    
				    //CODIGO
					if(index == 0){
				    	$('#idcliente').val($(this).text());
				    }
					//DESCRICAO
				    else if(index == 1){
				    	$('#nomecliente').val($(this).text());
				    }
					//TAMANHO
				    else if(index == 2){
				    	$('#cpfcliente').val($(this).text());
				    }
				    
				});
				
			});
		});
		
		// BOTAO EDITAR - CLICK
		$( ".bt_editar_produto" ).each(function() {
			
			$(this).click(function() {
				
				var row = $(this).closest("tr")
			    var tds = row.find("td");
				
				$.each(tds, function(index) {
				    
				    //CODIGO
					if(index == 0){
				    	$('#idproduto').val($(this).text());
				    }
					//DESCRICAO
				    else if(index == 1){
				    	$('#descricaoproduto').val($(this).text());
				    }
					//TAMANHO
				    else if(index == 2){
				    	$('#valorproduto').val(parseFloat($(this).text()));
				    }
				    else if(index == 3){
				    	$('#unidadesproduto').val($(this).text());
				    }
				    else if(index == 4){
				    	$('#estoqueproduto').val($(this).text());
				    }
				    
				});
				
			});
		});
		
		// BOTAO EXCLUIR - CLICK
		$( ".bt_excluir_cliente" ).each(function() {
			
			$(this).click(function() {
				
				var row = $(this).closest("tr")
			    var tds = row.find("td");
				
				$.each(tds, function(index) {
				    
				    //CODIGO
					if(index == 0){
				    	$('#id_cliente').val($(this).text());
				    }
					//NOME
					else if(index == 0){
						$('#nome_cliente').val($(this).text());
				    }
				    
				});
				
			});
		});
		
		// BOTAO EXCLUIR - CLICK
		$( ".bt_excluir_estoque" ).each(function() {
			
			$(this).click(function() {
				
				var row = $(this).closest("tr")
			    var tds = row.find("td");
				
				$.each(tds, function(index) {
				    
				    //CODIGO
					if(index == 0){
				    	$('#id_estoque').val($(this).text());
				    }
					//NOME
					else if(index == 0){
				    	$('#nome_estoque').val($(this).text());
				    }
				    
				});
				
			});
		});
		
		// BOTAO EXCLUIR - CLICK
		$( ".bt_excluir_produto" ).each(function() {
			
			$(this).click(function() {
				
				var row = $(this).closest("tr")
			    var tds = row.find("td");
				
				$.each(tds, function(index) {
				    
				    //CODIGO
					if(index == 0){
				    	$('#id_produto').val($(this).text());
				    }
					//NOME
					else if(index == 1){
				    	$('#nome_produto').val($(this).text());
				    }
					//CODIGO ESTOQUE
					else if (index == 4){
				    	$('#id_estoque').val($(this).text());
				    }
				    
				});
				
			});
		});
		
		$('#quantidade').on('focusout', function(e) { 
			e.preventDefault();  

			if (($('#valorproduto').val() != "") && ($('#quantidade').val() != "")){
				var valortotal = $('#valorproduto').val() * $('#quantidade').val();
				$('#valor').val(valortotal);
			}
		});
		
		$('#valorpago').on('focusout', function(e) { 
			e.preventDefault();  
			
			if ($('#valorpago').val() != ""){
				var valortotal = $('#valorproduto').val() * $('#quantidade').val();
				var troco = $('#valorpago').val() - valortotal;
				$('#troco').val(troco);
			}
		});
		
		$('#idProduto').on('focusout', function(e) { 
			e.preventDefault();  
			
			if ($('#idProduto').val() != ""){
				$('#valorproduto').val($("#idProduto option:selected").attr('valorproduto'));
			}
			
		});
		
	});
	
})(jQuery);

