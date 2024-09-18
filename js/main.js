document.addEventListener('DOMContentLoaded', function() {
    // Verificar estado de sesión
    if (!localStorage.getItem('isLoggedIn')) {
        window.location.href = '../index.html'; // Redirecciona al login si no está logueado
    }

    const logoutButton = document.getElementById(17); // Asegúrate de cambiar el selector según tu HTML
    logoutButton.addEventListener('click', function(event) {
        event.preventDefault();
        localStorage.removeItem('isLoggedIn'); // Limpiar estado de sesión
        window.location.href = '../index.html'; // Redireccionar al login
    });
});
