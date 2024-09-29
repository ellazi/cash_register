import React from 'react';
import ProductList from './components/ProductList';
import Navbar from './components/Navbar';

function App() {
  return (
    <>
    <Navbar />
    <div className="container">
      <h1>Welcome to Our Shop</h1>
      <ProductList />
    </div>
    </>
  );
}

export default App;
