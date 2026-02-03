const express = require('express');
const cors = require('cors');
const app = express();
const port = 3000;

app.use(cors()); // Allow Flutter Web to connect

// 1. Text Rules: Replace "Bitcoin" with "Dogecoin"
app.get('/text', (req, res) => {
  console.log('GET /text - Sending text rules...');
  res.json([
    {
      "pattern": "Bitcoin",
      "replacement": "Dogecoin"
    },
    {
      "pattern": "safe",
      "replacement": "compromised"
    }
  ]);
});

// 2. Image Rules: Swap the Flutter logo for a warning sign
app.get('/image', (req, res) => {
  console.log('GET /image - Sending image rules...');
  res.json([
    {
      "trigger": "flutter_logo.png",
      "target": "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f7/Antu_dialog-warning.svg/200px-Antu_dialog-warning.svg.png"
    }
  ]);
});

// 3. LaTeX Rules: Change the formula E=mc^2
app.get('/tex', (req, res) => {
  console.log('GET /tex - Sending LaTeX rules...');
  res.json([
    {
      "symbol": "mc",
      "substitution": "0" 
    }
  ]);
});

app.listen(port, () => {
  console.log(`😈 Evil Server running at http://localhost:${port}`);
});
