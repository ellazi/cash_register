import React, { useEffect, useState } from 'react';
import './ProductList.css';

function ProductList() {
  const [products, setProducts] = useState([]);

  useEffect(() => {
    fetch('http://127.0.0.1:9292/api/products')
      .then(response => response.json())
      .then(data => {
        console.log(data);
        setProducts(data);
      })
      .catch(error => console.error('Error fetching products:', error));
  }, []);

  const addToCart = (product) => {
    fetch('http://127.0.0.1:9292/api/add', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(product),
    })
      .then(response => {
        if (!response.ok) {
          throw new Error('Failed to add product to cart');
        }
        return response.json();
      })
      .then(data => {
        console.log('Product added to cart:', data);
      })
      .catch(error => {
        console.error('Error adding product to cart:', error);
      });
  };

  return (
    <div className="product-list">
      <h2>Products</h2>
      <div>
        <div className="flex-grid">
          <div>
            <h4>ID</h4>
          </div>
          <div>
            <h4>Product Code</h4>
          </div>
          <div>
            <h4>Name</h4>
          </div>
          <div>
            <h4>Price</h4>
          </div>
          <div></div>
        </div>
        {products.map((product) => (
          <div className="flex-grid" key={product.id}>
            <div>{product.id}</div>
            <div>{product.product_code}</div>
            <div>{product.name}</div>
            <div>{product.price} €</div>
            <div>
              <button onClick = {() => addToCart(product)}>Add to Cart</button>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

export default ProductList;
