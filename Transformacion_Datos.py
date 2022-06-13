# Importamos librerias

import pandas as pd
import numpy as np
from datetime import date, datetime

# Extraemos los datos
data=pd.read_csv("Pakistan.Largest.Ecommerce.Dataset.csv", decimal=".",thousands=",")
data = data.dropna(how='all')
data=data.iloc[:,:-5]
columnas=["Id_Item","Estado_Compra","Fecha","Direccion","Precio","Cantidad","Total","Id","Categoria_1","Comision","Descuento","Metodo_Pago","Fecha_Trabajo","BI_Status","MV","Año","Mes","Cliente_Desde","M-Y","FY","Id_Cliente"]
data.columns=columnas
print("Inserccion de datos correcta")

# Transformamos los datos
data["Id_Item"]=data["Id_Item"].astype(int)
data["Estado_Compra"]=data["Estado_Compra"].astype(str)
data['Fecha'] = pd.to_datetime(data['Fecha']).dt.date
data["Direccion"]=data["Direccion"].astype(str)
data["Precio"]=data["Precio"].astype(float)
data["Cantidad"]=data["Cantidad"].fillna(0)
data["Cantidad"]=data["Cantidad"].astype(int)
data["Total"]=data["Total"].astype(float)
data["Id"]=data["Id"].astype(str)
data["Categoria_1"]=data["Categoria_1"].astype(str)
data["Comision"]=data["Comision"].astype(str)
data["Descuento"]=data["Descuento"].astype(float)
data["Metodo_Pago"]=data["Metodo_Pago"].astype(str)
data['Fecha_Trabajo'] = pd.to_datetime(data['Fecha_Trabajo']).dt.date
data["MV"]=data["MV"].astype(str)
data["MV"]=[x.replace('-',"0") for x in data["MV"]]
data["MV"]=[x.replace(',','') for x in data["MV"]]
data["MV"]=data["MV"].astype(float)
data["Año"]=data["Año"].astype(float)
data["Año"]=data["Año"].astype(int)
data["Mes"]=data["Mes"].fillna(0)
data["Mes"]=data["Mes"].astype(int)
data["Cliente_Desde"]=data["Cliente_Desde"].astype(str)
data["Id_Cliente"]=data["Id_Cliente"].astype(str)

print("Primera parte de la transformacion correcta")

data["Estado_Compra"]=data["Estado_Compra"].replace("nan","No Data")
data["Estado_Compra"]=data["Estado_Compra"].replace("\\N","No Data")
data["Direccion"]=data["Direccion"].replace("nan","No Data")
data["Id"]=[x.replace('-',"") for x in data["Id"]]
data["Id"]=data["Id"].astype(int)
data["Categoria_1"]=data["Categoria_1"].replace("nan","No Data")
data["Categoria_1"]=data["Categoria_1"].replace("\\N","No Data")
data["Comision"]=data["Comision"].replace("nan","No Data")
data["Comision"]=data["Comision"].replace("\\N","No Data")
data["BI_Status"]=data["BI_Status"].replace("#REF!","No Data")
data["Cliente_Desde"]=data["Cliente_Desde"].replace("nan","No Data")
data["Id_Cliente"]=data["Id_Cliente"].replace(data["Id_Cliente"][427378],"0")
data["Id_Cliente"]=data["Id_Cliente"].astype(float)
data["Id_Cliente"]=data["Id_Cliente"].astype(int)
for i in range(len(data["Id_Cliente"])):
  if data.loc[i,"Id_Cliente"]==0:
      data.loc[i,"Id_Cliente"]=max(data["Id_Cliente"])+1

print("Segunda parte de la transformacion correcta")

# Exportamos los datos de los csv
Estado_Compra=pd.DataFrame(data["Estado_Compra"].unique(), index=range(1,17), columns=["Estado_Compra"])
Estado_Compra.to_csv("Estado_Compra.csv",index=True)

Metodo_Pago=pd.DataFrame(data["Metodo_Pago"].unique(), index=range(1,19), columns=["Metodo_Pago"])
Metodo_Pago.to_csv("Metodo_Pago.csv",index=True)

Categoria=pd.DataFrame(data["Categoria_1"].unique(), index=range(1,17), columns=["Categoria_1"])
Categoria.to_csv("Categoria.csv",index=True)

Columnas=["Id","Id_Item","Estado_Compra","Fecha","Categoria_1","Id_Cliente","Precio","Cantidad","Descuento","Metodo_Pago","Fecha_Trabajo","Total"]
Venta=pd.DataFrame(data[Columnas],index= range(1,len(data)), columns=Columnas)
Venta.to_csv("Venta.csv",index=True)

print("Archivos exportados")
