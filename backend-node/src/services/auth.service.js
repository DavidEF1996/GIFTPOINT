const jwt = require('jsonwebtoken');
const users = require('../data/users.mock');
const { jwtSecret } = require('../config');

function login(email, password) {
  const user = users.find(
    u => u.email === email && u.password === password
  );

  if (!user) {
    return null;
  }

  const payload = {
    sub: user.id,
    email: user.email
  };

  const token = jwt.sign(payload, jwtSecret, {
    expiresIn: '1h'
  });

  return {
    token,
    user: {
      id: user.id,
      email: user.email,
      name: user.name
    }
  };
}

module.exports = {
  login
};
