Instrucciones para levantar el backend:

1. Ir a la carpeta del backend:

cd backend-node

2. Instalar dependencias:

npm install


3. Ejecutar el servidor:

npm run dev


4. El backend se levantará por defecto en:

http://localhost:3000



Instrucciones para levantar el frontend:

1. Ir a la carpeta del frontend:

cd frontend


2. Modificar segun donde se este probando la variable de entorno

BASE_URL=http://TU_IP_LOCAL:3000


3. Instalar dependencias:

flutter pub get


4. Ejecutar la aplicación:

flutter run



Arquitectura (resumen)

El proyecto utiliza una arquitectura basada en features, donde cada funcionalidad principal se organiza de forma independiente.

En el backend se usa Express, con separación por rutas, controladores, servicios y middlewares, utilizando almacenamiento en memoria para simplificar la prueba.

En el frontend se usa Flutter + Provider, organizando la app por funcionalidades (auth, giftcards, orders), donde cada feature contiene su vista, lógica de estado y servicios.

La comunicación entre frontend y backend se realiza mediante API REST, con autenticación JWT.


Se adjunta un video con el funcionamiento de la aplicacion