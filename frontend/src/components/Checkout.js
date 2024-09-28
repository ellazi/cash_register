import React, { useEffect, useState } from 'react';

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
      <h3>Checkout</h3>
      {basket.length === 0 ? (
        <p>Your cart is empty.</p>
      ) : (
        <div>
          <p>Basket: {basket}</p>
          <h4>Total Price: {totalPrice} €</h4>
        </div>
      )}
    </div>
  );
};

export default Checkout;
