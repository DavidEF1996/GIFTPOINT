const authService = require('../services/auth.service');

function login(req, res) {
  const { email, password } = req.body;

  if (!email || !password) {
    return res.status(400).json({
      message: 'Las credenciales son requeridas'
    });
  }

  const result = authService.login(email, password);

  if (!result) {
    return res.status(401).json({
      message: 'Las credenciales son inválidas'
    });
  }

  res.json(result);
  console.log("llegando")
}

module.exports = {
  login
};
