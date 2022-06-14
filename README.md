# ECCOMERCE - ETL

En este proyecto realizaremos una EXTRACCION-TRANSFORMACION-CARGA del dataset encontrado en kaggle sobre un Eccomerce en Pakistan

https://www.kaggle.com/datasets/zusmani/pakistans-largest-ecommerce-dataset

Descargando el dataset y colocandolo en la carpeta del repositorio podremos empezar con el proceso extraccion y transformacion de los mismos.

## Primera parte: PYTHON

Utilizando las librerias de Pandas, Numpy, Matplotlib, Seaborn y datetime
```
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sb
from datetime import date, datetime
from matplotlib import rcParams
```

Despues importando el dataset, eliminamos filas y columnas que no son relevantes para el proceso

```
data = data.dropna(how='all')
data=data.iloc[:,:-5]
```

Renombramos las columnas y empezamos con la trasnformacion de los datos:

Los tipos de datos, los puntos y las comas de los decimales, los reemplazos de los valores nulos que aun quedan en el dataset.

Una vez finalizada la transformacion, exportamos los datos en 4 tablas distintas:

- Venta

- Metodo de Pago

- Estado de Compra

- Categoria


```
Estado_Compra.to_csv("Estado_Compra.csv",index=True)

Metodo_Pago.to_csv("Metodo_Pago.csv",index=True)

Categoria.to_csv("Categoria.csv",index=True)

Venta.to_csv("Venta.csv",index=True)
```

De esta forma damos por concluido el procesamiento en Python y pasamos a la creacion de la base de datos en MYSQL



En este link podran encontrar las tablas realizadas en la parte de python, por si alguien quiere realizar el proceso directamente desde la seccion de MYSQL :

https://www.mediafire.com/folder/w6o13bsw3jqoc/Tablas


## Segunda parte: MYSQL

Para el proceso en MYSQL realizaremos en un script la creacion de la base de datos, las tablas con sus llaves primarias-foraneas y la inserccion de los datos desde los archivos .csv obtenidos en el proceso con python.

<img src="_src\Estructura_Tablas_SQL.png" height="250"><br>


Con la imagen vemos como se dividieron las tablas, las columnas que poseen y las que funcionaran como llaves foraneas de cada una.

```
DROP TABLE IF EXISTS Venta_aux;
CREATE TABLE `Ecommerce`.`Venta_aux` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Id_Venta` INT NOT NULL,
  `Id_Item` INT NOT NULL,
  `Estado_Compra` VARCHAR(45) NOT NULL,
  `Fecha` DATE NOT NULL,
  `Categoria` VARCHAR(50) NOT NULL,
  `Id_Cliente` INT NOT NULL,
  `Precio` DECIMAL(10,3) NOT NULL,
  `Cantidad` INT NOT NULL,
  `Descuento` DECIMAL(10,4) NOT NULL,
  `Metodo_Pago` VARCHAR(45) NOT NULL,
  `Fecha_Trabajo` DATE NOT NULL,
  `Total` DECIMAL(15,5) NOT NULL,
  PRIMARY KEY (`Id`));
```
Utilizo una tabla auxiliar llamada venta_aux para poder cargar todos los datos y corroborar que no hayan fallos de elementos nulos que puedan haber sido obviados en el segmento anterior o indices duplicados para alguna de las tablas. 



## Tercera parte: Power BI

En esta seccion trabajo con la visualizacion de los datos, conectando la base de datos con Power BI. Ademas para poder visualizarlos de una mejor manera agregamos una tabla calendario al modelo, guiada por las fechas donde se realizaron las ventas.


```
Calendario = CALENDAR(MIN('Ecommerce Venta'[Fecha]),MAX('Ecommerce Venta'[Fecha]))
```

Despues realizo una presentacion para cada una de las caracteristicas: Metodo de Pago, Estado de Compra y Categoria.

<img src="_src\img1.jpg" height="250"><br>

<img src="_src\img2.png" height="250"><br>

<img src="_src\img3.png" height="250"><br>

## Conclusiones:

Pendiente...

https://www.mediafire.com/folder/w6o13bsw3jqoc/Tablas
