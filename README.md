## Terminal (Shell)

- `Ctrl + A` : Ir al inicio de la línea.
- `Ctrl + E` : Ir al final de la línea.
- `Ctrl + U` : Borrar desde el cursor hasta el inicio.
- `Ctrl + K` : Borrar desde el cursor hasta el final.
- `Ctrl + W` : Borrar la palabra anterior.
- `Ctrl + L` : Limpiar la pantalla.

## fzf

- `Ctrl + R` : Buscar en el historial de comandos.
- `Ctrl + T` : Buscar y pegar archivos/directorios en la línea actual.
- `Alt + C` : Buscar y cambiar de directorio.

## Tmux

### Gestión de Sesiones (Alias)
- `tn <nombre>` : Crear nueva sesión.
- `ta` : Adjuntar a sesión (con `fzf`).
- `tl` : Listar sesiones activas.

### Comandos Generales (Prefijo: `Ctrl + a`)
- `+ d` : Desconectar de la sesión actual.
- `+ r` : Recargar la configuración de tmux.
- `+ s` : Menú interactivo para cambiar de sesión/ventana.
- `+ z` : Zoom sobre el panel actual.
- `+ x` : Cerrar el panel actual.

### Gestión de Paneles (Prefijo: `Ctrl + a`)
- `+ H` : Dividir panel horizontalmente.
- `+ J` : Dividir panel verticalmente.
- `+ h/j/k/l` : Moverse entre paneles (estilo Vim).
