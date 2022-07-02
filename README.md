# ECCOMERCE - ETL - ENGLISH

In this project we will carry out an EXTRACTION-TRANSFORMATION-LOAD of the dataset found in kaggle on an Eccomerce in Pakistan

https://www.kaggle.com/datasets/zusmani/pakistans-largest-ecommerce-dataset

Downloading the dataset and placing it in the repository folder we can start with the process of extracting and transforming them.

## Part One: PYTHON

Using Pandas, Numpy, Matplotlib, Seaborn and datetime
```
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sb
from datetime import date, datetime
from matplotlib import rcParams
```
After importing the dataset, I remove rows and columns that are not relevant to the process

```
data = data.dropna(how='all')
data=data.iloc[:,:-5]
```

I rename the columns and start with the transformation of the data:

The data types, the points and commas of the decimals, the replacements of the null values that are still in the dataset.

Once the transformation is finished, we export the data in 4 different tables:

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

In this way I conclude the procedure in Python and we move on to the creation of the database in MYSQL


In this link you can find the tables made in the python part, in case someone wants to carry out the process directly from the MYSQL section:

https://www.mediafire.com/folder/w6o13bsw3jqoc/Tablas


## Second part: MySQL

For the process in MYSQL we will create the database, the tables with their primary-foreign keys and the insertion of the data from the .csv files obtained in the process with python in a script.

<img src="_src\Estructura_Tablas_SQL.png" height="250"><br>


With the image we see how the tables were divided, the columns they have and the ones that function as foreign keys for each one.

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

I use an auxiliary table called venta_aux to be able to load all the data and verify that there are no null element failures that may have been ignored in the previous segment or duplicate indexes for any of the tables.


## Part Three: Power BI

In this section I work with data visualization, connecting the database with Power BI. In addition, to be able to visualize them in a better way, we added a calendar table to the model, guided by the dates where the sales were made.


```
Calendario = CALENDAR(MIN('Ecommerce Venta'[Fecha]),MAX('Ecommerce Venta'[Fecha]))
```

Then I make a presentation for each of the characteristics: Payment Method, Purchase Status and Category.

<img src="_src\img1.jpg" height="250"><br>

<img src="_src\img2.png" height="250"><br>

<img src="_src\img3.png" height="250"><br>

## Conclusions:

We can see that the sales of this dataset are much higher in the months of November-December, so we say that there is a period of seasonality in sales. We also see an increase in the amount of sales from the first year to the other 2.

In the "Mobiles & Tables" categories it has the largest market share with 58% of sales, so we can conclude that the company largely depends on its operation on this category. Adding the categories "Appliances" and "Entertainement" we see that these 3 categories together correspond to almost 88% of the company's sales, leaving the rest of the categories far behind.

In Purchase Status we see a very curious and worrying detail, 63% of the company's sales are canceled leaving only 25% as completed. This is a very bad sign for the company because there are many products for unknown reasons that do not reach the customer, even when he himself chose to buy the product.

For the Payment Methods we see a much more even distribution (compared to the others), with the "cod", "Payaxis" and "Easypay" methods being the most used, having about 75% of the total transactions. An interesting fact also happens in the months of May-June-July where the "Bankalfalah" payment method is the most widely used.


# ECCOMERCE - ETL - ESPAÑOL

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

Podemos observar que las ventas de este dataset son mucho mayores en los meses de Noviembre-Diciembre, por lo que decimos que hay un periodo de estacionalidad en las ventas. Ademas vemos un aumento en la cantidad de ventas desde el primer año hacia los otros 2.

En las categorias "Mobiles & Tables" tiene la mayor cuota del mercado con un 58% de las ventas, por lo tanto podemos concluir que de esta categoria la empresa depende en gran medida su funcionamiento. Sumando las categorias "Appliances" y "Entertainement" vemos que estas 3 categorias juntas corresponden a casi el 88% de las ventas de la empreas, dejando muy por detras al resto de categorias.

En Estado de compra vemos un detalla muy curioso y preocupante, el 63% de las ventas de la empresa estan canceladas dejando solo un 25% como completadas. Esto es una muy mala señal para la empresa debido a que son muchisimos productos que razones desconocidas no llegan al cliente, aun cuando el mismo eligio comprar el producto.

Para los Metodos de Pago vemos una distribucion mucho mas uniforme (en comparacion con los demas), siendo los metodos "cod", "Payaxis" y "Easypay" los mas utilizados teniendo cerca del 75% de las transacciones totales. Tambien un dato interesante sucede en los meses de Mayo-Junio-Julio doende el metodo de pago "Bankalfalah" es el mas utilizado por amplia diferencia.

