package Model;

public class Estoque {
	private int idEstoque;
	private String descricao;
	private int tamanho;
	private int totalunidades;
	private int espacolivre;
	
	public int getEspacolivre() {
		return espacolivre;
	}
	public void setEspacolivre(int espacolivre) {
		this.espacolivre = espacolivre;
	}
	public int getTotalunidades() {
		return totalunidades;
	}
	public void setTotalunidades(int totalunidades) {
		this.totalunidades = totalunidades;
	}
	private String situacao;
	
	public String getSituacao() {
		return situacao;
	}
	public void setSituacao(String situacao) {
		this.situacao = situacao;
	}
	public int getIdEstoque() {
		return idEstoque;
	}
	public void setIdEstoque(int idEstoque) {
		this.idEstoque = idEstoque;
	}
	public String getDescricao() {
		return descricao;
	}
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	public int getTamanho() {
		return tamanho;
	}
	public void setTamanho(int tamanho) {
		this.tamanho = tamanho;
	}
	
	

}
