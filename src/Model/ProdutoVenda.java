package Model;

public class ProdutoVenda {
	private int idProduto;
	private int idVenda;
	private int quantidade;
	private float valorproduto;
	
	public float getValorproduto() {
		return valorproduto;
	}
	public void setValorproduto(float valorproduto) {
		this.valorproduto = valorproduto;
	}
	public int getQuantidade() {
		return quantidade;
	}
	public void setQuantidade(int quantidade) {
		this.quantidade = quantidade;
	}
	public int getIdProduto() {
		return idProduto;
	}
	public void setIdProduto(int idProduto) {
		this.idProduto = idProduto;
	}
	public int getIdVenda() {
		return idVenda;
	}
	public void setIdVenda(int idVenda) {
		this.idVenda = idVenda;
	}
}
