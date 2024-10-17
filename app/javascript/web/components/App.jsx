import React from "react";

const App = ({ currentUser }) => {
  return (
    <div>
        <h1>Welcome back, {currentUser.restaurant_id}!</h1>
    </div>
  );
};

export default App;
