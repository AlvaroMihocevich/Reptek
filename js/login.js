document.getElementById('loginForm').addEventListener('submit', function(event) {
    event.preventDefault();
  
    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;
    const loginError = document.getElementById('loginError');
  
    fetch('data/usuarios.json')
      .then(response => response.json())
      .then(data => {
        const user = data.users.find(user => user.username === username && user.password === password);
        if (user) {
          localStorage.setItem('isLoggedIn', 'true');  // Guardar estado de sesión en localStorage
          window.location.href = '../pages/inicio.html';
        } else {
          loginError.textContent = 'Usuario o contraseña incorrectos.';
          loginError.style.display = 'block';
        }
      })
      .catch(error => {
        console.error('Error fetching user data:', error);
        loginError.textContent = 'Error al cargar los datos de usuario.';
        loginError.style.display = 'block';
      });
  });
  
  // Verificar si el usuario ya está logueado
  if (localStorage.getItem('isLoggedIn')) {
    window.location.href = '../pages/inicio.html'; // Redirecciona si ya está logueado
  }
  