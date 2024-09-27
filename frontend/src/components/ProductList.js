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

  return (
    <div class="product-list">
      <h2>Products</h2>
      <div>
        <div class="flex-grid">
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
          {products.map((product) => (
            <React.Fragment key={product.id}>
              <div>{product.id}</div>
              <div>{product.product_code}</div>
              <div>{product.name}</div>
              <div>{product.price} €</div>
            </React.Fragment>
          ))}
        </div>
      </div>
    </div>
  );
}

export default ProductList;
