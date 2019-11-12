package Model;

import java.util.Date;

public class Venda {
	private int idVenda;
	private float valor;
	private int idCliente;
	private int idVendedor;
	private float valorpago;
	private float troco;
	private Date datahora = new Date();
	private ProdutoVenda produtovenda;
	
	public ProdutoVenda getProdutovenda() {
		return produtovenda;
	}
	public void setProdutovenda(ProdutoVenda produtovenda) {
		this.produtovenda = produtovenda;
	}
	public int getIdVenda(){
		return idVenda;
	}
	public void setIdVenda(int idVenda){
		this.idVenda = idVenda;
	}
	public float getValor(){
		return valor;
	}
	public void setValor(float valor){
		this.valor = valor;
	}
	public int getIdCliente(){
		return idCliente;
	}
	public void setIdCliente(int idCliente){
		this.idCliente = idCliente;
	}
	public int getIdVendedor(){
		return idVendedor;
	}
	public void setIdVendedor(int idVendedor){
		this.idVendedor = idVendedor;
	}
	public float getValorpago(){
		return valorpago;
	}
	public void setValorpago(float valorpago){
		this.valorpago = valorpago;
	}
	public float getTroco(){
		return troco;
	}
	public void setTroco(float troco){
		this.troco = troco;
	}
	public Date getDatahora(){
		return datahora;
	}
	public void setDatahora(Date datahora){
		this.datahora = datahora;
	}
}
