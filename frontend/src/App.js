// import logo from './logo.svg';
// import './App.css';

// function App() {
//   return (
//     <div className="App">
//       <header className="App-header">
//         <img src={logo} className="App-logo" alt="logo" />
//         <p>
//           Edit <code>src/App.js</code> and save to reload.
//         </p>
//         <a
//           className="App-link"
//           href="https://reactjs.org"
//           target="_blank"
//           rel="noopener noreferrer"
//         >
//           Learn React
//         </a>
//       </header>
//     </div>
//   );
// }

// export default App;

import React, { useState, useEffect } from 'react';

function App() {
  const [data, setData] = useState(null);

  useEffect(() => {
    // Fetch data from your Sinatra API running on port 9292
    fetch('http://127.0.0.1:9292/api/data')  // Ensure this matches the port Sinatra runs on
      .then(response => response.json())     // Parse the response as JSON
      .then(data => setData(data))           // Set the data into state
      .catch(error => console.error('Error fetching data:', error));  // Handle errors
  }, []);  // The empty array ensures this runs once when the component mounts

  return (
    <div>
      <h1>{data ? data.message : "Loading..."}</h1>  {/* Display the data when available */}
    </div>
  );
}

export default App;
