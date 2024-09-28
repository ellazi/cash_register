import React, { useEffect, useState } from 'react';
import './Checkout.css';

const Checkout = ({ cart }) => {
  const [totalPrice, setTotalPrice] = useState(0);
  const [basket, setBasket] = useState('');

  useEffect(() => {
    if (cart.length > 0) {
      fetch('http://127.0.0.1:9292/api/checkout', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(cart),
      })
        .then(response => {
          if (!response.ok) {
            throw new Error('Failed to fetch checkout data');
          }
          return response.json();
        })
        .then(data => {
          console.log('Checkout data received:', data);
          setBasket(data.basket);
          setTotalPrice(data.total_price);
        })
        .catch(error => {
          console.error('Error fetching checkout data:', error);
        });
    }
  }, [cart]);

  return (
    <div className="checkout">
      <h2>Checkout</h2>
      {basket.length === 0 ? (
        <p>Your cart is empty</p>
      ) : (
        <>
          <div className="flex-grid-checkout">
            <h4>Basket</h4>
            <h4>Total price</h4>
          </div>
          <div className="flex-grid-checkout">
            <div>{basket}</div>
            <div>{totalPrice} €</div>
          </div>
        </>
      )}
    </div>
  );
};

export default Checkout;
