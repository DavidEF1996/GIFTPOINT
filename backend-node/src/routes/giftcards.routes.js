const express = require('express');
const router = express.Router();

const authMiddleware = require('../middlewares/auth.middleware');
const giftcardsController = require('../controllers/giftcards.controller');

router.get('/', authMiddleware, giftcardsController.getGiftcards);

module.exports = router;
