const express = require('express');
const cors = require('cors');
const path = require('path');

const authRoutes = require('./routes/auth.routes');
const giftcardsRoutes = require('./routes/giftcards.routes');

const app = express();

app.use(cors());
app.use(express.json());

app.use(
  '/assets',
  express.static(path.join(__dirname, 'assets'))
);


app.use('/auth', authRoutes);
app.use('/giftcards', giftcardsRoutes);

module.exports = app;
