import React from "react";
import { createRoot } from "react-dom/client";
import App from "./components/App";

document.addEventListener("DOMContentLoaded", () => {
  const reactRoot = document.getElementById("react-root");
  const currentUser = reactRoot.dataset.user ? JSON.parse(reactRoot.dataset.user) : null;

  if (reactRoot) {
    createRoot(reactRoot).render(<App currentUser={currentUser} />);
  }
});
