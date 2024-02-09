<!DOCTYPE html>
<html lang="pt-BR">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Delivery de Comida Mexicana</title>
<style>
  body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f4f4f4;
  }
  header {
    background-color: #FFD700;
    padding: 20px;
    text-align: center;
    color: #fff;
  }
  nav {
    background-color: #333;
    color: #fff;
    text-align: center;
    padding: 10px;
  }
  nav a {
    color: #fff;
    text-decoration: none;
    margin: 0 10px;
  }
  .container {
    max-width: 1200px;
    margin: 20px auto;
    padding: 0 20px;
  }
  .restaurant-info {
    background-color: #fff;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    text-align: center;
  }
  .menu {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
    margin-top: 20px;
  }
  .dish {
    background-color: #fff;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
    text-align: center;
  }
  .dish h3 {
    margin-top: 0;
  }
  .dish img {
    max-width: 100%;
    border-radius: 5px;
  }
  .cart {
    background-color: #fff;
    padding: 20px;
    border-radius: 5px;
    margin-top: 20px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  }
  .cart h2 {
    margin-top: 0;
  }
  .cart ul {
    list-style: none;
    padding: 0;
  }
  .cart-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 0;
    border-bottom: 1px solid #ccc;
  }
  .cart-item:last-child {
    border-bottom: none;
  }
  .cart-total {
    margin-top: 10px;
    font-weight: bold;
  }
  .checkout-btn {
    margin-top: 20px;
    background-color: #FFD700;
    color: #fff;
    border: none;
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease-out;
  }
  .checkout-btn:hover {
    background-color: #FFA500;
  }
</style>
</head>
<body>
<header>
  <h1>Delivery de Comida Mexicana</h1>
</header>
<nav>
  <a href="#">Home</a>
  <a href="#">Cardápio</a>
  <a href="#">Sobre</a>
  <a href="#">Contato</a>
</nav>
<div class="container">
  <div class="restaurant-info">
    <h2>Restaurante "Sabor Mexicano"</h2>
    <p>Horário de Funcionamento: Seg-Sex 11:00 - 22:00, Sáb-Dom 12:00 - 23:00</p>
    <p>Telefone: (XX) XXXX-XXXX</p>
    <p>Endereço: Av. Principal, 123 - Cidade, Estado</p>
  </div>

  <h2>Cardápio</h2>
  <div class="menu">
    <div class="dish">
      <img src="tacos.jpg" alt="Tacos">
      <h3>Tacos</h3>
      <p>Descrição: Tacos mexicanos tradicionais recheados com carne, alface, queijo e molho.</p>
      <p>Preço: R$ 15,00</p>
      <button onclick="addToCart('Tacos', 15)">Adicionar ao Carrinho</button>
    </div>
    <div class="dish">
      <img src="enchiladas.jpg" alt="Enchiladas">
      <h3>Enchiladas</h3>
      <p>Descrição: Tortilhas de milho recheadas com frango e cobertas com molho de pimenta e queijo.</p>
      <p>Preço: R$ 18,00</p>
      <button onclick="addToCart('Enchiladas', 18)">Adicionar ao Carrinho</button>
    </div>
    <!-- Adicione mais pratos conforme necessário -->
  </div>

  <div class="cart" id="cart">
    <h2>Carrinho</h2>
    <ul id="cartItems"></ul>
    <div class="cart-total" id="cartTotal">Total: R$ 0,00</div>
    <button class="checkout-btn" onclick="checkout()">Finalizar Pedido</button>
  </div>
</div>

<script>
  let cartItems = [];
  let totalPrice = 0;

  function addToCart(name, price) {
    cartItems.push({ name, price });
    totalPrice += price;
    renderCart();
  }

  function removeFromCart(index) {
    totalPrice -= cartItems[index].price;
    cartItems.splice(index, 1);
    renderCart();
  }

  function renderCart() {
    const cartItemsContainer = document.getElementById('cartItems');
    const cartTotal = document.getElementById('cartTotal');
    cartItemsContainer.innerHTML = '';
    cartTotal.textContent = `Total: R$ ${totalPrice.toFixed(2)}`;

    cartItems.forEach((item, index) => {
      const cartItem = document.createElement('li');
      cartItem.classList.add('cart-item');
      cartItem.innerHTML = `
        <span>${item.name}</span>
        <span>R$ ${item.price.toFixed(2)}</span>
        <button onclick="removeFromCart(${index})">Remover</button>
      `;
      cartItemsContainer.appendChild(cartItem);
    });
  }

  function checkout() {
    alert(`Pedido finalizado! Total: R$ ${totalPrice.toFixed(2)}`);
    cartItems = [];
    totalPrice = 0;
    renderCart();
  }
</script>
</body>
</html
