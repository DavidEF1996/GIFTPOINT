const jwt = require('jsonwebtoken');
const { jwtSecret } = require('../config');

function authMiddleware(req, res, next) {
  const authHeader = req.headers['authorization'];

  if (!authHeader) {
    return res.status(401).json({
      message: 'No se tiene el token de autorizacion'
    });
  }

  const parts = authHeader.split(' ');

  if (parts.length !== 2 || parts[0] !== 'Bearer') {
    return res.status(401).json({
      message: 'No es un formato valido'
    });
  }

  const token = parts[1];

  try {
    const decoded = jwt.verify(token, jwtSecret);
    req.user = decoded; // sub, email
    next();
  } catch (error) {
    return res.status(401).json({
      message: 'Token expirado'
    });
  }
}

module.exports = authMiddleware;
